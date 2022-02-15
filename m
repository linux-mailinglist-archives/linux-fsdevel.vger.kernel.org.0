Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F294B644D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiBOH0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:26:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiBOH0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:26:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5743F89F
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ueh8A/4XTiUrAT2PAfp0oPFMdZ
        EyCRy+LS4rPIDrHdNNNU2HmVEIXjz5GCLZvj/Jk0g/bL5Hckc4rNCOFDqiPVTjdjEUPhACfnRs3yJ
        zBgAcTe0JW2IBbH01GHfuLZO60+dUOwMmZ7hb3vhL4W1ydLK6ck9h8AdlmJ/9TcvJQ/oOQXBKSDl0
        rajdsHVlXYMO0NNm0kC5K5kaYCa0TRBzBOpy0lY/hy16kbyyk7di/RSJlqVRooC5UncQLAo6dqYV9
        XFRTiSVFyjgU/bO5IQhwem1OzWQ5XTGz8W5zMHRxWJ4KfQ8y8n70tUwrQeZvn88cNqD0I9CsDKtMI
        UxelDSJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsEG-001BRt-R9; Tue, 15 Feb 2022 07:26:28 +0000
Date:   Mon, 14 Feb 2022 23:26:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/10] mm/truncate: Combine invalidate_mapping_pagevec()
 and __invalidate_mapping_pages()
Message-ID: <YgtVpNoN7bI5w4Cx@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-10-willy@infradead.org>
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
