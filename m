Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FC7675D41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 19:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjATS7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 13:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjATS7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:59:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48310410;
        Fri, 20 Jan 2023 10:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=faS00BN0vzsZ6ntF3Du1tRjH6pklFXGeUXMszEheyEE=; b=hYEyUmqNaKOTuvNMQxJooIHLIV
        AmQgKPQh2tIfprwXAHw7LP04bGXquP0MIThAlkNGPK4ohKVh4Hg9paQvYMAyhJmwiwolxCuS57qib
        GwB+AQ9Do+DYxm+Nk4NMIOIyFhC7xV88waK71ekyZC9RGt/LgQrIyIX6RLJ7CnEtTUVjGPiWG8WG6
        tWt9jlMjP9gcFfoyUWpgOq3gFDQkllEprXljcu6wOn0HRzLt/k+B+M6qNfCIecDSEvWqCY8GXEKdJ
        9DYHQg8NEqZ+1oaHoR8PgwJH+6cXkl4Gpm3tUf4Ylo5NFQlgOvIRmVG3O97LHElLAwvFgQRaF7tO3
        uaNVGPiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIwbl-002Knj-Ds; Fri, 20 Jan 2023 18:59:25 +0000
Date:   Fri, 20 Jan 2023 18:59:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 8/8] mm: Renumber FOLL_GET and FOLL_PIN down
Message-ID: <Y8rkjYn7HY/IwHrL@casper.infradead.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-9-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120175556.3556978-9-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:55:56PM +0000, David Howells wrote:
> Renumber FOLL_GET and FOLL_PIN down to bit 0 and 1 respectively so that
> they are coincidentally the same as BIO_PAGE_REFFED and BIO_PAGE_PINNED and
> also so that they can be stored in the bottom two bits of a page pointer
> (something I'm looking at for zerocopy socket fragments).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Although I was hoping you'd renumber some of the others since we
currently have gaps at 0x200, 0x400, 0x1000, and 0x4000 as well
as the 0x40 you're using here.

