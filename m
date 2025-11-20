Return-Path: <linux-fsdevel+bounces-69168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A45C71A62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 02:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A9F3E29734
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4883122B8A6;
	Thu, 20 Nov 2025 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIWEuPkS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3E227E83
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600741; cv=none; b=dPK85Aw7hP5QFKRLHI1UwBGxGJJOf4HXK4lwQo9GMmFe85wQWMNPy81WPVIc6e/0uivfTj4B7HFD+ibjCkwC0rf+7ZV3vtVa16P9J7YqkPs0O84Sgg9cJrN630KOn1yZfy03F0oAzBTaPTIDNRRhbBzsw5YhR67MLQ0zA1Rt9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600741; c=relaxed/simple;
	bh=foT51l3SMYD8vQYDcSkWyl6C8I+xUQKTEU0BRJ1mb6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeYf0vIjX6PdqV9GlGuCqu2h95g2zXW0nTx3XV9fzpQQQU2lTepxG0e8WnNqX+y3KxX8b5P1nvBDnzzwzVnEpLL4WdQv5OXQ4Gu9OJXP4kA8CgMMygCUg40zPW4s/uTcNF+dbfdZSs2QklRytCDHjMyJA/dDUycKMPHrndI6guw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIWEuPkS; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso289783d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 17:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763600739; x=1764205539; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/l5fUGyR93mLMU361mq1mXs+ZB/scP823W6nYMrNcwM=;
        b=hIWEuPkSF2EQZ0PWc21kBOrKj2Xavr4sgz/ObWINpumheKVT7JwIxmgPCZcTH3EDz6
         wIoXbTWi7RElJ1Ju/BOr9L2wUwYF7er2U13uG6K8O+LiLgiLigFafLK26VIpOhertqRB
         TRpMauifQwVqNlBTHa1N/CP9S/5gdk2mVPUfOdHean30dxVPKtlzKoKqoI4bH8Fpy8Uq
         7Am2wPYTK4fXLSQyVWjW6hNq59eGUV7GgKAf/ehN8mXhsyM5eHB+lOz0lTt5MDWo2qkp
         OZkSGA2uaEnn0gLTLCv1RGzMime/9ane1Ey0KLrgaButFY2XamDzgX+vXT2efdXtKYdc
         MScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763600739; x=1764205539;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l5fUGyR93mLMU361mq1mXs+ZB/scP823W6nYMrNcwM=;
        b=uQZtTgmE4zLg/t/dK1SO5yYyba0KlmhS5ZzL8yqnASR0TYTDQmKffdTG0D3WUuUgdO
         tyHVJ2uITzPcexlQxMppNnr8oiWJ2MzDnFcCCCvbmRMq2K1Qqzhen9JRltGR4HUDw7C4
         rkMvniYXwfL8Y4jJgAjcNn+hbT8QbeCOOtYJ8Og/65YstukepdTPz/SfvJvuXSwAfyMK
         Nd1aaqdIYfzp4xY929dolpXBoVvKF+JgDPhxf7BxvsulT3ROs/7c7G5/DsMzw5gdGjCK
         2eDAsPaiVXngpP+lfOMZP/z+7UOp3rCMi0NvtMHhlNk+cpvmERJcVGKOkVpTjGEmL1L2
         G+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmxCQOKrQQcy/8HqH6EERtYcPx1Mdr50zy+Gf8LiwgIZvpJY1s5fUmHF8xKOoZ8vIxii/XcCbXX/FYLVJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YwugGOKbiH+HTqAvrkIq60XCa6eaXTNbTxfu/DtH4VrfIj26mPD
	x9PHM1mqe4Gt5ajOzBNAJtZ2/BEFXxDPrbBa22XHCRwcPB3BZNvgM1QU
