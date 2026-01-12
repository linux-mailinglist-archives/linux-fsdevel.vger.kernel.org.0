Return-Path: <linux-fsdevel+bounces-73194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B49D116C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9335E308F863
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7A0346AE3;
	Mon, 12 Jan 2026 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbzVYqFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3392328627;
	Mon, 12 Jan 2026 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209039; cv=none; b=br0Uld26Gbw6/RN+xMCHIJEnFoTmfnKlESbRko7b7XyyK20DdX/yoPuQoBS7qJy8YOwL108nXPD2zZrF469MCdd7XEP83NC8Cu3upFQsgDUQ6O5HsuGs0AL5w0HFZQCKavgFk5siIpYQndhr4Gw+C7IqwEVcUl+iI365aPYhbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209039; c=relaxed/simple;
	bh=anQHeyKqkGvMtUYSA1DooDkEFH3wVejNmY4OIw3NEhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meTJvSN710WMtpm7ZPRBtP0UzeExpxDPrDuT75pQbUn+YHwtj2NMzH9q1dW2wWI5V+8mCqVvO+O4InWSO5GzQQMMofH1sUHi/x/bsDwghmXWk1twAKglx8cZLmYDDG42KzH5fQrVxnV7Ll8dnd03epedVXpxjS01338XypI7Fww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbzVYqFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B75CC116D0;
	Mon, 12 Jan 2026 09:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209038;
	bh=anQHeyKqkGvMtUYSA1DooDkEFH3wVejNmY4OIw3NEhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbzVYqFPzcix9RRop5g1a3lPwK0RW1lo5Hk2qugRk2dqccUER0hbhTfxfav4u4KUJ
	 vhT1zdaeCazrYVMeNO9oWNmJJ61DCD/lC6W+sLQCZrd2tWowNxFVLN99KKvyOTbRiM
	 4ThZaKaZKELNKz1FsvjoMDbqZzfQwB7jLqKT57Z3e71GyWb9xqlSfBboVKSL8XZ6VF
	 CSK+yn7xKdb5nx7HvkYbTqa1B/5u0X9J/ovHRxJB7HGchFBTdDMjsYgw3yiQT4Hdgm
	 8sKOMJY2G9WJqRuaR5NRLWploez8ETzLoeVrCeSeXcAVq7otgI56REKuMglpF9YvYP
	 fjgpxJa33C0BQ==
Date: Mon, 12 Jan 2026 10:10:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, djwong@kernel.org, 
	amir73il@gmail.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 03/10] fs: Export alloc_empty_backing_file
Message-ID: <20260112-renitent-mitbringen-e94874417a07@brauner>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-4-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109102856.598531-4-lihongbo22@huawei.com>

On Fri, Jan 09, 2026 at 10:28:49AM +0000, Hongbo Li wrote:
> There is no need to open nonexistent real files if backing files
> couldn't be backed by real files (e.g., EROFS page cache sharing
> doesn't need typical real files to open again).
> 
> Therefore, we export the alloc_empty_backing_file() helper, allowing
> filesystems to dynamically set the backing file without real file
> open. This is particularly useful for obtaining the correct @path
> and @inode when calling file_user_path() and file_user_inode().
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

