Return-Path: <linux-fsdevel+bounces-2753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980437E8C01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 19:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C8C1C20757
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F71C280;
	Sat, 11 Nov 2023 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0NvFGL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0EC1BDFA
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 18:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C89C433C7;
	Sat, 11 Nov 2023 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699725975;
	bh=bTbUUGMGT4DE4ZVC8v2yuWZ8JBGapEtafRxfzYK5xeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0NvFGL5ZS9FWVMXvkUUC6SyHnBecgFWD6DcrsFjZFQGoB96bkc6+0tNkYkvQDCPl
	 VEkLMqsZIf3GihP2TJCRn3f54QnaBgewZOHnxJL891T46FsYB+sxuilJq5kbU/NWPy
	 s+fDSySVFde34t+c88Zd+uutKn44ro0YBnb6SrEi+POUEAjM5IOoPs549nXmSASbSG
	 0SV+T+xB/Ou3vk3kzmU7snC+1hV91hfF1uGtUsbc1IISCLNeCbCagu9yVDiSRgMkPO
	 5+KKQDj1uzTO1UaeYXNuTGkCTaJAhHI1SbRwQoFZRU9sjCjX+hbe6Hz4/yvXJTiVuy
	 4Phgt/UumN5rQ==
Date: Sat, 11 Nov 2023 10:06:13 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] buffer: Fix more functions for block size >
 PAGE_SIZE
Message-ID: <20231111180613.GC998@sol.localdomain>
References: <20231109210608.2252323-1-willy@infradead.org>
 <20231109210608.2252323-8-willy@infradead.org>
 <20231110045019.GB6572@sol.localdomain>
 <ZU49o9oIfSc84pDt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU49o9oIfSc84pDt@casper.infradead.org>

On Fri, Nov 10, 2023 at 02:26:43PM +0000, Matthew Wilcox wrote:
> Would you want to invest more engineering time in changing it?

It seems logical to just keep the existing approach instead of spending time
trying to justify changing it to a less efficient one (divides).

- Eric

