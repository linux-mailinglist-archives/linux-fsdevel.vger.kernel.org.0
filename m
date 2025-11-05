Return-Path: <linux-fsdevel+bounces-67123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEA8C35C81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 14:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C8184F2791
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6403191A4;
	Wed,  5 Nov 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYx6HocA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E322DCF4C;
	Wed,  5 Nov 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348416; cv=none; b=Q0fzGibDBWRCb3KgiuznOB7CkJupc0f7EgDl97PHqPrp3LizZrk/lZtmB6h+2VrPgY8tB8ROLleEM4f1YEBWDd8G5EGbfWPvL1VKXtlJF2P6CM3YVJ8Sfq1Z/hFb5Fk6f3/uQ7iVji4SJJv9eyoKRCJPb5P/dKxl31P54SjySzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348416; c=relaxed/simple;
	bh=1fZTkRNwX3krq4GEcZpgaeh2R1lea3Jj9xZ2SAR+Iek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjMOT5kaxRIcIG/gnSCkIBRX+p0BtH7UVrXENSDFh5kAUsdnncVGkCnK6ukf8AGqUwiJlq+MJcetsD2bG5ssKblERghhbLTbIpSml/RAmuwp/aKXTLV67Oik2Nu4RlM6aD25sD68oY0Qpdvw/wJIzAH86G2SiLNVwlMNatPyCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYx6HocA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBBBC116C6;
	Wed,  5 Nov 2025 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762348416;
	bh=1fZTkRNwX3krq4GEcZpgaeh2R1lea3Jj9xZ2SAR+Iek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYx6HocAiiWdIlY8P1Ni0WfQ8tLPcWhGfDJTipZ/vBMEkvR5oeSnuI71jwamTaxqq
	 A0F49B5SfCRONStpnVlpHCogqSuK2jO009uU1CiCpWQc8Z5ZlivAbXGi/TTr2FiBN/
	 6YsvdfzFLzCzkGMctHA3487yv9rtoyOeUDBpJaZR/lIyERYhMLzvA+vld0BZCEVVwF
	 gkXam3+plDnSdbJzT9jTzTzuTIz9TKabHZZgxbrkMBZmT1JDdmt5mHARiIKEpVDf9l
	 6XXKsVL+kv1wwC3Ygjei4LJENkFq8Mnvuqhh1WUOt+r1VnAaC50ua91kqivm1NbwGq
	 fRK4NR//79u4g==
Date: Wed, 5 Nov 2025 14:13:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: start to split up fs.h
Message-ID: <20251105-nippen-forsten-dabf4d7508eb@brauner>
References: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
 <aQtJRisTtkX-Jzen@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQtJRisTtkX-Jzen@infradead.org>

On Wed, Nov 05, 2025 at 04:55:34AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 04, 2025 at 03:46:31PM +0100, Christian Brauner wrote:
> > Take first steps to split up fs.h. Add fs_super_types.h and fs_super.h
> > headers that contain the types and functions associated with super
> > blocks respectively.
> 
> We have this nice concept called directories for namespace prefixes.
> Why not include/linux/fs/*.h for all these split out bits?

Sure, fine by me. Some do it differently. For example, mm has mm_* too.
But yeah, the fs/ layout is fine.

