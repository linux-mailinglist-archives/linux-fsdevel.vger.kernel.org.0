Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4289472D8C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 06:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbjFMEw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 00:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjFMEwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:52:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4622195;
        Mon, 12 Jun 2023 21:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KXSUcmnO0D6A/R0ZhipRkj+YKyGYGDZJOwpl3ktF3nY=; b=1hr3nHQ8EVOZPHLapOy+bUcNmj
        /o1LXWRNZvFVU+NT2XByZ3AIqn8WYg/Ya2Q/xfWzsJXQPBtUPcDtZbppkDs+u6ierKTac2Zo/drui
        DQxwkFOYvC0Rj+4nd5oskY/LBrF+kb2t68gejyKqmY/Sx/IzPkPM4523EtAnDv0omdEkwLcfoEhtI
        3AHlJR5l/3+jtOxzIjPdRlQL1NdElC1ybdX69eDwaJIpiNtvY1UA/Cb7RwvaA5ukrKTfy2RoRt9I1
        tL4pLJWJK1vnRh8RmNXyumHk9xVHLA+jm0ynM0dLQH/oWmBIMDaykXz0s8TjN9L9vT7dvzjTuoPx9
        6SSVLT0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8w1U-006upi-0Q;
        Tue, 13 Jun 2023 04:52:52 +0000
Date:   Mon, 12 Jun 2023 21:52:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 1/8] iov_iter: Handle compound highmem pages in
 copy_page_from_iter_atomic()
Message-ID: <ZIf2JGDz0LUQtvUR@infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612203910.724378-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

