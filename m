Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE48536B04
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349008AbiE1GBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiE1GBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:01:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075C2F2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3CCidAfO7CDAY1Xeo0tE8eo2wKdVLimf36Fg6SjW3lU=; b=2dVVXsFtN0CgBJuFEZa0yrd/wK
        dQufcqzM7Bx5htW+oR6akqwBBmF0mUYsE2knqhCXUNaVy0tVAK4qOWoegMZX/OmaoLnpdAp2+cVWY
        9r4RFxGDJbawVZvHdzluMAJ9lGB5/fqWY3p07hs7sIUNfyVc6WcV5n+wpGB60sPO9Flh8kfV47m6F
        6JWk7K0iK5/x6fnhzZ4Fdztb62iebRdKb4YRNg2LF9yaqOpwNTrefy0xqTXgEukb3k2ut8RGsPwpH
        oBylObymPRoJ3x1jPSjaVHiLkyJJc8k4CDXOPp1K4IGkr5jXzmVEJZtDcAFFq3GoWBmXrpgSzYVHG
        RsY8B+Rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupVZ-001WoY-Ji; Sat, 28 May 2022 06:01:05 +0000
Date:   Fri, 27 May 2022 23:01:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 18/24] buffer: Remove check for PageError
Message-ID: <YpG6oZyXnTWJDvXz@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-19-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:30PM +0100, Matthew Wilcox (Oracle) wrote:
> If a buffer is completed with an error, its uptodate flag will be clear,
> so the page_uptodate variable will have been set to 0.  There's no
> need to check PageError here.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
