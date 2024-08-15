Return-Path: <linux-fsdevel+bounces-26083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1F9538B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E7328316F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D570A1BB6BB;
	Thu, 15 Aug 2024 17:00:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634911B3749;
	Thu, 15 Aug 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741223; cv=none; b=fz04eRcLSvGWh8cuzAj1ZMrAPP8002CPg0EfEZInROP1kroHrRen8B3FhoS4u1eZg/SrxV8D0TTCMPNcNUPDXXrPZHqOc+nszK3iCGPaciuQjo4pMf4Pf5LiW9LvQbDM/6LJ5BDcd3sYmX+qU+xtF4duW+yEop4A1Fs+O0fvZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741223; c=relaxed/simple;
	bh=Gg6eqMTXx74NWcO2J4NNXwW0PfKl0OCmoU0K7Wl6Ryg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcoEaH+u6u7K68p7xlsOGdAFbNv0usFHgHjQ/atWBbZIvuOjc2pPi9cz2Y6HGzOCsgiUWB3L66W/ykpdzrBvzSU5QrYUYoN1IWrXrSZD9/vt+AJvSYb34ZOoNfk/L2GuMUzRoGZm+P6iYDJTIaGxYlL8k6u0L8b4MzIbRS9Y2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AED9C32786;
	Thu, 15 Aug 2024 17:00:17 +0000 (UTC)
Date: Thu, 15 Aug 2024 18:00:15 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 04/40] arm64: Document boot requirements for Guarded
 Control Stacks
Message-ID: <Zr40H4xAb00MdMlX@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-4-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-4-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:31PM +0100, Mark Brown wrote:
> +  - If EL2 is present:
> +
> +    - GCSCR_EL2 must be initialised to 0.
> +
> + - If the kernel is entered at EL1 and EL2 is present:
> +
> +    - GCSCR_EL1 must be initialised to 0.
> +
> +    - GCSCRE0_EL1 must be initialised to 0.

Currently booting.rst doesn't list *_EL1 registers to be initialised
when the kernel is entered at EL1, that would usually be the
responsibility of EL1. The exception is some bits in SCTLR_EL1 around
not entering with the MMU and caches enabled. But here I think it makes
sense to add these GCS registers since if some random bits are set, they
can affect kernels (and user apps) that don't have GCS support.

Don't we need HCRX_EL2.GCSEn to be set when entered at EL1?

-- 
Catalin

