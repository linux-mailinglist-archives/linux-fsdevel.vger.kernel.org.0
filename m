Return-Path: <linux-fsdevel+bounces-15326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758FE88C32A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166601F3F37B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA27C71B5D;
	Tue, 26 Mar 2024 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go/33quK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139675CDE7;
	Tue, 26 Mar 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458936; cv=none; b=NoIz+RMI9GE92IIbPd/R3Z+7bxlJvU4W4u4S4RQQ5aZwej7Cl7FOHKrYvkGJJ8OtnAPpFVZftqOe0nu4vz6ths6GfHq18qTfY2glH+vkUZh/+VNkrs6yZXRUzJ0o4OL0ozJdamBBs9PirTJ/+pVwSwkxwQQ6XK0m3wgiOMjapCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458936; c=relaxed/simple;
	bh=lhl63qA0ynJJcI2nzKrcUscwGU03g+nK4AcFTMDf57s=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Fp1Ovcg2dSC/sd081qJPXlnShcS9CmOEwP4zpKzHz2/V7LFHrG/H0kIPeUDg+/AQ8kVa9KfHvyEvso5Rb9/b2AG+epo4eu7ZSs3zChaaykZEFgJ1vB7UTB6ClEF0mZBFZLN553o5F8iEuaIyrhR/fZSHMlh9cSKUz0I0i1ksIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go/33quK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4FAC433F1;
	Tue, 26 Mar 2024 13:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711458935;
	bh=lhl63qA0ynJJcI2nzKrcUscwGU03g+nK4AcFTMDf57s=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=go/33quK4x88ZOX+/GYbpxJv2Yzz2SHauWFo5qS6TlrMzKy9hmOWiQjA8CFWuwEeN
	 nDaLNwBPpMiC5f9fQsnaLRZfvBuxAX4vxBf84iVsNEZVpUvza09nh2Vuca55IBMSxS
	 rmHvWbhA9lyiiPzhBx1Lt2Hjre/bVv+feTHDV8b8j9detNAxRAVd57IpGQabtqa83V
	 Ue9iIRCUE4lClC/Lj/s3Z97LHGO7sgXP2cieeTIIZCTqJ761OdttN92EhaFAd4gcif
	 6m83aXboSViIh4jMPH5MCnZ/bA7XJzSYPnOniiLqIDAKYenZyMP/LoUW9eHLyeGDGk
	 GQ4TaVyRxRgUA==
References: <874jcte2jm.fsf@debian-BULLSEYE-live-builder-AMD64>
 <wdc2qsq3pzo6pxsvjptbmfre7firhgomac7lxu72qe6ard54ax@fmg5qinif62f>
 <s2kxdz3ztpuptn3o2znqpsbskra5yqxqnjhisfjxyc3cqw33ct@k6bvhr2il2sn>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 mark.tinguely@oracle.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to f2e812c1522d
Date: Tue, 26 Mar 2024 18:42:47 +0530
In-reply-to: <s2kxdz3ztpuptn3o2znqpsbskra5yqxqnjhisfjxyc3cqw33ct@k6bvhr2il2sn>
Message-ID: <87r0fxgmmj.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 26, 2024 at 12:14:07 PM +0100, Andrey Albershteyn wrote:
> On 2024-03-26 12:10:53, Andrey Albershteyn wrote:
>> On 2024-03-26 15:28:01, Chandan Babu R wrote:
>> > Hi folks,
>> > 
>> > The for-next branch of the xfs-linux repository at:
>> > 
>> > 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>> > 
>> > has just been updated.
>> > 
>> > Patches often get missed, so please check if your outstanding patches
>> > were in this update. If they have not been in this update, please
>> > resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
>> > the next update.
>> > 
>> > The new head of the for-next branch is commit:
>> > 
>> > f2e812c1522d xfs: don't use current->journal_info
>> > 
>> > 2 new commits:
>> > 
>> > Dave Chinner (2):
>> >       [15922f5dbf51] xfs: allow sunit mount option to repair bad primary sb stripe values
>> >       [f2e812c1522d] xfs: don't use current->journal_info
>> > 
>> > Code Diffstat:
>> > 
>> >  fs/xfs/libxfs/xfs_sb.c | 40 +++++++++++++++++++++++++++--------
>> >  fs/xfs/libxfs/xfs_sb.h |  5 +++--
>> >  fs/xfs/scrub/common.c  |  4 +---
>> >  fs/xfs/xfs_aops.c      |  7 ------
>> >  fs/xfs/xfs_icache.c    |  8 ++++---
>> >  fs/xfs/xfs_trans.h     |  9 +-------
>> >  6 files changed, 41 insertions(+), 32 deletions(-)
>> > 
>> 
>> I think [1] is missing
>> 
>> [1]: https://lore.kernel.org/linux-xfs/20240314170700.352845-3-aalbersh@redhat.com/

I am sorry to have missed that patch.

>
> Should I resend it?

You don't have to resend it.

I will include the above patch in 6.9-rc3 fixes queue.

-- 
Chandan

