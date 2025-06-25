Return-Path: <linux-fsdevel+bounces-52894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA12AE8051
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D36188F8B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6F2BDC17;
	Wed, 25 Jun 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="TFx/Rzdg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6EB25B2EB;
	Wed, 25 Jun 2025 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848855; cv=none; b=MP3fXdSVj3M9YV7GzT5D1ckx9IfE2dw3exgEMg07rZ8+bemLFkBFEGAMWrc7Su/g7QCOklJxjtVgzvjm0xb5IM/OCtHVOlLAbIerd/LgCtg5JFcJxfwcU+FC2UFcUe+6U5Z3cxO0Y4HYQ4CdszTFKvbMsPSoHlmoCgsQxL1J8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848855; c=relaxed/simple;
	bh=bHy/tsFUkk4MChMA7tjlZNXq6dQAUp54PElkCTKHIeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie3FtYzHOYaKPcCYZOWYkuStrBFCAizHTCyk9F2DbkNOmcb9YizdRQCDr/KjieJKKVou+5FeOfByVkaRMU1JXYmxoioVqPCD+43DVjuMD+ge9envkAI8UMyFSsA6ktkXY53dyQBuGi/dDqzOVIEEaH24xQhPcfsn0vll62btuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=TFx/Rzdg; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bRzG425yTz9t9R;
	Wed, 25 Jun 2025 12:54:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750848844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MI+jsWd8MF1hH5HPSJgI8R3f1cEcrL7qwGcueGBoZ+4=;
	b=TFx/Rzdg2B+0ULH33/wOta/nIO45jbi2kbA8IfiB+iZl1W4cYeqtuYGMclkjoCDp38wt72
	n1Hzne2t77hKl0LD3Ww/zjSY8Dm9dx07Il0uIYlo5ZU2snIHXQBsnIvjop3mDT1M+mWorv
	jFP7vWkJTCSTTvQLJ8faT/SP7mRifhWa8/+dhODqQL2rp+tiax4X43J3m7weYBUIldSmyd
	/PlKf+TZJyCqN0Cb+1UEQWv6cm4O41QnvD0BS+mz0ZiPVnCNlQ7SCB2WAjMsubPCpr3M5R
	xRpJRg6l42z63dOcDsiMTCYn6EgIgWrn/ZblBbqf6juYlPoEgz/Hjp+Uazfw0A==
Date: Wed, 25 Jun 2025 12:53:54 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Jan Kara <jack@suse.cz>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, mcgrof@kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gost.dev@samsung.com, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] fs/buffer: remove the min and max limit checks in
 __getblk_slow()
Message-ID: <jbtntrppqjzaq6tdfzvwojjsnpacrdmg74vcvab4dc2z6hlhnl@ntotjsab5ice>
References: <20250625083704.167993-1-p.raghav@samsung.com>
 <u7fadbfaq5wm7nqhn4yewbn43h3ahxuqm536ly473uch2v5qfl@hpgo2dfg77jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u7fadbfaq5wm7nqhn4yewbn43h3ahxuqm536ly473uch2v5qfl@hpgo2dfg77jp>

On Wed, Jun 25, 2025 at 12:16:49PM +0200, Jan Kara wrote:
> On Wed 25-06-25 10:37:04, Pankaj Raghav wrote:
> > All filesystems will already check the max and min value of their block
> > size during their initialization. __getblk_slow() is a very low-level
> > function to have these checks. Remove them and only check for logical
> > block size alignment.
> > 
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> I know this is a bikeshedding but FWIW this is in the should never trigger
> territory so I'd be inclined to just make it WARN_ON_ONCE() and completely
> delete it once we refactor bh apis to make sure nobody can call bh
> functions with anything else than sb->s_blocksize.
> 
Something like this:

diff --git a/fs/buffer.c b/fs/buffer.c
index a1aa01ebc0ce..a49b4be37c62 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1122,10 +1122,9 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 {
        bool blocking = gfpflags_allow_blocking(gfp);
 
-       if (unlikely(size & (bdev_logical_block_size(bdev) - 1))) {
+       if (WARN_ON_ONCE(size & (bdev_logical_block_size(bdev) - 1))) {
                printk(KERN_ERR "getblk(): block size %d not aligned to logical block size %d\n",
                       size, bdev_logical_block_size(bdev));
-               dump_stack();
                return NULL;
        }

I assume we don't need the dump_stack() anymore as we will print them
with WARN_ON_ONCE anyway?

--
Pankaj

