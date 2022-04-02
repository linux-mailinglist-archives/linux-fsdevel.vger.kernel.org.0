Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885F54F069A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Apr 2022 00:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiDBWoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 18:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiDBWon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 18:44:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC9F21B9;
        Sat,  2 Apr 2022 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LapvKWYiqzHjI7hRY3vDacnX08MOm2G68LM2gEuu+NQ=; b=tRISPQi8WR/82cWQ3TZzSeNG5L
        rHT2KmVZweb198H8wuXs/EPLl7MfsB78lhw1xnJ++PrNyZ6xUYeNNn+Wy9+PN0wKrpp1e5388pz2D
        ZxI0ZIJyG8ii9O/bJZyNUX/FsWo4A6QD32ODGaWCik4+xiEQSFaJ/0t5lC4+/cEl9lxOnJbgPrkxK
        g+5yOFHAwBTiYu+IZTXW7bBPZvYHFzJWb/BApAOJ5ziZmGMgWPL1JtPpTMvfbGBvqH3FrEsIry6Ut
        x7ShRJVBkGmSwq7hLnoSsq70kecCIrCkGVuZUKhBPd5h7R0hwjyQTCFQQ4MDxSQvF27XwuQ6w8HDn
        U92kcu2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1namRy-004RTM-Qq; Sat, 02 Apr 2022 22:42:30 +0000
Date:   Sat, 2 Apr 2022 23:42:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Enable multipage folio support
Message-ID: <YkjRVvx1rDcZ67qS@casper.infradead.org>
References: <2274528.1645833226@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2274528.1645833226@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 11:53:46PM +0000, David Howells wrote:
> Enable multipage folio support for the afs filesystem.  This is on top of
> Matthew Wilcox's for-next branch.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org

I can't say that I've audited AFS for its correct use of folios
everywhere, but since you've tested it, I have no objections:

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
