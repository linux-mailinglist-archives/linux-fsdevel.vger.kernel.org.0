Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB43445AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhCVN0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhCVNZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:25:43 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74CEC061574;
        Mon, 22 Mar 2021 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=2pTAH7EZAdLSAE5R2Xy8ywDt2Dc8ZTDLeumutAH0RKU=; b=F7YPZX3VvyRxSNzrKKb6ys3K0F
        g+79KJDZCDh/WBu0TgwYzmdi2Nm+16fysh9gkcNlk9X6ZbJ9XHL/6KoUcFJIO3Mlw/M5Dd+pnqxmZ
        wFi2LHPqy7D1kWTpHOvlJkzVYHx6eXIG1Dd3qmQm5nZf4hyIAdccTP4tWwmEBGRyVX0fyw7ZUMskC
        X2aInc0n9a47I0H9A+Td2IpUQdgtWPJaswlqPYvA8KF6hEz61yZ0Kbc7G3440uwUjA+vYDcFJo6xZ
        bIwkgpQTHOl+87LLFfANc7pO1zW/obLuA6t+wnIjW+agrMLgMqelSn4n8qTIcHyS8O47cBJ+PPaSg
        HNNyY/077ThHBATQl3YhRxPimrc5LxT03J04G57L9mKP99/OeJTnmqGRx1w0IfOij2hQ45Ss5CSYl
        ksytvPiVXaIN48IFTFpR8OXpH7nBZsqo2mbzQWeg7oLiQBH6JpBjhRE3FJiG1zmd/Qu7oGg8NKItA
        kDRcB2xL2ccLwYcNVC/9yBiR;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lOKYq-0003UK-Bn; Mon, 22 Mar 2021 13:25:36 +0000
To:     Christoph Hellwig <hch@lst.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-cifs@vger.kernel.org, aurelien.aptel@gmail.com,
        linux-cifsd-devel@lists.sourceforge.net, senozhatsky@chromium.org,
        rdunlap@infradead.org, sandeen@sandeen.net,
        linux-kernel@vger.kernel.org, aaptel@suse.com, hch@infradead.org,
        viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com,
        linux-fsdevel@vger.kernel.org, colin.king@canonical.com,
        Steve French <stfrench@microsoft.com>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
 <20210322051344.1706-3-namjae.jeon@samsung.com> <20210322064712.GD1667@kadam>
 <20210322065011.GA2909@lst.de>
From:   Stefan Metzmacher <metze@samba.org>
Subject: Re: [Linux-cifsd-devel] [PATCH 2/5] cifsd: add server-side procedures
 for SMB3
Message-ID: <7894be19-54f6-4c2c-daaa-1db03141e87c@samba.org>
Date:   Mon, 22 Mar 2021 14:25:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322065011.GA2909@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6UnFxiyjAB23kM2930rUzzDEuwXWMZy9h"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6UnFxiyjAB23kM2930rUzzDEuwXWMZy9h
Content-Type: multipart/mixed; boundary="4qSVWlLiwZ2A06gYey0rbvw7kWnkj4pov";
 protected-headers="v1"
From: Stefan Metzmacher <metze@samba.org>
To: Christoph Hellwig <hch@lst.de>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-cifs@vger.kernel.org, aurelien.aptel@gmail.com,
 linux-cifsd-devel@lists.sourceforge.net, senozhatsky@chromium.org,
 rdunlap@infradead.org, sandeen@sandeen.net, linux-kernel@vger.kernel.org,
 aaptel@suse.com, hch@infradead.org, viro@zeniv.linux.org.uk,
 ronniesahlberg@gmail.com, linux-fsdevel@vger.kernel.org,
 colin.king@canonical.com, Steve French <stfrench@microsoft.com>
Message-ID: <7894be19-54f6-4c2c-daaa-1db03141e87c@samba.org>
Subject: Re: [Linux-cifsd-devel] [PATCH 2/5] cifsd: add server-side procedures
 for SMB3
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
 <20210322051344.1706-3-namjae.jeon@samsung.com> <20210322064712.GD1667@kadam>
 <20210322065011.GA2909@lst.de>
In-Reply-To: <20210322065011.GA2909@lst.de>

--4qSVWlLiwZ2A06gYey0rbvw7kWnkj4pov
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


