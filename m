Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E6615197
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 19:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiKASce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAScd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:32:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C07DF0F;
        Tue,  1 Nov 2022 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M/eDz1dPM9ieaSzFHSmb+aMjZp+jHb2TWGdJk2dmydI=; b=dl3QR/w2lThFEQoeFvvO+wdwkh
        yo2/WBh5qDLH6PkZqyt4L1ySbMOttNGW8UaJGlRgrq4kIP/b7oFOTppRzqIgotUxgjGOg5TfdLtJd
        MCudoXLE2Glq5VhjMFxDtCjT6W00+46BNdhYs3X2C/we5G/+4MCKWhhWlEQu6RBa+HEU+2tv2pTPm
        EK29REZ+NKbvS0qN01sS917+8PhbFKp8DL+KkzfPL4o93a6G0J30v4mC4cHTsAaB8LLHmbBF7/6WS
        38aHqPmsflEzzd6W3stH4dF1FKziJH/3qAHs/WaofkwElhlvkdaTPxAClBeSgOGDx+LRNfaulToge
        zGBQqIsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opw3u-004pyx-IG; Tue, 01 Nov 2022 18:32:34 +0000
Date:   Tue, 1 Nov 2022 18:32:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        miklos@szeredi.hu
Subject: Re: [PATCH 4/5] khugepage: Replace lru_cache_add() with
 folio_add_lru()
Message-ID: <Y2FmQoWBYvoqZrKr@casper.infradead.org>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-5-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101175326.13265-5-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:53:25AM -0700, Vishal Moola (Oracle) wrote:
> Replaces some calls with their folio equivalents. This is in preparation
> for the removal of lru_cache_add(). This replaces 3 calls to
> compound_head() with 1.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
