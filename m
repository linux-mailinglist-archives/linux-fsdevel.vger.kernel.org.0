Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BBB74A100
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjGFPaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjGFPaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:30:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93FC1996;
        Thu,  6 Jul 2023 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NX1qQf32xB5e4Oic+4MH1QCXdCgL1B+9abCDcZ06Z2A=; b=IUKEfxvllaIuo1ZEI5alIZ7EpY
        FYzlzIKPPU3uEJxty49m8wk7i9gV6AaosIikGrFvYiO8ECA8dfGLba8HI3mPS3UnCmcVHGyLRstjy
        mFrdHYHpNED/+xo2A8ryGP0JYkigWiMTVTXuvFqS7d7/TLwQUWm7Sjn9TcSw5xZkx6Smha3oYMBOo
        72ExmGD82kvuFlKJFvsrB1/kVzRqU89zKbK3cuCdcYN2qLjVqg3II7Wyp1AEpkIqqN6GCr3FX8vJz
        aqPQJ1t9nyZsq8akd7GJji4nkCTebuWBUSVQdmVFcb8YnppYbplCTEptKzinGMjtJmtLBORbrwRuK
        P2KsjF8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQvn-0020bl-3C;
        Thu, 06 Jul 2023 15:30:07 +0000
Date:   Thu, 6 Jul 2023 08:30:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH 05/11] iov_iter: Use IOMAP_WRITE rather than iterator
 direction
Message-ID: <ZKbd/9gtXQuW/9sf@infradead.org>
References: <20230630152524.661208-1-dhowells@redhat.com>
 <20230630152524.661208-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630152524.661208-6-dhowells@redhat.com>
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

On Fri, Jun 30, 2023 at 04:25:18PM +0100, David Howells wrote:
> If an iomap_iter is available, use the IOMAP_WRITE flag instead of the
> iterator direction.

This is really two patches, one for dax and one for iomap, and not one
for the iov_iter code.

