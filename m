Return-Path: <linux-fsdevel+bounces-39843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637BBA192EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CE416097C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA72139B2;
	Wed, 22 Jan 2025 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBaw8f7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA641E4AB;
	Wed, 22 Jan 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553847; cv=none; b=L1z6DHZLgCojgsoPiVVu9D7ErCIkQ9rN2dTN3IUhI6iq2L+XxpHwrFOE9pcfSl8IRL0NRnuqHaVeLOULxkcw21ovAGc6AX5xp00q/oxzSJ04Wvs7js8TwGqhRJXRzPpw8RAHUlgWXfKWyylrv39NY3YFvUAmEStVLrkixqD31Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553847; c=relaxed/simple;
	bh=vSgcrihrMe3GZxdDtvj1G+9mZmVxTCyPzEHiobCCYlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpV2uzgPgibDk+9k7KWyFRY0U1iuKmKXhVSrRUJUQH/K/euFaD3LEEMvc2QS2EdpP3QEYQ5qHfyBNWuHzsQmwbK4imiU4kmlyQ7QFcdTgXLUWjszilV9l+/8JAPDGKRGaBwV2mJ7/Z7sbxGmlZi1mKC6f5ZgjZ1AQRCvmS/Bj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBaw8f7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA96EC4CED6;
	Wed, 22 Jan 2025 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737553846;
	bh=vSgcrihrMe3GZxdDtvj1G+9mZmVxTCyPzEHiobCCYlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBaw8f7/6wVmrSbBjPqZuAvT7K0ZqKMORvoEoq77gw/91MaNziIsE96mPl+JNFmtk
	 DgODxoTmnVWF5DH987tYYvA7klyNP4wAkp1TGC8Styk3R9TVqtyjb4jdWhWmRrUjxb
	 o9Rfo7KejFu86KBYQ563TgrgcKZWWIKd9hITcmWDljIMk1uJkb0bw19REW9uctSUQM
	 ajZDzIv0xO7pzF5JGF9Z5u0wyeLek4dvucx5Fg2cq5itYU7KUreLOVter+xBDz8TdF
	 XiGpVFgcqRDpY9vWZeIHNdVx1gYpZIWk2KXXS/vaWB8N9xvU1DRKVisvSmiLRv4WyM
	 B3Ct55YXvtf7A==
Date: Wed, 22 Jan 2025 14:50:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs dio
Message-ID: <20250122-aalen-knabbern-3a6d2f4b9c92@brauner>
References: <20250118-vfs-dio-3ca805947186@brauner>
 <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>
 <20250120-narrte-spargel-6b0f052af8b6@brauner>
 <CAHk-=wgdZJQFfBnKXQm2EZiej-KVk5=E1gOBhW72XnQ_SBZ=cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdZJQFfBnKXQm2EZiej-KVk5=E1gOBhW72XnQ_SBZ=cQ@mail.gmail.com>

On Mon, Jan 20, 2025 at 11:50:09AM -0800, Linus Torvalds wrote:
> On Mon, 20 Jan 2025 at 11:38, Christian Brauner <brauner@kernel.org> wrote:
> >
> > It is heavily used nowadays though because there's a few
> > additional bits in there that don't require calling into filesystems
> > but are heavily used.
> 
> By "heavily used" you mean "there is probably a 1:1000 ratio between
> statx:stat in reality".
> 
> Those "few additional bits" are all very specialized. No normal
> application cares about things like "mount ID" or subvolume data. I
> can't imagine what other fields you think are so important.

Sorry, I wasn't talking about new fields I was talking about actual bits
that statx has.

#define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
#define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
#define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
#define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
#define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
#define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
#define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
#define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */

I think that such an attribute field could've been added to struct stat
itself because afaict there are two unused fields in there currently:

struct stat {
	unsigned long	st_dev;		/* Device.  */
	unsigned long	st_ino;		/* File serial number.  */
	unsigned int	st_mode;	/* File mode.  */
	unsigned int	st_nlink;	/* Link count.  */
	unsigned int	st_uid;		/* User ID of the file's owner.  */
	unsigned int	st_gid;		/* Group ID of the file's group. */
	[...]
	unsigned int	__unused4;
	unsigned int	__unused5;
};

I happily concede that stat() will exceed the usage of statx() for most
application that e.g., just want to do the basic mode, uid, gid thing.
So compared to that statx() usage is probably not that important.

And nothing would stop us from adding a statx2()...

int statx(int dfd, const char *path, unsigned int flags, unsigned int mask
          struct statx *st, size_t st_size)

#define STATX_SIZE_VER0 // compatible with struct stat

and then only the stat portion is filled in. This could allow glibc to
use statx() for everything without perf impact especially when paired
with allowing NULL with AT_EMPTY_PATH.

