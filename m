Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E954EC76F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbiC3OyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347878AbiC3OxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:53:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC44926A
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pUF2K7pAIIMFFXlBDPAhTM/LC99BSpeM4v+oDEUb7Ho=; b=Vh7Ae4g0umgmrn/cwBamht5TnP
        vSnVd8QLu+FRPbb5U8gXnCzjtOJOJVUzrLxTt2nPxcsYPHrRaQDCpl3UJsXWCmZScA5xxQIr4Xuam
        ELjViT06mynX0YjVXJm1UV0L8J0Blp936WFRT6Q/eTUw8X86G99vl2iwLxPYzidlWn/E0xK9u3Xdj
        0khHMcF6feyEq+XUzV68cxwoyJ210rxvaFX+ag7xA7rK2AdCoZFv6MKdyM3CN9m9McwjnPQWLbJ7J
        S+ptwBrSl0T7Un5RA5tSvnEJFtZIk/EWBEe/EipRDVDWjSIxQGdes8iTu65UBUFnPU0Ixr20y1yeD
        Dt70Rduw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZfR-00GJ3H-CT; Wed, 30 Mar 2022 14:51:25 +0000
Date:   Wed, 30 Mar 2022 07:51:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/12] fs: Remove ->readpages address space operation
Message-ID: <YkRubXIW0EM3Jaan@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <20220330144930.315951-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330144930.315951-3-willy@infradead.org>
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

On Wed, Mar 30, 2022 at 03:49:20PM +0100, Matthew Wilcox (Oracle) wrote:
> All filesystems have now been converted to use ->readahead, so
> remove the ->readpages operation and fix all the comments that
> used to refer to it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
