Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325197254B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 08:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbjFGGuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 02:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbjFGGt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:49:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1811732;
        Tue,  6 Jun 2023 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YKQqOcnx67PiOh7rsVqz9RQJsOnTN3erymM0veTrubY=; b=Bmsmv+qcXgppQMhQWwF2fqJlRx
        s7FUws/5TauaBIYdIQBzdFnsZJl7SKK0SnQJMPKHjmzYiS69j759WzjYUw8Jh7SOtWI/Y7L3S38yh
        +vIdDpTw6Y+auLpXjV3w3nlz/K8ID/9ERJK8BmXy2vj+piUW3Hi44gIyXL50A0/5CcZFF1aVrZ8Ja
        fkuM/u5v6D4Tqofdc3tuXOLxWnQF0FZqKN+ddJg4B8KwxRh7fi+mrWrTpDaSwrgCZIsjRDNIA+dHn
        1K+B2vdTMQ++qTjhKYoyaca6MiBU3kg5GPULgytAh/H7QGC11kIH6FputUe4TUyvu5z+C2JtakxDG
        iLSUw7iA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6mzQ-004cXU-03;
        Wed, 07 Jun 2023 06:49:52 +0000
Date:   Tue, 6 Jun 2023 23:49:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 1/5] iomap: Rename iomap_page to iomap_folio and others
Message-ID: <ZIAojzrF5sEKDYmI@infradead.org>
References: <cover.1686050333.git.ritesh.list@gmail.com>
 <de5ef97f16733a2acd544c1cabb3866bf7d2e701.1686050333.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de5ef97f16733a2acd544c1cabb3866bf7d2e701.1686050333.git.ritesh.list@gmail.com>
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

> -static struct iomap_page *
> -iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
> +static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
> +				struct folio *folio, unsigned int flags)

This is really weird indenttion.  Please just use two tabs like the
rest of the code.

