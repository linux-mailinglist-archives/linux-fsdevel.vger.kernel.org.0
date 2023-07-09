Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295E974C7FC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGIUGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 16:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGIUGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 16:06:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56241FE;
        Sun,  9 Jul 2023 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0pveTWgFRr5mN5v32TgV3qLTNvcCzrdqvG9KBp/LfDM=; b=CKvxMWf1oJIhSQLDpLkOVg107b
        8gXWkpndkDR6J484pKeK9yBY6PVCcnX9DT31gBUbv/3Oj1JzGoqZRA+Gm9qYPzoaJ0XQIO5LzyqPK
        thfGelT9Kdj9Tmn89+S+D2xa84QpAqrQSuSDPciNnd+2cbBKATfQzYVmPLHZ9uFPsZpqlO/H/bnN6
        hKgcpXdx27TTyUJiTUEiDGidQN4dCRhDWbTdX/VY9IbFZxnuiSV5yM0Y8o4Zd9bJrZXydF/LHwa3P
        ELmkUJocCfn9vqzgWpC+MooCN1wWFdQT54RS9YMVvkHOnXBNGYW3DPZ5G3UX/KPkFCQcFGgCFfAXq
        s1LVW+jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIafF-00DyMr-3X; Sun, 09 Jul 2023 20:05:49 +0000
Date:   Sun, 9 Jul 2023 21:05:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Dylan Yudaken <dylany@fb.com>
Subject: Re: [PATCH] eventfd: avoid overflow to ULLONG_MAX when ctx->count is
 0
Message-ID: <ZKsTHWjJsvLw6kJo@casper.infradead.org>
References: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
 <add93bba-5c63-7d7f-2034-2d25b7b44ada@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add93bba-5c63-7d7f-2034-2d25b7b44ada@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 09, 2023 at 09:13:28PM +0200, Markus Elfring wrote:
> > For eventfd with flag EFD_SEMAPHORE, when its ctx->count is 0, calling
> > eventfd_ctx_do_read will cause ctx->count to overflow to ULLONG_MAX.
> 
> Please choose an imperative change suggestion.

Markus, stop this nitpicking.  It puts off contributors.  The changelog
is perfectly clear.
