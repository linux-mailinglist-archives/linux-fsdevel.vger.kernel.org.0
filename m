Return-Path: <linux-fsdevel+bounces-25655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D294E8F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 10:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B331F22DFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1493916C440;
	Mon, 12 Aug 2024 08:52:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84B14C5AA;
	Mon, 12 Aug 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452750; cv=none; b=FPaVICinKZtiZpv7NIM9SSuDE8KikCYblSa4In7W1G/eZq31JpDMG2m7DnXZCNTiG4ZU5GOqM3Y4mb02/+qTmNZCL6zzxzeatT6vWt0j0SKN6UJ7uWdCxUNxI6Ibf9JqrvWRJU/cgLNtH4cnggZCT5/X+7omaShUczjNcztiiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452750; c=relaxed/simple;
	bh=k1FJazrunpFZ6iYWhvd/aA/suw1fe3tngeFYLHcX0wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC5TNhKS/VR/iUufyjBgSgSjOce/UtrcAuPq5AS4fQbnazFd22rh//dLGxxAKOtSQfzY7Z6jVT2iqh6fTTj1y5T8WIoREb69E7euuUzhx2kjhV9Fg4ptGu125TFeboO9dmIK4+2Hf+O75f9jyGTl3ZuDSqYZZrUhe5CWgPKgf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC64C227A87; Mon, 12 Aug 2024 10:52:24 +0200 (CEST)
Date: Mon, 12 Aug 2024 10:52:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guo Xuenan <guoxuenan@huawei.com>
Cc: krisman@kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
	linux-kernel@vger.kernel.org, guoxuenan@huaweicloud.com,
	jack.qiu@huawei.com, ganjie5@huawei.com
Subject: Re: [PATCH] unicode: get rid of obsolete 'utf8data.h'
Message-ID: <20240812085224.GA3889@lst.de>
References: <20240808085619.3234977-1-guoxuenan@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808085619.3234977-1-guoxuenan@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Maybe mention in the subject that this is a reference to the
file and not the file itself which is long gone?

The change itself looks good, thanks!


