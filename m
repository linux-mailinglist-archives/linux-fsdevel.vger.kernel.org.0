Return-Path: <linux-fsdevel+bounces-31899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B19E99CFCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08447B24C25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C231B4F0A;
	Mon, 14 Oct 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNDqD7xh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDC1A4F20;
	Mon, 14 Oct 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917737; cv=none; b=gPtMUvawbmwuXtoGUd1cgSN0SeF8xEQZJyk7Unu4vtETATYs2pM23E3Mdu2UNBXbDzDnFjaJO6qA89g4hLuYL1zXflUXnnhH2MO2kjb4jb6UCzrMM+1ETypXHnvaRo0s81TCk9KoFD7VYCqO778i/WRPBfPJQByXyWGhwBYdkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917737; c=relaxed/simple;
	bh=kMc4iusA9vjrAOO2EnzfX6U2//CAjSVpSx54a9ql8jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhrQKqgFmS6n7Py9gXH4MEB81OmcSMOBv0BrTBZ3gLss/QjDNJuQHMdqzRFgxV8OScPCuKsbCvDSHT/WRsh/LaTq6fgR4vwNG/mYWcGwAwp62gov2EfJEn0j2jaJ8kGPJ4XT41BqCmHZc9w90bd0Y3wmWdxu9tzKU5U+4yYjxq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNDqD7xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFDAC4CEC7;
	Mon, 14 Oct 2024 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728917737;
	bh=kMc4iusA9vjrAOO2EnzfX6U2//CAjSVpSx54a9ql8jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNDqD7xhv668r3LmHOAyHcCWGZw2ud0lqj33ATM/cwyUNFWms3tpfrYCezLzDxar+
	 BipJaOc4ZVrcqJodyVtkd6ficho3P4clRqYcrmFwMckwDIWqYlPfg7uKmhJaM/7ebl
	 eiF8xCVLw+qnEplYX9B04dIbMRELNdfQHX2Xw3+MFO19jSCcoWEP5zpTCDztlmO/s/
	 b1qbvqbtsfeNpIvNzr01d0QhMiJGnYemGyLpCtEFNxQwHA2WDm15fFUAvBiWJtbCqa
	 0za+T1nw+yxN1d0mLbPMGKedDrMWLoqLKQMxtwqCR3bUzyPdc4rgLeuUjWLXnN87Wm
	 MvuRfEb5eV9/g==
Date: Mon, 14 Oct 2024 16:55:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>, 
	Jeff Layton <jlayton@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [fs]  e747e15156:  aim9.creat-clo.ops_per_sec
 4.2% improvement
Message-ID: <20241014-unflexibel-umorientieren-f37bedead363@brauner>
References: <202410141350.a747ff5e-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202410141350.a747ff5e-oliver.sang@intel.com>

On Mon, Oct 14, 2024 at 01:58:28PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 4.2% improvement of aim9.creat-clo.ops_per_sec on:
> 
> 
> commit: e747e15156b79efeea0ad056df8de14b93d318c2 ("fs: try an opportunistic lookup for O_CREAT opens too")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

For once a positive gift that give keeps on giving.

