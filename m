Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCF37997A7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345020AbjIIL11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbjIIL10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:27:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19877E47;
        Sat,  9 Sep 2023 04:27:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F09B6732D; Sat,  9 Sep 2023 13:27:19 +0200 (CEST)
Date:   Sat, 9 Sep 2023 13:27:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iov_iter: Fix iov_iter_extract_pages()
Message-ID: <20230909112718.GA12045@lst.de>
References: <20230908160322.1714302-1-dhowells@redhat.com> <20230908160322.1714302-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908160322.1714302-2-dhowells@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 08, 2023 at 05:03:20PM +0100, David Howells wrote:
> iov_iter_extract_pages() doesn't correctly handle skipping over initial
> zero-length entries in ITER_KVEC and ITER_BVEC-type iterators.

Maybe put a little of that into the subject.  Fix $foo only makes sense
when it is completely broken and not for a corner case.

i.e.

iov_iter: skip over leading empty vecs in iov_iter_extract_pages

The change itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
