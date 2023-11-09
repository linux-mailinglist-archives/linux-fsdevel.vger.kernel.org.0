Return-Path: <linux-fsdevel+bounces-2511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E47E6B51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4049E1C20968
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D1D1DFF7;
	Thu,  9 Nov 2023 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnzpfS0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A639E1DFEE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFF7C433C7;
	Thu,  9 Nov 2023 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699537431;
	bh=QvteiSJrg/mBtMt79VHBaCLpFZId5APkWqe4rt/ysck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnzpfS0LD2deCCLUviPpa+S/90uSHLvbGOq/sDjb3aoMZ/TwtcRN/j9A9aay0Qm5G
	 /cxFL6xuFOkfv8EzJVhLCrISobQjtNwh9734NhmRa092bJMuZGF/PMyujAWi7ZWeAn
	 9Fm4dGFHriS3YxXhng6iHPWd0L1RldDrx3neougaTZhd8kFvfWtikAVqseZQ3jLBiz
	 onjzNC42t5xOeJ2aQENyCLml0qj9LDDJnAj6gasZqWoGbarDjjxXdmCYyhs7fzFXZx
	 CVX2CgG2mVDaqvcBlsMd9umt+/QdLshapBQqOS5lCWSNx5yy7ypAgd043giOIaHisr
	 99oFm/aAz7eSA==
Date: Thu, 9 Nov 2023 14:43:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/22] coda_flag_children(): cope with dentries turning
 negative
Message-ID: <20231109-harpune-kubikmeter-8862f2f2af0f@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-3-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:37AM +0000, Al Viro wrote:
> ->d_lock on parent does not stabilize ->d_inode of child.
> We don't do much with that inode in there, but we need
> at least to avoid struct inode getting freed under us...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

