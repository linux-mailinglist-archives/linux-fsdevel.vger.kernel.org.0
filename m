Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3524EE26CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 01:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405883AbfJWXBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 19:01:53 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:41566 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392721AbfJWXBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:01:52 -0400
Received: by mail-pf1-f171.google.com with SMTP id q7so13835085pfh.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=M3Izv4zYvsPCQGZTCVMh5p2AvtGKSoEwW/Qg1q7QOpE=;
        b=EUWVSFnlRHDB7MFe+Cm4GinvGqI5Veh7OhQQE9gQXllLDfqsqxxL360MktsY2UZnOl
         UKKg6xwNxR2JoH2ordXCigmM6u72sAFQFf/kEmoWijKf1K/X15Bt0CArRRpi9iVPQ7Tl
         Y0WFrjzK/UaJiqgWXoFVXyuGq3AMRzpCTmZMpWuHbL+M3HtqarYc6uTyvpeixF1EvwUM
         li3N4cmJtCBgKBPhbZ3wFaNkz69X3UWvs7x7A03LNAJ8MBYfNG3uhbWiGC1lTOlq5Wrt
         OvqHzvFspY0GCnGD5hrJe/6IhSkjPTW/zQ4csNgnyrRr6FKq/gCCSEPhPYAc69V3RjBi
         nC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=M3Izv4zYvsPCQGZTCVMh5p2AvtGKSoEwW/Qg1q7QOpE=;
        b=rdMdsHFDT/2+qgxw7hBfJ5ltQqBRaBcWMb1j//OqdW4HHJ5lzDQPrLXFfoKdHyclnN
         QYtU3z+IdVmBbWP999nvs732BYNpfo+UIMM0ByXKPG0xHfVZClUSwS2f7wt9pZMbuJsN
         MkVA6OD6ICvNjZ5iP6JvYlTDtxKh6Juo8B7bn/0UKcxZJ1UQFJrYCIRBgDdG8caeaff9
         /a6SbPzC6oy7/e9FHqAT3j/7uaXyQU1puYgJkJXF9FDvgmsxSsfLbdtYvQWBOiTkj0zI
         J5vUakELhAne3wwbBv+BY8hBqvYyOljGIT65jfN65ycxz1FjImerSO/wP0naJGVFu9JO
         9wnw==
X-Gm-Message-State: APjAAAXnE34fW/vh/Z9x0Adcke4ETO7QK/fGsN639iAjJCmBwm8OPuAv
        2H7XWXtAKePXNdBd02CbmKBUEQ+rh2pVaw==
X-Google-Smtp-Source: APXvYqyB9qiIhT7UDS9a1R1+JB4JeKS88ujI+U600TjnM+AgL0cVKiid2x0a2ir8cMIrO71VdEUY2g==
X-Received: by 2002:a17:90a:e98d:: with SMTP id v13mr3074311pjy.64.1571871711197;
        Wed, 23 Oct 2019 16:01:51 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f59sm718376pje.0.2019.10.23.16.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 16:01:50 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6B0D1F84-0718-4E43-87D4-C8AFC94C0163@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0D8D4D2E-196C-4E8B-AA07-E8ED797281B3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [Project Quota]file owner could change its project ID?
Date:   Wed, 23 Oct 2019 17:01:45 -0600
In-Reply-To: <20191021233547.GA2681@dread.disaster.area>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
To:     Dave Chinner <david@fromorbit.com>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
 <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
 <20191016213700.GH13108@magnolia>
 <648712FB-0ECE-41F4-B6B8-98BD3168B2A4@dilger.ca>
 <20191021233547.GA2681@dread.disaster.area>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_0D8D4D2E-196C-4E8B-AA07-E8ED797281B3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 21, 2019, at 5:35 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Wed, Oct 16, 2019 at 06:28:08PM -0600, Andreas Dilger wrote:
