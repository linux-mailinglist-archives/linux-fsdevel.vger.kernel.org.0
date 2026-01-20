Return-Path: <linux-fsdevel+bounces-74578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2661D3C01B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E65403C6D8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9EB352F9A;
	Tue, 20 Jan 2026 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjrgFJNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820036CDFC
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892616; cv=none; b=HlhANG4i5eR2GVLaOtN6OHVFBIhsQY+F9Olt7p5u8pOMPahVUxNMOTiBPDcz27xLSitzACwoNc+t/uR97Xi4Z/Eag36fb2FmYYI/1lQfJMw0QJ/vb4ofMQWAc3O5nEBMlCJLajZWBfkmUmYiq4KFO8Zx4ZkiB2FkbQ5ydY7RCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892616; c=relaxed/simple;
	bh=LB/pk6+cWL0bUvqa3iZr7NhJSwVRRnNcJLFUvxN8UVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl6iIB5mqh8sFKSNaMS4+XkpITQefeXLTMtI7Lut43IHEPzQv5Ubu8yV1JSTH1ifqXgaNpYURhYBNHQ1/m1rvnc3R/Z1t5Z5WBfc+GiKXDz1XLfw4/CHZBgysmI9GUCvtF6KutRWXg/jYQqYcP68jL6w3w+ujzg4iR8A5GeA4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjrgFJNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CA7C4AF0D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 07:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768892614;
	bh=LB/pk6+cWL0bUvqa3iZr7NhJSwVRRnNcJLFUvxN8UVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XjrgFJNmdnGVcQCIW/0+rkUaeUrWOhrC2CWYRWIw16hL0OkiwvlbJokqknNi3hHNs
	 SQslIZcit7lk4PnBDu2UnFRlmtvMsZGPQ5OV6yB7ybAt9MslD8z3R6hhXYkuKrd6nX
	 CxOjgsFgph7IfiQ7W75XDNZ9UR3M2+SFuQt2xkqMZOodPJZ6d7BpszxWoYSKv+Ppwq
	 X4LOuF5JaDR8FPHTAEFpqoK7nyb2pTczlkkPb0xkfZub2ecY6S+kDQXIxx9vL6dnHH
	 usTdiFMb0djA/FeinvuHDUfUnVhGkAzxc2C0SGqyMyv3EBfZ9VSFinPvNtqTZD0k0b
	 yMUSwbtSkW12g==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b871cfb49e6so809326966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 23:03:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfqu5KsjUJsc0qpFzXa7hlYgkOofB0yLcH9uYshivN63MpV8Qw2cLnjc0Hobp0mdBNeYUwmrH4oD8sw1yQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9g/Q5HmBrPwaiMFXhr28DXDkxOrj+dDgmd9JhLcqY9WnuLEK+
	RSm3xI4r9GHiaA7HgjGQ7DK1YIkm5WTGsOR6aem7u6iJ/Pappdpu7073uKhLZELo1zMHzvNiGtE
	D4HwDPsmfC0F0h84J4gpa2De11kt4Ps0=
X-Received: by 2002:a17:906:f597:b0:b73:8639:334a with SMTP id
 a640c23a62f3a-b87968d0c82mr1122273666b.13.1768892612735; Mon, 19 Jan 2026
 23:03:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-3-linkinjeon@kernel.org>
 <20260116082352.GB15119@lst.de> <CAKYAXd9SeJYhBOOK6rZ+0c4G42wvFZkjJ9vGnSrythsz55WLwA@mail.gmail.com>
 <20260119070527.GB1480@lst.de> <CAKYAXd_Kio7Xeh1SnbZtxrh8nvenQ8RZ59p9RyhE2MSSUbjnMw@mail.gmail.com>
 <20260120064032.GA3350@lst.de>
In-Reply-To: <20260120064032.GA3350@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Jan 2026 16:03:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8utJ-Ejs-1o4qd=ZRYGPoeTuCzbAWpAe_8mPRpJqrgBQ@mail.gmail.com>
X-Gm-Features: AZwV_QgGqyqGVynaZBVb6vLgDGyHyxsUn6K9TqSbWcQ1uFaQtiYLJdTZ5-q0lqQ
Message-ID: <CAKYAXd8utJ-Ejs-1o4qd=ZRYGPoeTuCzbAWpAe_8mPRpJqrgBQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] ntfs: update in-memory, on-disk structures and headers
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 3:45=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Jan 20, 2026 at 01:27:55PM +0900, Namjae Jeon wrote:
> > On Mon, Jan 19, 2026 at 4:05=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> > >
> > > On Sun, Jan 18, 2026 at 01:54:06PM +0900, Namjae Jeon wrote:
> > > > > It seem like big_ntfs_inode is literally only used in the convers=
ion
> > > > > helpers below.  Are there are a lot of these "extent inode" so th=
at
> > > > > not having the vfs inode for them is an actual saving?
> > > > Right, In NTFS, a base MFT record (represented by the base ntfs_ino=
de)
> > > > requires a struct inode to interact with the VFS. However, a single
> > > > file can have multiple extent MFT records to store additional
> > > > attributes. These extent inodes are managed internally by the base
> > > > inode and do not need to be visible to the VFS.
> > >
> > > What are typical numbers of the extra extent inodes?  If they are rar=
e,
> > > you might be able to simplify the code a bit by just always allocatin=
g
> > > the vfs_inode even if it's not really used.
> > Regarding the typical numbers, in most cases, It will require zero or
> > only a few extra extent inodes. Okay, I will move vfs_inode to
> > ntfs_inode.
>
> This was just thinking out loud.  If it doesn't help to significantly
> simplify things, don't bother.
Okay, I will check it.
Thanks!
>
>

