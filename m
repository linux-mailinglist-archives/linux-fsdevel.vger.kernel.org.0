Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A264F4D14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457101AbiDEXir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573194AbiDESPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:15:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B9140C6;
        Tue,  5 Apr 2022 11:13:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 35811210DD;
        Tue,  5 Apr 2022 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649182428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EfLZS1Fjnkm0H+g213hibaWDOALEX+x0bMu4UJYXHy8=;
        b=gtFsupNU2XJjbDI26P/V+DBfJqIla6WaLeyX1MdUUJBoKpY8XCW6Ox/hJ6k5vrrETkfsaf
        /BRlKNgcc6S+z8xFNLb9NFxp0w6L8J6cU0K3k0d64L+c1tZ1ZXqd/6ZyoH8FOf80KPE0Az
        ONFj2wafYWrDy5N8a86cyb+fobKy2qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649182428;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EfLZS1Fjnkm0H+g213hibaWDOALEX+x0bMu4UJYXHy8=;
        b=/T8jyprkGKvGaS53PoKSliU9C96JGKuZTkM2HxRfQ6VhtEthDMD9257BP9SJhEKhdRx61i
        VvWkTphPVQhHNpBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2859EA3B83;
        Tue,  5 Apr 2022 18:13:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2213DA80E; Tue,  5 Apr 2022 20:09:46 +0200 (CEST)
Date:   Tue, 5 Apr 2022 20:09:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] Folio fixes for 5.18
Message-ID: <20220405180946.GA15609@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <YkdKgzil38iyc7rX@casper.infradead.org>
 <20220405120848.GV15609@twin.jikos.cz>
 <YkxQkZ24Zz9KCxK1@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkxQkZ24Zz9KCxK1@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 03:22:09PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 05, 2022 at 02:08:48PM +0200, David Sterba wrote:
> > Matthew, can you please always CC linux-btrfs@vger.kernel.org for any
> > patches that touch code under fs/btrfs? I've only noticed your folio
> > updates in this pull request. Some of the changes are plain API switch,
> > that's fine but I want to know about that, some changes seem to slightly
> > modify logic that I'd really like to review and there are several missed
> > opportunities to fix coding style. Thanks.
> 
> I'm sorry, that's an unreasonable request.  There's ~50 filesystems
> that use address_space_operations and cc'ing individual filesystems
> on VFS-wide changes isn't feaasible.

How many filesystems have you touched in the recent changes? I've
counted about 7 subsystems in commit 704528d895dd ("fs: Remove
->readpages address space operation"), the rest are VFS/MM changes or
individual filesystems in separate patches.

Examples of btrfs-only changes, there are more like that in the pull as
you probably know:

8e1dec8eb8b0 ("btrfs: Use folio_invalidate()").
895586eb6898 ("btrfs: Convert from invalidatepage to invalidate_folio")
...

You know you can slap a CC: linux-btrfs@vger.kernel.org to the patch
tag and forget about it, is that unreasonable? No. If you're updating
the same filesystems repeatedly you can copy the CC list for all of
them.
