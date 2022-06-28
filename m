Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366AC55C252
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244256AbiF1DDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 23:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiF1DDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:03:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4EFBF66;
        Mon, 27 Jun 2022 20:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CuGJhLbS9IkE7VTbFjMhJYW2Xfxy5se8WnpHZFVzwbM=; b=iJ0t/LUzaOKaiqLAkTpQkf4M8d
        MdeoKwSr+5w6YVsKXop+K+FrAfjK7qmhiCVhVt8rHUFO9zVEVSTzWGC5uxA+5ZCNO4Hxz/KAtajRn
        SGndeL42gx0z4CxihZmkJUQKSfZbDqlePhHdAJ3/lqQVZuFpI5OrGPnAtmxnQzkW8GeXmVmE0r1uF
        kjwMTkkhLJ++4r/tHq4WG7pErEVklcDYnzr+mimN1rVKxINqQkatTbDj2n2U9nnXM6s6T5UTnzc29
        aJELZ4oRb/5UAW3HeWh5jV9LQDXRJh9X7ZsKhMxVJsHsJ/qJmA63a62RfecrGuS2pVjYNmK3twAkJ
        e883mXLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o61Vb-00Bv39-7y; Tue, 28 Jun 2022 03:03:23 +0000
Date:   Tue, 28 Jun 2022 04:03:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap: minor cleanup for filemap_write_and_wait_range
Message-ID: <Yrpve403Pz2MmwM+@casper.infradead.org>
References: <20220627132351.55680-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627132351.55680-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:23:51PM +0800, Miaohe Lin wrote:
> Restructure the logic in filemap_write_and_wait_range to simplify the code
> and make it more consistent with file_write_and_wait_range. No functional
> change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Looks OK to me at a quick glance.  I'll look at it more closely next
week when I'm back from holiday.
