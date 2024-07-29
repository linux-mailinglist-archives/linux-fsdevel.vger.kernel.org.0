Return-Path: <linux-fsdevel+bounces-24409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC193F0B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F631F21D7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 09:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8634140395;
	Mon, 29 Jul 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAjtlnzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5169313DDAF;
	Mon, 29 Jul 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244376; cv=none; b=HALUghBWf8jlRNjfVZsy9XFz1GbDP1PB+oyBSh5obVayDruBxolufkVCG58Z+PmYEe0DZg8JSZNMDlFmqr1H5i+Kt3FJWm2DwWZF88p5CoUtyCaV1/0ACyxqHfmLqLP5orgsd+jAjyt9YNWWGYF5H6zRdCWxUrrP1naZt/r4Yh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244376; c=relaxed/simple;
	bh=70Yk2qWcEPq0YMz5MhPbsRjtysROwfSfU6XQ4d1lilw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDL6ISmyhc/ZsS4fVmmUG5EmnAccOLL/jPrVIG+zxS14a5a6QgiQugTyLAF0qeNnQaA+QGPyYm6G+ha/GK989o+gNHNGJvOhyUfw9nbmynCYI0aenckq1ACVKXPGA/CgzhznobbI96TZwFDudjEXMh8idDus6d9mG7zX7BHXagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAjtlnzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A7BC32786;
	Mon, 29 Jul 2024 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722244375;
	bh=70Yk2qWcEPq0YMz5MhPbsRjtysROwfSfU6XQ4d1lilw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAjtlnzWHzPxkYgtWHZAC7sewSaL0SzIP9FsGhGYnbV/AapwMRSIGy0QM1f7+fLwg
	 qFGxqXBHQa3w4W9Zs1hNyVf2U0mWBz6byCdmSeGspWPHx9e7QHI2I9DBvq2iayILjR
	 U/j2usEMvqKVbB9MYxmG00DuUmiDGdUCWKDAzlLcSgxGNzHygiJYLSTlAW6oeeC61J
	 mw4tCk1vx2ZmA29b1O8OuobdRyyQasP4tm+vle6vhngQFwdJo/F21kIoKUHOJjhBM4
	 w6XKnCzBxxUECKzU18txH5ZtAyMFYM83E49AMasoXlLG/tVP69HP2Y4zmkzBpS4Y+f
	 023TqhICib0gw==
Date: Mon, 29 Jul 2024 11:12:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: jack@suse.cz, axboe@kernel.dk, tj@kernel.org, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fs/writeback: fix kernel-doc warnings
Message-ID: <20240729-endabrechnung-proletarisch-4843dd0ea1bd@brauner>
References: <20240729020606.332894-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729020606.332894-1-haifeng.xu@shopee.com>

On Mon, Jul 29, 2024 at 10:06:06AM GMT, Haifeng Xu wrote:
> The kernel test robot reported kernel-doc warnings here:
> 
>     fs/fs-writeback.c:1144: warning: Function parameter or struct member 'sb' not described in 'cgroup_writeback_umount'
> 
> cgroup_writeback_umount() is missing an argument description, fix it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407261749.LkRbgZxK-lkp@intel.com/
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---

Unfortunately I had already fixed that before applying. Thanks though!

