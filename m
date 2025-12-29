Return-Path: <linux-fsdevel+bounces-72192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226CCE72E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3227302219A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822F32ABF7;
	Mon, 29 Dec 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIJTlIXv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C3329E49
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021293; cv=none; b=Rn2t2Tr68mE0jxJM0/kw2iyIatepo/gR1i45mHsaqlysZ8XOKp3dq/vtlEEUkSDYy5Zvdp68k+iN5p3no9oP2ux2vd9zMAn7VgZedFjWtiyOEktUGyF/k9H1t41Cin0E/VJY4aqQE5CpsDqw5+RisPYxC3FXMrGyGWuWYNJ8rIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021293; c=relaxed/simple;
	bh=+Fos5eePOJ0yhdB5+kRJzq9nkMbQ52dfJFrqKsUYizw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nC68COaM+pqNyvuQrgBfp567yCDq++nigGY9olbtWQ+Ln99vyCWw+2J8buN4y0i5XXMJyF486P7Z5VchTsr+qv4gU8MgHZco3EQ7dSa7MZZ4EuzZdxxDPoAbO0aIh7nTxd7FFVomSWo6y3tP4Iw289DiWHmevP0ifzPQ+p5aZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIJTlIXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1ADC19421
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767021292;
	bh=+Fos5eePOJ0yhdB5+kRJzq9nkMbQ52dfJFrqKsUYizw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BIJTlIXvN9XvbdZsJQ41tIiiVrrNyK6bL+6Wd6KMgw00jmO7bV15rdAZfo4e4eqVc
	 x15paqNDrvfdjt3UwKsMkddi6Dgn2vWIf4DCUsCrwCmQoQehNnhO+oxfGZ0QhBq3dl
	 3rq3VmS3PldanVI73UHLz/N5z0obwpiz+sHYuJSfyNo2wuyTWRs7Y6sNy5w89Xplk+
	 V6tqezLhl6xiPN2cS0xPuZrnNbgkCqhfLmxveDa8+3172j2FKQ+JguyEXnd2Ou72iZ
	 eEnTFXkMg4IF16KE+4W2RZdkkn5tM3iJAyNdUv0kQvjzSWRMiaZNFNV54R0LS09Vo/
	 YwWin7HIYsC+A==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so10463158a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 07:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxy8TsBmmr/IY6Vxfp2OnkjhMyfuCr5FLe0v/fCRjTaMusHUHN0TDU75n1ZO3lg/zLrXwgm/VkvigWAgUu@vger.kernel.org
X-Gm-Message-State: AOJu0YwITiVBl2bCBaiXYSm02Gz0/pUXFns4dk29uRIvj5uM1TXTP/Ur
	nSCPOE9fyxjlHIqoYnUVdERPPuJtMzSpRyFDxPriYJSA5DuqPeE9L8XcqIOMcUrbJzXyPRyIuiz
	ZEgZe4MteQDLRIydFmsWoSSH4/K/EDRw=
X-Google-Smtp-Source: AGHT+IE82hyVLO5kcLrGnP2UzTgF/aw5R4tdYKj9Q5q5MgoxUb0P7/IOM90R3TdeILJh/4dTtBwitRH96gfY3ifEsGo=
X-Received: by 2002:a05:6402:4312:b0:64b:48b1:7c12 with SMTP id
 4fb4d7f45d1cf-64b8e82b896mr29949028a12.3.1767021291189; Mon, 29 Dec 2025
 07:14:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <CAOQ4uxgSJXrQ5YEzEZrP5yFobzcHBShwSUX9DvHsmex0w-d5uQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgSJXrQ5YEzEZrP5yFobzcHBShwSUX9DvHsmex0w-d5uQ@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Dec 2025 00:14:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-HPvJonfjsvmaHJ08TKh1QywqLO5fAQM8q7HHihK93PA@mail.gmail.com>
