Return-Path: <linux-fsdevel+bounces-6749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3A81B993
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 15:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476222866D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6DA360B9;
	Thu, 21 Dec 2023 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="EvdVxCaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A880C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1703169061; x=1703773861;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	References:From:Organization:In-Reply-To:Content-Type; bh=+3d0Ry
	2xDdh0t0fujTvzMGj6NMBsKhvYQgGqDB7Ezy4=; b=EvdVxCaww5Y7PsRwuZrZzz
	AUmDPUH/kA7FMhz4/HOqiFDzOq7d8eo2OyZ+Kmh3+ooQHQA2edPP6vlIXsVbw3x4
	vBlUz1SUXbx2cBgs5we8CeHff3WGQYjeAcN8QzLpB0eiDUktPg64HoLK/50PeXPK
	rSKju4dyln1fAYnt/i/gM=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 21 Dec 2023 09:31:01 -0500
Received: from [IPV6:2603:7000:73c:c800:969b:c070:cc58:a112] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.1) 
	with ESMTPSA id md5001003765425.msg; Thu, 21 Dec 2023 09:31:00 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 21 Dec 2023 09:31:00 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:c800:969b:c070:cc58:a112
X-MDHelo: [IPV6:2603:7000:73c:c800:969b:c070:cc58:a112]
X-MDArrival-Date: Thu, 21 Dec 2023 09:31:00 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=17191febf5=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <7557e6c5-bc69-4e89-bb0e-b1d754afb3cf@auristor.com>
Date: Thu, 21 Dec 2023 09:30:53 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs: Fix overwriting of result of DNS query
Content-Language: en-US
To: David Howells <dhowells@redhat.com>,
 Anastasia Belova <abelova@astralinux.ru>,
 Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <1700862.1703168632@warthog.procyon.org.uk>
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <1700862.1703168632@warthog.procyon.org.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010009090505040106020008"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms010009090505040106020008
Content-Type: multipart/alternative;
 boundary="------------xy77y20BS4hMZGduEHK0piGj"

