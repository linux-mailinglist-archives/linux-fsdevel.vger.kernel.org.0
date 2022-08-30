Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3DB5A5DED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiH3ITC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 04:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiH3ITB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:19:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92380F43
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 01:19:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2BA0B21AFE;
        Tue, 30 Aug 2022 08:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661847539;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5PBVibySjNE2MBgKJlLRy7abF4kW322CqvMt8V3sMU=;
        b=Mmq+oviKUmrN8uU7eUsHGGXLxvemIsoJVM7QQOsxNpUNGLfTHaaEfBr+DvbValSEeJBD8k
        SmQd4KVgdl39skQ/vvgKqvE1uWYHld2c4rodh0MWUV5dU0Rb7J3C/TBVQIWL/V0q0HMNfw
        MH6TSj4FdKrErAEQYKfS7T3Rl7wTHog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661847539;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5PBVibySjNE2MBgKJlLRy7abF4kW322CqvMt8V3sMU=;
        b=sUwhx3WRxbkfqEFdteRsBql88GsPTd/mn/nYnu5QyGtZW7OjWE0h108mXXzPXapIt2Epyn
        JxwVZiqpsur2sQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7595F13B0C;
        Tue, 30 Aug 2022 08:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4scZGfLHDWPOdgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 30 Aug 2022 08:18:58 +0000
Date:   Tue, 30 Aug 2022 10:18:56 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Li Wang <liwang@redhat.com>
Cc:     Cyril Hrubis <chrubis@suse.cz>, LTP List <ltp@lists.linux.it>,
        Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>
Subject: Re: [Automated-testing] [PATCH 0/6] Track minimal size per filesystem
Message-ID: <Yw3H8EsbYWx1fV7j@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <YwyYUzvlxfIGpTwo@yuki>
 <YwyljsgYIK3AvUr+@pevik>
 <CAEemH2dbBZO91EEB-xheoToUPuz=SBDjp9dGzy1YuVL+qGgOMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEemH2dbBZO91EEB-xheoToUPuz=SBDjp9dGzy1YuVL+qGgOMQ@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Hi Petr, All,

> On Mon, Aug 29, 2022 at 7:40 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Cyril,

> > > Hi!
> > > > This patchset require to be on the top of:

> > > > [RFC,1/1] API: Allow to use xfs filesystems < 300 MB
> > > > https://lore.kernel.org/ltp/20220817204015.31420-1-pvorel@suse.cz/

> > https://patchwork.ozlabs.org/project/ltp/patch/20220817204015.31420-1-pvorel@suse.cz/

> > > I'm not that sure if we want to run tests for xfs filesystem that is
> > > smaller than minimal size used in production. I bet that we will cover
> > > different codepaths that eventually end up being used in production
> > > that way.

> >         > > LTP community: do we want to depend on this behavior or we
> > just increase from 256MB to 301 MB
> >         > > (either for XFS or for all). It might not be a good idea to
> > test size users are required
> >         > > to use.

> >         > It might *not*? <confused>
> >         Again, I'm sorry, missing another not. I.e. I suppose normal users
> > will not try
> >         to go below 301MB, therefore LTP probably should not do it either.
> > That's why
> >         RFC.

> > @Darrick, others (kernel/LTP maintainers, embedded folks) WDYT?

> > I'm personally OK to use 300 MB (safer to use code paths which are used in
> > production), it's just that for older kernels even with xfs-progs
> > installed it's
> > unnecessary boundary. We could base XFS size on runtime kernel, but unless
> > it's
> > 300 MB a real problem for anybody I would not address it. i.e. is there
> > anybody
> > using XFS on old kernels? (old LTS, whey sooner or later need to use these
> > variables themselves).


> Another compromised way I can think of is to let LTP choose
> 300MB for XFS by default, if the test bed can't provide that size,
> simply go back to try 16MB.  Does this sound acceptable?

I'll try to have look into this, but it'd would be quite special case given we
don't try to detect and recovery mkfs.* failures.

Kind regards,
Petr
