Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739C67BBA8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjJFOlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjJFOli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:41:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD9DB;
        Fri,  6 Oct 2023 07:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kz0MyaGCfhSoACpQk6IQSVxzrVBlg/0Wg5XzExLzRJA=; b=vyVGILvYDUxK77TznDGevX+p6+
        QeB3UyVYGG8z6uY8GfJUrVbceGW071wpmajsdgoky80NKhEJyy9wbt2HGIVvYK+V34X/xcZ7M88tO
        uv0A8F97qeYjl3j1wXTJ37tgEpP6bzpv0QeCjQfyLHCVQSrkDrYuixC9k1VwkKgD7O/aDn8K4oHEu
        aLBRPykgQkjRXYvNQg7Rvb3sYtTZ9ATM5boFOzN5hvaDmbVb9FPzFNpEbzgW0gFqTRukUUuq3MIFW
        1g2dA6Ns4ySooj/qULREI+uxM4kG5aT9g3OTf2WvqX1Z3WFRAc8Vexl7STBLjJ85GDuxLMFsKshej
        LScv7kIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qom1A-00FrAt-MO; Fri, 06 Oct 2023 14:41:28 +0000
Date:   Fri, 6 Oct 2023 15:41:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] filemap: call filemap_get_folios_tag() from
 filemap_get_folios()
Message-ID: <ZSAcmFaZC9d4VJNF@casper.infradead.org>
References: <20231006110120.136809-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006110120.136809-1-kernel@pankajraghav.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:01:20PM +0200, Pankaj Raghav wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> filemap_get_folios() is filemap_get_folios_tag() with XA_PRESENT as the
> tag that is being matched. Return filemap_get_folios_tag() with
> XA_PRESENT as the tag instead of duplicating the code in
> filemap_get_folios().

Yes, I think this makes sense.  I was consciously trying to make them
as similar to each other as possible.  I hadn't realised I'd succeeded
to such an extent.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
