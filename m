Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B86060BC3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJXVcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiJXVcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:32:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34A44CEC;
        Mon, 24 Oct 2022 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rWeKahqjg8VAD1dtAEhE4rortSi/MmENxoyZPPFT3KA=; b=p8A06p4YSjdkrVWvgA1JfWZjL8
        Q/fKS1i1qtNMepcvFZBlIOmLEnO9EOAC3/sxOsEXCrtAti4NI1wr1f8hte79v+XFrKL35DLtIB2GU
        zi3APTubBbGh8RjT75MjmkoXpdO8fQ0puFRQVMjWyEsmZaTEdK2OgDh7UkQiBfqJrU5dgT/vQveft
        bqGju8jkvOALt/LWfVuhxxcjVoDYmsza9cQK22J8wHRp0Rs5TMWJCQTQv77PrnmO27hvcBbBzNUFr
        jP28Z3Q2GEF5uZ0RW1UMTD0Bygxy4Uv0tShW3PXlM5lsL1KFSDM8we1Rokbv3PeoMrsL8HMoH4dqJ
        TM+W5AWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on3Gy-00FgaS-Oq; Mon, 24 Oct 2022 19:38:08 +0000
Date:   Mon, 24 Oct 2022 20:38:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 01/23] pagemap: Add filemap_grab_folio()
Message-ID: <Y1bpoF9Flds1tHdl@casper.infradead.org>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017202451.4951-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:24:29PM -0700, Vishal Moola (Oracle) wrote:
> Add function filemap_grab_folio() to grab a folio from the page cache.
> This function is meant to serve as a folio replacement for
> grab_cache_page, and is used to facilitate the removal of
> find_get_pages_range_tag().

I'm still not loving the name, but it does have historical precedent
and I can't think of a better one.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
