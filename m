Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792B666D75B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 08:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjAQH6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 02:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjAQH6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:58:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D278025E0F;
        Mon, 16 Jan 2023 23:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b0nS55MfXPyMov4axRHGXQeYFTCNO98nDj10cXmRS1Y=; b=QlWgpAfqbJ/Wm1Rsi5gnTq5sVM
        FeuoUlhWDiuQ9jMsZIlCZ2S1ne2SwCsMNg53tZY5unUhoPM6b5nHYWZE5kdWALzD2OqSe7n14Z6l2
        ClXxY41oAuUcqKztDjR+0RwBKrDGlTyGdOcTWjKMqcH7gmIt/iPP/qAo/btu0jHCkmlXRY7yippOe
        a7DhXxwjr90om/RDe2lXvEJ58P/lnG/audGrflA7+k24JvT7TWuE1mO44KKWRJ9xViQWbhUJZ6OYH
        umSmytHhF5quOMVl49y9nj8hTjNsv1e2GXx2sIPX0b10k5sGSATLIin0efVEcTbhPHZB10UdxFd8r
        2ZX6KSAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHgrI-00DGCj-7W; Tue, 17 Jan 2023 07:58:16 +0000
Date:   Mon, 16 Jan 2023 23:58:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/34] iov_iter: Use the direction in the iterator
 functions
Message-ID: <Y8ZVGEvbVsf4eDNU@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391052497.2311931.9463379582932734164.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391052497.2311931.9463379582932734164.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:08:44PM +0000, David Howells wrote:
> Use the direction in the iterator functions rather than READ/WRITE.

I don't think we need the direction at all as nothing uses it any more.
Maybe don't crate churn there until that's been sorted.
