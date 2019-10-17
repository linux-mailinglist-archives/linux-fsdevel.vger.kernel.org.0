Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587BFDA2B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 02:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391330AbfJQA1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 20:27:54 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:46992 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391385AbfJQA1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 20:27:54 -0400
Received: by mail-pl1-f179.google.com with SMTP id q24so211541plr.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 17:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=BqoeGV2D1N7EryAXqg8r4RvbJr4RaowdrbuQXkBcA0c=;
        b=M6NjSc0VpcusbErvX94N5vFyHJIe9z955Et8/7WwUJ96pQXgrxNSG5xLGCYcUgg0Xx
         jCk3TsE6cnwALZbb/Mz+TUB5ip8STKhWFVei+6dLhNOQYCg5RQ/t3IFLqmUn+REOVc2t
         nQClbNSwryIW518xgt/H7RdlkIU11gnFxElxVingbEk8SmsxL9r1lr70XwlQ/S06gNFa
         tcWMWIZHBGeZmefP6gcoBmIG1v9zyY6VTFRy09EZRw7ZG2nW5wYjR/mleg0CHQK8/nfZ
         8UvTdv2SpqPrIN96SvcFDHowmiZ0c65vuloW06zg0x9711/sqy+i1VOZHMEjQjLB+MWM
         Ezag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=BqoeGV2D1N7EryAXqg8r4RvbJr4RaowdrbuQXkBcA0c=;
        b=VRZUy3r5JuqhQNb8rUKu8r1Ms/Gz2KyhorosuhaA7ddXoJ4RJZFFY08pYfLu2kIP46
         TT/kdCmr94isLDEivjgfzUuk79FGyQi2Vd0UC6YngghKDTb1qQwIxzY0Lr1WAmAp0kgD
         ZpOyyWN1TZhEaFD4R04weAQM3s3508Fr/hs204LF504qgcHchy9sdvq2N/VUGDJV/W7a
         DPnL5llDiNcXE8E9GtZ1a7Novh4aRdJcs0SaayiayoM81XiqJuTaMgFsF6FQNPtpOj/G
         XQArg/eS7AJK2z0+NWVRNh2QEXLpo4i1EPzsijNqDwvYONYvnB/3RXPc/aQRBD37TQk0
         vOIw==
X-Gm-Message-State: APjAAAVMd8GLvsy5Zx+BPcfJf+HPaUw1jcRfNuIhA0UgYzu7iTE2NXFl
        mYWbT919Cd9IKkKMTY1rvZ0vJ74yVpftuw==
X-Google-Smtp-Source: APXvYqyVnqS8R6kiBVd1UhikRP3tFAnUu4QxHZ3R3dlXfqcDb3texdH1vZ4yq+LewHWu51lMsjddyg==
X-Received: by 2002:a17:902:700b:: with SMTP id y11mr1067105plk.29.1571272071882;
        Wed, 16 Oct 2019 17:27:51 -0700 (PDT)
Received: from [172.16.182.166] (pb6abe849.tokyff01.ap.so-net.ne.jp. [182.171.232.73])
        by smtp.gmail.com with ESMTPSA id s5sm285321pjn.24.2019.10.16.17.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 17:27:50 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <648712FB-0ECE-41F4-B6B8-98BD3168B2A4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_13619D83-4B15-42F9-B9D2-2D87D8B7FD21";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [Project Quota]file owner could change its project ID?
