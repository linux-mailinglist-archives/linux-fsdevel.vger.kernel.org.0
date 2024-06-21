Return-Path: <linux-fsdevel+bounces-22129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C9912C29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14161283ED1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21CA15F40A;
	Fri, 21 Jun 2024 17:02:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2772BD05;
	Fri, 21 Jun 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989368; cv=none; b=iDJ3dzI4co2xh6AVNN5AAvYNCEwbQaKvWSbTYilsbTj38KNzogS0pGWaRoYnh8+xGFGmwZd1iriHq3uF10blceENNwMOtSyF42RwKkr1y0qD1wAoVaiKkYEZMnSiAQWh4i4is1oCogxEbsR1Vjw37xltakkjPReWWO/ByRhyQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989368; c=relaxed/simple;
	bh=3jzH4jvEcuFZzlKGPhEVPTXbanqWf+vKVdJHAfsK8eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMvaONkvb0eXlb5aPGT8WYsTe1DkyJoxl0LmI7kwb+gBjxIAKwIK9sXM8AE3ZKvXW3MCKIHEKZo3fCkXjibFzCY9a83JDcMvIxkpDxLSzCzA5EoR+phupd5sDIMK/B8NMBYS+dXcxz0veP2kn3dDjFKGtp/qhMs6TgfeFIwojDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF7FC2BBFC;
	Fri, 21 Jun 2024 17:02:43 +0000 (UTC)
Date: Fri, 21 Jun 2024 18:02:42 +0100
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
Message-ID: <ZnWyMvu0HCKajrXP@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-6-joey.gouly@arm.com>
 <ZnWyAJb63XjZiEqf@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnWyAJb63XjZiEqf@arm.com>

On Fri, Jun 21, 2024 at 06:01:52PM +0100, Catalin Marinas wrote:
> On Fri, May 03, 2024 at 02:01:23PM +0100, Joey Gouly wrote:
> > This indicates if the system supports POE. This is a CPUCAP_BOOT_CPU_FEATURE
> > as the boot CPU will enable POE if it has it, so secondary CPUs must also
> > have this feature.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

One ack is sufficient, ignore this one ;)

-- 
Catalin

