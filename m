Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858BF3E02F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 16:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbhHDOU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbhHDOU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:20:57 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB53C0613D5
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Aug 2021 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Date:Message-ID:From:Cc:To;
        bh=tMENpnDxmzpGuvHAfXHaXqijPV+OP0GQmGI11BQsBZU=; b=aNR1nHzWNCJ+LKNaCx+ArDloyj
        sJoC/bi0L7ghWjHE4ZTtzPwILumzwzjRUjGPvxhDBaSvXqgHXU7QR2iKvYmwfihUBtykOQWCTSdJe
        BwxLWwqCXSmQRI4NOwZHGcv4gLf5XnoA48CnDWN3TKYKWLQ4ev+nMsa2jFKYJyMAAbSnf5Ub918ui
        1wP0aQSHzhI7AtiJK4MG202aR0H7rSvvQmNhF1ytikKRvrobO4fQkUPx4mpye1tzdbrfvw7xbnUDC
        sCc6DDzOd2UgYL3rrJXFSfhhbG59NwQPwx1Ykzy7iCFm48FZ8EYMD4ELyfXLkJ3D8f9H7hEyfHlmm
        j0YGFX5i3CqC7ko4WisT1lJGOXqXdQnc7Eo00vfrLSmXEsZU0q7l3lj+JjgU8e5IIn2PYBxgrYYdp
        L+/BnToAcA4yvE8Psbzyilwfu2AcNrEEaYOrdO/zknp6YaooEmyuBlIcHPIXFIgg3VCVN9ElBYX52
        FGJAamoDrLHKq8T3yIHmjhN3;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1mBHlA-000c9s-56; Wed, 04 Aug 2021 14:20:40 +0000
Subject: Re: Allowed operations on O_PATH handles
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>, Rich Felker <dalias@libc.org>
References: <f183fb32-3f08-94f1-19b9-6fe2447b168c@samba.org>
 <CAOQ4uxgPK+cj2BMuA2EmfkygLmJj0gXk5mM3zZOw9ftR4+Mf1Q@mail.gmail.com>
From:   Ralph Boehme <slow@samba.org>
Message-ID: <7f86b231-c954-d44c-743e-23cf936b0098@samba.org>
Date:   Wed, 4 Aug 2021 16:20:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgPK+cj2BMuA2EmfkygLmJj0gXk5mM3zZOw9ftR4+Mf1Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Szmr5m0nY5h2sw0wTMZqNQh7X15Pz8CMM"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Szmr5m0nY5h2sw0wTMZqNQh7X15Pz8CMM
Content-Type: multipart/mixed; boundary="jwZUI34rGqAgj339XEpyzs6bD8iuKl5Vy";
 protected-headers="v1"
From: Ralph Boehme <slow@samba.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Aleksa Sarai <cyphar@cyphar.com>, Rich Felker <dalias@libc.org>
Message-ID: <7f86b231-c954-d44c-743e-23cf936b0098@samba.org>
Subject: Re: Allowed operations on O_PATH handles
References: <f183fb32-3f08-94f1-19b9-6fe2447b168c@samba.org>
 <CAOQ4uxgPK+cj2BMuA2EmfkygLmJj0gXk5mM3zZOw9ftR4+Mf1Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgPK+cj2BMuA2EmfkygLmJj0gXk5mM3zZOw9ftR4+Mf1Q@mail.gmail.com>

--jwZUI34rGqAgj339XEpyzs6bD8iuKl5Vy
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Amir!

Am 30.07.21 um 18:57 schrieb Amir Goldstein:
> On Fri, Jul 30, 2021 at 12:25 PM Ralph Boehme <slow@samba.org> wrote:
>> A recent commit 44a3b87444058b2cb055092cdebc63858707bf66 allows
>> utimensat() to be called on O_PATH opened handles.
>>
>> If utimensat() is allowed, why isn't fchmod()? What's the high level
>> rationale here that I'm missing? Why is this not documented in man ope=
nat.2?
>>
>=20
> As you noticed, there is no uniformity among the various filesystem sys=
calls,
> but there are some common guidelines.
>=20
> 1. O_PATH fds are normally provided as the dirfd argument to XXXat()
>      calls (such as utimensat()).

