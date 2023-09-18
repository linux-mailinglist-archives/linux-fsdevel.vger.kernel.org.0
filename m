Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFB87A5209
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjIRS1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRS1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:27:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B0F7;
        Mon, 18 Sep 2023 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ioEeAGr+2NV3niPRdLLhdMSROTGhWvYL7RpL0QlpWXo=; b=PnfRPAkBF0mMzSlbZyC87L/2P8
        hax/k2KlhyAoApjRDSwNcg5w4O1qCwBtBHRybKE1zQzj80vHiy2j2dI7X15GAb+Znu7FGbDdGgVvB
        wfujJfBcPFioDiKB9xDpcKdWf8/uuQYl5rdvhzoAhGwudtXTUVzsInO4Am7F16uE7T337/N27315u
        yCoK0kwJjAy0BKVDORUH++3XKnAdP0w8pihdcPs/3P4p26/tTXg2b/o1hJ5/i9H2W7Ao2rJG4Xf9z
        I382YPvkdujLoFZ8+274K28EB5kjsINTeIpRuxcj+BmmX3IhAKOC+QK4a0I1a8+LzIBFDs+/1eM8R
        pckEMDIw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiIyI-00G5AT-1k;
        Mon, 18 Sep 2023 18:27:46 +0000
Date:   Mon, 18 Sep 2023 11:27:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pankaj Raghav <kernel@pankajraghav.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com
Subject: Re: [RFC 06/23] mm: call xas_set_order() in
 replace_page_cache_folio()
Message-ID: <ZQiWomUH5HRQxJ2l@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-7-kernel@pankajraghav.com>
 <ZQS0gizJxwonqVC/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQS0gizJxwonqVC/@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:46:10PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 08:38:31PM +0200, Pankaj Raghav wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Call xas_set_order() in replace_page_cache_folio() for non hugetlb
> > pages.
> 
> This function definitely should work without this patch.  What goes wrong?

As with batch delete I was just trying to take care to be explicit about
setting the order for a) ddition and b) removal. Will drop as well after
confirming, thanks!

  Luis
