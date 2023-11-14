Return-Path: <linux-fsdevel+bounces-2850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F127EB5DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 18:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1312812FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E2B2C1B2;
	Tue, 14 Nov 2023 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PozRcZIt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3c4AuJH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E132AEFE;
	Tue, 14 Nov 2023 17:56:40 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162494;
	Tue, 14 Nov 2023 09:56:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F33D420466;
	Tue, 14 Nov 2023 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699984598;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjn3IbWkBne1GmE9J/QApD4YcU3qIAAt++S+UlyCfZw=;
	b=PozRcZItobtoAcP4OVIAW8CC0aZqU4GsCRfmI51RMFeFhuedsAJBjbJtrEX+uJhkr9+5Mb
	cS/gGqpVtf7a3+eB488+iNYnvcvGLxRInRiok5RDP0d/9tVWlveYazFG0ZbqrQfBsB4mFz
	NkGYTrGBFY0vdHeRod8E5Y8m3l3zgss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699984598;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjn3IbWkBne1GmE9J/QApD4YcU3qIAAt++S+UlyCfZw=;
	b=3c4AuJH7rSGIvuPuhf4xpbjiqs1zD3Kr+PpUDUInXs1yaPl47JF2RT2ETs/BqFxdZwJhMR
	rvBMllgaeh2dGJAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFF4F13460;
	Tue, 14 Nov 2023 17:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TJoELtW0U2UtHgAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 14 Nov 2023 17:56:37 +0000
Date: Tue, 14 Nov 2023 18:49:32 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v2 08/18] btrfs: add fs_parameter definitions
Message-ID: <20231114174932.GE11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1699470345.git.josef@toxicpanda.com>
 <24771d34a49eb428d6415197f390bf41dcef495c.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24771d34a49eb428d6415197f390bf41dcef495c.1699470345.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Nov 08, 2023 at 02:08:43PM -0500, Josef Bacik wrote:
