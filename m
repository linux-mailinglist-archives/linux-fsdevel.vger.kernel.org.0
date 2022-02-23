Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39684C0CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiBWG6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiBWG6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:58:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B7249C82
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=pBQONB4C5zvr54Tie2nG25KPyo
        R9XgeCB7y8x/99qe84xDznRT33vYy3jh2f6wwrkbMcEFXlGXOi/C129O83qa98AEYp3r/8vFIjYm8
        gqf/1kDTW7NTMl17VngS4hktUS4ctfOxq1oeZXBuNuw/G7jaUSu2s1U+pfeP/tAu2bW/C8WI2vy5l
        iw7SBnre4LXwYRecHvl2ruDBS5IR9v1lNRgkcuLLG0E6ury3Kx0kUYrzLbeitw+JvmnExk1yYQeZy
        ysqn36AmPexV1F3P0Yf78FiWl2DnImNtGFmiz1NMkOv4EwstnR2nLZJGE52X17E6BCLCwAms5CM5D
        8O+G5R5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlao-00D3QF-9N; Wed, 23 Feb 2022 06:57:42 +0000
Date:   Tue, 22 Feb 2022 22:57:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/22] fs: Remove aop flags argument from
 pagecache_write_begin()
Message-ID: <YhXa5nwwcVua5OEj@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-15-willy@infradead.org>
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
