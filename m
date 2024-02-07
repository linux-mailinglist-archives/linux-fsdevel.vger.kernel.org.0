Return-Path: <linux-fsdevel+bounces-10564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D184C49C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 07:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9F01F2567C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0751CD25;
	Wed,  7 Feb 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t9puZH7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938611CD19
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286041; cv=none; b=Nii08gWFE3jjLueS9B792UWOO1AZsaqT8/Jmmtfb1OqqmVkLJkx5HeQRf/eFvdFsF8EV8H9XM6x1oNdxNgdxsRILyGFvKoyDH70TsgD/uCGDC151q/1zeae+Flx/S5NZPs66bywQjwqbFwlsHfyDxIc9+yUNpL5f8F+sj3BVwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286041; c=relaxed/simple;
	bh=q0Mk42SfClBmXgR+mRwkON9QCrmzXvm/owjFOgsgmeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egkh5XfZBdrUh0QC0UpUB1sy7gNhTucqNR8AbU2SVJWPMpKlNdchX6+Lnbh1kPgLSTixOr+uRrxIYqDC231x1ejM6S/rFpp1KOY88TWzNX8Df1gFluhITfekMT48UQyBnTrvnNAZBshCpiFqc0t6T1UHXLajPb8rLygjqApMPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t9puZH7V; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Feb 2024 01:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707286036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rXdRa4zp6MzexystDTSFUKYrLZ3abbocWvQ9PBcVzwc=;
	b=t9puZH7VCCTNvKi8fyuu0OUIYPAwmi2atp3W9rWCEA7SeHhZwSjVrfg08j0KTQcFyx/wnH
	mWP82k2NrCnmp6JtnL031Osa7yvkTu8hXT4BD4ItYr+jXYavGClZAUIaBfSnLd7CsVEeZ1
	mpiw53RuFpFXpQU839qROJwKRIGZqy4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thomas Bertschinger <tahbertschinger@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bfoster@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com
Subject: Re: [PATCH RFC 3/3] bcachefs: introduce Rust module implementation
Message-ID: <byanermjc6vyh373uswa5hhbnwcnv3uzgngcvrkbbp5kijr67q@t3g6ox35pnbt>
References: <20240207055845.611710-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207055845.611710-1-tahbertschinger@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 06, 2024 at 10:58:45PM -0700, Thomas Bertschinger wrote:
> This patch uses the bcachefs bindgen framework to introduce a Rust
> implementation of the module entry and exit functions. With this change,
> bcachefs is now a Rust kernel module (that calls C functions to do most
> of its work).
> 
> This is only if CONFIG_BCACHEFS_RUST is defined; the C implementation of
> the module init and exit code is left around so that bcachefs remains
> usable in kernels compiled without Rust support.

so the module_init in Rust is an interesting test case, but - not much
point in checking it in if we're not deleting code on the C side.

Instead, have you looked at pulling the btree transaction layer bindings
from -tools into the kernel? That was going to be my starting point;
once we've got that there's a lot of code we'll be able to rewrite in
Rust piecmeal (fsck, debugs, alloc_background.c - anything that
primarily interacts with the transaction layer).

