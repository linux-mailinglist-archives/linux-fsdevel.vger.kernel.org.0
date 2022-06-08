Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1552B542A81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 11:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiFHJEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 05:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiFHJCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:02:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658F86352D;
        Wed,  8 Jun 2022 01:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TVP8BYurAveyS5a2ptp5SFIihW
        BuI5q00/6pN2s3gp5WhksU/P8/P2qUDb/FHcWz8IJGjzMTYhz0TfzpIAse4uKP/IW8h+OuDqK90xM
        SjRJm7GRWSpMnGR6q4dcVgc/arN1yKbaYlapAgfXlPuc+cbKwGsd3i+ubdgTTNNVXGAb6Nq9WDy8O
        AiQ7zKq+egS0Fz29IorHKLjedhgdJ1XYLzEJA0nIhqRuWgf4eHgQ8NenhgT9y1HqbXMOSc14U8Nef
        0nmBEWbyDsk0TKpJma4NQ+OHTVhznlBOK3CghLojUexldBYZaAgCEfuz2Dt7vGQssU3/GWVDopeI6
        LKtiBMjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyqpQ-00BrH1-5s; Wed, 08 Jun 2022 08:14:12 +0000
Date:   Wed, 8 Jun 2022 01:14:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 05/20] mm/migrate: Convert expected_page_refs() to
 folio_expected_refs()
Message-ID: <YqBaVJE9aIkK0xs+@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
