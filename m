Return-Path: <linux-fsdevel+bounces-1656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC687DD420
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 18:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E721F22363
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879F2032C;
	Tue, 31 Oct 2023 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1+KHOYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2B3C26
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 17:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D148C433C9;
	Tue, 31 Oct 2023 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698772030;
	bh=5yk+2vvRHUvd55yUpZ3bi/j82qm7dQEJfyStX1WSi+w=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=I1+KHOYHit7M+lnfCavY+JOsoZt/pemQfqwdH2dYRGmN2oPNqgj4OOF7/JHk0OrqR
	 G5hSP7hcV7PU9JQoJ44IDl9tR9TYp2aTsTRZ3kQQVLaVV3b4vyJ3PhgSXiugunX1wn
	 mGk3NI7je/cVK79eYHZkksfcFi7z+RAW1TsWKnn8ZsaCJUqBhjz+0SXtGa0PtP61Pm
	 ApdUUHHyb3/YH5k6Th+tjXS/m/t2Ev3mvYfVaiAy5L81YaDA6sdyX/0vryv7KeTC7a
	 l6x246CCRdoqT3oieFOJ+pJ2oGaQxyWtoKsAr3pVgEQxXbMhWWag5IXq4bAG/Jc3Yd
	 prUNOB4ztdxmQ==
References: <87fs1s3bk6.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231031090242.GA25889@lst.de> <20231031164359.GA1041814@frogsfrogsfrogs>
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: ruansy.fnst@fujitsu.com
Cc: Christoph Hellwig <hch@lst.de>, catherine.hoang@oracle.com,
 cheng.lin130@zte.com.cn, dan.j.williams@intel.com, dchinner@redhat.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, osandov@fb.com,
 "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 22c2699cb068
Date: Tue, 31 Oct 2023 22:32:30 +0530
In-reply-to: <20231031164359.GA1041814@frogsfrogsfrogs>
Message-ID: <875y2mk9fo.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 31, 2023 at 09:43:59 AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 31, 2023 at 10:02:42AM +0100, Christoph Hellwig wrote:
>> Can you also pick up:
>> 
>> "xfs: only remap the written blocks in xfs_reflink_end_cow_extent"
>> 
>> ?
>> 
>> Also this seems to a bit of a mix of fixes for 6.7 and big stuff that
>> is too late for the merge window.
>
> If by 'big stuff' you mean the MF_MEM_PRE_REMOVE patch, then yes, I
> agree that it's too late to be changing code outside xfs.  Bumping that
> to 6.8 will disappoint Shiyang, regrettably.
>

I am sorry Shiyang, I will have to postpone your "mm, pmem, xfs: Introduce
MF_MEM_PRE_REMOVE for unbind" patch for v6.8. The delay was my
mistake. Apologies once again.

I have updated xfs-linux's for-next branch and I will be sending an
announcement shortly.

-- 
Chandan

