Return-Path: <linux-fsdevel+bounces-72212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F12CE836B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 22:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 304183015A99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237BC2E7BC2;
	Mon, 29 Dec 2025 21:26:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C701244675
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767043579; cv=none; b=KAG8zLkUkRqZ9ODz87Xoel4ArazfIcW0EHI3IcKmYuKVn8uYcT5FXtdOOrTVS6o4xpE3Uhc/AHoEwQfj2n487ZYCqsfkmlBAIW23Q6MBdpqspIlS6hWfL+e5TRR9qQ3vMuVLvtHy2kGuxwDCdBWOdrv56dvBRUU90F14gIq1fQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767043579; c=relaxed/simple;
	bh=7Cl2BxazGeNhCTQ3ThrrMJ+GeESqgMBoGanH1493pvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV29R4tSQ8UkLag77/FiyGKU3Pi0cVhNXfhfZsLhCAfHw7QwxnEjjIHiWFhS/MPC8XlcAeuzEhoaTIqJrpZBMY8r0KQ5nnzB6+IUuxVZQe15PcxKXE/lltA4O8latHMUJ9d6+LOC3g4Quu8pj9+bK2RdTz0HD+o1lmBquH+cWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee158187aaso103162221cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 13:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767043577; x=1767648377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/BdjzZK0893AWS7SkJkqlA6nknxVuhpl0UQfOQftyY=;
        b=SkK+r5XUeilDIoX+xm8jTtZoBBAbTvzQtXZOgUNZO4cTXADyLhK8BtCKy5qfqEvQws
         3Ibl8BcSJVKBbsWuGI5e8ZWCDO4kYiQw7EC4xHa7yMK2v+pelXsj7LcDXPwJOPkhV7mt
         SaSzJps6mt5nENec3vpk9VfXkEVQuwIBbPYtEe6+oqdzx/Zj0M3Pc1TL8qrcJKkoy84q
         RV5Nc6OqpLWO15MZaINXstadodZQD7bq2SSW8wM4qH/SxL61C4NtYdTjdgiBavxmif5C
         OW3YH2kTnd67lJ7YLVegTYsIqzq65fHhUeX/cDLs/IzAXk0z+cq973cUj4nsvBSNnkiY
         quvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzWMk6VJY80PgoaqzlJ0Fkjk3WRQ2QgAsmTDt6Q9omJ0BRmjCSPAkNXQmTM4T3nJLgrBVyzyKhf6fDKAn9@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTrCsce5Xuq7hnZauqwDBeghKQEwBdxZ9R60Mj5h/rP6BGNxo
	BVNHI81mO7U8CjjjFrbx3Y1AiLoDBigYlTVsI67lEU/QRtaCvPYxsJGQVwA44Q==
X-Gm-Gg: AY/fxX4p+pBwqJ2a1Ys7JtoSRJMp78pIs5KajlzsjxvfMyaTQBReevCMn8RUU+1w0VO
	vz9QYSilHj19Bfe0v7TjLatp/azw+hPl/7oFGxGF9dUF6yJzu431ysoBv8+kOd8AGKV8kEP0CcX
	csNJ9jSU/9fUNXXDeD7uUxLxQzWxJYSgatIj5CQU458Y+IhiwY1Ss7ugBBLvsnz5eYfiDmXt5KQ
	aeSJZ2CrQIfTu7rIPWVL1Qo7Vhg0FvrNa1uLYxSZlmwrSq2dbeVJlHAeqkXBsufow7zVCQkL1dc
	OoxGhGs2BkyFQjejmYJJQaVQ2L0zVYZJN1vbGY84WN7E0yzODwsBpHfXDh6oQ39QAU369pf8Ulo
	iA0g4Oa6/fbd3S73F8iMIJfmz9kR2tRmaZmxcnU0HTa4UntIUO4JzXUHE69pGdyM5umPyTaymoT
	onlTT3nQ5vkZzdeYJR3y3Nnah2DuMAlrxIbgO+NR7W62yvl+fDNlIHtxqqgL1qwtvX2Dp5x6f3Y
	mL12MBUur0=