> In order to convert to the new mount api we have to change how we do the
> mount option parsing.  For now we're going to duplicate these helpers to
> make it easier to follow, and then remove the old code once everything
> is in place.  This patch contains the re-definiton of all of our mount
> options into the new fs_parameter_spec format.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/super.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 127 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d7070269e3ea..0e9cb9ed6508 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -27,6 +27,7 @@
>  #include <linux/crc32c.h>
>  #include <linux/btrfs.h>
>  #include <linux/security.h>
> +#include <linux/fs_parser.h>
>  #include "messages.h"
>  #include "delayed-inode.h"
>  #include "ctree.h"
> @@ -132,7 +133,7 @@ enum {
>  	/* Debugging options */
>  	Opt_enospc_debug, Opt_noenospc_debug,
>  #ifdef CONFIG_BTRFS_DEBUG
> -	Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
> +	Opt_fragment, Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
>  #endif
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	Opt_ref_verify,
> @@ -222,6 +223,131 @@ static const match_table_t rescue_tokens = {
>  	{Opt_err, NULL},
>  };
>  
> +enum {
> +	Opt_fatal_errors_panic,
> +	Opt_fatal_errors_bug,
> +};
> +
> +static const struct constant_table btrfs_parameter_fatal_errors[] = {
> +	{ "panic", Opt_fatal_errors_panic },
> +	{ "bug", Opt_fatal_errors_bug },
> +	{}
> +};
> +
> +enum {
> +	Opt_discard_sync,
> +	Opt_discard_async,
> +};
> +
> +static const struct constant_table btrfs_parameter_discard[] = {
> +	{ "sync", Opt_discard_sync },
> +	{ "async", Opt_discard_async },
> +	{}
> +};
> +
> +enum {
> +	Opt_space_cache_v1,
> +	Opt_space_cache_v2,
> +};
> +
> +static const struct constant_table btrfs_parameter_space_cache[] = {
> +	{ "v1", Opt_space_cache_v1 },
> +	{ "v2", Opt_space_cache_v2 },
> +	{}
> +};
> +
> +enum {
> +	Opt_rescue_usebackuproot,
> +	Opt_rescue_nologreplay,
> +	Opt_rescue_ignorebadroots,
> +	Opt_rescue_ignoredatacsums,
> +	Opt_rescue_parameter_all,
> +};
> +
> +static const struct constant_table btrfs_parameter_rescue[] = {
> +	{ "usebackuproot", Opt_rescue_usebackuproot },
> +	{ "nologreplay", Opt_rescue_nologreplay },
> +	{ "ignorebadroots", Opt_rescue_ignorebadroots },
> +	{ "ibadroots", Opt_rescue_ignorebadroots },
> +	{ "ignoredatacsums", Opt_rescue_ignoredatacsums },
> +	{ "idatacsums", Opt_rescue_ignoredatacsums },
> +	{ "all", Opt_rescue_parameter_all },
> +	{}
> +};
> +
> +#ifdef CONFIG_BTRFS_DEBUG
> +enum {
> +	Opt_fragment_parameter_data,
> +	Opt_fragment_parameter_metadata,
> +	Opt_fragment_parameter_all,
> +};
> +
> +static const struct constant_table btrfs_parameter_fragment[] = {
> +	{ "data", Opt_fragment_parameter_data },
> +	{ "metadata", Opt_fragment_parameter_metadata },
> +	{ "all", Opt_fragment_parameter_all },
> +	{}
> +};
> +#endif
> +
> +static const struct fs_parameter_spec btrfs_fs_parameters[] __maybe_unused = {
> +	fsparam_flag_no("acl", Opt_acl),
> +	fsparam_flag("clear_cache", Opt_clear_cache),
> +	fsparam_u32("commit", Opt_commit_interval),
> +	fsparam_flag("compress", Opt_compress),
> +	fsparam_string("compress", Opt_compress_type),
> +	fsparam_flag("compress-force", Opt_compress_force),
> +	fsparam_string("compress-force", Opt_compress_force_type),
> +	fsparam_flag("degraded", Opt_degraded),
> +	fsparam_string("device", Opt_device),
> +	fsparam_enum("fatal_errors", Opt_fatal_errors, btrfs_parameter_fatal_errors),
> +	fsparam_flag_no("flushoncommit", Opt_flushoncommit),
> +	fsparam_flag_no("inode_cache", Opt_inode_cache),

I think it's a good opportunity to remove this option completely, its
functionality is gone since 5.11, that's eough time. I'm fine with
removing it both before or after the API switch.

> +	fsparam_string("max_inline", Opt_max_inline),
> +	fsparam_flag_no("barrier", Opt_barrier),
> +	fsparam_flag_no("datacow", Opt_datacow),
> +	fsparam_flag_no("datasum", Opt_datasum),
> +	fsparam_flag_no("autodefrag", Opt_defrag),
> +	fsparam_flag_no("discard", Opt_discard),
> +	fsparam_enum("discard", Opt_discard_mode, btrfs_parameter_discard),
> +	fsparam_u32("metadata_ratio", Opt_ratio),
> +	fsparam_flag("rescan_uuid_tree", Opt_rescan_uuid_tree),
> +	fsparam_flag("skip_balance", Opt_skip_balance),
> +	fsparam_flag_no("space_cache", Opt_space_cache),
> +	fsparam_enum("space_cache", Opt_space_cache_version, btrfs_parameter_space_cache),
> +	fsparam_flag_no("ssd", Opt_ssd),
> +	fsparam_flag_no("ssd_spread", Opt_ssd_spread),
> +	fsparam_string("subvol", Opt_subvol),
> +	fsparam_flag("subvol=", Opt_subvol_empty),
> +	fsparam_u64("subvolid", Opt_subvolid),
> +	fsparam_u32("thread_pool", Opt_thread_pool),
> +	fsparam_flag_no("treelog", Opt_treelog),
> +	fsparam_flag("user_subvol_rm_allowed", Opt_user_subvol_rm_allowed),
> +
> +	/* Rescue options */
> +	fsparam_enum("rescue", Opt_rescue, btrfs_parameter_rescue),
> +	/* Deprecated, with alias rescue=nologreplay */
> +	__fsparam(NULL, "nologreplay", Opt_nologreplay, fs_param_deprecated,
> +		  NULL),
> +	/* Deprecated, with alias rescue=usebackuproot */
> +	__fsparam(NULL, "usebackuproot", Opt_usebackuproot, fs_param_deprecated,
> +		  NULL),
> +
> +	/* Deprecated options */
> +	__fsparam(NULL, "recovery", Opt_recovery,
> +		  fs_param_neg_with_no|fs_param_deprecated, NULL),

Same here, 'recovery' obsoleted by the rescue options in 4.5.

> +
> +	/* Debugging options */
> +	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
> +#ifdef CONFIG_BTRFS_DEBUG
> +	fsparam_enum("fragment", Opt_fragment, btrfs_parameter_fragment),
> +#endif
> +#ifdef CONFIG_BTRFS_FS_REF_VERIFY
> +	fsparam_flag("ref_verify", Opt_ref_verify),
> +#endif
> +	{}
> +};
> +
>  static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
>  			    const char *opt_name)
>  {
> -- 
> 2.41.0
> 

