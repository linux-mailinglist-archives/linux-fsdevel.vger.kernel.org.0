Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2705429BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiFHIpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 04:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiFHIoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:44:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9BF237C2F;
        Wed,  8 Jun 2022 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=l7NT0ps+5Sa+CTK3H9hfJji4Fd
        A7zNd6sKSO21jiFel/Yej67cZcGS8Ks/1Nb+KruI8rTzKZY/l6nUl7fe1mhKhtHOKgFOLFpCU/I/G
        cP/mswbGcgITkNlQgIvaPGgYDXtiGSCr4xWVnIwAtN29JyYy+jnTPkkJrzAdQxZq9Ord8Jn+skutt
        Wrb6S14hig+fqYnKrsb2t0gMBTssRTpRIopwoCZWchk1J7byiNXWATQvPxAOZ2Pw48g8LuX6s5jqy
        eXvItBOcIUJMtZMkd9H0mwoW/g0SRCKPioQvvaw19MER0dpzkRRSveecHr8+snwhAZc8DTbqin7GO
        1gJ0jepw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyqfx-00BoJo-JM; Wed, 08 Jun 2022 08:04:25 +0000
Date:   Wed, 8 Jun 2022 01:04:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 06/10] hugetlbfs: Convert remove_inode_hugepages() to use
 filemap_get_folios()
Message-ID: <YqBYCdMaaSNfBIF7@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
 <20220605193854.2371230-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605193854.2371230-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
