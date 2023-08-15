Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC177C634
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 05:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjHODCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 23:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjHODCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:02:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775BC198C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 20:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RyW8U2Pr/7HpHcgWHMTkiSeB3n1gPmJN0VgtMXrWYck=; b=mchSmvRsZzlOPqEvDTR6WyguFs
        uWEokfAIXtkE1aEGSm+zIhfQI8KA4qu52wG4J4a1pG5zTjqCQWb5i7XJhzIPIjqBdsS8AAfwr5Usp
        fbjgWUoanilJniKTQyGsQ+coKGuwcuijcjsu6KpOoyYX0bjDWsaB02mVMtcLIZjmthWxAkn3SL0mQ
        p+alYWksMl7dSWE1M8v7ZUg8Drgd1bYzY9ivxPCoZ4Leu+7Flr0e+AoBfg8CY3D7VqNUAB79pFS4j
        PcukxB/Sx1Vu52YM4cOnHRgdGbH0JZ/dqx7Fuu5HcmeUVB0PhHezwsCxV/zfAv+6KX8GVUXVgt0Qe
        dCAWqDhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVkJs-005lBb-BN; Tue, 15 Aug 2023 03:02:08 +0000
Date:   Tue, 15 Aug 2023 04:02:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pagemap: remove wait_on_page_locked_killable()
Message-ID: <ZNrqsAsL9TPYtljn@casper.infradead.org>
References: <20230815030609.39313-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815030609.39313-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:06:09AM +0800, Kefeng Wang wrote:
> There is no users of wait_on_page_locked_killable(), remove it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Yes, NFS was the last user.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
