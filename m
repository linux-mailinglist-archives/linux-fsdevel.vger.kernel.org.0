Return-Path: <linux-fsdevel+bounces-16506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4FD89E678
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 01:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FF42876D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F49D1591F1;
	Tue,  9 Apr 2024 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntWTdmfJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC3158DDC
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706777; cv=none; b=f9QfRGB1PZvudGLXPOr9emJPo6wkKzoI0vZ6lFnVWv1Ee3XZMBxVzUg/piB15D2hS9X+yzkTj07iKQdqpkn1+ov+mTnq0ievieXjeUiHJyQ1gzSt5N91ypOnYW6CDKy6GxTd4+q/lN1zzeBnIqpr8gZY1+VRuxi/W29xBY3Myjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706777; c=relaxed/simple;
	bh=aGOAwsjrjo3bP61sfLBWWWl30IWWZzDFTUxJ/vScs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZNwnArlzrlI73dBS0fyjtWTecNa/d/ActFlAZ9TAAe/yN6o1BjB22idL1GdEENApEA47fkAhV1aHgo3vyjkJfyG7fs7tzJd1PPLER49Cvm7EbDL7gj7lsK5QAhqzH0TbeGTMmm5+MY6uYzng6AaIlylTfA7fFVfurr0BoGXkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntWTdmfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02779C433C7;
	Tue,  9 Apr 2024 23:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706777;
	bh=aGOAwsjrjo3bP61sfLBWWWl30IWWZzDFTUxJ/vScs5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntWTdmfJ0gZ4pEKZP24/kLooKj7fln2qfbVUSAfgUTS16Pa13Vru/1XNVdCAJr/By
	 0mJMadfSTLn4ycwMgVbaJR1gD1VNCsdE6eWXccawYk3CfKFv+fy1hABHdYsU/lwemX
	 vAtC3BwQix8HYlB78/5zA5NRvGUID3ddp8qVQCN7TKMyG0tBkqU+5C+whfIjnYrRQe
	 MFEqK8lxxhgBLFgLJ7R2JgUpAEK7I4DLDMzprLOmMaqWqw8UxendFP5Dj8ftKpBjtE
	 HtX4gu3FIiOiKEbwUGA2+8+L1ddTUUTYeRjetdpKN08Km9ugmTrZ9rccB2OsFH8zUm
	 SvsfCaL0CVdtA==
Date: Tue, 9 Apr 2024 19:52:54 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Richard Fung <richardfung@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/1] fuse: Add initial support for fs-verity
Message-ID: <20240409235254.GD1609@quark.localdomain>
References: <20240328205822.1007338-1-richardfung@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328205822.1007338-1-richardfung@google.com>

On Thu, Mar 28, 2024 at 08:58:21PM +0000, Richard Fung wrote:
> Hi! I am trying to add fs-verity support for virtiofs.
> 
> The main complication is that fs-verity ioctls do not have constant
> iovec lengths, so simply using _IOC_SIZE like with other ioctls does not
> work.
> 
> Note this doesn't include support for FS_IOC_READ_VERITY_METADATA.  I
> don't know of an existing use of it and I figured it would be better
> not to include code that wouldn't be used and tested. However if you feel
> like it should be added let me know.
> 
> (Also, apologies for any mistakes as this is my first Linux patch!)
> 
> Richard Fung (1):
>   fuse: Add initial support for fs-verity
> 
>  fs/fuse/ioctl.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Just a process note: single patches should not use a cover letter.  The
information should be in the patch instead, preferably in the actual commit
message but it's also possible to put text below the scissors line of the patch.

- Eric

