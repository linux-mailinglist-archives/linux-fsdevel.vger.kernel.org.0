Return-Path: <linux-fsdevel+bounces-3139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52DD7F0677
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 14:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E938280D8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705CE10A2D;
	Sun, 19 Nov 2023 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE4SncId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD97101C9
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 13:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCACDC433C8;
	Sun, 19 Nov 2023 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700401133;
	bh=jfjgB/r0hnM+zDFTIkW9ALTStYyWaMSCgI96dZyVNws=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=UE4SncIdxVXwX05TNo7Xt7g8qedCWOqq/ihB+AXR32bIe6sOScmS11g04/rREmI30
	 LngyDo7Mv+gV2x8l0WwRucVYqEUiKwwlJc9uHa5ZBfl9vPPz+IcM6zREjr0hGpnTu5
	 BqHlrNjGzXVMmUkxk3GSWBw+xRCVpnRyTK0gyw/hUqg7Orh+jx02YmIt5BWJquY3D+
	 4yBhHOQQIOwsKBwO+FDcpZIlqwb/f/YU44YT2kx65MDEODkMtfVBJeDjPGAs9fpv7a
	 lY377qxqtCGpFomtDjvLkfKYwZNMpG0MlzNSnefOXizP8tItaGxYmcBqunxrt27ROY
	 6ndjh+4aP50ww==
References: <87zfzb31yl.fsf@debian-BULLSEYE-live-builder-AMD64>
 <CAHk-=wgC_nn_6d=G0ABjco5qMMZELGrUyCVQN3zB8+Yo5F8Drw@mail.gmail.com>
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ailiop@suse.com, dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
 holger@applied-asynchrony.com, leah.rumancik@gmail.com,
 leo.lilong@huawei.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, osandov@fb.com, willy@infradead.org
Subject: Re: [GIT PULL] xfs: bug fixes for 6.7
Date: Sun, 19 Nov 2023 19:05:09 +0530
In-reply-to: <CAHk-=wgC_nn_6d=G0ABjco5qMMZELGrUyCVQN3zB8+Yo5F8Drw@mail.gmail.com>
Message-ID: <87r0klg8wl.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 18, 2023 at 11:41:36 AM -0800, Linus Torvalds wrote:
> On Sat, 18 Nov 2023 at 00:22, Chandan Babu R <chandanbabu@kernel.org> wrote:
>>
>> Matthew Wilcox (Oracle) (1):
>>       XFS: Update MAINTAINERS to catch all XFS documentation
>
> I have no complaints about this change, but I did have a reaction:
> should that "Documentation/filesystems" directory hierarchy maybe be
> cleaned up a bit?
>
> IOW, instead of the "xfs-*" pattern, just do subdirectories for
> filesystems that have enough documentation that they do multiple
> files?
>
> I see that ext4, smb and spufs already do exactly that. And a few
> other filesystems maybe should move that way, and xfs would seem to be
> the obvious next one.
>
> Not a big deal, but that file pattern change did make me go "humm".
>
> So particularly if somebody ends up (for example) splitting that big
> online fsck doc up some day, please just give xfs a subdirectory of
> its own at the same time?

I agree with your suggestion. I will make sure that new files documenting XFS
will be created in a new directory that is specific to XFS and existing
documentation will be moved under the new directory.

-- 
Chandan

