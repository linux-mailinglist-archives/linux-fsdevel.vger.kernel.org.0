Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF7B1836FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 18:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCLRLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 13:11:23 -0400
Received: from hr2.samba.org ([144.76.82.148]:41420 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgCLRLV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=l3WEqW9aJTnPggmRYNuVaJbzRmwbUiGLn7NbD543xPs=; b=kPz0QwZ28DlSyux/DPK/xcMGkA
        5pauZM3WM1XgAbt7LWKhvANmYtqZ2WIRa+7odOjfBsu+F6LJi/TLhru9N77G3sUsl5Cxd8DXXYG/b
        sijGPJgnK1pH6dkwT52bM1SlZ8fvvYLHaiWQF+JI1jN4c0tbwITQnqXFLu6f6/YGXnXajOei2bEKz
        8cisBbEPf8U5iwjmoB+Laqv9iTfr06ydg1YLvePzgSFfHr7EvdEPIdtaKMH5OoeTVWbA+zge2XuqP
        LpesDJHxB5DTFEiG9xcH74HnndGFifo1cM2Rbw5elyVafV2KWV9EmdD20xHpoYtZnoHFy2PuGNhQd
        6AfILct/mmG8BGFE9IUOs3mDdObQzQNpCwtDwIswF+3OJhW1O11w6JbH+fJ/4VQriKYCv36KPvhoa
        6JQCmuCy58Mnp5jTGtaDL3mTRbJoGAXCeoWRWzDKHK3jud0JXgILa9g1GDI0mMDkq5EQE4z/Fo3tf
        +9T6VdQmnH1HsnvQauervqlB;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1jCRMa-0008BA-4k; Thu, 12 Mar 2020 17:11:16 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Allison <jra@samba.org>,
        =?UTF-8?Q?Ralph_B=c3=b6hme?= <slow@samba.org>,
        Volker Lendecke <vl@sernet.de>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
From:   Stefan Metzmacher <metze@samba.org>
Autocrypt: addr=metze@samba.org; prefer-encrypt=mutual; keydata=
 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
 t/YZOE37yKSj2rcCbqg=
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
Date:   Thu, 12 Mar 2020 18:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SzKuuk5XXqpdQwAWe2MRsuKrTxuD0xt8e"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SzKuuk5XXqpdQwAWe2MRsuKrTxuD0xt8e
Content-Type: multipart/mixed; boundary="cuifYNvqcph6ixorv5xP690zbG2MMcWDK";
 protected-headers="v1"
From: Stefan Metzmacher <metze@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
 Miklos Szeredi <mszeredi@redhat.com>,
 Christian Brauner <christian@brauner.io>, Jann Horn <jannh@google.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>, Karel Zak <kzak@redhat.com>,
 jlayton@redhat.com, Linux API <linux-api@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jeremy Allison <jra@samba.org>, =?UTF-8?Q?Ralph_B=c3=b6hme?=
 <slow@samba.org>, Volker Lendecke <vl@sernet.de>
Message-ID: <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
In-Reply-To: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>

--cuifYNvqcph6ixorv5xP690zbG2MMcWDK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 12.03.20 um 17:24 schrieb Linus Torvalds:
> On Thu, Mar 12, 2020 at 2:08 AM Stefan Metzmacher <metze@samba.org> wro=
te:
>>
>> The whole discussion was triggered by the introduction of a completely=

>> new fsinfo() call:
>>
>> Would you propose to have 'at_flags' and 'resolve_flags' passed in her=
e?
>=20
> Yes, I think that would be the way to go.

Ok, that's also fine for me:-)

>>> If we need linkat2() and friends, so be it. Do we?
>>
>> Yes, I'm going to propose something like this, as it would make the li=
fe
>> much easier for Samba to have the new features available on all path
>> based syscalls.
>=20
> Will samba actually use them? I think we've had extensions before that
> weren't worth the non-portability pain?

Yes, we're currently moving to the portable *at() calls as a start.
And we already make use of Linux only feature for performance reasons
in other places. Having the new resolve flags will make it possible to
move some of the performance intensive work into non-linux specific
modules as fallback.

I hope that we'll use most of this through io_uring in the end,
that's the reason Jens added the IORING_REGISTER_PERSONALITY feature
used for IORING_OP_OPENAT2.

> But yes, if we have a major package like samba use it, then by all
> means let's add linkat2(). How many things are we talking about? We
> have a number of system calls that do *not* take flags, but do do
> pathname walking. I'm thinking things like "mkdirat()"?)

I haven't looked them up in detail yet.
Jeremy can you provide a list?

Do you think we could route some of them like mkdirat() and mknodat()
via openat2() instead of creating new syscalls?

>> In addition I'll propose to have a way to specify the source of
>> removeat and unlinkat also by fd in addition to the the source parent =
fd
>> and relative path, the reason are also to detect races of path
>> recycling.
>=20
> Would that be basically just an AT_EMPTY_PATH kind of thing? IOW,
> you'd be able to remove a file by doing
>=20
>    fd =3D open(path.., O_PATH);
>    unlinkat(fd, "", AT_EMPTY_PATH);
>=20
> Hmm. We have _not_ allowed filesystem changes without that last
> component lookup. Of course, with our dentry model, we *can* do it,
> but this smells fairly fundamental to me.
>
> It might avoid some of the extra system calls (ie you could use
> openat2() to do the path walking part, and then
> unlinkat(AT_EMPTY_PATH) to remove it, and have a "fstat()" etc in
> between the verify that it's the right type of file or whatever - and
> you'd not need an unlinkat2() with resolve flags).

If that works safely for hardlinks and having another process doing a
rename between openat2() and unlinkat(), we could try that.

My initial naive idea was to have one syscall instead of
linkat2/renameat3/unlinkat2.

int xlinkat(int src_dfd, const char *src_path,
            int dst_dfd, const char *dst_path,
            const struct xlinkat_how *how, size_t how_size);

struct xlinkat_how {
       __u64 src_at_flags;
       __u64 src_resolve_flags;
       __u64 dst_at_flags;
       __u64 dst_resolve_flags;
       __u64 rename_flags;
       __s32 src_fd;
};

With src_dfd=3D-1, src_path=3DNULL, how.src_fd =3D -1, this would be like=

linkat().
With dst_dfd=3D-1, dst_path=3DNULL, it would be like unlinkat().
Otherwise a renameat2().

If how.src_fd is not -1, it would be checked to be the same path as
specified by src_dfd and src_path.

> I think Al needs to ok this kind of change. Maybe you've already
> discussed it with him and I just missed it.

This is the first time I'm discussing this.

Thanks for the useful feedback!
metze



--cuifYNvqcph6ixorv5xP690zbG2MMcWDK--

--SzKuuk5XXqpdQwAWe2MRsuKrTxuD0xt8e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEfFbGo3YXpfgryIw9DbX1YShpvVYFAl5qbS0ACgkQDbX1YShp
vVb5Xw/9E1xPwD9bV6gcU95apxGam3kjy1/9dK1kh9Zx6k9DtkAqAlsSVPyAGqY2
kgMRf/hVuuOkR+0wEkDNMFKyH2h9dVN0ddtbuDoa44WiFAmRPTAI7HoC4T0iOHV6
Z0vj808Xwn0M48HpS+WSV+vNzFuMGo4wLkvfxiJlioKBoxiiXnnZT52S38KeBFgj
Nin7t+3SdJ9LQWMxoP4yNBhAfYJLGzjwID4EsuD9VdCSLgc/GmatVPs/Bj8mEmef
As8MSEhakSiE+92N86V5XNA5fJs9KvirbKBokIIIKT5CelZOTTMollwNQGs/42Qo
TM3t4d6tE6bciEBO+AvMmdlKzbD57Lj8mO6Wj/fbkm8IiD7c9UAaRFEu2BnaBY/g
wvP/FUJ41eh/WWWOuvxN23XFvaPIj3ckfaR8OMdgkq3PxnI3pDX0ECW7iIhNMI3V
h9Cj/3wmjMh1fOqrpBdN/U83ncNUQzOBwoigc5Gf2WqrYr571FhPJ7VfgeCZ9SlT
QKCr4qwN4WUFSK5I/o3fZfwK6tyPHxeJvOuICVRT7ShtsQ/WfojhnJfsUbhlZc03
TywXtWTRWTuxOIcK5c+decGI6zTEGQz49Z8UTK7T/hBoDYa+PrgUyIYrz+O0/82B
//ZKMX9YviI5gHBDF4ROBJOyAbtjbTtA/6/8eNpbdCTPuyJ1DQQ=
=9LVB
-----END PGP SIGNATURE-----

--SzKuuk5XXqpdQwAWe2MRsuKrTxuD0xt8e--
