Return-Path: <linux-fsdevel+bounces-4822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E980450A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 03:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AF41C20A05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459CD278
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk23hlFO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8D17F1;
	Tue,  5 Dec 2023 01:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6C2C433C8;
	Tue,  5 Dec 2023 01:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701740959;
	bh=T6weC/KqM51ouiW8+bUDkyJnBjEYuCszJWxBFjiJa4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vk23hlFOOv9kB5zl5tD3DQ3zHXb3D9pRxi0oYe9HsdVXFHxnK4Z9qqT6jR+IQJUTx
	 xayQGrPC524N5UutBPrjEnMj3OwSlagcqwYUzahrYFghJbrSnkWzsQlCInt+wn8mwI
	 mntltn22FNA4IDWOPwiyHoFJBpU6vZCX/9A+pElcsf2h+q5K8+gZa/DI1uC1OV3P/q
	 8+2iczvq/3v6p74R4sXal/Db3NwYx3JCHo9kOpv3GIDx8CpcI5xm0DOrA1jej47f5W
	 ZdeSC8YzG57LYxMbfutiZNTOgKaqwt+MN6s7fZj0bzINgxjot3h8c/ZvDHOUgl09ln
	 ALE1TPjLk2USg==
Date: Mon, 4 Dec 2023 17:49:17 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/46] btrfs: add fscrypt support
Message-ID: <20231205014917.GB1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:10:57PM -0500, Josef Bacik wrote:
> Hello,
> 
> v3 can be found here
> 
> https://lore.kernel.org/linux-btrfs/cover.1697480198.git.josef@toxicpanda.com/
> 
> There's been a longer delay between versions than I'd like, this was mostly due
> to Plumbers, Holidays, and then uncovering a bunch of new issues with '-o
> test_dummy_encryption'.  I'm still working through some of the btrfs specific
> failures, but the fscrypt side appears to be stable.  I had to add a few changes
> to fscrypt since the last time, but nothing earth shattering, just moving the
> keyring destruction and adding a helper we need for btrfs send to work properly.
> 
> This is passing a good chunk of the fstests, at this point the majority appear
> to be cases where I need to exclude the test when using test_dummy_encryption
> because of various limitations of our tools or other infrastructure related
> things.
> 
> I likely will have a follow-up series with more fixes, but the bulk of this is
> unchanged since the last posting.  There were some bug fixes and such but the
> overall design remains the same.  Thanks,
> 

Well, it wouldn't be Linux kernel development without patchsets that don't
mention what they apply to...  I managed to apply this for reviewing after
spending a while choosing the base that seemed to work best (6d3880a76eedd from
kdave/for-next) and resolving conflicts.  It would save a lot of time if proper
information was included, though.

- Eric

