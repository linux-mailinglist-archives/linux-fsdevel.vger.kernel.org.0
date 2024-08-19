Return-Path: <linux-fsdevel+bounces-26245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289C956680
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18702860BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B815ECC6;
	Mon, 19 Aug 2024 09:12:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5615B14C;
	Mon, 19 Aug 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058744; cv=none; b=cqVf3/2ZvMjqnsQnRV33LUkVNTDc3F+G9cqUx7Ozo0cUcsgPs59eCt8SkVzzlHrH3tds1S2nFPer2ifvr3sKZh3jEEDj5Kzo0TxImwVvDHpOXkeErm6Zcg/dtCu/LlO9jy+2qrH3HnsWiCJC+Jbj8WT4dIp5lmlX20p6gWfbIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058744; c=relaxed/simple;
	bh=6pYqfa9L8DBEkL940BQiGRPe8Jr534n4rXkMGQghNbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL0XjNRchmlKt2yyNIjECsQP/jbWholaT7k+SRVf6jBXVVY1IuEjg51HZhtVeZjH+r0TWH8B7uCAOl1X/FXOfSh7c2PJH9b2KLz8ZAmB4ThmKWGnNUKkGbx3FYBL42B8lxLew1dGpishPBapu/lOgmYwPBNBQMbe4lsM4kUHkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8031AC32782;
	Mon, 19 Aug 2024 09:12:18 +0000 (UTC)
Date: Mon, 19 Aug 2024 10:12:16 +0100
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
Subject: Re: [PATCH v10 16/40] arm64/hwcap: Add hwcap for GCS
Message-ID: <ZsMMcImUfZ6X5hBw@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-16-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-16-699e2bd2190b@kernel.org>
X-TUID: ar7/7KcGpDoJ

On Thu, Aug 01, 2024 at 01:06:43PM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> index 285610e626f5..328fb7843e2f 100644
> --- a/arch/arm64/include/uapi/asm/hwcap.h
> +++ b/arch/arm64/include/uapi/asm/hwcap.h
> @@ -122,5 +122,6 @@
>  #define HWCAP2_SME_SF8FMA	(1UL << 60)
>  #define HWCAP2_SME_SF8DP4	(1UL << 61)
>  #define HWCAP2_SME_SF8DP2	(1UL << 62)
> +#define HWCAP2_GCS		(1UL << 63)

You'll be fighting with Joey over the last bit here ;) (we do have
HWCAP3 though).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