>> On Oct 16, 2019, at 3:37 PM, Darrick J. Wong =
<darrick.wong@oracle.com> wrote:
>>>=20
>>> On Wed, Oct 16, 2019 at 07:51:15PM +0800, Wang Shilong wrote:
>>>> On Mon, Oct 14, 2019 at 12:41 AM Darrick J. Wong
>>>> <darrick.wong@oracle.com> wrote:
>>>>>=20
>>>>> On Sat, Oct 12, 2019 at 02:33:36PM +0800, Wang Shilong wrote:
>>>>>> Steps to reproduce:
>>>>>> [wangsl@localhost tmp]$ mkdir project
>>>>>> [wangsl@localhost tmp]$ lsattr -p project -d
>>>>>>   0 ------------------ project
>>>>>> [wangsl@localhost tmp]$ chattr -p 1 project
>>>>>> [wangsl@localhost tmp]$ lsattr -p -d project
>>>>>>   1 ------------------ project
>>>>>> [wangsl@localhost tmp]$ chattr -p 2 project
>>>>>> [wangsl@localhost tmp]$ lsattr -p -d project
>>>>>>   2 ------------------ project
>>>>>> [wangsl@localhost tmp]$ df -Th .
>>>>>> Filesystem     Type  Size  Used Avail Use% Mounted on
>>>>>> /dev/sda3      xfs    36G  4.1G   32G  12% /
>>>>>> [wangsl@localhost tmp]$ uname -r
>>>>>> 5.4.0-rc2+
>>>>>>=20
>>>>>> As above you could see file owner could change project ID of file =
its self.
>>>>>> As my understanding, we could set project ID and inherit =
attribute to account
>>>>>> Directory usage, and implement a similar 'Directory Quota' based =
on this.
>>>>>=20
>>>>> So the problem here is that the admin sets up a project quota on a
>>>>> directory, then non-container users change the project id and =
thereby
>>>>> break quota enforcement?  Dave didn't sound at all enthusiastic, =
but I'm
>>>>> still wondering what exactly you're trying to prevent.
>>>>=20
>>>> Yup, we are trying to prevent no-root users to change their project =
ID.
>>>> As we want to implement 'Directory Quota':
>>>>=20
>>>> If non-root users could change their project ID, they could always =
try
>>>> to change its project ID to steal space when EDQUOT returns.
>>>>=20
>>>> Yup, if mount option could be introduced to make this case work,
>>>> that will be nice.
>>>=20
>>> Well then we had better discuss and write down the exact behaviors =
of
>>> this new directory quota feature and how it differs from ye olde =
project
>>> quota.  Here's the existing definition of project quotas in the
>>> xfs_quota manpage:
>>>=20
>>>      10.    XFS  supports  the notion of project quota, which can be
>>>             used to implement a form of directory tree  quota  (i.e.
>>>             to  restrict  a directory tree to only being able to use
>>>             up a component of the filesystems  available  space;  or
>>>             simply  to  keep  track  of the amount of space used, or
>>>             number of inodes, within the tree).
>>>=20
>>> First, we probably ought to add the following to that definition to
>>> reflect a few pieces of current reality:
>>>=20
>>> "Processes running inside runtime environments using mapped user or
>>> group ids, such as container runtimes, are not allowed to change the
>>> project id and project id inheritance flag of inodes."
>>>=20
>>> What do you all think of this starting definition for directory =
quotas:
>>>=20
>>>      11.    XFS supports the similar notion of directory quota.  The
>>> 	      key difference between project and directory quotas is the
>>> 	      additional restriction that only a system administrator
>>> 	      running outside of a mapped user or group id runtime
>>> 	      environment (such as a container runtime) can change the
>>> 	      project id and project id inheritenace flag.  This means
>>> 	      that unprivileged users are never allowed to manage their
>>>             own directory quotas.
>>>=20
>>> We'd probably enable this with a new 'dirquota' mount option that is
>>> mutually exclusive with the old 'prjquota' option.
>>=20
>> I don't think that this is really "directory quotas" in the end, =
since it
>> isn't changing the semantics that the same projid could exist in =
multiple
>> directory trees.
>=20
>=20
> The quota ID associated with a directory is an admin choice - admins
> are free to have multiple directories use the same quota ID if
> that's how they want to control usage across those directories.

Sure, I understand that, and am not suggesting anything change here.

> i.e. "directory quota" does not mean "quota IDs must be unique for
> different directory heirarchies", it just means quota IDs are
> assigned to new directory entries based on the current directory
> quota ID.

Essentially you mean "PROJID_INHERIT" is the difference between
"project quota" and "directory quota"?

>> The real difference is the ability to enforce existing
>> project quota limits for regular users outside of a container.
>> Basically, it is the same as regular users not being able to
>> change the UID of their files to dump quota to some other user.
>=20
> No, no it isn't - project IDs are not user IDs. In fact, UIDs and
> permission bits are used to determine if the user has permission to
> change the project ID of the file. i.e. anyone who can write data to
> the file can change the project ID and "dump quota to some other
> user".

I fully understand that project IDs do no controlling file access.
That is IMHO one of the benefits of project quotas - that users can be
grouped together without automatically granting file access permissions.
My point is that people use quotas to track and limit space usage.  In
this regard, "project quotas" are only "project accounting" since can
be set arbitrarily, which inhibits the ability to limit project space
usage.

> That's the way it's always worked, and there are many users out
> there that rely on users setting project quotas correctly for their
> data sets. i.e. the default project quota is set up as a directory
> quota and they are set low to force people creating large data sets
> account them to the project that the space is being used for.

While this may be the way it's always worked, several new sites using
project quotas found this completely unintuitive.  Their objection is
that the benefit of project quota tracking is lost if users can easily
circumvent the tracking itself.  If there are no restrictions on which
projid values can be set on a file, how do users even know if they are
not arbitrarily using conflicting or incorrect projid values?

> IOWs, directory-based project quotas and project-based project quotas
> are often used in the same filesystem, and users are expected to
> manage them directly.
>=20
> What is being asked for here is a strict interpretation of directory
> quotas to remove the capability of mixing directory and project
> based quotas in the one filesystem. That's not the same thing as
> an "enforced project quota".

