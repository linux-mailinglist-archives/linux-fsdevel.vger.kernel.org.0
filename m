Return-Path: <linux-fsdevel+bounces-26106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89495478C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 349EAB242C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF61A01CF;
	Fri, 16 Aug 2024 11:09:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C5198A2A;
	Fri, 16 Aug 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806549; cv=none; b=jpWFsIxNp1EVeBZVfnmVtTbyhwtN16PYvkyCXzFHN4wFN0m+Xjxkl8V+z+fiUVx95EWoWp0CMBpZc0MQyj3zQKrGeqqux1KtN9/rwA5QcM7gMYMcm1H9C+3Rd0IJVK9xBz08z0+RletBLcnkcv6ZwqnlcA5haMXqcrxu+f04Kt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806549; c=relaxed/simple;
	bh=FbLmrmMC1NtCf5/c0O+HnpWKmt75tXsuzNE9sTnkVfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoOhM5itibErt6YVB5mv66wk0jZn/E0DSI89NG3XZ/zYb+i8xSUqgO9aMFkqobwcbYc6gz4l5vCHCSa3N2cKi5VaQ0x3Gr9rFi5C0RwazeeUVvv6sltIlYkRQDLTxP7qwQm7VrI4qiQqUg+8r9hXfWsGrRzdOmcIiYphhGK2gns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB36CC32782;
	Fri, 16 Aug 2024 11:09:03 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:09:01 +0100
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
Subject: Re: [PATCH v10 05/40] arm64/gcs: Document the ABI for Guarded
 Control Stacks
Message-ID: <Zr8zTTrJ6M0SCvCV@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-5-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-5-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:32PM +0100, Mark Brown wrote:
> +1.  General
> +-----------
[...]
> +* EL0 GCS entries with bit 63 set are reserved for use, one such use is defined

Maybe "reserved for specific uses". The proposed sentenced feels like
it's missing something.

> +  below for signals and should be ignored when parsing the stack if not
> +  understood.
[...]
> +3.  Allocation of Guarded Control Stacks
> +----------------------------------------
> +
> +* When GCS is enabled for a thread a new Guarded Control Stack will be
> +  allocated for it of size RLIMIT_STACK or 2 gigabytes, whichever is
> +  smaller.
> +
> +* When a new thread is created by a thread which has GCS enabled then a
> +  new Guarded Control Stack will be allocated for the new thread with
> +  half the size of the standard stack.

Is the half size still the case? It also seems a bit inconsistent to
have RLIMIT_STACK when GCS is enabled and half the stack size when a new
thread is created.

[...]
> +* When a thread is freed the Guarded Control Stack initially allocated for
> +  that thread will be freed.  Note carefully that if the stack has been
> +  switched this may not be the stack currently in use by the thread.

Is this true for shadow stacks explicitly allocated by the user with
map_shadow_stack()?

> +4.  Signal handling
> +--------------------
> +
> +* A new signal frame record gcs_context encodes the current GCS mode and
> +  pointer for the interrupted context on signal delivery.  This will always
> +  be present on systems that support GCS.
> +
> +* The record contains a flag field which reports the current GCS configuration
> +  for the interrupted context as PR_GET_SHADOW_STACK_STATUS would.
> +
> +* The signal handler is run with the same GCS configuration as the interrupted
> +  context.
> +
> +* When GCS is enabled for the interrupted thread a signal handling specific
> +  GCS cap token will be written to the GCS, this is an architectural GCS cap
> +  token with bit 63 set and the token type (bits 0..11) all clear.  The
> +  GCSPR_EL0 reported in the signal frame will point to this cap token.
> +
> +* The signal handler will use the same GCS as the interrupted context.

I assume this is true even with sigaltstack. Not easy to have
alternative shadow stack without additional ABI.

-- 
Catalin

