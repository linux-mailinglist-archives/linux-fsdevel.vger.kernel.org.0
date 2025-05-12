Return-Path: <linux-fsdevel+bounces-48723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8913AB33A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A83D17A6D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD16625EF89;
	Mon, 12 May 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuTKMfVH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289C25F97C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042185; cv=none; b=VBcuFoAugTFE8M/nPoWJAOz/dhq0LGxO6PfFaMzRIcx7Nbc/cyExWvkHRUG+QsgVBMuzWfCULxRO0l2qkUAeS3RLMBE8r0/oIM6aLSiFs+Ve/DkXcLD4mbqArBSwgAfdDPAUUZ206DD1WCSHIvMJJYZKcznNw3McHt5q/yIeosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042185; c=relaxed/simple;
	bh=rLAhnDerrM+9/iZ82pUCPuWbcnaIINxb/LxljkhofpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE75eAKicM7Zpw7wbZV9oadWertDRo4AWq5xcdl+ZbeVrBgBeUMn3fKRmohmpKEHt9nOIw0x/gB7VpapAILGGYfhtGTPC+oisrX3fRRkbvF8xfDzqoHfTa3FF5lyRZSR75DFiPOf/oXzSuK7ilVGaU8V1HQje0dIFJhqHgO+v3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuTKMfVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D18C4CEE7;
	Mon, 12 May 2025 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042184;
	bh=rLAhnDerrM+9/iZ82pUCPuWbcnaIINxb/LxljkhofpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuTKMfVH5n63d7dTn0+UwSly0uVmv2dofG1eSPrLDGnCUTRLYbHjNReHkSwffUpoB
	 m9IhsTsH9cuSEPha0i7ITI82JQ574LWQJH0rozWpltRTdkwjo5l/+IoAYrh/MHp+O5
	 lpFGXHL8DW9nuB0Nm2Sfz+H8bOSdvH/ICcoGdlLtPN8HmW654OYcZrX7c/frpZ+HJY
	 MN0GZorRAd9Sx9Ag7q82/8QBjdhaD3pUJDUYUlWOJEBwyBS9MWNV4E1agFbPusvC7u
	 QjlPeG+TmpL/kaHaP34PCms9cvi+yQJtxA5RBl6Ke0NGY+4gWALSsGI2UHYIWg9C9K
	 2H4RIkC6Mn7vg==
Date: Mon, 12 May 2025 11:29:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] selftests/fs/statmount: build with tools include
 dir
Message-ID: <20250512-gekonnt-magnesium-94af268a23fc@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
 <20250509133240.529330-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509133240.529330-3-amir73il@gmail.com>

On Fri, May 09, 2025 at 03:32:34PM +0200, Amir Goldstein wrote:
> Copy the required headers files (mount.h, nsfs.h) to the tools
> include dir and define the statmount/listmount syscall numbers
> to decouple dependency with headers_install for the common cases.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

