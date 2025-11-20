Return-Path: <linux-fsdevel+bounces-69176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 528FBC71DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDF2B34CCF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 02:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F682EC56F;
	Thu, 20 Nov 2025 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa8H596M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298672C15B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 02:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763606385; cv=none; b=oramILPYuDLBzl2ncN/kCi5+Lck/AiycQOZtfW07RNwgKnb9ubSzYXcqmyGUKj+KK8ESGC5/Xxj1TEeE7mGY0xGbXj/OL81MBhOUEzl+3ExSHnSmpXjEPiIA5Ggbsx7SdjisKDnS/qoFttfO9xpoVKJlSPQzq0vm2Uk9L/sWrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763606385; c=relaxed/simple;
	bh=a0D237kTvqSy7G3B/ggbMldWsTQ5jNT9DYm7SEqR+4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gS4s6zYCZiUcB4GPMYJys7X5u7YFW//KLGmwaU156xXpZrPLVxSQBJSTq8jopgDlXua+pPJPvjulTWRpgL9llGf6sOAP7NzcJLxlh0IUviFNUaXEihfcHUFIDPMCvA0LTdDR+JsxcPzC5Xa8hTVgtVcL9MZUxgJBaHjotT2kgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa8H596M; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6420c0cf4abso293431d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 18:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763606383; x=1764211183; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/BGlbnjlK2xDtSVf8eh0jaXQUCtUbkhDDh5/hXYEJQ=;
        b=Pa8H596MjqDHZ7w/4/RAqbyZEu5/jmzrDTYvOijLIp4N+/slgMO+esbfuu7cwq/4y7
         HMdN1cOsyMek9MaG2ECnqmAVuG6aOxGpO84R4Cl0D0bDLA7G+XXT67lyNFX4Cdh/Zl3r
         8Fod67eQb7/kFRDjtqaUOfct+RTHT2KJAnatM6c5igXcOXs9lgKdK1lzcR3r9p2hsQi5
         5XJCBk647MSAD/mi8refomJqKxnG5nMaKL2gxcAskiia3w3XzHXcNb2Eol1Rsoywb7TL
         s9iexyh8iGThMbiiHOaGJ71QLrltD6nu6X5vJivJzuy6PwlP+53norpwZehfxvjO/rts
         F7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763606383; x=1764211183;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/BGlbnjlK2xDtSVf8eh0jaXQUCtUbkhDDh5/hXYEJQ=;
        b=L+/XmosWx0Tvpt1yX2jWl8NpccmFVpON/TX5mjUyBz7y83CWE3VFfGR7KFvwjsLjxL
         GMBaxHT+Ru4SqQyXfFxSO+cMotm3AXkgOP27xruzgjapJD/PqD53hg3rIv4+TRaOdnka
         oOxU/+ZPjTuxTk1Se7LB5xdi/2kZo0eg5svMC0rlr0n8SQnqNzUiiHt7WgwNtDQ48tBu
         sWFXYa2kHdmag87dgRBi5RPCTLhLKS86wiZ5nSGo1MWCBlLv+p2VACVjHhsuNNY32v0n
         b4w9U7a0cY0UBUJRkE6bzVHmNsxX8uuCSIDcOyljgKRdPUfNshYU7a4gJJksVubqF07X
         wNzg==
X-Gm-Message-State: AOJu0YwBDRZUrPKAKcS8b68iUUlJvw/ypy2QebXldZmxXN3/GwsaTThb
	hhpi9sgVSl+6FZljUYWU8iOplEaxqz87wyw+5UayOYB6jm30mjpyK+Lt
X-Gm-Gg: ASbGncsmErxrHLWiV9znIcT0Vl3eyUjFuvDFb9ixBTrQNicMhm4WwVrs+hRAe3I7NaV
	S0MDRAZzm6o0VpT9hCvBOqpiSnpd23cCwfkrdUoRJvHGX6o7uam23FJfGDhK6PIClGEU18ePBYf
	K+kPwMxwR8Pt22BeENlnV4DcvT97EV4zcZj8aHQTD/O6KE+VJG0W/cuKouUnNL6rh4ntAwc8qkJ
	LLEGurA+YPm3WPxxtPtfh8APvXfjacGwJ6A1CdZrWTQFRlQvZRHXNXanVwheeDhkrWd3shxwELp
	Yil4ylVv5EDLEU2SvG1/l5SQol1dU6tvYYjFJYOzW/Fi9nUdpduAmIqP+NkofTnxuVBlG9YbwWS
	jvJHMeLolaOchJzav4qujB4Hg/d+Hu1YmSxNagbgQ7gFxw4Exnk7nds9mRwrubAAfG0jemw6NcU
	kvw+opfsc7eyeDwycSyXZJpN0ijvMp4ipxH+WHKs6XlNGxRMIRJb7jN2GPDydrBIWF9tRPxoAvN
	CeUbFuHKAMtVQNN3HKUKDBmiwY=
X-Google-Smtp-Source: AGHT+IHBTuLq69Gvfbr66ez8lbBS1N4ktmEnj0xsmrMpR6VUfoQpjm/xu8sHO0mLgebF/zU8OV36Og==
X-Received: by 2002:a05:690e:14c1:b0:63e:1f47:f504 with SMTP id 956f58d0204a3-642f7da8b41mr984026d50.50.1763606382757;
        Wed, 19 Nov 2025 18:39:42 -0800 (PST)
