Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9E54B6439
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiBOHVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:21:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiBOHVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:21:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4027626100
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5GBqs2dxH93tUrV8iWp6FEaXTBcRZoxMtE6RrsNXYvU=; b=xhPyqGFL1zQdLcs4OmwcO8ddDg
        IrBWX3noQEC1ENWI6mU4ny7oIUC0m8ATneVMK4cnCsEiSnGcQb8nfTdu3o2TT1p50nR55XXu9PwAW
        gEJwozRl+MHhZ5vcVYu0YZpHgbvwNBVZLS+/mcc0vnUAgx48Ad4hpTZjwEKu9x831hwR+FGbFKKR9
        fZCBMkQqa89y2os1ttrU22anZDFx278Ga/+8TNiFWE2/nImzvRffATy6YFc7XoKgohkNfspNRclY2
        U8jb8l+D48Zidj7+kPWecquLk/gCUapMyqWTeGrDSOlcxTUTV1meUBOHEGi/NR10MeZiO7GDsjnlT
        CoSH90zA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJs9U-0018cY-Tm; Tue, 15 Feb 2022 07:21:32 +0000
Date:   Mon, 14 Feb 2022 23:21:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/10] mm: Convert remove_mapping() to take a folio
Message-ID: <YgtUfL0jf1aPECqF@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-6-willy@infradead.org>
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

On Mon, Feb 14, 2022 at 08:00:12PM +0000, Matthew Wilcox (Oracle) wrote:
> Add kernel-doc and return the number of pages removed in order to
> get the statistics right in __invalidate_mapping_pages().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
