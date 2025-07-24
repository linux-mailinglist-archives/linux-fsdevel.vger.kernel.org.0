Return-Path: <linux-fsdevel+bounces-55956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB16FB10F34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 17:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FFE56174F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ADF2EA46F;
	Thu, 24 Jul 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AE3Gbq2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF12E888F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372539; cv=none; b=NEO1iabPUKeasnPcPBTFy5cYcdYtbHrslm0mUeLS2FFKUSpXG5WAXvIsPPLY6vq3rZkfh0WMcEmc+RzCI0QKHzQ7tqexyNbfd9BcYHworLC25h+u8F/6ljBPoH6UAEDxlth9jpWC8dSonVHhUSzRhtHQ79Bbe3pmZfGINGjN0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372539; c=relaxed/simple;
	bh=Hisyj378uiJAIFPzRDmFz5OLEjyPnSjhsEfq9rlP3uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhQSqJEkZPh50z+RW/Pb5z5+rd0CSw+mgttYwlg4SmY/Qc0b9TteyC7SCW0uiC07R5tpZZMXTbws0TVAoXRJkd2AZSn9Cq+qvczl0cAescgLa6AE2GgxIMtZw4TbIpbzSQvOCV1w8axX4ydTAm1sPKNYLb6kzrHJxILKafSZIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AE3Gbq2n; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Jul 2025 11:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753372536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5inmDgdRwIMQtI4/1oH7JNUoET+5k+ZLBMu1uTvWQhA=;
	b=AE3Gbq2nusDBQ7yQhSO5iyflI9jPC3thEsFAZNyQ+GP4cVgpRkKvtxjtQmes/nv34X5fCP
	AD2o4vw0dS2/ig5ISaYveXBBDSXMEG7+9ne+zlIVmWbv1daZ2ulRm6x7WGyJxG1xDcA1hM
	85iqbRl2TO46vst89TWxVsmJxPzYXY4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: mark file_remove_privs_flags static
Message-ID: <llgd4a55kdoakgcxmfzf7iz6k7dbxdrfdjyi6hpsifsvtyr5o2@z4fy75s3utx3>
References: <20250724074854.3316911-1-hch@lst.de>
 <20250724154623.GT2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724154623.GT2580412@ZenIV>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 24, 2025 at 04:46:23PM +0100, Al Viro wrote:
> On Thu, Jul 24, 2025 at 09:48:54AM +0200, Christoph Hellwig wrote:
> > file_remove_privs_flags is only used inside of inode.c, mark it static.
> 
> That's close being a revert of 66a67c860cce "fs: file_remove_privs_flags()";
> I've no objections per se, but at least a Cc to Kent and summary of the
> history in commit message would be useful.
> 
> AFAICS, the history is more or less "the only in-tree user got reverted
> in August 2024 and hadn't come back since then; its removal did not
> touch the export", but I've no idea if it has successors yet to be merged
> back into the tree.
> 
> Again, I've no problem with making the damn thing static, but some context
> would be useful.

Oh, that...

That was for a buffered write path that didn't need the inode lock (if
we're not extending we should be able to just lock all the folios -
right?) - which got reverted due to some absolutely nutty page cache
corruption that I was never able to track down.

We still want that, but I won't get back to it in less than a year,
bcachefs is currently in hard freeze and I've been snapping at people
who come to me with feature requests...

