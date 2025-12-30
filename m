Return-Path: <linux-fsdevel+bounces-72258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3CCEAF00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 00:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 751893059A45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 23:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18032B9B5;
	Tue, 30 Dec 2025 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY51M0NA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E22E62CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767138070; cv=none; b=dUIi7CMo2Kv6CjrjhckMm0VgdUF8pc9vNYV/tEhia7Cyo3J2ygCCrOVXwf7DbCJ1THntJfTBUFQrgTpZcpCDSJFul7FFilfYPVYbzpU1u5HZzTTJ41kH/bemO3pou3zJPYlqeIzFNKaR4B02AUmEdHFDPB7yaqfPcna+wavc6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767138070; c=relaxed/simple;
	bh=BsvELlz3UH73Y7kWFIntf28BZFpNM1YEJNvazcGtYeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5AIekOcq2W0VPWJgQ9SxX3sGKNOgm18tNnLp2CBpngFjaWrEp/GcGAcNMLX8ufxzZV/9aYEhBlafJCiaz21mAYETj8CK25E3WCeId7F7Aww9hUpkAWWnuD37fen11KczGlSId7GYbplKBEtLk3Quk7QeSc114R+fOfrHdVr+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY51M0NA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA029C2BCB1
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 23:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767138069;
	bh=BsvELlz3UH73Y7kWFIntf28BZFpNM1YEJNvazcGtYeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XY51M0NAioe/A21osIXsJAUkap8dKsAUwQNnl7i0Rm48FLR93k46q0kPZ0ruyZY6/
	 CsiqC+Nn5uRinsOUehUt77Uzbn0nk4gXW36Oto5ntXoOWCVmljx45JgDhFs52+UrDC
	 fnF+Odtyw93masp/Yy9/WvQfp7W7V6o6o9wrmGg5C8OgJxEaBvz+ZS46zpeUXxEBis
	 aFpEUunt9kzcZIYNOkLpKPyiMKOn9XW787nf2mMyqO7yYXLzdsh9Wl3rY7UQEAMjwj
	 d2+lWn/T7jnXlMLhOrcJ+EaHt7ODk6pSA8kG9kUvSLiahGbCxNxy9LvG5vyacBLQ9C
	 mJRCP+fDNw+0A==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7633027cb2so1886434266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 15:41:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWR9kmrCEuJzJwIUpkqBfCez64L9TMqNgZW9DVWz4DPcy2R9LZF6Ot/yhKowdECKr2ujr0bDBH42Ul94WOh@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGYfD5ATRpIGak5Drij7MuIfzbZqfqjQhIO7YON9y6vAjOpve
	DnIVXqqouIV2sycHtCMzUeCqgS/qEYVwFjK4iAgO6aboyu9x3qNyoFWueD8Y/rd4Ov806mxYZma
	/u6ON8zqVuFWeD8E14F0pd3yOxW115LM=
X-Google-Smtp-Source: AGHT+IEDylwEStzVUDt7rSI+xfIWWOEYhGSY4xkMs/Eguwk6Wdc40UMRc9hKR9nR6wgZlprlR8LqUnVqA6E9tK8E9Zo=
X-Received: by 2002:a17:907:9406:b0:b73:9792:919b with SMTP id
 a640c23a62f3a-b8036f0a57bmr3736453266b.13.1767138068278; Tue, 30 Dec 2025
 15:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <CAEg-Je9nZbN8LkjX2n9MqobXBv91NYZk5v08u1ptufn=hSXnCg@mail.gmail.com>
In-Reply-To: <CAEg-Je9nZbN8LkjX2n9MqobXBv91NYZk5v08u1ptufn=hSXnCg@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 31 Dec 2025 08:40:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-7voNQqfrLm=Jakee0YWMyZsyOwBrah=RfwCxjHpn1pw@mail.gmail.com>
X-Gm-Features: AQt7F2qyONIMGWA8SrGD8RZR_REgnUSmVFLb9xtWw6jn7pR8LSI0Hj_LMT7uR9Y
Message-ID: <CAKYAXd-7voNQqfrLm=Jakee0YWMyZsyOwBrah=RfwCxjHpn1pw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] ntfs filesystem remake
To: Neal Gompa <neal@gompa.dev>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:14=E2=80=AFAM Neal Gompa <neal@gompa.dev> wrote:
>
> On Mon, Dec 29, 2025 at 7:47=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.or=
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
> >
> >
> > References
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://en.wikipedia.org/wiki/NTFS
> > [2] https://github.com/ntfsprogs-plus/ntfsprogs-plus
> > [3] https://lore.kernel.org/ntfs3/CAOZgwEd7NDkGEpdF6UQTcbYuupDavaHBoj4W=
wTy3Qe4Bqm6V0g@mail.gmail.com/
> > [4] https://marc.info/?l=3Dlinux-fsdevel&m=3D161738417018673&q=3Dmbox
> >
> >
> > Available in the Git repository at:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git ntfs-=
next
> >
>
> Thanks for renaming this to ntfs. :)
>
> That said, are you able to make a commitment about journaling support
> work?
some people asked the same question, I said I would start that work as
soon as this upstream is finished.

> I vaguely recall that a similar promise was made with ntfs3 and,
> well... here we are.
I expected it would end up like this after all. But this time, it will
be different. In a similar case, when I upstreamed exfat filesystem,
Eric requested public utilities. After upstreaming exfat, we developed
and released exfatprogs, which included mkfs, fsck, dump, etc, and
currently, well-known CE vendors have adopted linux exfat driver and
exfatprogs for their products. I will maintain the new ntfs in the
same way.

>
> I would have preferred to see it as part of the initial upstreaming,
> but I'm equally fine with some kind of known timeline post merge for
> working on it.
>
> Thanks for this great work!
>
>
> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!

