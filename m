Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC015186EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbiECOmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbiECOmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 10:42:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5735A9D
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=C3EEooVBYdf8uynl9/sMEfCZi3
        DeIp/UkYqvMXZLWioc/0bTvRPvOFJvwkwjTH+gXEgnEPBltM7UBa4rf4grR+rVfB8c2ZpP8SqVt17
        Ox8Q+xZ0j7TTFFT9B+jjr9XgqZypBQdbsekxv6C0maaSmgTmQ7rmvwTtTpUDup6IzDdMMHbZlj9EQ
        4PTvQm5gfVTxRBOTOJEIPCJzxd3ymh0C8AhteqNMFWYjO6SKxePbuDN6+EHY29eS2qcyNMOT8DfBe
        smib1RIDNhXP6GHWOp5X+1npmilNe6pVKhMfOQpAiL6GkKvIkawlZKM8kkJPMwnlWpvQwGGl1jII3
        rchsANSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nltgP-006IrD-UA; Tue, 03 May 2022 14:39:21 +0000
Date:   Tue, 3 May 2022 07:39:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 30/69] fs: Convert is_dirty_writeback() to take a folio
Message-ID: <YnE+mXpiDabdRBOL@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
 <20220429172556.3011843-31-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429172556.3011843-31-willy@infradead.org>
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