X-Gm-Gg: ASbGncvbR/arPpAxWh8RIsC6SogeaG6T7PkBxLK3vYZJDnB+Zy+tfOLgFtzi257/1v4
	YZSCgwoBcT8sjKsFATGn5z64tATeKtPZksoBC4gKY3NIuYBUIDwsUX07fGZtUqXe3fZxsSRRyXd
	Qk4mRpyPrCMfiXLX6qERA37NbTONlsaje0ubL03JLiQkfjAg/JSqYDZimxiSiQdExnYPlNDNcsU
	/zrsmW7W/IRsuky/jW2D6b22iGMkGYFaiNdQBqhiiulqAHnXLSDcQMu+M15DA71bKY+MBzU24lQ
	uxWO0+akzlPtCsNCjHtYCIqOg6qz1l7uS7p0N46ciH0pZ6+AYlbXfWYYB/Jbi7ogCERb0ewFt7S
	yXw27oadCw73BqWOnKhwJjvRAnvIy9zrdhL2F8WrHWiJj0vH+XMKCAhY8xjjqYmvoVrUHC6DqzL
	FhWecB7vperT4g/LXQ2B3/5YkQ9bUjBCgCUhwFXdybiDXp8/i5AGh3HwvPboS6IQx3VedNC2aEu
	Xuf4Ndktg+orXVKG8TK1F6yNv4=
X-Google-Smtp-Source: AGHT+IGw7yxIGSw7u4FYGXzH7RT7RuCw5Nv1lAb8nGjm9Zu4VXBRzQHCtVl5B7Gc3PSxL1WxO3VJVg==
X-Received: by 2002:a05:690e:1404:b0:63e:3296:8886 with SMTP id 956f58d0204a3-642f79e3f6fmr912994d50.42.1763600738566;
        Wed, 19 Nov 2025 17:05:38 -0800 (PST)
Received: from [10.138.34.110] (h96-60-249-169.cncrtn.broadband.dynamic.tds.net. [96.60.249.169])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-642f707a9b9sm371524d50.6.2025.11.19.17.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 17:05:37 -0800 (PST)
Message-ID: <be773548-2da5-4c95-a4fa-bf8ed3066bc0@gmail.com>
Date: Wed, 19 Nov 2025 20:05:33 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 zfs-devel@list.zfsonlinux.org
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
 <20251119180449.GS196358@frogsfrogsfrogs>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20251119180449.GS196358@frogsfrogsfrogs>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------S5C4tdGLAP0AjKQkvP9jFY0O"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------S5C4tdGLAP0AjKQkvP9jFY0O
Content-Type: multipart/mixed; boundary="------------NSEBSGoCKxMj93bMaVcZAtHW";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 zfs-devel@list.zfsonlinux.org
Message-ID: <be773548-2da5-4c95-a4fa-bf8ed3066bc0@gmail.com>
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
 <20251119180449.GS196358@frogsfrogsfrogs>
In-Reply-To: <20251119180449.GS196358@frogsfrogsfrogs>

--------------NSEBSGoCKxMj93bMaVcZAtHW
Content-Type: multipart/mixed; boundary="------------C6s7sC4jbxxpcVBTPW8SAxki"

--------------C6s7sC4jbxxpcVBTPW8SAxki
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you so much for the helpful responses!

On 11/19/25 13:04, Darrick J. Wong wrote:
> On Wed, Nov 19, 2025 at 04:19:36AM -0500, Demi Marie Obenour wrote:
>>> By keeping the I/O path mostly within the kernel, we can dramatically=

>>> increase the speed of disk-based filesystems.
>>
>> ZFS, BTRFS, and bcachefs all support compression, checksumming,
>> and RAID.  ZFS and bcachefs also support encryption, and f2fs and
>> ext4 support fscrypt.
>>
>> Will this patchset be able to improve FUSE implementations of these
>> filesystems?  I'd rather not be in the situation where one can have
>> a FUSE filesystem that is fast, but only if it doesn't support modern
>> data integrity or security features.
>=20
> Not on its own, no.

Not surprised.  I'm mostly curious if there is a path forward to add
such support in the future.

>> I'm not a filesystem developer, but here are some ideas (that you
>> can take or leave):
>>
>> 1. Keep the compression, checksumming, and/or encryption in-kernel,
>>    and have userspace tell the kernel what algorithm and/or encryption=

