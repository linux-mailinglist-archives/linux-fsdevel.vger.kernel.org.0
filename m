Return-Path: <linux-fsdevel+bounces-13160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4C86C028
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 06:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AE71F224EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 05:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C325F3A1A7;
	Thu, 29 Feb 2024 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHfcur02"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60E39840;
	Thu, 29 Feb 2024 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709184345; cv=none; b=T/BjvKb3vcHzEF+VIl9qN85CXq72VZgs3snMFdBo/TL4Brc0Obyk1W39nFl7VCJNW8N4xRRunGS5SE+lJH3BbEbz//uekH+aANHF15TdQmmAOe1+hCpAegW6bfiOu6f4Qw6yctkywxgXxLPmE4wb55sg4HtoBgY1Ud79uGFiI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709184345; c=relaxed/simple;
	bh=FCoZRFNi4zITcIlLN0RV/YfVYRQCko+oEZMNxFjEmOI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=qkcxe6vkgcF5LEE1y1dXEogV6tsUtti42FgFWtzo0XuxaxV2oOXJUBNR5KAyYdMLXjKmllAg/dyq84sbUmTwzGV1S4dGxfSMOSs5IAjhE93R3u5U8X2Oy+ZbujhYbcSTpgCe7kUPmWG/3+r3fl7Lu3j7/c8rO8PpAeKA884kP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHfcur02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3631EC433C7;
	Thu, 29 Feb 2024 05:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709184344;
	bh=FCoZRFNi4zITcIlLN0RV/YfVYRQCko+oEZMNxFjEmOI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=FHfcur02gFf7e7AWEgaOUOX+c3jW7gBCwXYq4tMrhCesDWNlTofnur7lAtJFGo43E
	 b3yP5shQydcD2nYCBElfQfPNCacw7Q5TX7PI5ifky8svIC7ZUY95BcK8txVIj85nEW
	 h34ebX4NfUyranltkd9s+QFQAtw4IdkGuUG2mSVF1djhGNzD2+CrLdNHkGPt9ksKiV
	 dK2i4Tkd6PvsJxP8UCTnc6szGcLlymyHxBBlC/haSZEnfK38q/bsbPglhe2tWV1gWU
	 KbO7bL9in2D1zAD7XeD+n9eAyJ9191sBzdF/YR+X69ghbMULKCF2ko5cXEu5x8cmje
	 CIYyfUizdlHgQ==
References: <87r0gvna3j.fsf@debian-BULLSEYE-live-builder-AMD64>
 <ZeAP01ULpmV0u9Ba@casper.infradead.org>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: akiyks@gmail.com, cmaiolino@redhat.com, corbet@lwn.net,
 dan.carpenter@linaro.org, dan.j.williams@intel.com, dchinner@redhat.com,
 djwong@kernel.org, hch@lst.de, hughd@google.com, kch@nvidia.com,
 kent.overstreet@linux.dev, leo.lilong@huawei.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 longman@redhat.com, mchehab@kernel.org, peterz@infradead.org,
 ruansy.fnst@fujitsu.com, sfr@canb.auug.org.au, sshegde@linux.ibm.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 601f8bc2440a
Date: Thu, 29 Feb 2024 10:39:16 +0530
In-reply-to: <ZeAP01ULpmV0u9Ba@casper.infradead.org>
Message-ID: <87msrjn8ob.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 29, 2024 at 05:02:11 AM +0000, Matthew Wilcox wrote:
> On Thu, Feb 29, 2024 at 10:23:45AM +0530, Chandan Babu R wrote:
>> Hi folks,
>> 
>> The for-next branch of the xfs-linux repository at:
>> 
>> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>> 
>> has just been updated.
>> 
>> Patches often get missed, so please check if your outstanding patches
>> were in this update. If they have not been in this update, please
>> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
>> the next update.
>> 
>> The new head of the for-next branch is commit:
>> 
>> 601f8bc2440a Merge tag 'xfs-6.8-fixes-4' into xfs-for-next
>
> Some kind of merge snafu?  It looks like you merged all of 6.8-rc6 into
> for-next:
>
> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next

Apart from the patches destined for v6.9 cycle, The for-next branch has one
patch (i.e. xfs: drop experimental warning for FSDAX) that needs to be pulled
into v6.8-rc7. This patch is committed on v6.8-rc6. Hence, commits from
v6.8-rc6 got pulled into tree.

This issue will go away after I send a pull request for v6.8-rc7 to Linus and
drop the v6.8-* stuff from for-next.

-- 
Chandan

