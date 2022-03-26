Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EEA4E7FA1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 07:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiCZGp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 02:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiCZGp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 02:45:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE31B7551
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=m/PtcgKkudIrcuy/OyF0YWmWxD
        EbVi0BlUG5lu+S4MeN1b6twQYzRlwr85JrgDHz4LRFFs1GHVdWoke0gNo3VQNBnMptO+xoRJ2yD0q
        839wHL9woP9ajDn00udOm2yyZXWY2bY0uXIy67ZNvZmvz6FASH4S2mq6WF5KHUZh2B3ecxv1s/g2H
        myvxNQdugJyx2BaSvLj07ZmpuD32YmkTNAM+BkskYbgI7KMgpIR6QmjsWblj0rTZlrRndXsKLqYb3
        z7HeMINX6ScfxFAgrJeCkpxxUiURelr+D0gxC2BDqqqPDolVgEIptHXWJgHg2XVZBhJSaqsw75XMC
        gpRQ1IUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nY09q-003rev-DD; Sat, 26 Mar 2022 06:44:18 +0000
Date:   Fri, 25 Mar 2022 23:44:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs/dcache: use lockdep assertion instead of warn try_lock
Message-ID: <Yj62Qvx/I//yqIU6@infradead.org>
References: <20220325190001.1832-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325190001.1832-1-dossche.niels@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
