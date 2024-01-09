Return-Path: <linux-fsdevel+bounces-7581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E705A827C62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 02:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510BEB22E44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 01:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1028F5;
	Tue,  9 Jan 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hX+j5Kmt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE623D9
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2041c292da8so1359457fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 17:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704762706; x=1705367506; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kq7aDb3sh/xjoJWNX1RcLcR0s8Lg81SC41roYsu+Oe4=;
        b=hX+j5KmttCrB0tWrfmmDShseAoT0MXIfPTkWvVKbpBIXiLMuo5RKxS6l/400DBnWdH
         qxttXkulqaPC6ZuWpa7GvjoiBeVIZ4HUkSvl+xKFoIK6D0WzyJdSu2iU/GzDw2S4gNCk
         BYSuUQtzhEbADgHsSlmjPE+G1VP14ZvbVelDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704762706; x=1705367506;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kq7aDb3sh/xjoJWNX1RcLcR0s8Lg81SC41roYsu+Oe4=;
        b=nX+GeJHEwbj8v1kPPWAROcFnrrzST3aV2HIhUlRr5tplQFmdsQ1I+YBwcWS5LMCHLo
         OPHfpEqMc+O7UbE3yoKvdPFmPsW/dRIIguMl+JHdYCD3+muf10fpWmV4ugOHUXvzCyOh
         WO5YCgTq7j16zwJUyiM2DAN+fi93tGPdDW3AM5DFYkCQfDRLTcHxILwFyHbZtZsDMP8e
         Sa1L4yXLTvLYpoiwyFNYS5+xMTbVyhA41u6tBXXlZAEeQblNFU5kEigHH1GIeGYF+Q7D
         6qI2fuaqM7jKzTl3AnIQibB98Zn84Q0+I7t3mmhhZZKQXVUB9Bu48xy6gbFIfbo37QFK
         W8KQ==
X-Gm-Message-State: AOJu0YxvkBWPrSTQ+IW34H5pQVqCu+PvltXMqxFXuvihv9FZFAmWKn1U
	JjDMGqACulQiA63hQVvHkohigGEJ9iVN
X-Google-Smtp-Source: AGHT+IFp601e9v6sUKl9/2ND9JThoIRoU+j/yd3/0RtNpZw3IDBI2NyMyJx0iC0xylM7wHbbiLgKeQ==
X-Received: by 2002:a05:6871:7588:b0:204:4926:1824 with SMTP id nz8-20020a056871758800b0020449261824mr4588588oac.80.1704762706071;
        Mon, 08 Jan 2024 17:11:46 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d10-20020a056a00198a00b006db00cb78a8sm478738pfl.179.2024.01.08.17.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 17:11:44 -0800 (PST)
Message-ID: <688dc165-5fee-488f-bdf9-a855d2fac71d@broadcom.com>
Date: Mon, 8 Jan 2024 17:11:41 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] wire up syscalls for statmount/listmount
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
 Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
 David Howells <dhowells@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>,
 Amir Goldstein <amir73il@gmail.com>, Matthew House
 <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-7-mszeredi@redhat.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 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
In-Reply-To: <20231025140205.3586473-7-mszeredi@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008a6f6f060e78ff78"

--0000000000008a6f6f060e78ff78
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 10/25/23 07:02, Miklos Szeredi wrote:
> Wire up all archs.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   arch/alpha/kernel/syscalls/syscall.tbl      | 3 +++
>   arch/arm/tools/syscall.tbl                  | 3 +++
>   arch/arm64/include/asm/unistd32.h           | 4 ++++
>   arch/ia64/kernel/syscalls/syscall.tbl       | 3 +++
>   arch/m68k/kernel/syscalls/syscall.tbl       | 3 +++
>   arch/microblaze/kernel/syscalls/syscall.tbl | 3 +++
>   arch/mips/kernel/syscalls/syscall_n32.tbl   | 3 +++
>   arch/mips/kernel/syscalls/syscall_n64.tbl   | 3 +++
>   arch/mips/kernel/syscalls/syscall_o32.tbl   | 3 +++
>   arch/parisc/kernel/syscalls/syscall.tbl     | 3 +++
>   arch/powerpc/kernel/syscalls/syscall.tbl    | 3 +++
>   arch/s390/kernel/syscalls/syscall.tbl       | 3 +++
>   arch/sh/kernel/syscalls/syscall.tbl         | 3 +++
>   arch/sparc/kernel/syscalls/syscall.tbl      | 3 +++
>   arch/x86/entry/syscalls/syscall_32.tbl      | 3 +++
>   arch/x86/entry/syscalls/syscall_64.tbl      | 2 ++
>   arch/xtensa/kernel/syscalls/syscall.tbl     | 3 +++
>   include/uapi/asm-generic/unistd.h           | 8 +++++++-
>   18 files changed, 58 insertions(+), 1 deletion(-)

FWIW, this broke the compat build on ARM64:

./arch/arm64/include/asm/unistd32.h:922:24: error: array index in 
initializer exceeds array bounds
   922 | #define __NR_statmount 457
       |                        ^~~