obvious.

> 2. When the syscall supports empty name with dirfd to represent the
>      O_PATH fd object itself, an explicit AT_EMPTY_PATH is required

If this is wanted, this is not documented in the manpage. Lacking any=20
other reference then reading kernel sources, I would say this is a bit=20
of a challenge for userspace developers. :)

>>   From man openat.2
>>
>>     O_PATH (since Linux 2.6.39)
>>
>>       Obtain a file descriptor that can be used for two purposes:
>>       to indicate a location in the filesystem tree and to perform
>>       operations that act purely at the file descriptor level. The
>>       file itself is not opened, and other file operations (e.g.,
>>       read(2),  write(2),   fchmod(2),   fchown(2),   fgetxattr(2),
>>       ioctl(2), mmap(2)) fail with the error EBADF.
>>       ...
>>
>> My understanding of which operations are allowed on file handles opene=
d
>> with O_PATH was that generally modifying operations would not be
>> allowed, but only read access to inode data.
>>
>=20
> I think the rationale is that they are allowed when a user explicitly
> requests to use them via a new XXXat(..., AT_EMPTY_PATH) API.
>=20
> write(),read(),mmap() are different because they access file data,
> so it is required that the file is "really open".
>=20
> Letting fgetxattr() accept an O_PATH was actually suggested [1],
> but the author (Miklos) dropped it shortly after, because there is
> already a safe API to achieve the same goal using magic /proc
> symlink (see details in [1]).

Yep, this is what we use in Samba.

>> Can someone please help me to make sense of this?
>>
>=20
> Does that answer your question or do you have other needs
> that the current API cannot provide?

Thanks for providing some pointers. The basic problem I see is the lack=20
of documentation of the API.

Thanks!
-slow


--jwZUI34rGqAgj339XEpyzs6bD8iuKl5Vy--

--Szmr5m0nY5h2sw0wTMZqNQh7X15Pz8CMM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+uLGCIokJSBRxVnkqh6bcSY5nkYFAmEKojcFAwAAAAAACgkQqh6bcSY5nkaR
jw/+N+nbUb9QKyjth3Bl7MmGo4pmlcIC6Nwf9WdfF3+0Pbf2uvAuE3kafjAfPraxhCmMcSy/jOUs
z9oLlLfEz51fyJJfJVoIQfbzute9SyGzQjZHSjN+HJL8EfYex4q95/DKyyBSt34IRm/TsiV5okyH
kNDhSGx9lfW+9D/y7FVdy2iQsf5f96QH3/SAR6hcFRan03Ua2plRaVreGmpusDvGmxRMm596dlRQ
HXR+g5BGxvjpSZRkIVxyyEUnGVizPNJIayG/z6ELg/GlFPuFptD+Yvv0KhHb3RkRospCurxa+LOy
KkFkfmTjm1tcumK8UiqbaRhENgSqO0vocduljUtKKMCEx7GF5ZR8KoDeYlcYM/hoNAOcAFjJoqrG
WxoFV1lz+Y3KXw2coNzCyGmQTGV9+PgYiT+KrPOlOW1fV/WTvJi17IQHOG2cSlOp0jqCSb6cSH8u
umIC4VFwT3cDNT10LBEiPU7NJO1Wtn3OUAgqNfeAaRINV6JoDwchi16DhfGsPOIDaObz08D4Wre4
rwnw9I/mjssiaLQ/dHch5jJx0zf4yoQNofHYptKw2n5NipklGRY2+xGkNxeHreNN12+ca8OK6whF
65KCFccaKNw+qYMAtYCGXzfUc3/YImLeSX+jO4tFSrXCvWChIg3/9vXCdkJ046ceGBgS7KBRIoWM
ejc=
=FafS
-----END PGP SIGNATURE-----

--Szmr5m0nY5h2sw0wTMZqNQh7X15Pz8CMM--
