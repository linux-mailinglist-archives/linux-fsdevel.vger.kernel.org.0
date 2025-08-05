Return-Path: <linux-fsdevel+bounces-56703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643B2B1ABB0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 02:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31A018A055F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 00:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F3D128819;
	Tue,  5 Aug 2025 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9fAlkr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA252F85B;
	Tue,  5 Aug 2025 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353463; cv=none; b=VwoW/gR2x0jZ3HVmR8/C++u/4aDnw7276KcbW6rrv5+HN9CedXX2wz1hZ8bkf6jDSMtHOjRU4wgN5IEJaTu+nCY+WvdgwjoYbQRC9KAXSPqNP1ptpd7BgJrPSYYtMeMSfwWkKTgfNZvmW5Uc5CTCw0iyjS66wRTV0KacigaWJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353463; c=relaxed/simple;
	bh=BTRLS37F6fEXicLH3zCLCSaYO+eszqMeA1wyetcZWEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsMR4DxRLtGEdgJQ/t+4I8AS/++YNpVgvY9kGxHGXzauqaovgHeRkEhhLhvyJinniiCTe3LWctVgxZ41Bp1EbYwQ1uCm0wjJAr0YLJoMnaCieQkb4QWDK16vZCbXBOHBMl8crAfNMDEKsW0Ids5AsCO6gIGrjma03qIZwKrMjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9fAlkr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056ABC4CEE7;
	Tue,  5 Aug 2025 00:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353463;
	bh=BTRLS37F6fEXicLH3zCLCSaYO+eszqMeA1wyetcZWEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W9fAlkr6K73zCeG4TS/yronzilbHRn2vdIAR63tKAalChAnzWYc3egVxX6q2FExSp
	 qMLyD1zjmT9dLpeGT/LEG6OYzoMEfsHPhQDG7N4Ip53CcQV/ri4atbj0jkRMfVVtda
	 taHzu12Uu/Ci8KSToXppe7+jhw9n3e8xc3z9QHqY9eVlG+/gQd7vT30RbGNeyya/0W
	 jMcQJ5s+95qjKhPwoM0shjOSKvbh4/xy9j4qIQeRxm+rDkHCcANth2A13yoF9sBPXj
	 HgRFjX8xP3N34HXHt/CUrgscEfR4v/I5coanJ5d4thHaKfHtPb+RJX0zubI+rAytZ4
	 fu9Mru+jNehxg==
Date: Mon, 4 Aug 2025 20:24:21 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 7/7] iov_iter: remove iov_iter_is_aligned
Message-ID: <aJFPNbaz3_yRDznz@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-8-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801234736.1913170-8-kbusch@meta.com>

On Fri, Aug 01, 2025 at 04:47:36PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> No more callers.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

