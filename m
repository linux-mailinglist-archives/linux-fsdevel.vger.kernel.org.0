Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B4542A96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiFHJFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 05:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiFHJCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:02:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4646712C960;
        Wed,  8 Jun 2022 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Szf0A6CRm0TBzxMXL1+4gkRAFMANtEnQnq4pU3N3BDY=; b=bYF6iw7wjd0y+Z+F/STcPCdMi7
        QSbSyR1GVcGFHB6mUBGkUCvisiY89ZNNX0/Xw7TDYYqDhHEMDOkqpQ78YG7sV4Im0du6F72Z2caY2
        H1v0O8XuuqPMcgOMYc4Efb1MkS92YKtPUeCLJbq9RGFmaygkN6erKP+/0UYxlGLIp8l92hgq4KJ31
        kF5IB4FI7Rq0HgNYKMpkwaCRGuxqr9lQsYWHvQqZ+Vswy62VOxb0dtM/TNE4n9Rus3hm4P1v786GN
        Bu2U9oHHaP3qDEJtlCQFZ55nYDw8n8UvwKtVqn7mGlBP2GXKaLdhKDC9jgMMNKOZ33JSqYzDxDfna
        Md/gh56g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyqnR-00Bqhf-Qd; Wed, 08 Jun 2022 08:12:09 +0000
Date:   Wed, 8 Jun 2022 01:12:09 -0700
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
Subject: Re: [PATCH 04/20] mm/migrate: Convert buffer_migrate_page() to
 buffer_migrate_folio()
Message-ID: <YqBZ2fWTyU9cbyR+@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-5-willy@infradead.org>
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

On Mon, Jun 06, 2022 at 09:40:34PM +0100, Matthew Wilcox (Oracle) wrote:
> Use a folio throughout __buffer_migrate_folio(), add kernel-doc for
> buffer_migrate_folio() and buffer_migrate_folio_norefs(), move their
> declarations to buffer.h and switch all filesystems that have wired
> them up.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
