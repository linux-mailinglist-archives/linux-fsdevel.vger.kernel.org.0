Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9766631E393
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 01:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBRAvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 19:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhBRAvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 19:51:21 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D5C061786
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 16:50:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a9so277990plh.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 16:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=zSNf4zEuNYLh9QMwdOefeg3SBSqTSCCjWXcw+CrRYeA=;
        b=GzVD5J/6dJeN0jK3xbvCkp8GBwAAwhljwRmslFd4muzDOpkujDtF6E5+Zl0WpvCTvE
         yPV6zN+KMJw5bm0M7KOqLkbeQ/ygxqpRDpOzQjmkOrJgeS1bdnah5aMXIy7TxLHjdV8o
         i5mAiep1drpAq4ucXVs7JfAtWLqU2bvR0ZRLKAfjop8xup72eaibwmCrUtcwwdhA3nXw
         h6mk2yS6T/o35qsShtX6IISGJWFwk99clwsgtZokEaiY63g5nfZY6q3gxTQBZAsdGUnb
         frbN8/+6/uu2WqpEswBsbocNdKM2ZpfahYKnSt9ajNWFt8BJBaHjRKy6ligm/NrA7mrX
         u0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=zSNf4zEuNYLh9QMwdOefeg3SBSqTSCCjWXcw+CrRYeA=;
        b=CtgVH8cpJVwx+BVXGji99/ERHhsFLj65u1g6rwYr8QmmUsvs9uTRRplq38KWv0Qq9x
         /vC2CNC/HIMsqBTG2d8TsnNSc5TXwXq1yeLOXuShCQAggzNUy437Th2FcqOgCswVbLTw
         HHHM0alTm1E/6LGY9RofWf44Q43+sKcNeXI6ONKphtSCt8MQcPTKKiq0qRGy7JtOuW2P
         H6ZPvLXyeJXdAFpci4GiftxGOjqMXoFdorpkZh4XV/G914nS0G9JbL8wMnRvdIdziU+k
         q1h4ni3o5WXPGp7+1zFCwSdjAeJmqjKaD1t+zF8ssgnw2NhhyM6wjQGy/07KzmldMZo6
         dx/w==
X-Gm-Message-State: AOAM530ttxGMnISUTWQuWWRNGo743DWdqa2c40mzFn/SvME/xxyQzrxm
        0/HFoPQNJUW1Vus2bbU4/RI/fg==
X-Google-Smtp-Source: ABdhPJx5CdTywPoSpnizVseLRqF9GG0p/+HnFFJrSSYPz5qfEFA9aehylKSsOop09UGA3XRGPbYmuw==
X-Received: by 2002:a17:90b:ec5:: with SMTP id gz5mr1485070pjb.34.1613609440561;
        Wed, 17 Feb 2021 16:50:40 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j1sm3507363pfr.78.2021.02.17.16.50.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 16:50:39 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <216103D5-0575-4BFC-9802-2C21A1B12DF9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_78AEEB9E-A81A-43DA-9A4B-7AC7529D21C3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Date:   Wed, 17 Feb 2021 17:50:35 -0700
In-Reply-To: <CAOQ4uxii=7KUKv1w32VbjkwS+Z1a0ge0gezNzpn_BiY6MFWkpA@mail.gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Henriques <lhenriques@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de>
 <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
 <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
 <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com>
 <92d27397479984b95883197d90318ee76995b42e.camel@hammerspace.com>
 <CAOQ4uxjUf15fDjz11pCzT3GkFmw=2ySXR_6XF-Bf-TfUwpj77Q@mail.gmail.com>
 <87r1lgjm7l.fsf@suse.de>
 <CAOQ4uxgucdN8hi=wkcvnFhBoZ=L5=ZDc7-6SwKVHYaRODdcFkg@mail.gmail.com>
 <87blckj75z.fsf@suse.de>
 <CAOQ4uxiiy_Jdi3V1ait56=zfDQRBu_5gb+UsCo8GjMZ6XRhozw@mail.gmail.com>
 <874kibkflh.fsf@suse.de>
 <CAOQ4uxgRK3vXH8uAJKy8cFLL8siKnMMN8h6hx4yZeA5Fe0ZZYA@mail.gmail.com>
 <CAFX2Jfk0X=jKBpOzjq7k-U6SEwFn1Atw62BK2DzavM8XgeLUaQ@mail.gmail.com>
 <CAH2r5mvybG3mRUfHUub9B+nk5WrQ5Fvzu5pZ+ZynqZg4c4ct2A@mail.gmail.com>
 <CAOQ4uxhqaTUwD8Lw+9HWWj61EXRv4X-eE3u4DFeWnv_VOUZF5A@mail.gmail.com>
 <CAH2r5msmtuk0f8FuZxdRBQ2d_VKXexctcP0OmnLXoDEBien-nQ@mail.gmail.com>
 <CAOQ4uxii=7KUKv1w32VbjkwS+Z1a0ge0gezNzpn_BiY6MFWkpA@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_78AEEB9E-A81A-43DA-9A4B-7AC7529D21C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 17, 2021, at 1:08 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>=20
