Return-Path: <linux-fsdevel+bounces-8248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89D831B7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5557288F2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6A658;
	Thu, 18 Jan 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZEanvXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180A375;
	Thu, 18 Jan 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588609; cv=none; b=sN6Fb0vX7lmKJBsR7kkKl2KJ03cD0z/lPP6ZvR5dyGj07+ba+L+KGz8d76pFeR6LxjajgptUbvjGmqlhe2P0yfo5GablPX+mSAP92UdubI/VhVilLatqI9/N/+bHcjc5tdoKMlZu9d8EkuIx5m+vgd3KPtvjxtLtMZXX2LiB5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588609; c=relaxed/simple;
	bh=qMt2J9WJVh8Lt5ah5A2hje2wNwvlh9tADBFQTncWdZ0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=TeU+icpSMENUPb2eninezaM8xZNs7sr77WDwNDBCnzcgA6kL9IJ4LPOgboyvecvewDpLo3adajb0/CSKbL2v0JyBFLjYRNtf9QQBrNnWA4/VChVt03dPmT0zp2io38tdvQdT4Fg0nGfkPNFQ4UJHbqvKb5y+l8G9tGv28ULRDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZEanvXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282DBC433F1;
	Thu, 18 Jan 2024 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705588608;
	bh=qMt2J9WJVh8Lt5ah5A2hje2wNwvlh9tADBFQTncWdZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZEanvXWX4JwfldgWL7suTBzVUCnAVAeMd7rwByUUcbkTM23v34drO9DkKByRHcsx
	 bMbtTyLqKBtw1aTaAzIZ7W+s4FUcXThq17tZXtTujAqYocTUChK1Gk4zN66S/Yuwt8
	 HQ6Yv96H971uPjWFigf9xB1TkaHNSfBB6PIu+oulbJe3VNHjLBg8SjMZQiYR9KfLn6
	 gjbhRMu1I1aqCe5ZXKMLkPinpYVLTznO1QtlguVmTK2f+w7ZfVUaIW1YXDy4Dc3wHX
	 u4sT9HL4Vb+pUjnrs40Ji3aVmJ7/WhVNjIIpOyeMrrOnTc7tKdT67kVquKnOyW7qrk
	 ZXNOZxHyKsW+A==
Date: Thu, 18 Jan 2024 15:36:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>, jack@suse.cz
Cc: viro@zeniv.linux.org.uk, akpm@linux-foundation.org, tj@kernel.org, 
	xiujianfeng@huawei.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] writeback: move wb_wakeup_delayed defination to
 fs-writeback.c
Message-ID: <20240118-werkvertrag-wahrsagung-3011377aef2d@brauner>
References: <20240118203339.764093-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240118203339.764093-1-shikemeng@huaweicloud.com>

On Fri, Jan 19, 2024 at 04:33:39AM +0800, Kemeng Shi wrote:
> The wb_wakeup_delayed is only used in fs-writeback.c. Move it to
> fs-writeback.c after defination of wb_wakeup and make it static.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---

I'll leave that for Jan to review.

