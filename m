Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4EE7966F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 01:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbjIFXUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 19:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjIFXUl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:20:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3F173B;
        Wed,  6 Sep 2023 16:20:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D9881FD7B;
        Wed,  6 Sep 2023 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694042435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgodE4ydDVlHm5Hs6I7NhySZqPHst/TeqSQFj1Ju8nE=;
        b=Kq8LNuaY3Oy90JFbmYjlqaNWUn5+g3XXdtPF2zYYYkmKdX33XBaBATt4CCeh/9dswZapgl
        5IWbjbmKXF1WZH/DkkK1x4hbzERML+QlID162osX9X2ZsTDXUxxCUOiTp84BQ4hzX30H6c
        4fUbABxOQXP5xKBLCxRljYdrEekgQiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694042435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgodE4ydDVlHm5Hs6I7NhySZqPHst/TeqSQFj1Ju8nE=;
        b=g2uipkudF7rb0SEqoXrhLINDvxVMCEMIvZ/eQT593Hw/xMbemjrhAFe4LWRFkUKS4vdoKQ
        aQRiOel/rWitVODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 514921346C;
        Wed,  6 Sep 2023 23:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FDO8EkMJ+WR+MgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 23:20:35 +0000
Date:   Thu, 7 Sep 2023 01:13:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230906231354.GX14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
 <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
 <ZPj1WuwKKnvVEZnl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPj1WuwKKnvVEZnl@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 06:55:38PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 06, 2023 at 01:20:59PM -0700, Linus Torvalds escreveu:
> > On Wed, 6 Sept 2023 at 13:02, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > And guess what happens when you have (unsigned char)-1? It does *not*
> > > cast back to -1.
> > 
> > Side note: again, this may be one of those "it works in practice",
> > because if we have -fshort-enums, I think 'enum
> > btree_node_locked_type' in turn ends up being represented as a 'signed
> > char', because that's the smallest simple type that can fit all those
> > values.
>  
> > I don't think gcc ever uses less than that (ie while a six_lock_type
> > could fit in two bits, it's still going to be considered at least a
> > 8-bit value in practice).
> 
> There are some cases where people stuff the enum into a bitfield, but
> no, no simple type.
> 
> ⬢[acme@toolbox perf-tools-next]$ pahole | grep -w enum | grep :
> 	enum btrfs_rsv_type        type:8;               /*    28:16  4 */
> 	enum btrfs_delayed_item_type type:8;             /*   100: 0  4 */

The simple grep might give a skewed view, in the above case there's also

/* Bitfield combined with previous fields */

in the full output, with adjacent bool struct members it's all packed
into one int. I think I've always seen an int for enums, unless it was
explicitly narrowed in the structure (:8) or by __packed attribute in
the enum definition.

> 	enum kernel_pkey_operation op:8;                 /*    40: 0  4 */
> 	enum integrity_status      ima_file_status:4;    /*    96: 0  4 */
> 	enum integrity_status      ima_mmap_status:4;    /*    96: 4  4 */
> 	enum integrity_status      ima_bprm_status:4;    /*    96: 8  4 */
> 	enum integrity_status      ima_read_status:4;    /*    96:12  4 */
> 	enum integrity_status      ima_creds_status:4;   /*    96:16  4 */
> 	enum integrity_status      evm_status:4;         /*    96:20  4 */
> 	enum fs_context_purpose    purpose:8;            /*   152: 0  4 */
> 	enum fs_context_phase      phase:8;              /*   152: 8  4 */
> 	enum fs_value_type         type:8;               /*     8: 0  4 */
> 	enum sgx_page_type         type:16;              /*     8: 8  4 */
> 	enum nf_hook_ops_type      hook_ops_type:8;      /*    24: 8  4 */
> 		enum resctrl_event_id evtid:8;         /*     0:10  4 */
> 		enum _cache_type   type:5;             /*     0: 0  4 */
