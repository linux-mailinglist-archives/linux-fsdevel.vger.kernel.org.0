Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D775F51867E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 16:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiECOZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 10:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiECOZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 10:25:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25B2DA96;
        Tue,  3 May 2022 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CGAmq2buQ/fYxQwOonrx5m9HPjC2FfICCxpYpt6nExw=; b=Kv9wW9wqwNa9bKa7eoRidA7yMX
        Twha4hq+kYA+LB0uHJd/X7TjvKaAj8AsknrzvlA5QQadrqu3FPjNXGytFycvP9ys03B60GmOqoxO4
        TUTyE0Res8cq0kO92+z7EaJdPzz+CKafROLlcwem5EHlutLYnB/SulmL4oFzeO2szNMdySYYUsDCl
        l7uwqs5WWqWE6O3+TzwNJAS5DqKRosmM3k18IMJ9gxZQ5+dlL/cDhUdBQ9E5cisXCyroPHsvEWhV5
        5rRSLhA74A1vDn72FugMwISl3cgD0TCvBQkjFwS3ChOgG47xioNy5xqg4s/zjvqNvKB3uELEoqroL
        GEengPzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nltPL-006ETz-4e; Tue, 03 May 2022 14:21:43 +0000
Date:   Tue, 3 May 2022 07:21:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] nfs: Pass the file pointer to nfs_symlink_filler()
Message-ID: <YnE6d2WvWRuxbk3j@infradead.org>
References: <20220502054159.3471078-1-willy@infradead.org>
 <20220502054159.3471078-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502054159.3471078-3-willy@infradead.org>
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

On Mon, May 02, 2022 at 06:41:58AM +0100, Matthew Wilcox (Oracle) wrote:
> In preparation for unifying the read_cache_page() and read_folio()
> implementations, make nfs_symlink_filler() get the inode
> from the page instead of passing it in from read_cache_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