X-Google-Smtp-Source: AGHT+IEn9u8QQJQis8sFomuI3Uqh7ZW+nbVxA4akYtWnFRbtNsJxuGTxr0wE9h2tO5arcFIYa2Rkxw==
X-Received: by 2002:a05:6808:191b:b0:450:42c9:4cd0 with SMTP id 5614622812f47-457b20f8f9cmr14531228b6e.49.1767036994524;
        Mon, 29 Dec 2025 11:36:34 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b39f22e2sm15130165b6e.0.2025.12.29.11.36.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 11:36:34 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c75a5cb752so6566207a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 11:36:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9Fyx8RqqMf7UTP7yc5IU68Ol/DFXDmE07lTk1JxghSocwAwjWMda/mYlrZi2jR5cPr60mo2cdJZQcgeYX@vger.kernel.org
X-Received: by 2002:a05:6830:2541:b0:7ca:e8bf:8c4c with SMTP id
 46e09a7af769-7cc668c4b01mr22448712a34.12.1767036993906; Mon, 29 Dec 2025
 11:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org>
In-Reply-To: <20251229105932.11360-1-linkinjeon@kernel.org>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 29 Dec 2025 14:35:57 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9nZbN8LkjX2n9MqobXBv91NYZk5v08u1ptufn=hSXnCg@mail.gmail.com>
X-Gm-Features: AQt7F2qGXuUpzXWgFWB_-8JBQOPu4uJApopkEkRE5odvQUOmYeNh1oSOpLtzfHw
Message-ID: <CAEg-Je9nZbN8LkjX2n9MqobXBv91NYZk5v08u1ptufn=hSXnCg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] ntfs filesystem remake
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 7:47=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The NTFS filesystem[1] still remains the default filesystem for Windows
> and The well-maintained NTFS driver in the Linux kernel enhances
> interoperability with Windows devices, making it easier for Linux users
> to work with NTFS-formatted drives. Currently, ntfs support in Linux was
> the long-neglected NTFS Classic (read-only), which has been removed from
> the Linux kernel, leaving the poorly maintained ntfs3. ntfs3 still has
> many problems and is poorly maintained, so users and distributions are
> still using the old legacy ntfs-3g.
>
> The remade ntfs is an implementation that supports write and the essentia=
l
> requirements(iomap, no buffer-head, utilities, xfstests test result) base=
d
> on read-only classic NTFS.
> The old read-only ntfs code is much cleaner, with extensive comments,
> offers readability that makes understanding NTFS easier. This is why
> new ntfs was developed on old read-only NTFS base.
> The target is to provide current trends(iomap, no buffer head, folio),
> enhanced performance, stable maintenance, utility support including fsck.
>
>
> Key Features
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Write support:
>    Implement write support on classic read-only NTFS. Additionally,
>    integrate delayed allocation to enhance write performance through
>    multi-cluster allocation and minimized fragmentation of cluster bitmap=
.
>
> - Switch to using iomap:
>    Use iomap for buffered IO writes, reads, direct IO, file extent mappin=
g,
>    readpages, writepages operations.
>
> - Stop using the buffer head:
>    The use of buffer head in old ntfs and switched to use folio instead.
>    As a result, CONFIG_BUFFER_HEAD option enable is removed in Kconfig al=
so.
>
> - Public utilities include fsck[2]:
>    While ntfs-3g includes ntfsprogs as a component, it notably lacks
>    the fsck implementation. So we have launched a new ntfs utilitiies
>    project called ntfsprogs-plus by forking from ntfs-3g after removing
>    unnecessary ntfs fuse implementation. fsck.ntfs can be used for ntfs
>    testing with xfstests as well as for recovering corrupted NTFS device.
>
> - Performance Enhancements:
>
>    - ntfs vs. ntfs3:
>
>      * Performance was benchmarked using iozone with various chunk size.
>         - In single-thread(1T) write tests, ntfs show approximately
>           3~5% better performance.
>         - In multi-thread(4T) write tests, ntfs show approximately
>           35~110% better performance.
>         - Read throughput is identical for both ntfs implementations.
>
>      1GB file      size:4096           size:16384           size:65536
>      MB/sec       ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
>      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>      read          399 | 399           426 | 424           429 | 430
>      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>      write(1T)     291 | 276           325 | 305           333 | 317
>      write(4T)     105 | 50            113 | 78            114 | 99.6
>
>
>      * File list browsing performance. (about 12~14% faster)
>
>                   files:100000        files:200000        files:400000
>      Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
>      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>      ls -lR       7.07 | 8.10        14.03 | 16.35       28.27 | 32.86
>
>
>      * mount time.
>
>              parti_size:1TB      parti_size:2TB      parti_size:4TB
>      Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
>      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>      mount        0.38 | 2.03         0.39 | 2.25         0.70 | 4.51
>
>    The following are the reasons why ntfs performance is higher
>     compared to ntfs3:
>      - Use iomap aops.
>      - Delayed allocation support.
>      - Optimize zero out for newly allocated clusters.
>      - Optimize runlist merge overhead with small chunck size.
>      - pre-load mft(inode) blocks and index(dentry) blocks to improve
>        readdir + stat performance.
>      - Load lcn bitmap on background.
>
> - Stability improvement:
>    a. Pass more xfstests tests:
>       ntfs passed 287 tests, significantly higher than ntfs3's 218.
>       ntfs implement fallocate, idmapped mount and permission, etc,
>       resulting in a significantly high number of xfstests passing compar=
ed
>       to ntfs3.
>    b. Bonnie++ issue[3]:
>       The Bonnie++ benchmark fails on ntfs3 with a "Directory not empty"
>       error during file deletion. ntfs3 currently iterates directory
>       entries by reading index blocks one by one. When entries are delete=
d
>       concurrently, index block merging or entry relocation can cause
>       readdir() to skip some entries, leaving files undeleted in
>       workloads(bonnie++) that mix unlink and directory scans.
>       ntfs implement leaf chain traversal in readdir to avoid entry skip
>       on deletion.
>
> - Journaling support:
>    ntfs3 does not provide full journaling support. It only implement jour=
nal
>    replay[4], which in our testing did not function correctly. My next ta=
sk
>    after upstreaming will be to add full journal support to ntfs.
>
>
> The feature comparison summary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> Feature                               ntfs       ntfs3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> Write support                         Yes        Yes
> iomap support                         Yes        No
> No buffer head                        Yes        No
> Public utilities(mkfs, fsck, etc.)    Yes        No
> xfstests passed                       287        218
> Idmapped mount                        Yes        No
> Delayed allocation                    Yes        No
> Bonnie++                              Pass       Fail
> Journaling                            Planned    Inoperative
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://en.wikipedia.org/wiki/NTFS
> [2] https://github.com/ntfsprogs-plus/ntfsprogs-plus
> [3] https://lore.kernel.org/ntfs3/CAOZgwEd7NDkGEpdF6UQTcbYuupDavaHBoj4WwT=
y3Qe4Bqm6V0g@mail.gmail.com/
> [4] https://marc.info/?l=3Dlinux-fsdevel&m=3D161738417018673&q=3Dmbox
>
>
> Available in the Git repository at:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git ntfs-ne=
xt
>

Thanks for renaming this to ntfs. :)

That said, are you able to make a commitment about journaling support
work? I vaguely recall that a similar promise was made with ntfs3 and,
well... here we are.

I would have preferred to see it as part of the initial upstreaming,
but I'm equally fine with some kind of known timeline post merge for
working on it.

Thanks for this great work!


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

