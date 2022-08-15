Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88584594A29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 02:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354723AbiHOXzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 19:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355731AbiHOXwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:52:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721791593D5;
        Mon, 15 Aug 2022 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HkdesMUoZ61tMBtJNUxc0TT34BYc4cdbeRZcIwePCUI=; b=Gc1ER7H2A6KFPOBzMzB0DAXCiO
        gtDR0SURShm2pT7GJzeB0PGkGb1o//myUl91rYDicg47L+TIsiPpH2h9Ck5ZrwQnZ7DD7nXLk4y9c
        BfCINCjdWhJxWz9Sg8GU1zl2PGcWJRInRXMCwQhumyreUkbq5sdcJD7CY0GPIaJGDGyUhpDzFeyuJ
        nijbOOwH0IS+r5G9YFs4U1WTjmoJpdXWiHoEe1n0UpiweIwhkXxDbWfEY4TOFh6SYNkjgSKrllX6f
        IlKBf7bIjHRcYArc9DwNosV1TRtvhlGsGnNvpzDFXOZn958KvyKiyLnUYKCTvoja5mNx5iJkqwhY4
        Adt9aplw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNgWZ-0063or-EA; Mon, 15 Aug 2022 20:17:23 +0000
Date:   Mon, 15 Aug 2022 21:17:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Convert to filemap_get_folios_contig()
Message-ID: <Yvqp05w5HOVQ9qLj@casper.infradead.org>
References: <20220815185452.37447-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815185452.37447-1-vishal.moola@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 15, 2022 at 11:54:45AM -0700, Vishal Moola (Oracle) wrote:
> This patch series replaces find_get_pages_contig() with
> filemap_get_folios_contig(). I've run xfstests on btrfs. I've also
> tested the ramfs changes. I ran some xfstests on nilfs2, and its
> seemingly fine although more testing may be beneficial.

These all look good to me.  I'd like to see R-b tags from the various
fs maintainers, but I intend to add this series to the folio tree for
merging in 6.1.
