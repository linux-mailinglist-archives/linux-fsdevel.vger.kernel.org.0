Return-Path: <linux-fsdevel+bounces-25660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D094E9AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819452808EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 09:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017416D4DE;
	Mon, 12 Aug 2024 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHsf4RbE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200B20323
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454711; cv=none; b=TWNqxTQ6u0Wg/iUglPyZSlx6R7wwGcNi5TyBpZ+3HTXthvAgSB/XeS6BV2Pee/WKFxyX+Nw9X2wJD4gQkOxlkuRIy6dp2xYTQwNZrCHmfLu7VsCYaAlHJsgacWuvELh3PWJQMW7VsSZmeKjdF25Ync1YHIAiD2HGdqgpr7eAS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454711; c=relaxed/simple;
	bh=WGRzrVkbDA/h0pWcD4AxGsPYjycrGPUhqmb4M2Fx0gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erGe6R8MJB3E79rJejmWdjfKfNvXEAyT336nCxDBiZ0wciZ2owScKjUWHyc4zVyZ/jpN75ID2mPwqvy2nBnkZ6yN/VzFTVYsM6M5dHwVQOXF80VExcMqwKsAQBHpGD+EjQAdW2ExD5MBBNv60ZBAGbMpR/sXtb+HQGnDoESx8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHsf4RbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F00EC32782;
	Mon, 12 Aug 2024 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723454711;
	bh=WGRzrVkbDA/h0pWcD4AxGsPYjycrGPUhqmb4M2Fx0gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHsf4RbE9A2bX2NzelyiqKWiEfzeDHOakiRSE2gufriHHg329mXt8/y0e+3KUMoEm
	 uwIDhXyxZf/aEOmPiCooEtcEEI9IhKJl4MZht8okthXKTX1e/zCCEVmkQpG+uvC9Oi
	 40hdhHEZoMsGs+9Zwf1RAGnJiAzBbYQeU/3pAVWmNN1H40PNNx+ZQdJX0tgsBsiLec
	 ouOAGk6OlZDa+xzS7c/SUMtLsIK72+MFTiRT2dbNnnpCu2iDRr6iMZ4Ju/+JTxHlER
	 xQYRWLfNVo68mxoG6vfLomUgp44Vo+wldFttilv3pFINGtvZHurdR1FCgdKoyDnrkO
	 A8XqFuocZoP1w==
Date: Mon, 12 Aug 2024 11:25:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/11] remove pointless includes of <linux/fdtable.h>
Message-ID: <20240812-rennpferd-fielen-86699e3effde@brauner>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
 <20240812064427.240190-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812064427.240190-2-viro@zeniv.linux.org.uk>

On Mon, Aug 12, 2024 at 07:44:18AM GMT, Al Viro wrote:
> some of those used to be needed, some had been cargo-culted for
> no reason...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