>>    key to use.  These algorithms are generally well-known and secure
>>    against malicious input.  It might be necessary to make an extra
>>    data copy, but ideally that copy could just stay within the
>>    CPU caches.
>=20
> I think this is easily doable for fscrypt and compression since (IIRC)
> the kernel filesystems already know how to transform data for I/O, and
> nowadays iomap allows hooking of bios before submission and/or after
> endio.  Obviously you'd have to store encryption keys in the kernel
> somewhere.
>=20
> Checksumming is harder though, since the checksum information has to be=

> persisted in the metadata somewhere and AFAICT each checksumming fs doe=
s
> things differently.  For that, I think the fuse server would have to
> convey to the kernel (a) a description of the checksum geometry and (b)=

> a buffer for storing the checksums.  On write the kernel would compute
> the checksum and write it to the buffer for the fs to persist as part o=
f
> the ioend; and for read the fuse server would have to read the checksum=
s
> into the buffer and pass that to the kernel.

That definitely sounds doable.  Bcachefs, and I believe ZFS and BTRFS,
store the checksum in the pointer.  This means that when the kernel
is asked to read data from the buffer, the checksum or authentication
tag is already available.

For CoW filesystems, there is still the problem that every write
requires a metadata operation.  Does that mean these filesystems
will not be able to benefit for writes?  Or can the latency be
hidden somehow?

> (Note that fsverity won't have this problem because all current
> implementations stuff the merkle tree in post-eof datablocks; the
> fsverity code only wants fses to read it in the pagecache; and pass it
> the page)
>=20
>> 2. Somehow integrate with the blk-crypto framework.  This has the
>>    advantage that it supports inline encryption hardware, which
>>    I suspect is needed for this to be usable on mobile devices.
>>    After all, the keys on these systems are often not even visible
>>    to the kernel, let alone to userspace.
>=20
> Yes, that would be even easier than messing around with bounce buffers.=


Makes sense.

>> 3. Figure out a way to make a userspace data path fast enough.
>>    To prevent data corruption by unprivileged users of the FS,
>>    it's necessary to make a copy before checksumming, compression,
>>    or authenticated encryption.  If this copy is done in the kernel,
>>    the server doesn't have to perform its own copy.  By using large
>>    ring buffers, it might be possible to amortize the context switch
>>    cost away.
>>
>>    Authenticated encryption also needs a copy in the *other* direction=
:
>>    if the (untrusted) client can see unauthenticated plaintext, it's
>>    a security vulnerability.  That needs another copy from server
>>    buffers to client buffers, and the kernel can do that as well.
>>
>> 4. Make context switches much faster.  L4-style IPC is incredibly fast=
,
>>    at least if one doesn't have to worry about Spectre.  Unfortunately=
,
>>    nowadays one *does* need to worry about Spectre.
>=20
> I don't think context switching overhead is going down.

I agree, at least for big CPUs.

>> Obviously, none of these will be as fast as doing DMA directly to user=