Received: from [10.138.34.110] (h96-60-249-169.cncrtn.broadband.dynamic.tds.net. [96.60.249.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79925b99sm3837167b3.36.2025.11.19.18.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 18:39:42 -0800 (PST)
Message-ID: <cdf9deb2-7a09-48c5-97e2-2ea6d5901882@gmail.com>
Date: Wed, 19 Nov 2025 21:39:36 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of resolving untrusted paths with detached mount dirfd
To: Aleksa Sarai <cyphar@cyphar.com>, Alyssa Ross <hi@alyssa.is>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
 Bruce Fields <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
 David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Tycho Andersen <tycho@tycho.pizza>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
References: <87cy5eqgn8.fsf@alyssa.is>
 <2025-11-20-limber-salted-luncheon-scads-7AT044@cyphar.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <2025-11-20-limber-salted-luncheon-scads-7AT044@cyphar.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pQ0lEQ9hLDflRFiGxpQgU0gK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pQ0lEQ9hLDflRFiGxpQgU0gK
Content-Type: multipart/mixed; boundary="------------HMozd5V45JYglr0q2XDYAHfy";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: Aleksa Sarai <cyphar@cyphar.com>, Alyssa Ross <hi@alyssa.is>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
 Bruce Fields <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
 David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Tycho Andersen <tycho@tycho.pizza>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <cdf9deb2-7a09-48c5-97e2-2ea6d5901882@gmail.com>
Subject: Re: Safety of resolving untrusted paths with detached mount dirfd
References: <87cy5eqgn8.fsf@alyssa.is>
 <2025-11-20-limber-salted-luncheon-scads-7AT044@cyphar.com>
In-Reply-To: <2025-11-20-limber-salted-luncheon-scads-7AT044@cyphar.com>
Autocrypt-Gossip: addr=hi@alyssa.is; keydata=
 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
 wGxvGU7TX5ou

--------------HMozd5V45JYglr0q2XDYAHfy
Content-Type: multipart/mixed; boundary="------------FZH1bzujXbklYqgofMmGxWNw"

--------------FZH1bzujXbklYqgofMmGxWNw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/19/25 21:18, Aleksa Sarai wrote:
> On 2025-11-19, Alyssa Ross <hi@alyssa.is> wrote:
>> Hello,
>>
>> As we know, it's not safe to use chroot() for resolving untrusted path=
s
>> within some root, as a subdirectory could be moved outside of the
>> process root while walking the path[1].  On the other hand,
>> LOOKUP_BENEATH is supposed to be robust against this, and going by [2]=
,
>> it sounds like resolving with the mount namespace root as dirfd should=

>> also be.
>>
>> My question is: would resolving an untrusted path against a detached
>> mount root dirfd opened with OPEN_TREE_CLONE (not necessarily a
>> filesystem root) also be expected to be robust against traversal issue=
s?
>> i.e. can I rely on an untrusted path never resolving to a path that
>> isn't under the mount root?
>=20
> No, if you hit an absolute symlink or use an absolute path it will
> resolve to your current->fs->root (mount namespace root or chroot).
> However, OPEN_TREE_CLONE will stop ".." from naively stepping out of th=
e
> detached bind-mount. If you are dealing with procfs then magic-links ca=
n
> also jump out.

Is using open_tree_attr() with MOUNT_ATTR_NOSYMFOLLOW enough to prevent
these?  Will it still provide protection even if someone concurrently
renames one of the files out from under the root?  I know that can
escape a chroot, but I wonder if this provides more guarantees.
https://github.com/QubesOS/qubes-secpack/blob/main/QSBs/qsb-014-2015.txt
was the chroot breakout.

> You can always use RESOLVE_BENEATH or RESOLVE_IN_ROOT in combination
> with OPEN_TREE_CLONE.
Unfortunately not everything supports that.  For instance, mkdirat()
doesn't.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------FZH1bzujXbklYqgofMmGxWNw
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

--------------FZH1bzujXbklYqgofMmGxWNw--

--------------HMozd5V45JYglr0q2XDYAHfy--

--------------pQ0lEQ9hLDflRFiGxpQgU0gK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmkef2gACgkQszaHOrMp
8lO3ZhAAmZA03bcOAmYW6yxHo3mjR7tfRejmiIQemfIgZM9syr29NsKegdJKah/U
7L9YND6HgQmkVTMXN3gavdWNkgL80JbMvjC819kbOzcAlenw4WP0GqepVSGGMuia
xO9Osrfa7Ibj6Sa1pJ3EQCV+uyh84yIAivOmeY9BF9g9On84AHwH3nIPcNrihRfu
giz9whOaUISztCBVfm2YRXDMBk/jdeJP4swIN9oQLBFhaNVeP9VM6wWht8dWVoBZ
sVwB6F0h3Uzs9BHAvOv1WzmZUc+IEY2epHXq9A6KV9D3dsyiKBM6ppzvR0jXaNvU
eYq2AlHOpFZbTyX/N/f3VEJCe5QswGCNzIkB/1t7Q1gJRGGG+7ehjOMRc3txVlqc
Bkv2WamQMfDGO+zmLIEXGKpQnFPxm4TJbvl6i+UtckTvETQiioYZtlQvxK85Ij0x
CrKpTjGOYcJ0+vuJoL4t9OfDdAQS4xMEEwFFNC50VHRKhJ/HogCshZYhOeldyq7n
fpGMVVaKTHrDZz0QlsLeb2sqdWqDho4KR8jyCJ1OsCAQCzgvPg/KTqtD/hW3z8lI
fRRnERNCstJ5kLkksqgOV1tNBIPEHGzDKGvxzOQt6/q37j7U6LSZDbpfeO0dZT5N
p9oHusfbm6s5KOFLJFQIV84tOqWDHyJIckHg4VYznIJcGfsmPvU=
=h5sF
-----END PGP SIGNATURE-----

--------------pQ0lEQ9hLDflRFiGxpQgU0gK--