> 
> Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
> ---
>  fs/bcachefs/Makefile                   |  3 ++
>  fs/bcachefs/bcachefs.h                 |  5 ++
>  fs/bcachefs/bcachefs_module.rs         | 66 ++++++++++++++++++++++++++
>  fs/bcachefs/bindgen_parameters         | 13 ++++-
>  fs/bcachefs/bindings/bindings_helper.h |  4 ++
>  fs/bcachefs/bindings/mod.rs            |  2 +
>  fs/bcachefs/super.c                    | 31 ++++++++++--
>  7 files changed, 120 insertions(+), 4 deletions(-)
>  create mode 100644 fs/bcachefs/bcachefs_module.rs
> 
> diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
> index 3f209511149c..252810a4d9a0 100644
> --- a/fs/bcachefs/Makefile
> +++ b/fs/bcachefs/Makefile
> @@ -89,8 +89,11 @@ bcachefs-y		:=	\
>  	varint.o		\
>  	xattr.o
>  
> +bcachefs-$(CONFIG_BCACHEFS_RUST)	+= bcachefs_module.o
>  always-$(CONFIG_BCACHEFS_RUST)		+= bindings/bcachefs_generated.rs
>  
> +$(obj)/bcachefs_module.o: $(src)/bindings/bcachefs_generated.rs
> +
>  $(obj)/bindings/bcachefs_generated.rs: private bindgen_target_flags = \
>      $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
>  
> diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
> index b80c6c9efd8c..3a777592bff4 100644
> --- a/fs/bcachefs/bcachefs.h
> +++ b/fs/bcachefs/bcachefs.h
> @@ -1252,4 +1252,9 @@ static inline struct stdio_redirect *bch2_fs_stdio_redirect(struct bch_fs *c)
>  #define BKEY_PADDED_ONSTACK(key, pad)				\
>  	struct { struct bkey_i key; __u64 key ## _pad[pad]; }
>  
> +#ifdef CONFIG_BCACHEFS_RUST
> +int bch2_kset_init(void);
> +void bch2_kset_exit(void);
> +#endif
> +
>  #endif /* _BCACHEFS_H */
> diff --git a/fs/bcachefs/bcachefs_module.rs b/fs/bcachefs/bcachefs_module.rs
> new file mode 100644
> index 000000000000..8db2de8139bc
> --- /dev/null
> +++ b/fs/bcachefs/bcachefs_module.rs
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! bcachefs
> +//!
> +//! Rust kernel module for bcachefs.
> +
> +pub mod bindings;
> +
> +use kernel::prelude::*;
> +
> +use crate::bindings::*;
> +
> +module! {
> +    type: Bcachefs,
> +    name: "bcachefs",
> +    author: "Kent Overstreet <kent.overstreet@gmail.com>",
> +    description: "bcachefs filesystem",
> +    license: "GPL",
> +}
> +
> +struct Bcachefs;
> +
> +impl kernel::Module for Bcachefs {
> +    #[link_section = ".init.text"]
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        // SAFETY: this block registers the bcachefs services with the kernel. After succesful
> +        // registration, all such services are guaranteed by the kernel to exist as long as the
> +        // driver is loaded. In the event of any failure in the registration, all registered
> +        // services are unregistered.
> +        unsafe {
> +            bch2_bkey_pack_test();
> +
> +            if bch2_kset_init() != 0
> +                || bch2_btree_key_cache_init() != 0
> +                || bch2_chardev_init() != 0
> +                || bch2_vfs_init() != 0
> +                || bch2_debug_init() != 0
> +            {
> +                __drop();
> +                return Err(ENOMEM);
> +            }
> +        }
> +
> +        Ok(Bcachefs)
> +    }
> +}
> +
> +fn __drop() {
> +    // SAFETY: The kernel does not allow cleanup_module() (which results in
> +    // drop()) to be called unless there are no users of the filesystem.
> +    // The *_exit() functions only free data that they confirm is allocated, so
> +    // this is safe to call even if the module's init() function did not finish.
> +    unsafe {
> +        bch2_debug_exit();
> +        bch2_vfs_exit();
> +        bch2_chardev_exit();
> +        bch2_btree_key_cache_exit();
> +        bch2_kset_exit();
> +    }
> +}
> +
> +impl Drop for Bcachefs {
> +    fn drop(&mut self) {
> +        __drop();
> +    }
> +}
> diff --git a/fs/bcachefs/bindgen_parameters b/fs/bcachefs/bindgen_parameters
> index 547212bebd6e..96a63e3a2cc3 100644
> --- a/fs/bcachefs/bindgen_parameters
> +++ b/fs/bcachefs/bindgen_parameters
> @@ -1,5 +1,16 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> ---allowlist-function ''
> +--allowlist-function bch2_bkey_pack_test
> +--allowlist-function bch2_kset_init
> +--allowlist-function bch2_btree_key_cache_init
> +--allowlist-function bch2_chardev_init
> +--allowlist-function bch2_vfs_init
> +--allowlist-function bch2_debug_init
> +--allowlist-function bch2_debug_exit
> +--allowlist-function bch2_vfs_exit
> +--allowlist-function bch2_chardev_exit
> +--allowlist-function bch2_btree_key_cache_exit
> +--allowlist-function bch2_kset_exit
> +
>  --allowlist-type ''
>  --allowlist-var ''
> diff --git a/fs/bcachefs/bindings/bindings_helper.h b/fs/bcachefs/bindings/bindings_helper.h
> index f8bef3676f71..8cf3c35e8ca1 100644
> --- a/fs/bcachefs/bindings/bindings_helper.h
> +++ b/fs/bcachefs/bindings/bindings_helper.h
> @@ -1,3 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
>  #include "../bcachefs.h"
> +#include "../btree_key_cache.h"
> +#include "../chardev.h"
> +#include "../fs.h"
> +#include "../debug.h"
> diff --git a/fs/bcachefs/bindings/mod.rs b/fs/bcachefs/bindings/mod.rs
> index 19a3ae3c63c6..d1c3bbbd7b5a 100644
> --- a/fs/bcachefs/bindings/mod.rs
> +++ b/fs/bcachefs/bindings/mod.rs
> @@ -1,3 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#![allow(missing_docs)]
> +
>  include!("bcachefs_generated.rs");
> diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> index da8697c79a97..343c4bc6e81c 100644
> --- a/fs/bcachefs/super.c
> +++ b/fs/bcachefs/super.c
> @@ -69,9 +69,12 @@
>  #include <linux/sysfs.h>
>  #include <crypto/hash.h>
>  
> +#ifndef CONFIG_BCACHEFS_RUST
> +/* when enabled, the Rust module exports these modinfo attributes */
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Kent Overstreet <kent.overstreet@gmail.com>");
>  MODULE_DESCRIPTION("bcachefs filesystem");
> +#endif
>  MODULE_SOFTDEP("pre: crc32c");
>  MODULE_SOFTDEP("pre: crc64");
>  MODULE_SOFTDEP("pre: sha256");
> @@ -2082,6 +2085,7 @@ struct bch_fs *bch2_fs_open(char * const *devices, unsigned nr_devices,
>  
>  /* Global interfaces/init */
>  
> +#ifndef CONFIG_BCACHEFS_RUST
>  static void bcachefs_exit(void)
>  {
>  	bch2_debug_exit();
> @@ -2109,6 +2113,30 @@ static int __init bcachefs_init(void)
>  	return -ENOMEM;
>  }
>  
> +module_exit(bcachefs_exit);
> +module_init(bcachefs_init);
> +
> +#else /* CONFIG_BCACHEFS_RUST */
> +/*
> + * bch2_kset_init() and bch2_kset_exit() are wrappers around the kset functions
> + * to be called from the Rust module init and exit because there is not
> + * currently a Rust API for ksets. If/when a Rust API is provided, these
> + * wrappers can be removed and the Rust kernel module can use that directly.
> + */
> +int __init bch2_kset_init(void)
> +{
> +	bcachefs_kset = kset_create_and_add("bcachefs", NULL, fs_kobj);
> +
> +	return !bcachefs_kset;
> +}
> +
> +void bch2_kset_exit(void)
> +{
> +	if (bcachefs_kset)
> +		kset_unregister(bcachefs_kset);
> +}
> +#endif
> +
>  #define BCH_DEBUG_PARAM(name, description)			\
>  	bool bch2_##name;					\
>  	module_param_named(name, bch2_##name, bool, 0644);	\
> @@ -2119,6 +2147,3 @@ BCH_DEBUG_PARAMS()
>  __maybe_unused
>  static unsigned bch2_metadata_version = bcachefs_metadata_version_current;
>  module_param_named(version, bch2_metadata_version, uint, 0400);
> -
> -module_exit(bcachefs_exit);
> -module_init(bcachefs_init);
> -- 
> 2.43.0
> 