>> buffers.  However, all of these features (except for encryption using
>> inline encryption hardware) come at a performance penalty already.
>> I just don't want a FUSE server to have to pay a much larger penalty
>> than a kernel filesystem would.
>>
>> I'm CCing the bcachefs, BTRFS, and ZFS-on-Linux mailing lists.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------C6s7sC4jbxxpcVBTPW8SAxki
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49y
B+l2nipdaq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYf
bWpr/si88QKgyGSVZ7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/
UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7M
MPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9H
zx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS1pJ5EvU
T1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXs
BtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r
6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nS
m9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQAB
zTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhdGhlbmFAaW52aXNpYmxl
dGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/5wiwQUC
X6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0Y
R+YYC5Kduv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkB
oY6n/5lSJdfnuGd2UagZ/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3S
zk1OwFx2lzY1EnnconPLfPBc6rWG2moA6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDV
rGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQrqFDA7nBNiIVFDJTmQzuEqIy
Jl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1HL5VQCNQdqEc
/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQh
ra2u8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XI
Fl7aM2d6/GJiq6LC9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsN
xaQJH6VRK3NOuBUGeL+iQEVF5Xs6Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCu
fudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVNKyDP7lYpwc4nCCGNKCj622ZSocH
AcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM08RGVtaSBNYXJpZSBPYmVu
b3VyIChsb3ZlciBvZiBjb2RpbmcpIDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+wsF4
BBMBAgAiBQJafgNKAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyiLVf
/5wiwYa/EACv8a2+MMou9cSCNoZBQaU+fTmyzft9hUE+0d5W2UY1RY3OsjFIzm9R
/4SVccfsqOYLEo+S0vQMIIIqFEq3FCpXXwPzyimotps05VA8U3Bd7yseojFygOgK
sAMOAee2RCaDDOnoJue01dfZMzzHPO/TVdp3OvnpWipfv5G1Xg96rwbhMLE3tg6N
xwAHa31Bv4/Xq8CJOoIWvx6fcmZQpz01/lSvsYn0KrfEbTKkuUf0vM9JrCTCP2oz
VNN5BYzqaq2M4r+jmSyeXLim922VOWqGkUEQ85BSEemqrRS06IU6NtEMsF8EWt/b
hWjk/9GDKTcnpdJHTrMxTspExBiNrvpI2t+YPU5B/dJJAUxvmhFrbSIbdB8umBZs
I3AMYrEmpAbh5x7jEjoskUC7uN3o9vpg1oCLS2ePDLtAtyBtbHnkA4xGD7ar8mem
xpH9lY/i+sC6CyyIUWcUDnnagKyJP0m9ks0GLsTeOCA0bft2XA6rD6aaCnMUsndT
ctrab42CV5XypjmC4U1rPJ8JQJUh1/3P48/8sMH+3krxpJ06KNWNFaUbaMTGiltZ
7x9DngklSYrX0T+2G4kVXNmjaljwkoLahwLla2gUWwBSyofXdqyhQdwZsp01KXNQ
UCyT/Pg+aDcm/E7OMV3d4lf7g/CSxiX2GSEe6BlhSz+Lmd7ZJ3g32M1ARGVtaSBN
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
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------C6s7sC4jbxxpcVBTPW8SAxki--

--------------NSEBSGoCKxMj93bMaVcZAtHW--

--------------S5C4tdGLAP0AjKQkvP9jFY0O
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmkeaV4ACgkQszaHOrMp
8lMdUhAAmy3HPvqn0pAm3poG5XVRRaPgejZeFbyZlTnv3CFP52c7ZTD3x+FhzizB
aPi5CX/93MtXDarIJ5rrzs3yqS5hGxzgVpnu6jZTP3p627L8HtSCgSdJRZT7fzVz
ybkBxYxfg+rQsKny2hb7ztpgEaNVzwHQ/bjs4NvOOtmmCyDrEDqCJMdrCkN6zqNg
eeVusfdTrviySXsDbH9+jLZ5lkM5uUPzGMto+FJt5Nss7dTVpgh7gRPuSr//vQNL
l2eUX53dAOPNThIFA7gW0bk441YP/dUeOilBi0nHov6VMa+R/QTUop3gTnIytEHo
L1kxmF3A4L3SpThEqJrzr9Ii91HQhVUBuEnaW9YCglL+V9NXCTE3ZohgaD3zLPV9
njBMwKaOF1qoKGJQKq1zX1R7X9fIXj+7Qg3+352X87268facBWBIUFRZboHF/yd1
HVDCGlYceukztNPyT7VnSS7zE1vnhBDDfBv0Vb2nzAXl26+7sYBoJCNWeVckCdTZ
de7JnN0HMENih5JQtOuEGGTpVxS7aA1eU4nEAUALP300mVkR1UgohMLnUI1k+wIs
uKMwKUh0dMUjSB6woy/5WQAnEswYOmEVu0oxeyiJJj2/K5QuO0nvVuu05Tj+Roqn
nD98tPD9qy9/89Dtqep1w1g7fPqAkLGFqjIu31/jEzcvKEC+j+0=
=1gTC
-----END PGP SIGNATURE-----

--------------S5C4tdGLAP0AjKQkvP9jFY0O--

