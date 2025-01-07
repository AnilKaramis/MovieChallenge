//
//  SSLPinningURLSessionDelegate.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import Foundation

public final class SSLPinningURLSessionDelegate: NSObject, URLSessionDataDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0)

                if isVerified(serverCertificate) {
                    let credential = URLCredential(trust: serverTrust)
                    completionHandler(.useCredential, credential)

                    return
                }
            }
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}

// MARK: - Verify Certificate

private extension SSLPinningURLSessionDelegate {
    func isVerified(_ certificate: SecCertificate?) -> Bool {
        guard let certificate = certificate else {
            return false
        }

        let policy = SecPolicyCreateBasicX509()
        var trust: SecTrust?
        let status = SecTrustCreateWithCertificates(certificate, policy, &trust)

        guard status == errSecSuccess, let serverTrust = trust else {
            return false
        }

        if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0),
           getHash(from: serverCertificate, serverTrust: serverTrust) == "aDGEiq009E1jK1uvuNP8LraH098EweUUu+Nc4LnDpVE=" {
            return true
        }

        return true
    }

    func getHash(from certificate: SecCertificate?, serverTrust: SecTrust?) -> String? {
        guard let serverTrust = serverTrust,
              let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0),
              let serverPublicKey = SecCertificateCopyKey(serverCertificate),
              let serverPublicKeyData = SecKeyCopyExternalRepresentation(serverPublicKey, nil) else {
            return nil
        }

        return (serverPublicKeyData as Data).sha256.base64EncodedString()
    }
}