X-Gm-Features: AQt7F2qY5ZpJf2FbLGTKnR9q3FsZfIfKHdBj8k0WhqXrMKR3xehxnExXrJiABko
Message-ID: <CAKYAXd-HPvJonfjsvmaHJ08TKh1QywqLO5fAQM8q7HHihK93PA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] ntfs filesystem remake
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 11:34=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Mon, Dec 29, 2025 at 2:45=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > Introduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The NTFS filesystem[1] still remains the default filesystem for Windows
> > and The well-maintained NTFS driver in the Linux kernel enhances
> > interoperability with Windows devices, making it easier for Linux users
> > to work with NTFS-formatted drives. Currently, ntfs support in Linux wa=
s
> > the long-neglected NTFS Classic (read-only), which has been removed fro=
m
> > the Linux kernel, leaving the poorly maintained ntfs3. ntfs3 still has
> > many problems and is poorly maintained, so users and distributions are
> > still using the old legacy ntfs-3g.
> >
> > The remade ntfs is an implementation that supports write and the essent=
ial
> > requirements(iomap, no buffer-head, utilities, xfstests test result) ba=
sed
> > on read-only classic NTFS.
> > The old read-only ntfs code is much cleaner, with extensive comments,
> > offers readability that makes understanding NTFS easier. This is why
> > new ntfs was developed on old read-only NTFS base.
> > The target is to provide current trends(iomap, no buffer head, folio),
> > enhanced performance, stable maintenance, utility support including fsc=
k.
> >
> >
> > Key Features
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - Write support:
> >    Implement write support on classic read-only NTFS. Additionally,
> >    integrate delayed allocation to enhance write performance through
> >    multi-cluster allocation and minimized fragmentation of cluster bitm=
ap.
> >
> > - Switch to using iomap:
> >    Use iomap for buffered IO writes, reads, direct IO, file extent mapp=
ing,
> >    readpages, writepages operations.
> >
> > - Stop using the buffer head:
> >    The use of buffer head in old ntfs and switched to use folio instead=
.
> >    As a result, CONFIG_BUFFER_HEAD option enable is removed in Kconfig =
also.
> >
> > - Public utilities include fsck[2]:
> >    While ntfs-3g includes ntfsprogs as a component, it notably lacks
> >    the fsck implementation. So we have launched a new ntfs utilitiies
> >    project called ntfsprogs-plus by forking from ntfs-3g after removing
> >    unnecessary ntfs fuse implementation. fsck.ntfs can be used for ntfs
> >    testing with xfstests as well as for recovering corrupted NTFS devic=
e.
> >
> > - Performance Enhancements:
> >
> >    - ntfs vs. ntfs3:
> >
> >      * Performance was benchmarked using iozone with various chunk size=
.
> >         - In single-thread(1T) write tests, ntfs show approximately
> >           3~5% better performance.
> >         - In multi-thread(4T) write tests, ntfs show approximately
> >           35~110% better performance.
> >         - Read throughput is identical for both ntfs implementations.
> >
> >      1GB file      size:4096           size:16384           size:65536
> >      MB/sec       ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
> >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> >      read          399 | 399           426 | 424           429 | 430
> >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> >      write(1T)     291 | 276           325 | 305           333 | 317
> >      write(4T)     105 | 50            113 | 78            114 | 99.6
> >
> >
> >      * File list browsing performance. (about 12~14% faster)
> >
> >                   files:100000        files:200000        files:400000
> >      Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
> >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> >      ls -lR       7.07 | 8.10        14.03 | 16.35       28.27 | 32.86
> >
> >
> >      * mount time.
> >
> >              parti_size:1TB      parti_size:2TB      parti_size:4TB
> >      Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
> >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> >      mount        0.38 | 2.03         0.39 | 2.25         0.70 | 4.51
> >
> >    The following are the reasons why ntfs performance is higher
> >     compared to ntfs3:
> >      - Use iomap aops.
> >      - Delayed allocation support.
> >      - Optimize zero out for newly allocated clusters.
> >      - Optimize runlist merge overhead with small chunck size.
> >      - pre-load mft(inode) blocks and index(dentry) blocks to improve
> >        readdir + stat performance.
> >      - Load lcn bitmap on background.
> >
> > - Stability improvement:
> >    a. Pass more xfstests tests:
> >       ntfs passed 287 tests, significantly higher than ntfs3's 218.
> >       ntfs implement fallocate, idmapped mount and permission, etc,
> >       resulting in a significantly high number of xfstests passing comp=
ared
> >       to ntfs3.
> >    b. Bonnie++ issue[3]:
> >       The Bonnie++ benchmark fails on ntfs3 with a "Directory not empty=
"
> >       error during file deletion. ntfs3 currently iterates directory
> >       entries by reading index blocks one by one. When entries are dele=
ted
> >       concurrently, index block merging or entry relocation can cause
> >       readdir() to skip some entries, leaving files undeleted in
> >       workloads(bonnie++) that mix unlink and directory scans.
> >       ntfs implement leaf chain traversal in readdir to avoid entry ski=
p
> >       on deletion.
> >
> > - Journaling support:
> >    ntfs3 does not provide full journaling support. It only implement jo=
urnal
> >    replay[4], which in our testing did not function correctly. My next =
task
> >    after upstreaming will be to add full journal support to ntfs.
> >
> >
> > The feature comparison summary
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > Feature                               ntfs       ntfs3
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > Write support                         Yes        Yes
> > iomap support                         Yes        No
> > No buffer head                        Yes        No
> > Public utilities(mkfs, fsck, etc.)    Yes        No
> > xfstests passed                       287        218
> > Idmapped mount                        Yes        No
> > Delayed allocation                    Yes        No
> > Bonnie++                              Pass       Fail
> > Journaling                            Planned    Inoperative
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> For completion of this report, are the 287 passed xfstests a super set
> of the 218
> passed xfstest for ntfs3?
> IOW, are there any known functional regressions from ntfs3 to ntfs?
There are 9 testcases that passed in ntfs3 but fail in ntfs.
I will fix them on v4.
Thanks!
>
> Thanks,
> Amir.