Date:   Wed, 16 Oct 2019 18:28:08 -0600
In-Reply-To: <20191016213700.GH13108@magnolia>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
 <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
 <20191016213700.GH13108@magnolia>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_13619D83-4B15-42F9-B9D2-2D87D8B7FD21
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 16, 2019, at 3:37 PM, Darrick J. Wong <darrick.wong@oracle.com> =
wrote:
>=20
> On Wed, Oct 16, 2019 at 07:51:15PM +0800, Wang Shilong wrote:
>> On Mon, Oct 14, 2019 at 12:41 AM Darrick J. Wong
>> <darrick.wong@oracle.com> wrote:
>>>=20
>>> On Sat, Oct 12, 2019 at 02:33:36PM +0800, Wang Shilong wrote:
>>>> Steps to reproduce:
>>>> [wangsl@localhost tmp]$ mkdir project
>>>> [wangsl@localhost tmp]$ lsattr -p project -d
>>>>    0 ------------------ project
>>>> [wangsl@localhost tmp]$ chattr -p 1 project
>>>> [wangsl@localhost tmp]$ lsattr -p -d project
>>>>    1 ------------------ project
>>>> [wangsl@localhost tmp]$ chattr -p 2 project
>>>> [wangsl@localhost tmp]$ lsattr -p -d project
>>>>    2 ------------------ project
>>>> [wangsl@localhost tmp]$ df -Th .
>>>> Filesystem     Type  Size  Used Avail Use% Mounted on
>>>> /dev/sda3      xfs    36G  4.1G   32G  12% /
>>>> [wangsl@localhost tmp]$ uname -r
>>>> 5.4.0-rc2+
>>>>=20
>>>> As above you could see file owner could change project ID of file =
its self.
>>>> As my understanding, we could set project ID and inherit attribute =
to account
>>>> Directory usage, and implement a similar 'Directory Quota' based on =
this.
>>>=20
>>> So the problem here is that the admin sets up a project quota on a
>>> directory, then non-container users change the project id and =
thereby
>>> break quota enforcement?  Dave didn't sound at all enthusiastic, but =
I'm
>>> still wondering what exactly you're trying to prevent.
>>=20
>> Yup, we are trying to prevent no-root users to change their project =
ID.
>> As we want to implement 'Directory Quota':
>>=20
>> If non-root users could change their project ID, they could always =
try
>> to change its project ID to steal space when EDQUOT returns.
>>=20
>> Yup, if mount option could be introduced to make this case work,
>> that will be nice.
>=20
> Well then we had better discuss and write down the exact behaviors of
> this new directory quota feature and how it differs from ye olde =
project
> quota.  Here's the existing definition of project quotas in the
> xfs_quota manpage:
>=20
>       10.    XFS  supports  the notion of project quota, which can be
>              used to implement a form of directory tree  quota  (i.e.
>              to  restrict  a directory tree to only being able to use
>              up a component of the filesystems  available  space;  or
>              simply  to  keep  track  of the amount of space used, or
>              number of inodes, within the tree).
>=20
> First, we probably ought to add the following to that definition to
> reflect a few pieces of current reality:
>=20
> "Processes running inside runtime environments using mapped user or
> group ids, such as container runtimes, are not allowed to change the
> project id and project id inheritance flag of inodes."
>=20
> What do you all think of this starting definition for directory =
quotas:
>=20
>       11.    XFS supports the similar notion of directory quota.  The
> 	      key difference between project and directory quotas is the
> 	      additional restriction that only a system administrator
> 	      running outside of a mapped user or group id runtime
> 	      environment (such as a container runtime) can change the
> 	      project id and project id inheritenace flag.  This means
> 	      that unprivileged users are never allowed to manage their
>              own directory quotas.
>=20
> We'd probably enable this with a new 'dirquota' mount option that is
> mutually exclusive with the old 'prjquota' option.

I don't think that this is really "directory quotas" in the end, since =
it
isn't changing the semantics that the same projid could exist in =
multiple
directory trees.  The real difference is the ability to enforce existing
project quota limits for regular users outside of a container.  =
Basically,
it is the same as regular users not being able to change the UID of =
their
files to dump quota to some other user.

So rather than rename this "dirquota", it would be better to have a
an option like "projid_enforce" or "projid_restrict", or maybe some
more flexibility to allow only users in specific groups to change the
projid like "projid_admin=3D<gid>" so that e.g. "staff" or "admin" =
groups
can still change it (in addition to root) but not regular users.  To
restrict it to root only, leave "projid_admin=3D0" and the default (to
keep the same "everyone can change projid" behavior) would be -1?

Cheers, Andreas

>>> (Which is to say, maybe we introduce a mount option to prevent =
changing
>>> projid if project quota *enforcement* is enabled?)
>>>=20
>>> --D


Cheers, Andreas






--Apple-Mail=_13619D83-4B15-42F9-B9D2-2D87D8B7FD21
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl2ntZgACgkQcqXauRfM
H+D+3g/9Hibb7xuUxOK+zGcIr8/YlprNOfZRj23nSnWyOGXKxLTSiyNIIaEFSVbP
xSVQyb79LcKJ8MxkAcLgo9eVY8zCXpOcZE+MxTsrcYO1WA5H0u7H+9cmXbip7gkq
+Ldkt/iz3/9CWljcljjgxL2OyMnarPnvky0VfjGWQ320t45Na4Z2LLqneebUPJEW
Vw46ndio/CxbdAVizU78TexD63hAIruWbQ210ZUxeFD2fGW2Ksv1KYu10AIQjtmQ
OvpIbovuBSaO9xQnNpx8BmodrOC4ubk68b4dcntBp9ZgM8h0Xjh/uPmCXo6HkJg1
y1XYiOOdBefHxQmpbGb/YnLmMw65xKYAnpz4sr14bGnWDDJy88hzNkn7OhaH7ij3
qbQN17APTY10loDkdJ4XTthpaKqgK0NfjBuwnm5FYrmHMGoT/DpJU8Sxwt3Lxcgi
kcRKshgs9SgW8gVjv9IVFqhN/08ZpA9/3uRXMZqwpE7Bq5CaymNgJ4MrDOrCyrMz
PmYeQwFWECzFN87hFNrzBTzEi/tilsHmG1D763a+RZVU7cyI8J0JcsHPl50pSp9F
2oRASO/yGinj8sjSqykV686ZQjif4UqmzWVqsbYDost1KvJdEzGKaja/rClotVzO
BIO61AFChHHD2AZcX9ul8I8PmSJd9cPMOPZ8aZDfiCcqbwhSuyI=
=lB9i
-----END PGP SIGNATURE-----

--Apple-Mail=_13619D83-4B15-42F9-B9D2-2D87D8B7FD21--
