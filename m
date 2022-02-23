Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419F44C0CD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiBWGze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiBWGze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:55:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7136E4DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=38KOrDclc3sEtsXV8i33uafn2G3hrDEENwyxQ7psyk8=; b=Ou9xFPfm7n4kcElwYcBwIC+Mvb
        var6jcymxIEPqpAL8uiEt6PviDhBUwJlE1YrrOzetw5xRli5yv5jObxE6XojbbVXPfBH5PyKSJ9/s
        UdCGYxqZhr7ZBBVVzYFd/8FEJ/2Q/GGkilSwy9KBa0UXS/biaDircLFQrOtM66uW1t/AX44U+Btix
        tgCXZbhASEc2cFt/D1KoV8YQZGM2L5lKdG0jN7kb83mNwwu0jrKiVeUga2mhn0uLPJHN1QprVbPXG
        o5/4GpETpT4P4TcwDTl2cyUJ+fU7JfgUmm3n0cILMtxaolZwGACdSY1Ph3FVAsd49ZbrXmpkRtf52
        BGBz9uUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlYJ-00D3B9-85; Wed, 23 Feb 2022 06:55:07 +0000
Date:   Tue, 22 Feb 2022 22:55:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/22] namei: Merge page_symlink() and __page_symlink()
Message-ID: <YhXaSzevgYIw3JDt@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-7-willy@infradead.org>
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

On Tue, Feb 22, 2022 at 07:48:04PM +0000, Matthew Wilcox (Oracle) wrote:
> There are no callers of __page_symlink() left, so we can remove that
> entry point.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
