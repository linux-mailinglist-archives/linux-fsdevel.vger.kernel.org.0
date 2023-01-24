Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD0867A206
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjAXTBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjAXTBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:01:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691434C6C8;
        Tue, 24 Jan 2023 11:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wUIvYwP9fsit2iMfgfdaW3+bhvI90/rC/aH72KemOcM=; b=Fqa6KkJ/pTEy1IXNJfFxc/scHe
        ilJkZm8LBVVyQU8SBFpithAOHc9dtYIdOYnz1TXMhAAsLqYr4NUdLE7WkRztldYpGzJRsgZT8gRNW
        UAouh962tNQRiVSTrAuySJh0kP7G+Hh6bugGmyNpTmcDLS3Q077DeOaMUVtTMLUw+DGGWEIszKkCh
        tReXDOotIAVUVlWPwy2KP6l+YUilVvDXuuglA+2AqeLLBLEXfT3HF/y5bzvjFgT8fOJXVj48gN/PD
        wwkpWCUEBf9feOQ1eWDA8TX9NzK+gfhV5QkDBPHuCy9excBnc7nhim+eQoKNq7AJE+qgoG2GhdRMc
        ecoTZ8iA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKOXV-005007-Kp; Tue, 24 Jan 2023 19:01:01 +0000
Date:   Tue, 24 Jan 2023 11:01:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/8] iomap: Don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Message-ID: <Y9Aq7eJ/RKSDiliq@infradead.org>
References: <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124170108.1070389-4-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 05:01:03PM +0000, David Howells wrote:
> ZERO_PAGE can't go away, no need to hold an extra reference.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

If you send this on this needs your signoff as well, btw.
