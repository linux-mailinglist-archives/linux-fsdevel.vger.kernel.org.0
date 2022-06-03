Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB9F53CDF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbiFCRR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiFCRRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:17:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE0C52511;
        Fri,  3 Jun 2022 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nBx/NbU4HXIOKAcGrEAiFD5zI7/ONKNqMop28OvDkIw=; b=I04kpGV5e0ITx/ywVzkXX+jlwh
        36Fko0jxoKN9eTovUrASkrAhhDzvQhMQ539r3r6hjRtjzJ/mpCIYVG6C0Py5NEbc4IqUpj8Ak/5Sp
        e1pRvQeFeFkOHMV8pT+zvbsmgu2ihS0bnuexJHnG+17jvN3tyqHuEd9XKGHPT9BSXNx4HNO5mYwy5
        K3sNY/O5d0tEVLBhitErxiUgb1Qn/GBgt41jk3HPjSnJO0ag4b3AIrGWNHvjbjzN/+85DBIO39nfr
        E5yZIH2xypOGdm3SlujzAQpX7Jnd7/gtXDQtYjOIHIs70Z2B6kyN9w9gz6/RTUY3uOUiOJgVfUie8
        Gu+TJblw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxAvK-0081lU-FM; Fri, 03 Jun 2022 17:17:22 +0000
Date:   Fri, 3 Jun 2022 18:17:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] xarray: Replace kernel.h with the necessary
 inclusions
Message-ID: <YppCIr4qM3lVYi8N@casper.infradead.org>
References: <20220603171153.48928-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603171153.48928-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 03, 2022 at 08:11:53PM +0300, Andy Shevchenko wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.

Thanks.  Can you fix the test suite too?

(cd tools/testing/radix-tree; make)
