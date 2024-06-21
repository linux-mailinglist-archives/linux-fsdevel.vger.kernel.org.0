Return-Path: <linux-fsdevel+bounces-22127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD84912BFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 18:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1642228948B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3017160865;
	Fri, 21 Jun 2024 16:58:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3DDDC4;
	Fri, 21 Jun 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989114; cv=none; b=GAznW2nX/sF0aj9eDYRk5hPWXlvnLnSFTnv65h+O0tfLfF7G4IGAtALisInUVgo8VKiyaesXDLLMKzSMvbrN+wMRzyyzIRGVsW7+L81YJt6cH/Robt15U9ziuIjTDyIM4LtHrcHsXB7LzQAMX0mIJnUZPDdXQltEB9FGWa53AE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989114; c=relaxed/simple;
	bh=YZ4wuvbb4gFtHZbF9fvlx5bgcCy4f7uN9nMQ8hyWNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfIjKFt5pWk7mTe9T5R3pB2oMhNIqzUbmcSFUaiqbXWcVmug/4CmQiNwoMtZs7OkEpS6h8Tl4g4jDyx3iLVUpusyBkhaQg7AclsqsX2Gab6Fh00wNTLN8PYZD/JKad3Qu2js97A2PHno6uhasBVIZkPZar86E23K6WhWEqW5dAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1D4C2BBFC;
	Fri, 21 Jun 2024 16:58:29 +0000 (UTC)
Date: Fri, 21 Jun 2024 17:58:27 +0100
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
Subject: Re: [PATCH v4 05/29] arm64: cpufeature: add Permission Overlay
 Extension cpucap
Message-ID: <ZnWxM1tNITYyyXS_@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-6-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-6-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:23PM +0100, Joey Gouly wrote:
> This indicates if the system supports POE. This is a CPUCAP_BOOT_CPU_FEATURE
> as the boot CPU will enable POE if it has it, so secondary CPUs must also
> have this feature.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

Adding some acks otherwise I'll forget what I reviewed.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

