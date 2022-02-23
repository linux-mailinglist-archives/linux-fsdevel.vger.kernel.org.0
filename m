Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0DB4C0CDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiBWG7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiBWG7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:59:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B97F49C82
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W6fvWgP2c8/L6tvCM0YRHEZSjnQ7JyrjlVEIm5uUOSE=; b=IJJ5XPTWCYNKGkmQLK/b2ke9WM
        67hrVkMfPP1NoRebUHIfZ0M8gG9jiioYQmCD3AQtpwrbC3yR7D2KDgGJbezmM1WP24hgJq7TjIzdK
        UTX2xi2bb6Be2NeHnp6aW63kQSXUQ7uK9uw5EsJ2fbb+OQGm6NYn77c96CkWdMlthPWB/8flxAXJB
        MOv6kU606LZaTKLcjC/vXGtz04maV6GYyPmor1MlSFKbxxAAizYhTXJsL71OEKOSKI3stCUj2s+bA
        MHl5o3QrP4cNuUa9McjI9ciEJ1ibkML/hWPrFiQXHqMWV/YT+pL4xFWtNCW8Qf5N9M7xbTxjPxAxt
        wsd8ftCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlc0-00D3Ya-RK; Wed, 23 Feb 2022 06:58:56 +0000
Date:   Tue, 22 Feb 2022 22:58:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/22] fs: Remove aop flags parameter from
 block_write_begin()
Message-ID: <YhXbMFBeRSPBC/75@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-17-willy@infradead.org>
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

On Tue, Feb 22, 2022 at 07:48:14PM +0000, Matthew Wilcox (Oracle) wrote:
> There are no more aop flags left, so remove the parameter.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
