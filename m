Return-Path: <linux-fsdevel+bounces-8755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6783AAE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B841F26601
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82D077F16;
	Wed, 24 Jan 2024 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3nwWoI0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792D77622;
	Wed, 24 Jan 2024 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102861; cv=none; b=rYCp4zW53ek+of9zvwGb+sI97k6MrFDZnTbHW73/oBcYr/ry6Pqugk/RXbQiarKhm3942x+Am1dD2lkgKG55nfpRBo8g/+1b9qdv/EWPd/aPFTFX76BAYc0Tc842zUBe8Va7L+mUXtOA7x2jGHC8zw6AfpTvYMjZe2mM94vjJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102861; c=relaxed/simple;
	bh=bNrHqLlFYmYkA+7xzD7KSxDGDte3wX3S/VF9m/zHMAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1ngWqXUEtEviMBuYvQG0UOKwS8iXMwqNEb2ytX50PGYar1Q2dTAxwC5F9PhXvYWj8GoZqXcyX0yL8Vrkp/sExDIb2w1/kDFMT0zMallay44lBDLdb/b2OVnb/6vjZOozzumJYz1mPqePnk1pp6Hu4UPqDfKATwV9M/v/bFkt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3nwWoI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA6FC433F1;
	Wed, 24 Jan 2024 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706102860;
	bh=bNrHqLlFYmYkA+7xzD7KSxDGDte3wX3S/VF9m/zHMAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3nwWoI0H2BP9UMdNWaXtwNf2HozuQ8m9PtmZeJLHrirRYzop1u+gQJ4VmM04FUpW
	 QImQOqcKn/otEAn98vajr6b/0BtsunIO6koFteiaIMrXQuoXTMYNlEAXq3jHcqXEA9
	 vHJU3KimT4eCyat62+QJ3euS7aJby2bBc/OHiIiA4r55dNxgp31rKSSe3XulnlY7HM
	 ieRG6L0nyC87LdVscMm21GAxvaV+lTwLo5ROwxv4dsRiUTux8+/LugvirnWo1SpdOv
	 dTwuK2QcG2ejZ0IyWwKEn+uy6rzg9tMcw6lelinIjf3Hy702I4D0I8R2r+vbXYAVa7
	 NjQiQMz8RWWhw==
Date: Wed, 24 Jan 2024 14:27:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	kernel test robot <lkp@intel.com>, sfr@canb.auug.org.au, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Christian Brauner <christianvanbrauner@gmail.com>, 
	yangerkun <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, linux-next@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [brauner-vfs:vfs.misc 12/13] include/linux/fs.h:911:9: error:
 call to '__compiletime_assert_207' declared with 'error' attribute: Need
 native word sized stores/loads for atomicity.
Message-ID: <20240124-warnhinweis-servolenkung-e482feb8fc43@brauner>
References: <202401230837.TXro0PHi-lkp@intel.com>
 <59fae3eb-a125-cd5f-224e-b89d122ecb46@huawei.com>
 <20240123-glatt-langgehegter-a239e588ae2c@brauner>
 <2abc7cc4-72eb-33c9-864a-9f527c0273d3@huawei.com>
 <20240124-abbaggern-oblag-67346f8dee9f@brauner>
 <bf9b8a90-7ace-5f14-e585-8cc467f4d611@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf9b8a90-7ace-5f14-e585-8cc467f4d611@huawei.com>

> If CONFIG_SMP is not enabled in include/asm-generic/barrier.h,
> then smp_load_acquire/smp_store_release is implemented as
> READ_ONCE/READ_ONCE and barrier() and type checking.
> READ_ONCE/READ_ONCE already checks the pointer type,
> but then checks it more stringently outside, but here the
> more stringent checking seems unnecessary, so it is removed
> and only the type checking in READ_ONCE/READ_ONCE is kept
> to avoid compilation errors.

Maha, brainfart on my end, I missed the !CONFIG_SMP case.
Sorry about that.

> 
> When CONFIG_SMP is enabled on 32-bit architectures,
> smp_load_acquire/smp_store_release is not called in i_size_read/write,
> so there is no compilation problem. On 64-bit architectures, there
> is no compilation problem because sizeof(long long) == sizeof(long),
> regardless of whether CONFIG_SMP is enabled or not.

Yes, of course.

> Yes, using smp_rmb()/smp_wmb() would also solve the problem, but
> the initial purpose of this patch was to replace smp_rmb() in filemap_read()
> with the clearer smp_load_acquire/smp_store_release, and that's where
> the community is going with this evolution. Later on, buffer and page/folio
> will also switch to acquire/release, which is why I think Linus' suggestion
> is better.

Ah ok, thanks for the context. Can you send an updated series then, please?

