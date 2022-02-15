Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE14B643D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiBOHY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:24:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiBOHY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:24:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17DF1EBD
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bLyXpU/Pxlb+iQpH4fs8tHCVQXpNfIgE68fWGKX2lA8=; b=eElP7SneL9x20VFYnjTuHpcSIp
        ulQBAooCJPGOzWjyP+D4KZD8paRg8HQieR/l6jud3Yl/nzDC4bw2JkIEeyMwrskors1ongBCaAXmS
        jAvN0iIkzdcHKH+YBEomjRZxR9iV9QSkeUwTg/i4B+Y8JARxu4lJMydoFRKB50rFnT52UcLcsRjEF
        FOtXYqTVAHzgGqgboxD+iTRB770f5Eee/mYFODBPrGQY3DjKkZtENZOR3a6qB4ja/Z99z08xBg73N
        Ab4vc0gMBHFR/0BIngvBdGUHv7+kc3tstkG9G9+o3MCNn9FkXhkMDJO81bcURiPM7lPFm4fdgfqep
        uSds4/5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsCA-0019sz-Dw; Tue, 15 Feb 2022 07:24:18 +0000
Date:   Mon, 14 Feb 2022 23:24:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/10] mm/truncate: Convert __invalidate_mapping_pages()
 to use a folio
Message-ID: <YgtVIrlqrp+ASPHp@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-8-willy@infradead.org>
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

On Mon, Feb 14, 2022 at 08:00:14PM +0000, Matthew Wilcox (Oracle) wrote:
> Now we can call mapping_shrink_folio() instead of invalidate_inode_page()
> and save a few calls to compound_head().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

