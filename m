Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A773666B9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 08:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjALHc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 02:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjALHc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:32:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E03391;
        Wed, 11 Jan 2023 23:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fzTsI/XfuD28OOI8CbmCAj26l5GkvrEUKgk/R0u9xL8=; b=A1J+hoTRw2rXyWH5xGcBAeQNVb
        OXD9g0nslx5lo5eU18QDAeabzNXWrVDJu4TFYlo96H7jBuxN6wHoU96rkBh1CLAKbMJPNHTKfOCVE
        XnAm1mBGbfrRDblNlCPKM6YXicYQZ5rjYf7M9Elvjp/0oHQc+77R6K5Lp+aF0oY2iigIVQG5Euptp
        zZkrKaqaTG6cdCBSrBNsZeIpiDAiMkkCBWtv03OEtIvfo+wTWm2ITL+khinKNMYnpmghGGdljTMlW
        ql3zWAY+v43fbf70Mfe+S83shPTcc04PXb3qcFEoxfp/YwFKyNchiIxbF+sceaPUANzsYrOLOj3kX
        Vdv1IcrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFs4M-00E12U-3x; Thu, 12 Jan 2023 07:32:14 +0000
Date:   Wed, 11 Jan 2023 23:32:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/9] bio: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED
 and invert the meaning
Message-ID: <Y7+3fjxlOOeLnFkX@infradead.org>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344730802.2425628.14034153595667416149.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167344730802.2425628.14034153595667416149.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd rename the flag to BIO_PAGES_REFFED as it can effect multiple pages,
but otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