arch/arm64/kernel/sys32.c:130:34: note: in definition of macro '__SYSCALL'
   130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
       |                                  ^~
./arch/arm64/include/asm/unistd32.h:923:11: note: in expansion of macro 
'__NR_statmount'
   923 | __SYSCALL(__NR_statmount, sys_statmount)
       |           ^~~~~~~~~~~~~~
./arch/arm64/include/asm/unistd32.h:922:24: note: (near initialization 
for 'compat_sys_call_table')
   922 | #define __NR_statmount 457
       |                        ^~~
arch/arm64/kernel/sys32.c:130:34: note: in definition of macro '__SYSCALL'
   130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
       |                                  ^~
./arch/arm64/include/asm/unistd32.h:923:11: note: in expansion of macro 
'__NR_statmount'
   923 | __SYSCALL(__NR_statmount, sys_statmount)
       |           ^~~~~~~~~~~~~~
arch/arm64/kernel/sys32.c:130:40: warning: excess elements in array 
initializer
   130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
       |                                        ^~~~~~~~
./arch/arm64/include/asm/unistd32.h:923:1: note: in expansion of macro 
'__SYSCALL'
   923 | __SYSCALL(__NR_statmount, sys_statmount)
       | ^~~~~~~~~
arch/arm64/kernel/sys32.c:130:40: note: (near initialization for 
'compat_sys_call_table')
   130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
       |                                        ^~~~~~~~
./arch/arm64/include/asm/unistd32.h:923:1: note: in expansion of macro 
'__SYSCALL'
   923 | __SYSCALL(__NR_statmount, sys_statmount)
       | ^~~~~~~~~
./arch/arm64/include/asm/unistd32.h:924:24: error: array index in 
initializer exceeds array bounds
   924 | #define __NR_listmount 458
       |                        ^~~
arch/arm64/kernel/sys32.c:130:34: note: in definition of macro '__SYSCALL'
   130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
       |                                  ^~
./arch/arm64/include/asm/unistd32.h:925:11: note: in expansion of macro 
'__NR_listmount'
   925 | __SYSCALL(__NR_listmount, sys_listmount)
       |           ^~~~~~~~~~~~~~
./arch/arm64/include/asm/unistd32.h:924:24: note: (near initialization 
for 'compat_sys_call_table')
   924 | #define __NR_listmount 458
       |                        ^~~
arch/arm64/kernel/sys32.c:130:34: note: in definition of macro '__SYSCALL'
   130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
       |                                  ^~
./arch/arm64/include/asm/unistd32.h:925:11: note: in expansion of macro 
'__NR_listmount'
   925 | __SYSCALL(__NR_listmount, sys_listmount)
       |           ^~~~~~~~~~~~~~
arch/arm64/kernel/sys32.c:130:40: warning: excess elements in array 
initializer
   130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
       |                                        ^~~~~~~~
./arch/arm64/include/asm/unistd32.h:925:1: note: in expansion of macro 
'__SYSCALL'
   925 | __SYSCALL(__NR_listmount, sys_listmount)
       | ^~~~~~~~~
arch/arm64/kernel/sys32.c:130:40: note: (near initialization for 
'compat_sys_call_table')
   130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
       |                                        ^~~~~~~~
./arch/arm64/include/asm/unistd32.h:925:1: note: in expansion of macro 
'__SYSCALL'
   925 | __SYSCALL(__NR_listmount, sys_listmount)
       | ^~~~~~~~~
host-make[5]: *** [scripts/Makefile.build:243: 
arch/arm64/kernel/sys32.o] Error 1
host-make[4]: *** [scripts/Makefile.build:480: arch/arm64/kernel] Error 2
host-make[3]: *** [scripts/Makefile.build:480: arch/arm64] Error 2
host-make[3]: *** Waiting for unfinished jobs....

Sent out a fix for that:

https://lore.kernel.org/all/20240109010906.429652-1-florian.fainelli@broadcom.com/
-- 
Florian


--0000000000008a6f6f060e78ff78
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAM5yt5UQxTGAlYb
ALe+2QjojUUx8TX7a0W9AzAP3q12MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDEwOTAxMTE0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQD3P7pTnbQypk3ax2nFb81LsOPYmshSqY9f
eqblQ7fb68ZorSAYloqoBA20GbwWFB5S+98VKNpkrLeAWcgAc/WlHoOoZnJHPXERrF+hj5TNUMLf
T7RuexW7Ijp4qh1+M9CEgafaspP2Hqx157if+HsrHUErY+TnH7w2YUDcuPuSzXSLfKf6+J7yDVEZ
Xc1HnG2QyG9fwu0e++oi3Dl8hnbqt0+bDXVNBNANkH0zpxPXvMkw4p9Xr47NYC3vTwNCmkzyA9c/
Xck8I1QXORtFUFz5KyvELqt519UMsVZPoJrBkkDJRQbA5stVdDejLulrd4LKnazVLEejb7eDsFA9
LTbx
--0000000000008a6f6f060e78ff78--

