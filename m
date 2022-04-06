Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08844F57DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiDFIjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 04:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383748AbiDFIix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:38:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138148BEE7;
        Tue,  5 Apr 2022 22:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Ypxhbz/np55GXLZ63U30G4gE8wYAFughC237OInixw=; b=mOWvaWvntKJt7+qlKgTwd3MK3y
        dBlugBGVzPi338E8zYhdSit/9i+H3F6jhVCmjyFXXp7z8hyqXASHvbBY0Ry1rCG6WP41UbuR0pRh/
        XwllF61XNinwGoTS3UHVer3ZfS1vmY+k7G9yUkXnv9RdBijEvj/FIo3JBiVS7HfBguoXK0Gq9S2Ij
        VlHVM9NF4yCfanuJ+93n+7BmuWmWzbHD60ROGy0eO8CvDlQ+p+QjfIYBAjDPmiWgV9etSPROhu4sk
        dGeU7i1wN4zwMzNRysfX7DIQGc51MnVkEqoKPdszB0dOiEDpWu3c/m6A3s4489yRoyyamkWRWOFBn
        FvMRKA8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbye6-003tMu-PC; Wed, 06 Apr 2022 05:55:58 +0000
Date:   Tue, 5 Apr 2022 22:55:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] Folio fixes for 5.18
Message-ID: <Yk0rbm6n6801cEq9@infradead.org>
References: <YkdKgzil38iyc7rX@casper.infradead.org>
 <20220405120848.GV15609@twin.jikos.cz>
 <YkxQkZ24Zz9KCxK1@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkxQkZ24Zz9KCxK1@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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

FYI, for these kinds of global API changes I tend to add all the
mainling lists, but drop the multiple maintainers that would blow this
up even futher.  But even that lead to occasional complaints.
