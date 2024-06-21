Return-Path: <linux-fsdevel+bounces-22137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47C912C50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78E81F22B32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE813160792;
	Fri, 21 Jun 2024 17:16:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744003EA66;
	Fri, 21 Jun 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990192; cv=none; b=uVnk3W82WaN5X2jg9nRasv/SdamsPZF92y3MT7M2IpVTZf/x0bAyei5wMpEz2r4ip5pVyhruE56dDoXRH7KqhHOyQZXsukdxAnwKqlhBsmntTWngXLs1aDHOIqB8u8DMVi+JYnZXlr6Poz7+QVhUQfjbwVRzMpha4B/xIjTdqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990192; c=relaxed/simple;
	bh=p1eh7NcEYjHNpZ5ZwSRwmMG3GKSxKkwtdlwS/BjQXxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU4PVd+hGH6rJbK9g1JILbQPsX7ZKjvYtCC1Pxz1U7bTvc8wB2+OOOSAwWdZw87NiHJB1cQsFdKBQx2pJnnRuFEVKFLj6OjSZrhdSWIWYUF1XHg/mlHHFBbVhclQNEmfvai3oLRtI/sSfwSoB4HOVDneiexWiLfAXenkAN/i6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3053FC2BBFC;
	Fri, 21 Jun 2024 17:16:28 +0000 (UTC)
Date: Fri, 21 Jun 2024 18:16:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 20/29] arm64: enable POE and PIE to coexist
Message-ID: <ZnW1athTTlx1_hac@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-21-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-21-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:38PM +0100, Joey Gouly wrote:
> Set the EL0/userspace indirection encodings to be the overlay enabled
> variants of the permissions.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

