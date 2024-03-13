Return-Path: <linux-fsdevel+bounces-14298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F987AA03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 16:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FBD1F2602F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8647A6F;
	Wed, 13 Mar 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="DX5ukTQk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFABB4778C;
	Wed, 13 Mar 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342317; cv=none; b=d8HZDPgaH9jRNlPUMWfZIQuBmy/GofwGh/m+X66BbJFFdFnJPWwzU/CEwkMyzOu7rjB1w9fP+BuOawt4QWU6p7EIgWWkPQJz69KTO5q/Zp5wsvwGnlxjnC8KAtQjERRcVwSIn2sA6lhV1NbomUNGk8TWg+P9A5FF7ZGStmBCV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342317; c=relaxed/simple;
	bh=iMnS8ZGEFpxUyyW9drRJ6JBVm+281k0oK57TGx+F1Qg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nesCinalHRI6dvnSG5y5Ev/C+HYa3kYHST5mofKpN2B/mRFe+8FfIaNkxV47A6nsQaNv/GExCyKEu3gcLWoEfxPP+NNApY/xCpweTyyzlBq047MKTwapq/BqIihm8xeCeyNYQNBieeFX0//yZpqASuUOFCfA3joFKTADOK2FSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=DX5ukTQk; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 94DCA8043E;
	Wed, 13 Mar 2024 11:05:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1710342310; bh=iMnS8ZGEFpxUyyW9drRJ6JBVm+281k0oK57TGx+F1Qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DX5ukTQk6tKvpEuCn0px4VNAaAVmncdYvgwtF6zi959+eFamyAPjH8ApYehtL6R+G
	 P+O8ALWTyCJEOMEyWx1I6mCPmKCHJtXy//MPP+yJjI968LoheXSceWhAcD9dIg5xqs
	 AuFfTl98Nrd1TYGkFAc8qL7FuiJlRUspSW5nhn7OCTPa5f/xhypc5OjvxdIDvm+xo1
	 zI9zbcElOIsYxmp7Qtse7+ddQ5/0TnPS8yuKAZzjNQn9BDJNAGFEW2kY2BbQY8cY9L
	 vSFnKZfH6TZNG03QQchl5XNdqp19tq9ELnR0uPuaRla6gF/aZzNg/QmBGmFqjG5QTL
	 rXAs3VdfR8Idg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Mar 2024 11:05:10 -0400
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Andreas Dilger <adilger@dilger.ca>
Cc: corbet@lwn.net, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-btrfs
 <linux-btrfs@vger.kernel.org>, Chris Mason <clm@meta.com>, David Sterba
 <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 jbacik@toxicpanda.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] add physical_length field to fiemap extents
In-Reply-To: <D8407E1D-F188-4115-A963-9EFBB515C45D@dilger.ca>
References: <cover.1709918025.git.sweettea-kernel@dorminy.me>
 <0b423d44538f3827a255f1f842b57b4a768b7629.1709918025.git.sweettea-kernel@dorminy.me>
 <D8407E1D-F188-4115-A963-9EFBB515C45D@dilger.ca>
Message-ID: <d29c6482853ded9b1c14620c0523068a@dorminy.me>
X-Sender: sweettea-kernel@dorminy.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-11 20:22, Andreas Dilger wrote:
> On Mar 8, 2024, at 11:03 AM, Sweet Tea Dorminy
> <sweettea-kernel@dorminy.me> wrote:
>> 
>> Some filesystems support compressed extents which have a larger 
>> logical
>> size than physical, and for those filesystems, it can be useful for
>> userspace to know how much space those extents actually use. For
>> instance, the compsize [1] tool for btrfs currently uses 
>> btrfs-internal,
>> root-only ioctl to find the actual disk space used by a file; it would
>> be better and more useful for this information to require fewer
>> privileges and to be usable on more filesystems. Therefore, use one of
>> the padding u64s in the fiemap extent structure to return the actual
>> physical length; and, for now, return this as equal to the logical
>> length.
> 
> Thank you for working on this patch.  Note that there was a patch from
> David Sterba and a lengthy discussion about exactly this functionality
> several years ago.  If you haven't already read the details, it would 
> be
> useful to do so. I think the thread had mostly come to good 
> conclusions,
> but the patch never made it into the kernel.
> 
> https://patchwork.ozlabs.org/project/linux-ext4/patch/4f8d5dc5b51a43efaf16c39398c23a6276e40a30.1386778303.git.dsterba@suse.cz/
> 
> One of those conclusions was that the kernel should always fill in the
> fe_physical_length field in the returned extent, and set a flag:
> 
> #define FIEMAP_EXTENT_PHYS_LENGTH      0x00000010
> 
> to indicate to userspace that the physical length field is valid.
> 
> There should also be a separate flag for extents that are compressed:
> 
> #define FIEMAP_EXTENT_DATA_COMPRESSED  0x00000040
> 
> Rename fe_length to fe_logical_length and #define fe_length 
> fe_logical_length
> so that it is more clear which field is which in the data structure, 
> but
> does not break compatibility.
> 
> I think this patch gets most of this right, except the presence of the
> flags to indicate the PHYS_LENGTH and DATA_COMPRESSED state in the 
> extent.
> 
> Cheers, Andreas
> 
I had not seen that; thank you for the pointers, I'll add the flags in 
v2.

