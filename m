Return-Path: <linux-fsdevel+bounces-17207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45F8A8DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 23:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7500B20BF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901DA134CED;
	Wed, 17 Apr 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="LtEdEUCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A213CAB6;
	Wed, 17 Apr 2024 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389127; cv=pass; b=bCssi+QCtDIjhYuZXR0WmBTVdhOzKPUKLn14pi2UQXtx0d0dlWA+lFrCxAFNEOU/Ib82QdePjdQpfKtOHo/hjFK8FOWmAJJvYLaJHTyYgdyQUAQbGon+oW7m5rJNKxcWPRnRqh8f1M+VVQ54tS01WkxGk4wxDZhRJKhegqBNdJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389127; c=relaxed/simple;
	bh=tC+7yTElOo8NizUeWmwPJc5RgZN4HysQOzBaQtEI1HI=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=YdmjAgdtV4mXujOanFCS8arir7YzL5LVF+oWWN7lOlrOBJkKqmR+uK2c8ol5fI6volC4JwnPWhuMf2kVUC8QtlzRocVtgEo5DAvETcgcIcs6cqf/bBj02DmDmnWCSj/yr3wNr/jafUOoMVDm4mNAMkZXQbc+/F9Q3/9QjyfdS4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=LtEdEUCl; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <59c322dc49c3cc76a4b6a2de35106c61@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1713389123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm5lOUCFdHBxZja8AoWQ7jaoK0LEOZ3w0EQ3U0PSlcc=;
	b=LtEdEUCllSCxadjHzH7qzgI5I1vp7qF+T/pkKGDfZrgaliLaGQ9Kgu70jhRjFZ0jze2QHk
	Xpmibcjg6fzE70Oo4lYNy1pWeGsE07zDCQ18QDSfWYnIe3ZnStou+X40zhppSX/+cPU51m
	QGxG2hDmY6MDNVeZxLXFZRBkkIAL1Y+8ZlgTci9jf3ruWLk527QldlpXh5wagP+0K3kiOs
	Rx9sLSky7VI6YndGtSWoVj/5eLWmI8wzTB5AR5vj3+2Yb0pUpTdbiwT8LUoMKYqkitNOgA
	raIgPufImkAJF6s4J01znWEtt1POdLIeReRen2BCc1dkxtOveYEFo2swVVW+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1713389123; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jm5lOUCFdHBxZja8AoWQ7jaoK0LEOZ3w0EQ3U0PSlcc=;
	b=bATw+SRqOIkakFXBx/zNj9qOd5J6FaCapDT1Vm/lCVzweKDqWSXfJjc9HRK4pbYWJwrHTS
	cUHXSjW7XJgPVQgsa78f+MBclCbxmIK5LM6YTVOugaV5Ajdj49PeoRDVDp65N3OmmnLzxM
	qoWg3gqyyCkZh0XynqtEr84bVBJRj+lfCZVWlIxB5D7guVrcPLjs3p3/vLHlGOJ9YRsGAV
	X2woe3vH+FmTWT0iXsCPTgPsYmJqyTubI+AFI3iDIH1L1Wg3NXFZHnPdrzcBtPecDF2iGo
	63N9ffQ82I6j6q0sa4N687iuFXy4QTxFrCqSs1l7ZFICqc5KBL8mDAo4yYOWRA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1713389123; a=rsa-sha256;
	cv=none;
	b=jkrBs+1mkPf02RAwTVbNkRU4xl8I6Z7pATP1FjOEITqOTLDyDhHQYKbA5PaZuz7p8NFliy
	sVUjYZGvigdqUn/JdrNQNHQMA9L+cBkFF3RUpAq/ID1f8E2aLuER5Cj7J8DpsRSYc/6PIL
	KjV3XQFkuAJ8Po4aSQyiltDVAtlQLaDF1DzwNHG/zS3BLamix96SoX0iZLFzzJbG+JjNa3
	KMt1OqgqnLrgY8Ld4GH+AqeEPDOmSGniFEWqzfKKIjlCCqPnrWovyjTNJ2z2sslHx/fmEF
	jbxETy8k+A4lJPgXHGdO7fD/tlKk2U20hKaN0ePrqHhKC3TSc2mbRJ49GBuUuw==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>, Shyam Prasad N
 <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live
 connection
In-Reply-To: <277920.1713364693@warthog.procyon.org.uk>
References: <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com>
 <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com>
 <3756406.1712244064@warthog.procyon.org.uk>
 <2713340.1713286722@warthog.procyon.org.uk>
 <277920.1713364693@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 18:25:19 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Paulo Alcantara <pc@manguebit.com> wrote:
>
>> Consider the following example where a tcon is reused from different
>> CIFS superblocks:
>> 
>>   mount.cifs //srv/share /mnt/1 -o ${opts} # new super, new tcon
>>   mount.cifs //srv/share/dir /mnt/2 -o ${opts} # new super, reused tcon
>> 
>> So, /mnt/1/dir/foo and /mnt/2/foo will lead to different inodes.
>> 
>> The two mounts are accessing the same tcon (\\srv\share) but the new
>> superblock was created because the prefix path "\dir" didn't match in
>> cifs_match_super().  Trust me, that's a very common scenario.
>
> Why does it need to lead to a different superblock, assuming ${opts} is the
> same in both cases?  Can we not do as NFS does and share the superblock,
> walking during the mount process through the directory prefix to the root
> object?

I don't know why it was designed that way, but the reason we have two
different superblocks with ${opts} being the same is because cifs.ko
relies on the value of cifs_sb_info::prepath to build paths out of
dentries.  See build_path_from_dentry().  So, when you access
/mnt/2/foo, cifs.ko will build a path like '[optional tree name prefix]
+ cifs_sb_info::prepath + \foo' and then reuse connections
(server+session+tcon) from first superblock to perform I/O on that file.

> In other words, why does:
>
>     mount.cifs //srv/share /mnt/1 -o ${opts}
>     mount.cifs //srv/share/dir /mnt/2 -o ${opts}
>
> give you a different result to:
>
>     mount.cifs //srv/share /mnt/1 -o ${opts}
>     mount --bind /mnt/1/dir /mnt/2

Honestly, I don't know how bind works at VFS level.  I see that the new
superblock isn't created and when I access /mnt/2/foo,
build_path_from_dentry() correctly returns '\dir\foo'.