--------------xy77y20BS4hMZGduEHK0piGj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/2023 9:23 AM, David Howells wrote:
> In afs_update_cell(), ret is the result of the DNS lookup and the errors
> are to be handled by a switch - however, the value gets clobbered in
> between by setting it to -ENOMEM in case afs_alloc_vlserver_list() fails.
>
> Fix this by moving the setting of -ENOMEM into the error handling for OOM
> failure.  Further, only do it if we don't have an alternative error to
> return.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.  Based on
> a patch from Anastasia Belova[1].
>
> Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
> Signed-off-by: David Howells<dhowells@redhat.com>
> cc: Anastasia Belova<abelova@astralinux.ru>
> cc: Marc Dionne<marc.dionne@auristor.com>
> cc:linux-afs@lists.infradead.org
> cc:lvc-project@linuxtesting.org
> Link:https://lore.kernel.org/r/20231221085849.1463-1-abelova@astralinux.ru/  [1]
>
> ---
>   fs/afs/cell.c |    6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/afs/cell.c b/fs/afs/cell.c
> index 988c2ac7cece..926cb1188eba 100644
> --- a/fs/afs/cell.c
> +++ b/fs/afs/cell.c
> @@ -409,10 +409,12 @@ static int afs_update_cell(struct afs_cell *cell)
>   		if (ret == -ENOMEM)
>   			goto out_wake;
>   
> -		ret = -ENOMEM;
>   		vllist = afs_alloc_vlserver_list(0);
> -		if (!vllist)
> +		if (!vllist) {
> +			if (ret >= 0)
> +				ret = -ENOMEM;
>   			goto out_wake;
> +		}
>   
>   		switch (ret) {
>   		case -ENODATA:
>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>

--------------xy77y20BS4hMZGduEHK0piGj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 12/21/2023 9:23 AM, David Howells
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1700862.1703168632@warthog.procyon.org.uk">
      <pre class="moz-quote-pre" wrap="">In afs_update_cell(), ret is the result of the DNS lookup and the errors
are to be handled by a switch - however, the value gets clobbered in
between by setting it to -ENOMEM in case afs_alloc_vlserver_list() fails.

Fix this by moving the setting of -ENOMEM into the error handling for OOM
failure.  Further, only do it if we don't have an alternative error to
return.

Found by Linux Verification Center (linuxtesting.org) with SVACE.  Based on
a patch from Anastasia Belova[1].

Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
Signed-off-by: David Howells <a class="moz-txt-link-rfc2396E" href="mailto:dhowells@redhat.com">&lt;dhowells@redhat.com&gt;</a>
cc: Anastasia Belova <a class="moz-txt-link-rfc2396E" href="mailto:abelova@astralinux.ru">&lt;abelova@astralinux.ru&gt;</a>
cc: Marc Dionne <a class="moz-txt-link-rfc2396E" href="mailto:marc.dionne@auristor.com">&lt;marc.dionne@auristor.com&gt;</a>
cc: <a class="moz-txt-link-abbreviated" href="mailto:linux-afs@lists.infradead.org">linux-afs@lists.infradead.org</a>
cc: <a class="moz-txt-link-abbreviated" href="mailto:lvc-project@linuxtesting.org">lvc-project@linuxtesting.org</a>
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/r/20231221085849.1463-1-abelova@astralinux.ru/">https://lore.kernel.org/r/20231221085849.1463-1-abelova@astralinux.ru/</a> [1]

---
 fs/afs/cell.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 988c2ac7cece..926cb1188eba 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -409,10 +409,12 @@ static int afs_update_cell(struct afs_cell *cell)
 		if (ret == -ENOMEM)
 			goto out_wake;
 
-		ret = -ENOMEM;
 		vllist = afs_alloc_vlserver_list(0);
-		if (!vllist)
+		if (!vllist) {
+			if (ret &gt;= 0)
+				ret = -ENOMEM;
 			goto out_wake;
+		}
 
 		switch (ret) {
 		case -ENODATA:

</pre>
    </blockquote>
    <p>Reviewed-by: Jeffrey Altman <a class="moz-txt-link-rfc2396E" href="mailto:jaltman@auristor.com">&lt;jaltman@auristor.com&gt;</a></p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------xy77y20BS4hMZGduEHK0piGj--

--------------ms010009090505040106020008
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DHEwggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEz
MB4XDTIyMDgwNDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0Ew
MTQxMEQwMDAwMDE4MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRt
YW4xFTATBgNVBAoTDEF1cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCkC7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3
xHZRtv179LHKAOcsY2jIctzieMxf82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyN
fO/wJ0rX7G+ges22Dd7goZul8rPaTJBIxbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kI
EEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg
9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjG
IcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAwgYQGCCsGAQUFBwEBBHgwdjAwBggr
BgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEIGCCsGAQUF
BzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NlcnRzL3RydXN0aWRjYWEx
My5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYDVR0TBAIwADCCASsG
A1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIBFj5odHRwczov
L3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRt
bDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJlZW4g
aXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRp
ZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
dmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQY
MBaBFGphbHRtYW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2s
gjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwV
eycprp8Ox1npiTyfwc5QaVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4c
WLeQfaMrnyNeEuvHx/2CT44cdLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYq
utYF4Chkxu4KzIpq90eDMw5ajkexw+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJo
Qle4wDxrdXdnIhCP7g87InXKefWgZBF4VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXt
a8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRkgIGb319a7FjslV8wggaXMIIEf6ADAgECAhBA
AXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUAMEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBDb21tZXJjaWFsIFJvb3QgQ0EgMTAe
Fw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6ixaNP0JKSjTd+SG5L
wqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6iqgB63OdHxBN/
15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxlg+m1Vjgn
o1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi2un0
3bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkG
CCsGAQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29t
L3Jvb3RzL2NvbW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C
5yZUyI42djCCASQGA1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0
dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMIG6BggrBgEFBQcCAjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMg
YmVlbiBpc3N1ZWQgaW4gYWNjb3JkYW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2Vy
dGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20v
Y2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0
dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY3JsL2NvbW1lcmNpYWxyb290Y2ExLmNy
bDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX6Nl4a03cDHt7TLdPxCzFvDF2
bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN95jUXLdLPRToNxyaoB5s
0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24GBqqVudvPRLyMJ7u
6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azNBkfnbRq+0e88
QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8HvgnLCBFK2s4
Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXFC9bu
db9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4d
UsZyTk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJn
p/BscizYdNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eA
MDGCAxQwggMQAgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUG
A1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCg
ggGXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIyMTE0
MzA1M1owLwYJKoZIhvcNAQkEMSIEIJyQYDdi599/aEAr+ZKtMcRb298h3j8VclLqS/CNXUj7
MF0GCSsGAQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEX
MBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQ
AgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRy
dXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzMMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAMlmM
sMb1pD520W0shnwOZzEX9Rr/AhxhWlhK2UlbmWRej8hdH52q3x75x487OZ+IS1TSiZ9+qozx
PgGvyCSZCQUclFOf3rTg2ZPFcliIkq4CR1kXnr9XBk3lC8ius3aSGolrVGdFbbiYAy6T1VJG
CFAGM72my2UNo8Bfv9eERALGRVw1CUvEVFu73+z6UTTYc9DE5fBfyJxE8KfV3ncDxgKozFPQ
hcCS6VP9pc0R+wlKhCP/SIgAa0KDoVrFj5Vzn9/ipzJlw+ucLeBlpG6CK1mgjDyUETPJsYt6
iwdmBGmR6OEnxLwB/nYPCuaaoAAke5LoIZ0mT1S328Z2ubJMfQAAAAAAAA==
--------------ms010009090505040106020008--


