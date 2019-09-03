Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3CA75F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfICVIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 17:08:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45104 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfICVIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:08:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id v12so14023309oic.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UF2P6jBmZTalAZpiNYok41chfv7muSCjlkjkBSebiA=;
        b=kWkzS1hiEFG76FW8Ude9YAyAeEhuHQclP4qTZ2Dmjoatw1JalUXZTCgQkjm4RY3Yzr
         G+VH/6sfRtA+xkqcAZHrouU02GTBvsOWMtgrdgveNZ6gu/RSpxQfbZort4XO9n14KZFQ
         duB6TZ2ZTnFGKNAg3ONPXe2b0fD7QKZKDmTOUEtOc2r1XDR6aNmLAjAtgi+ypFTbmytS
         7eTIIJggi9tf6nMnpScEc/+14vlzrCtaC9NBpSj5RitAm4NKZlYyRsNFahfxi0s6LyL9
         melAxKjXBhq5uqQqqxD4A7x+N4YESsefFUKI508XnTk/sFW2ILM5iFrkq2z9tnPKKi7R
         ps0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UF2P6jBmZTalAZpiNYok41chfv7muSCjlkjkBSebiA=;
        b=TEFRv2sGYYdJIwxJDHoaEWg/ZcXk8xNaFIx39hySnN8sELBxgvNKt2QgW+fxrk7Z9t
         mOdPytIulZlg2407ztmB71PdPnfJjp51V5esA4yFnKEeSc3Mq1Br3iWD5JWaGqhnx+zx
         XGlB9m6syWwZNPBOBSw2dx10aSdbn2/cCxvfbLdYaSvUl/aI09yKr9XOYB+wqS3yMxoy
         f7ICty60lHqVjUQi4WHZ0sQPXjmdB/FSdJ7M5wOv4xJ/Bq6bP+FRqR33QPmVwi2/4oSe
         m/HeWwVqsXJGJzFX40/kgjkRkeJ+o5WrG0KyOPBncvnKdrpGn9ChyDnHG2IQSQbbKvU2
         kj4Q==
X-Gm-Message-State: APjAAAWBU3j6ek87GueYPlVZM8PzyZpy+8tHxBVUuZksnerYsD7WbLek
        5uaI9a86KXVHnfaU9d5rKaldUkxmDD+0j7js424ke+Wm
X-Google-Smtp-Source: APXvYqx7vCcqY7JYSqJ7ruyJLsM5+4x6by5t5sMbC45cXVsxXe3O3v5ljDXh0T9jJ66uyg/z2WW2jKwk6p/Nm5eI8fA=
X-Received: by 2002:aca:3a87:: with SMTP id h129mr1006349oia.4.1567544898133;
 Tue, 03 Sep 2019 14:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190822200030.141272-1-khazhy@google.com>
In-Reply-To: <20190822200030.141272-1-khazhy@google.com>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Tue, 3 Sep 2019 14:08:07 -0700
Message-ID: <CACGdZYKPyBnJvZWY7+JiUoHZvzC+RWonbZ1PBKtpCXCa4BVa6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fuse: on 64-bit store time in d_fsdata directly
To:     miklos@szeredi.hu
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000dbfbf80591ac7c61"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000dbfbf80591ac7c61
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 22, 2019 at 1:00 PM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> Implements the optimization noted in f75fdf22b0a8 ("fuse: don't use
> ->d_time"), as the additional memory can be significant. (In particular,
> on SLAB configurations this 8-byte alloc becomes 32 bytes). Per-dentry,
> this can consume significant memory.
>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  fs/fuse/dir.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>

ping?

--000000000000dbfbf80591ac7c61
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS5wYJKoZIhvcNAQcCoIIS2DCCEtQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBNMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWltZWNhMS5j
cnQwHQYDVR0OBBYEFKBLk14axMQMpZ/b8PKcFvP/M5dTMB8GA1UdIwQYMBaAFMs4ErDHmcB4koyz
IZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQBKP0VRR9yRe7hRjO9f
l8vyi9FFUHwUYhQNrCn759p3gcg02mxtS8zV2g/xgJuYRni5WstweUmeTAslWVGNcsYVUOn973Ep
l/19VTDE1G3k+wvs3xY5+Y11hUzgDVsCvuicWAOWAmHgoKEd95uNI30HFT/XRIHAizSXG3uZTciq
c77VPsnICGmrIQnD9UJGknakL8eyVDAcdO1FxpGiWmW1c2eTMf2mqOTrB+1+ixiDCV5Iq7vFY/vk
/OjbOc2/RCcDlA6VNEeLUeSWQe59aQ+YiO1jrgnLn3fMgcE7o3t3Lah9K3fFRP8foYGcx8XOESWI
zZM9o9E2BY7eSO1XYXxyMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIMTewG74t+
Y00MjT2SMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDXTjFC5qnUa5hvoqlvwDxq
0GWaTVym4W9r2f0RHDIwCTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xOTA5MDMyMTA4MThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAitjUS5nnJ0YjaX/JdsIbn0yTVlLLC7phdG7JKYC/
TW1L9URFHyzl+fBaz/Q9aRPCkdRD3YwPlvpzsSECwW61PM+7irbBiPn1WevGyOIOrzB3SMJGSeex
wTMWbLt0LJ34SFaVLSHN6vM4HjwoiaMwq/YTed1znVTpv33l21oogBxEUSZiipxsl9O03X8cqagO
MD6yoZSiBORn4SJBdpnhZNj7TyqnPrG2QHHnkTKaJ8Ju8WAPqeidVFVnFNzo5LOPiWVPpSe2zc7I
EDBVeKW1dYXY6jnApZ5chOfic3j9orgzqF3Kf0dUHVtyygsCZlnW95GmdupPrlKypjNxMy5OMg==
--000000000000dbfbf80591ac7c61--
