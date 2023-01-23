Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187816777E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 10:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjAWJ5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 04:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAWJ5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:57:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2B62111;
        Mon, 23 Jan 2023 01:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G7UllmyOqeEU3sLBmDnL9w87zvUottHaIxl+4NBhRGM=; b=NO8XklhYC1uoMeybIV1CKcyOxe
        Q5odFQQa2k7ONm5fl/TQnbGsk0+xAFGI/AyMyKsr/KuFu5pb74PynDpI/qZUTqU6reLAmq5/T4jv0
        wbaf5iCyfRohf16d6l6wmDzYQJXtMsXoYHnqQWrpie05hbFY12v7h2EGXpvlMsKmL3Hw1k1xwX65A
        lnB95rUOEr1+5eoDnVtYPQegezHf/L3ffWxO+dqlpp/1x/i/RgDujP7ZCkdELGo+DmXFSzRLwFb4S
        5KHVEzJuqR8+X2f0rkR09Bn0ctxrkMl/veZRWJjgzZYsiwT6LuiUoF24WkxpTD7oKsK1KgG8TvxWI
        LvcoW+Sg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJtZQ-00GbqR-05; Mon, 23 Jan 2023 09:56:56 +0000
Date:   Mon, 23 Jan 2023 01:56:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 4/8] block: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED
 and invert the meaning
Message-ID: <Y85Z511xeGSwmlhG@infradead.org>
References: <Y8vi8/sCvOxvLzzc@infradead.org>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-5-dhowells@redhat.com>
 <3668657.1674466725@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3668657.1674466725@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:38:45AM +0000, David Howells wrote:
> That looks okay.  Do you need to put a Co-developed-by tag on the "block:
> invert BIO_NO_PAGE_REF" patch?

I can do if you want, although there's really not much left of the
original.

> Should I take that set of patches and send it on to Linus when the window
> opens?  Or should it go through the block tree?

I think the block tree would be better.
