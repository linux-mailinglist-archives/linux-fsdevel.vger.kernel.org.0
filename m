Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1C5A4AD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiH2L56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 07:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiH2L5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:57:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F297B82753
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 04:42:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D46C22B9F;
        Mon, 29 Aug 2022 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661773200;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6BHDlAB8TTUl8P4HhZMiJ0pkCMtuJ1JSbpNDI82gAFU=;
        b=L7oiDhCeuYMpuCIj8LfV3N49vysrMPKVxoBa9IQd/qQuIF+12KK9m+ZaTbsYNoKTApxG6e
        CcuUx1zF6TEqucyiM7joFkH6jdUexGuiCFeAMe076EhwMQmGGhtfQI7h1rkQSBROjlZMkJ
        /WAB57V3tKHlgSGB+U+lVAV3HivwruA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661773200;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6BHDlAB8TTUl8P4HhZMiJ0pkCMtuJ1JSbpNDI82gAFU=;
        b=O4hFDsPnmugG1GACZwnNmGIeKCq/3d4Hq1wXmUWvtAUDgoOrB/L2eL70THI4ux/wHYaWj2
        v4qd0IkRDWhb5RBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 142971352A;
        Mon, 29 Aug 2022 11:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RG/FApClDGOvIAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 11:40:00 +0000
Date:   Mon, 29 Aug 2022 13:39:58 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
        Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>
Subject: Re: [Automated-testing] [PATCH 0/6] Track minimal size per filesystem
Message-ID: <YwyljsgYIK3AvUr+@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <YwyYUzvlxfIGpTwo@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwyYUzvlxfIGpTwo@yuki>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Cyril,

> Hi!
> > This patchset require to be on the top of:

> > [RFC,1/1] API: Allow to use xfs filesystems < 300 MB
> > https://lore.kernel.org/ltp/20220817204015.31420-1-pvorel@suse.cz/
> > https://patchwork.ozlabs.org/project/ltp/patch/20220817204015.31420-1-pvorel@suse.cz/

> I'm not that sure if we want to run tests for xfs filesystem that is
> smaller than minimal size used in production. I bet that we will cover
> different codepaths that eventually end up being used in production
> that way.

	> > LTP community: do we want to depend on this behavior or we just increase from 256MB to 301 MB
	> > (either for XFS or for all). It might not be a good idea to test size users are required
	> > to use.

	> It might *not*? <confused>
	Again, I'm sorry, missing another not. I.e. I suppose normal users will not try
	to go below 301MB, therefore LTP probably should not do it either. That's why
	RFC.

@Darrick, others (kernel/LTP maintainers, embedded folks) WDYT?

I'm personally OK to use 300 MB (safer to use code paths which are used in
production), it's just that for older kernels even with xfs-progs installed it's
unnecessary boundary. We could base XFS size on runtime kernel, but unless it's
300 MB a real problem for anybody I would not address it. i.e. is there anybody
using XFS on old kernels? (old LTS, whey sooner or later need to use these
variables themselves).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/Yv4ABHlsP+BZ3bRD@pevik/
