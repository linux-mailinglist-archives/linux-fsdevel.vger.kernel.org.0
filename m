Return-Path: <linux-fsdevel+bounces-26892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8095C990
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 11:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656801F2255F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F47016BE2A;
	Fri, 23 Aug 2024 09:48:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594B152178;
	Fri, 23 Aug 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406536; cv=none; b=b7Z3ZoX5Ld5iNKAV4kciU2lXkuOjwwFH3ojTBXAM75Oen27BYWdjL0/z9X/pmIFXj9PGoNwcBVrjH7pS3n0DU6uAt7wN8Rv1x/8UXR2FbMv4j47kvfttEbHN8c0WXEkmQ9WAjFmRioMJtEDa2SWri3p85XgdfDMbu+dgNaECzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406536; c=relaxed/simple;
	bh=shLl9B9UeieVDAiPc96T6YsYCgNbh9Jph92u4fXeHmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjkVwPt/ZpoBC6st2UEXBO6yUzL7f+4QzEmQHEs9Lui2zIMBv1SBUveZm13Mus4JjMAd0folne2DOSz7XeNf6YUtuXmT3dSRmxUb3rtIJzd1w6V+i7JGb8dD4JOjo/h23S9CD5tSGyLDP4z3vYTzK95XRD3uHVgAV80uxTfk8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6993C32786;
	Fri, 23 Aug 2024 09:48:49 +0000 (UTC)
Date: Fri, 23 Aug 2024 10:48:47 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 27/39] arm64: Add Kconfig for Guarded Control Stack
 (GCS)
Message-ID: <Zsha_58Y2nkOC35v@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-27-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-arm64-gcs-v11-27-41b81947ecb5@kernel.org>

On Thu, Aug 22, 2024 at 02:15:30AM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2f8ff354ca6..772f9ba99fe8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2137,6 +2137,26 @@ config ARM64_EPAN
>  	  if the cpu does not implement the feature.
>  endmenu # "ARMv8.7 architectural features"
>  
> +menu "v9.4 architectural features"
> +
> +config ARM64_GCS
> +	bool "Enable support for Guarded Control Stack (GCS)"
> +	default y
> +	select ARCH_HAS_USER_SHADOW_STACK
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	help
> +	  Guarded Control Stack (GCS) provides support for a separate
> +	  stack with restricted access which contains only return
> +	  addresses.  This can be used to harden against some attacks
> +	  by comparing return address used by the program with what is
> +	  stored in the GCS, and may also be used to efficiently obtain
> +	  the call stack for applications such as profiling.
> +
> +	  The feature is detected at runtime, and will remain disabled
> +	  if the system does not implement the feature.
> +
> +endmenu # "v9.4 architectural features"

BTW, as Mark R spotted we'd also need to handle uprobes. Since that's
off in defconfig, I think it can be done separately on top of this
series. In the meantime, we could make this dependent on !UPROBES.

-- 
Catalin