Might I ask how would you implement "enforced project quota"?  =
Presumably
it mush prevent users from changing the project ID of a file =
arbitrarily,
as is allowed today?  It isn't a rhetorical question, I'm genuinely
interested what you would do as this is what users are asking for.

>> So rather than rename this "dirquota", it would be better to have a
>> an option like "projid_enforce" or "projid_restrict", or maybe some
>=20
> If only specific admins can change project quotas, then the only way
> that project quotas can be used is either:
>=20
> 	1. inherit project ID from parent directory at create time;
> 	or
> 	2. admin manually walks newly created files classifying them
> 	into the correct project after the fact.
>=20
> #2 is pretty much useless to anyone - who wants to look at thousands
> of files a day and classify them to this project or that one? I
> haven't seen that admin model in use anywhere in the real world.

I wouldn't imagine admins doing this on a file-by-file basis either.

Rather, non-root admins could create new project directories (e.g.
when a new project is added to a system) and/or (in presumably rare
cases) change the projid of an existing tree.  This wouldn't be any
different than admins doing other quota admin, and not needing root
to do it is good security practice.

> Which leaves #1 - default project IDs inherited from the parent
> directory, and users can't change them. And that is the very
> definition of a strict directory quota...

I've previously steered away from using the term "directory quota"
(even though that's what exists in other filesystems) because it
isn't what it is called in XFS.

> Quite frankly, people are going to understand what "dirquota" means
> and how it behaves intuitively, as opposed to having to understand
> what a project quota is, how project IDs work and what the magical
> "projid_restrict" mount option does and when you'd want to use it.

Naming of the mount option aside, I don't see a tangible difference
in complexity for users to understand what a project ID is whether
they are allowed to change it or not?

Note users *could* still change the project ID of files even if project
quota is enforced by moving the files into a different directory that
has a different project ID assigned. The current XFS/ext4 implementation
returns -EXDEV for rename() between directories with different projid,
forcing userspace to do a file copy.  It isn't clear to me that this
restriction is useful (for ext4 at least, you wrote previously that
there were implementation complexities for XFS for this case), since
userspace doing "copy + unlink" is not really a win in my books.

It seems possible to change the projid directly in ext4 on rename() to
that of the target directory, assuming the user has write permission.
That shouldn't be more complex than chgrp() changing the group quota
of a file, or in case the user currently changes the projid directly
and assigns quota to a new project (ext4_ioctl_setproject() calling
__dquot_transfer(inode, <new projid>))?

> They do the same things - one API is easy to understand for users,
> the other is a horrible "designed by an engineer to meet a specific
> requirement" interface. I know which one I'd prefer as a user...

It isn't clear to me what you are unhappy about?  Is it the mount option
naming?  Feel free to suggest something better.  Some alternatives =
"setprojid=3Don/off/setprojid_gid=3DN", =
"dirquota/nodirquota.dirquota_gid=3DN",
or something else?  It doesn't seem to me that having a different *name*
for the mount option turns functionality from "intuitive" to "horrible"
in one shot (especially since the admin only has to set this once), so
I'm genuinely at a loss how "chattr -p <any_projid> <file>" (or =
equivalent
XFS command) being allowed/forbidden for a regular user is a "horrible"?

Cheers, Andreas






--Apple-Mail=_0D8D4D2E-196C-4E8B-AA07-E8ED797281B3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl2w29kACgkQcqXauRfM
H+CwmQ//WhZaEHOFBBdI5qWyay2qZGXtM6PXZ9ZMHWOTqmdTHiXJCVbFIMZXe16o
8wh87iqz5m2/UYvnwUQiwA2nf5biVeet1pMrG7vlqBPGT2L/67PN4metSAXl+dEh
Ad0n5oyM8mp+BwrtUQ7qvxgQdhhVzhPVUNByWsEElcHd52wN0t9SJ9wT11hB5YAX
KdcimtrlNyZBr3te4uL12foNRYq790oCJSW3ryLqSXRmO2g80opLMwc9kjLpjUA/
hPMJU3qPHgO6HgqScNJAyn+slLRZzHIbvNlwIgvuITh7opKh7syQxO5OdT7tZF/S
DN5r6ZC1UK+ampMfFS8+Crev0Eolrb7Xn7KI8xBRUkbUQvaoO0R4XP8viy9/WdM9
eWtHhSrKpfnp33r89PXZX3t8/x6covEKtbZ3jpHH1z4Q5GtPTc59tQhEWr3sGv42
gX6y++z+geEEqt3lJ9aktWrIUjwhUpj7cV1fwdWcwTR7LN6977i8a1ak9QV/ilFW
V5xobxOdUTPWm6cy3eC6sVAblVOkgo0+Rdqk/uzNaur7+1fov7mjDUiSHuBN83WN
1BBLU9wxN6RaW37J5mPS8i67JqdIANW/rW8x3YAT7HqnYdRnBqgKChsYUbRRCAdo
yRRr/bqBli1LcvuDpaLRd/OeBTjEAZqT0p9ux4vjiC7arugDT1s=
=0u/3
-----END PGP SIGNATURE-----

--Apple-Mail=_0D8D4D2E-196C-4E8B-AA07-E8ED797281B3--
