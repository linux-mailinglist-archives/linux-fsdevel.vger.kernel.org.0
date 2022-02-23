Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE44C0CE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiBWG74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiBWG7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:59:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84A49C82
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J/A/mYg8MWKqS4FZK+IzHiXc4WLfinQV87IRm/bcgNo=; b=ffwcShAcYwufZBtwJtVyyuLB6w
        pxpgXCNYrvTnf+cACmixh4/dtkJNqS3GaHR/bxuLltVte7poCmGOCJ8EVEEW5wbaVgqBa924B2+CO
        qG+jbzC4FESaKt70k23Ot0HUeZrxDPuo6u2kHBqCMK+iubdq9tYEi1zYTPeRQs5yUS1B8cvkYB4KQ
        73hPjimTGSY1D5f3DhV36P/+qzA8lY+AD+h8aME7pQ/s8CcRejRq25oJz3Kd75YximL22EgwHzJhA
        i7hCGWrgm7uc5t6xwcSnnIIIqEce6odQURsbK3k8OT5NVVg2zc1Nd1Wms52HhE5zpH+/z2Z00pBXm
        nufAeb8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlcV-00D3ci-Rd; Wed, 23 Feb 2022 06:59:27 +0000
Date:   Tue, 22 Feb 2022 22:59:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/22] fs: Remove aop flags parameter from
 grab_cache_page_write_begin()
Message-ID: <YhXbT+QY63M/IeKq@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-19-willy@infradead.org>
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

On Tue, Feb 22, 2022 at 07:48:16PM +0000, Matthew Wilcox (Oracle) wrote:
> There are no more aop flags left, so remove the parameter.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