> You are missing my point.
> Never mind which server. The server does not *need* to rely on
> vfs_copy_file_range() to copy files from XFS to ext4.
> The server is very capable of implementing the fallback generic copy
> in case source/target fs do not support native =
{copy,remap}_file_range().
>=20
> w.r.t semantics of copy_file_range() syscall vs. the fallback to =
userespace
> 'cp' tool (check source file size before copy or not), please note =
that the
> semantics of CIFS_IOC_COPYCHUNK_FILE are that of the former:
>=20
>        rc =3D cifs_file_copychunk_range(xid, src_file.file, 0, =
dst_file, 0,
>                                        src_inode->i_size, 0);
>=20
> It will copy zero bytes if advertised source file size if zero.
>=20
> NFS server side copy semantics are currently de-facto the same
> because both the client and the server will have to pass through this
> line in vfs_copy_file_range():
>=20
>        if (len =3D=3D 0)
>                return 0;
>=20
> IMO, and this opinion was voiced by several other filesystem =
developers,
> the shortend copy semantics are the correct semantics for =
copy_file_range()
> syscall as well as for vfs_copy_file_range() for internal kernel =
users.
>=20
> I guess what this means is that if the 'cp' tool ever tries an =
opportunistic
> copy_file_range() syscall (e.g. --cfr=3Dauto), it may result in zero =
size copy.

Having a syscall that does the "wrong thing" when called on two files
doesn't make sense.  Expecting userspace to check whether source/target
files supports CFR is also not practical.  This is trivial for the
kernel to determine and return -EOPNOTSUPP to the caller if the source
file (procfs/sysfs/etc) does not work with CFR properly.

Applications must already handle -EOPNOTSUPP with a fallback, but
expecting all applications that may call copy_file_range() to be
properly coded to handle corner cases is just asking for trouble.
That is doubly true given that an existing widely-used tool like
cp and mv are using this syscall if it is available in the kernel.

Cheers, Andreas






--Apple-Mail=_78AEEB9E-A81A-43DA-9A4B-7AC7529D21C3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAtudsACgkQcqXauRfM
H+CO9g//WwBMyeIl911flDvwfLe5tUQtTs8/bVC4xjWR3LBb+PIqo8UfTbhe+9T6
18pmJ8bSza18bVv+TKZr0qVgJBb44/5dM9sIlFQth5VCSdQUJiqmLc2sGduO0DGh
f9tQmw+2wDtzhuAJyxL2Vz1jIDKPMjr91xODblzQ+fBa1d/H8N04vE7TPmI5mbWx
V3Hs7RlvMoYZ6ZqdQR9SJ2aDmJmMixkOnXVomDM0yEqCftZWLk8tI+n0aLkSfmqz
aQIYf2mFwJ6q+U6LoaRMqMG1malw75xcS+FkgddxvrYjLII/3ZJ8oe0/zkNuGxIF
OkQt6ghStT1zi6TU+IxP6Pdk5BPTWhF1EAFtHiKnuezPfCQlhABSmv4sru8jyArD
7zo7SoH/6Qu+/dSSLXYC1gma3eS6+e0NZrEVR655lBJy4hnssNJNRe5hlobtgTMr
5Dkim9EXb2qYUdf6SRA4oXA0JVbaL44F/QiPzeFXPcQWa6ACzf33sCSMyuM1KVHR
Q2o0dNkP3BettePxdN5dq0JkrSbQFVKZ9Tgb6nmw5lVWPXjBA/jU2Oj0zD9n/KbW
h9FijAV/QQBdylhuxrKZFayeOrk5cz3fGyerKAEjSMyJddFciZNewYv6RjVUYw19
6aoTk2cTs+9dfT/GDN5Af/QgJHu2J3+hWX2celNzL1ExUENIgtU=
=sggq
-----END PGP SIGNATURE-----

--Apple-Mail=_78AEEB9E-A81A-43DA-9A4B-7AC7529D21C3--