Am 22.03.21 um 07:50 schrieb Christoph Hellwig:
> On Mon, Mar 22, 2021 at 09:47:13AM +0300, Dan Carpenter wrote:
>> On Mon, Mar 22, 2021 at 02:13:41PM +0900, Namjae Jeon wrote:
>>> +static unsigned char
>>> +asn1_octet_decode(struct asn1_ctx *ctx, unsigned char *ch)
>>> +{
>>> +	if (ctx->pointer >=3D ctx->end) {
>>> +		ctx->error =3D ASN1_ERR_DEC_EMPTY;
>>> +		return 0;
>>> +	}
>>> +	*ch =3D *(ctx->pointer)++;
>>> +	return 1;
>>> +}
>>
>>
>> Make this bool.
>>
>=20
> More importantly don't add another ANS1 parser, but use the generic
> one in lib/asn1_decoder.c instead.  CIFS should also really use it.

I think the best would be to avoid asn1 completely in the kernel
and do the whole authentication in userspace.

The kernel can only deal this blobs here, I don't there's need to
look inside the blobs.

1. ksmbd-mount would provide a fixed initial blob that's always
   the same and will be returned in the
   "2.2.4 SMB2 NEGOTIATE Response" PDU as SecurityBuffer

2. The kernel just blindly forwards the SecurityBuffer
   of "2.2.5 SMB2 SESSION_SETUP Request" to userspace
   together with the client provided SessionId (from
   2.2.1.2 SMB2 Packet Header - SYNC) as well as
   negotiated signing and encryption algorithm ids
   and the latest preauth hash.

3. Userspace passes a NTSTATUS together with SecurityBuffer blob for the
   2.2.6 SMB2 SESSION_SETUP Response back to the kernel:

   - NT_STATUS_MORE_PROCESSING_REQUIRED (more authentication legs are req=
uired)
     SecurityBuffer is most likely a non empty buffer

   - NT_STATUS_OK - The authentication is complete:
     SecurityBuffer might be empty or not
     It also pass a channel signing key, a decryption and encrytion key
     as well as the unix token ( I guess in the current form it's only ui=
d/gid)
     down to the kernel

   - Any other status means the authentication failed, which is a hard er=
ror for the client

The PDU definitions are defined here:
https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/6eaf=
6e75-9c23-4eda-be99-c9223c60b181

I think everything else belongs to userspace.

Such a "simple" design for the kernel part, would mean that ksmbd-mount w=
ould do what the
kernel part is currently doing, but it also means it will be trivial to p=
lug the userspace
part to samba's winbindd in future order to get domain wide authenticatio=
n.

metze


--4qSVWlLiwZ2A06gYey0rbvw7kWnkj4pov--

--6UnFxiyjAB23kM2930rUzzDEuwXWMZy9h
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEfFbGo3YXpfgryIw9DbX1YShpvVYFAmBYmsQACgkQDbX1YShp
vVYCDA/9HKKADvAj1r/udNzjMzn+kT+4lpHFRzQltPBVe7JMdFry6XDgGe1DG8Gs
EHzPQpIOI2xJgOM+DnyIXM0DHnSrgjsYHsnQXikDYUw5gZMAx9djJI55ncFZrIj5
cvbM4zmflCwErzMBVu2535fUmKoMgv0ny5nYoL5wzqlD5kaAz3l30Nzlul7HwH6X
R7cZFrrKmO1h9Of5JOIicok5CieJgOq/1dcmilEJQ6P2sc9qYhnVlf2vnTSRWPbo
XtaIB7kawTE3QrCCdUu6FYQe5h6yxwl9bOKHVZ1IQ8d8JHszi0OHCF5Z3PcJLg5Q
n3vKFNMpeAeMjy813zSDvh6CDkgHsU/zkJnQeCu54Pe407NwoW9KSaDFG6PFZsyV
cGuHyShF7YRP5PScFsM5YSR29T6pzQDbLocsIcxoMawu7Ls3wYAa2W1fqH9ZmtgN
vyOQrP924JFkuxfpTlDygvYT/bnnos93tVBlX6Hq70LUcI5i1Thd6fQFEYcQ74zt
xxFx0bwXZxwPgaAWxySEegYBHnV8dxxj336e7LhRcMyBmn/tQo3Pjb+Lv2866wee
yqSMVDQX9sCXd7XIwewEN9fhZ3zvRmSNgPIdC82ge59LhT8oiYH/f2XHMc5/B/vY
+6wBng+/T/CNYdle2y1TCY4hRV58X0IdHDopdvxWogEG5Fvyx3w=
=n0tH
-----END PGP SIGNATURE-----

--6UnFxiyjAB23kM2930rUzzDEuwXWMZy9h--
