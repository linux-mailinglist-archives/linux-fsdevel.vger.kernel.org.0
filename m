Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF753242C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 18:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhBXQ66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhBXQ6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:58:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF0DC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PfWCmza47JW+IbRVssMx5/wjrLqy2TFMYziwljasB28=; b=YXbmDRERPh7zav8Sh+zSYo4nSV
        89ODAQ3f3F1VgFBrZs0EQzknFKdwZYGFkn/vsp0kCxSeJG4lJxKNrbLk6trDujiVZIBAbVuh1b/Ek
        52BMp54ALNHrU/FMAaBy1gS0zbe0OBBZMZomKKIn/doB3HulY/0KbRQeQAlBtfC7FFdqtDrdPfe6a
        ZPLztUdiB7PReoMw9H1S6A15W5HccrhvXmEx8/TLXwNhHrP/XiAv1mk6mctSCjUaqmCglSwCG89Fk
        E/PdQJBouGPd4/cL5zpB2SXyo+6JaWjqt6tC0dgh6hCzgTgpipldmGBTvi4EgpdfwT7tKWDLdWEk9
        kgnlHd6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lExTw-009eED-Q2; Wed, 24 Feb 2021 16:57:52 +0000
Date:   Wed, 24 Feb 2021 16:57:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] mm: use filemap_range_needs_writeback() for O_DIRECT
 reads
Message-ID: <20210224165748.GS2858050@casper.infradead.org>
References: <20210224164455.1096727-1-axboe@kernel.dk>
 <20210224164455.1096727-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224164455.1096727-3-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 09:44:54AM -0700, Jens Axboe wrote:
> For the generic page cache read helper, use the better variant of checking
> for the need to call filemap_write_and_wait_range() when doing O_DIRECT
> reads. This avoids falling back to the slow path for IOCB_NOWAIT, if there
> are no pages to wait for (or write out).
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
