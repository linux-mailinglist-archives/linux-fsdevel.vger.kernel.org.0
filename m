Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F964D18C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 14:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiCHNKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 08:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiCHNKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:10:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA98BFD
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 05:09:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 189B9210F4;
        Tue,  8 Mar 2022 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646744984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+6YFVLU4HUQxgav2Y/h9g6SMlYrkn6Y06kPO8UDTNY=;
        b=w4OC+foCY1UMtr145vOAD2Yxlj+KxyV8fFasHAwRjFaBWnvLO6jobP/QgXECzrkPA7jdu3
        Gu4Rhe0QeR9HKcB1k024OnklNhCggVYER6A3A6SNZsNeVimBE4MMjVIKJmeURztHrZKR21
        vfmgwrDPZK/idJhFW4sDH54TYMqdCM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646744984;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+6YFVLU4HUQxgav2Y/h9g6SMlYrkn6Y06kPO8UDTNY=;
        b=BTJ/ZbZYjJM75i8hS4p1bok0K94D0bBApw8aeSN1nuvrMz7LrKQ0R2MNZGzU28v8EUXKiG
        k3NvlZnLaCTqqoCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD64413CA6;
        Tue,  8 Mar 2022 13:09:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4weqNJdVJ2IkFQAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 08 Mar 2022 13:09:43 +0000
Date:   Tue, 8 Mar 2022 14:09:42 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: [PATCH v6 3/6] initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig
 option
Message-ID: <20220308140942.47dcb97c@suse.de>
In-Reply-To: <20220107133814.32655-4-ddiss@suse.de>
References: <20220107133814.32655-1-ddiss@suse.de>
        <20220107133814.32655-4-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping on this patchset again...

@Andrew: while looking through lkml archives from a lifetime ago at
https://lkml.org/lkml/2008/8/16/59 , it appears that your preference at
the time was to drop the scattered INITRAMFS_PRESERVE_MTIME ifdefs prior
to merge.
I'd much appreciate your thoughts on the reintroduction of the option
based on the microbenchmark results below.

On Fri,  7 Jan 2022 14:38:11 +0100, David Disseldorp wrote:

