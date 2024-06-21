Return-Path: <linux-fsdevel+bounces-22130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B787912C2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC23D1C21B4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21521607AD;
	Fri, 21 Jun 2024 17:03:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A8513D521;
	Fri, 21 Jun 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989413; cv=none; b=HV9hFVIrjMSUp//n3EXRLroI7CJGrG9Y0LyUS+4d2cPVG7FFg3+OgnGzSPvNLTcaHoVMgscjUOQkDpTMzVJswCHrsmClfF0TOpip3M3rg91mNp5emOuB4M4y+ScOqqM3EfOL1dHkOIB3WyMaIUD7yeGdmwlDtr/873X2/U5WIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989413; c=relaxed/simple;
	bh=D+Raz8KAfT2bCqaRz2uy0roK97yIdIygpPSbXYx7Drg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdheAu2egBOFoD7h5zKwUDs/CQrevV0ooHQhBmjx1jg4wN5AuV8PlQFxvZMi2O2HYMUCk1As6VkSSwvszeUrznKyq9T/Yt/JOMWS3iv9II5t/Dq3bFgk9ur6wIxMqmTrlBq5T3VanBOss/3xMDCUV2K2JKidUek2/1kb48jO4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D240BC3277B;
	Fri, 21 Jun 2024 17:03:26 +0000 (UTC)
Date: Fri, 21 Jun 2024 18:03:24 +0100
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
Subject: Re: [PATCH v4 06/29] arm64: context switch POR_EL0 register
Message-ID: <ZnWyXEpoIx_BnUhw@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-7-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-7-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:24PM +0100, Joey Gouly wrote:
> POR_EL0 is a register that can be modified by userspace directly,
> so it must be context switched.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