> initramfs cpio mtime preservation, as implemented in commit 889d51a10712
> ("initramfs: add option to preserve mtime from initramfs cpio images"),
> uses a linked list to defer directory mtime processing until after all
> other items in the cpio archive have been processed. This is done to
> ensure that parent directory mtimes aren't overwritten via subsequent
> child creation. Contrary to the 889d51a10712 commit message, the mtime
> preservation behaviour is unconditional.
> 
> This change adds a new INITRAMFS_PRESERVE_MTIME Kconfig option, which
> can be used to disable on-by-default mtime retention and in turn
> speed up initramfs extraction, particularly for cpio archives with large
> directory counts.
> 
> Benchmarks with a one million directory cpio archive extracted 20 times
> demonstrated:
> 				mean extraction time (s)	std dev
> INITRAMFS_PRESERVE_MTIME=y		3.808			 0.006
> INITRAMFS_PRESERVE_MTIME unset		3.056			 0.004
> 
> The above extraction times were measured using ftrace
> (initcall_finish - initcall_start) values for populate_rootfs() with
> initramfs_async disabled.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> Reviewed-by: Martin Wilck <mwilck@suse.com>
> [ddiss: rebase atop dir_entry.name flexible array member]
> ---
>  init/Kconfig           | 10 ++++++++
>  init/initramfs.c       | 50 +++-------------------------------------
>  init/initramfs_mtime.h | 52 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 47 deletions(-)
>  create mode 100644 init/initramfs_mtime.h
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 4b7bac10c72d..a98f63d3c366 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1357,6 +1357,16 @@ config BOOT_CONFIG
>  
>  	  If unsure, say Y.
>  
> +config INITRAMFS_PRESERVE_MTIME
> +	bool "Preserve cpio archive mtimes in initramfs"
> +	default y
> +	help
> +	  Each entry in an initramfs cpio archive carries an mtime value. When
> +	  enabled, extracted cpio items take this mtime, with directory mtime
> +	  setting deferred until after creation of any child entries.
> +
> +	  If unsure, say Y.
> +
>  choice
>  	prompt "Compiler optimization level"
>  	default CC_OPTIMIZE_FOR_PERFORMANCE
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 656d2d71349f..5b4ca8ecadb5 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -17,6 +17,8 @@
>  #include <linux/init_syscalls.h>
>  #include <linux/umh.h>
>  
> +#include "initramfs_mtime.h"
> +
>  static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
>  		loff_t *pos)
>  {
> @@ -116,48 +118,6 @@ static void __init free_hash(void)
>  	}
>  }
>  
> -static long __init do_utime(char *filename, time64_t mtime)
> -{
> -	struct timespec64 t[2];
> -
> -	t[0].tv_sec = mtime;
> -	t[0].tv_nsec = 0;
> -	t[1].tv_sec = mtime;
> -	t[1].tv_nsec = 0;
> -	return init_utimes(filename, t);
> -}
> -
> -static __initdata LIST_HEAD(dir_list);
> -struct dir_entry {
> -	struct list_head list;
> -	time64_t mtime;
> -	char name[];
> -};
> -
> -static void __init dir_add(const char *name, time64_t mtime)
> -{
> -	size_t nlen = strlen(name) + 1;
> -	struct dir_entry *de;
> -
> -	de = kmalloc(sizeof(struct dir_entry) + nlen, GFP_KERNEL);
> -	if (!de)
> -		panic_show_mem("can't allocate dir_entry buffer");
> -	INIT_LIST_HEAD(&de->list);
> -	strscpy(de->name, name, nlen);
> -	de->mtime = mtime;
> -	list_add(&de->list, &dir_list);
> -}
> -
> -static void __init dir_utime(void)
> -{
> -	struct dir_entry *de, *tmp;
> -	list_for_each_entry_safe(de, tmp, &dir_list, list) {
> -		list_del(&de->list);
> -		do_utime(de->name, de->mtime);
> -		kfree(de);
> -	}
> -}
> -
>  static __initdata time64_t mtime;
>  
>  /* cpio header parsing */
> @@ -381,14 +341,10 @@ static int __init do_name(void)
>  static int __init do_copy(void)
>  {
>  	if (byte_count >= body_len) {
> -		struct timespec64 t[2] = { };
>  		if (xwrite(wfile, victim, body_len, &wfile_pos) != body_len)
>  			error("write error");
>  
> -		t[0].tv_sec = mtime;
> -		t[1].tv_sec = mtime;
> -		vfs_utimes(&wfile->f_path, t);
> -
> +		do_utime_path(&wfile->f_path, mtime);
>  		fput(wfile);
>  		eat(body_len);
>  		state = SkipIt;
> diff --git a/init/initramfs_mtime.h b/init/initramfs_mtime.h
> new file mode 100644
> index 000000000000..688ed4b6f327
> --- /dev/null
> +++ b/init/initramfs_mtime.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CONFIG_INITRAMFS_PRESERVE_MTIME
> +static void __init do_utime(char *filename, time64_t mtime)
> +{
> +	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
> +	init_utimes(filename, t);
> +}
> +
> +static void __init do_utime_path(const struct path *path, time64_t mtime)
> +{
> +	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
> +	vfs_utimes(path, t);
> +}
> +
> +static __initdata LIST_HEAD(dir_list);
> +struct dir_entry {
> +	struct list_head list;
> +	time64_t mtime;
> +	char name[];
> +};
> +
> +static void __init dir_add(const char *name, time64_t mtime)
> +{
> +	size_t nlen = strlen(name) + 1;
> +	struct dir_entry *de;
> +
> +	de = kmalloc(sizeof(struct dir_entry) + nlen, GFP_KERNEL);
> +	if (!de)
> +		panic("can't allocate dir_entry buffer");
> +	INIT_LIST_HEAD(&de->list);
> +	strscpy(de->name, name, nlen);
> +	de->mtime = mtime;
> +	list_add(&de->list, &dir_list);
> +}
> +
> +static void __init dir_utime(void)
> +{
> +	struct dir_entry *de, *tmp;
> +
> +	list_for_each_entry_safe(de, tmp, &dir_list, list) {
> +		list_del(&de->list);
> +		do_utime(de->name, de->mtime);
> +		kfree(de);
> +	}
> +}
> +#else
> +static void __init do_utime(char *filename, time64_t mtime) {}
> +static void __init do_utime_path(const struct path *path, time64_t mtime) {}
> +static void __init dir_add(const char *name, time64_t mtime) {}
> +static void __init dir_utime(void) {}
> +#endif

