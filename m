Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2138697E84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 15:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBOOiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 09:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBOOiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:38:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45C38EA1;
        Wed, 15 Feb 2023 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mdhw8NJg/mGm2rLRE7K+YYjG5J4d7EGwj+3NTs6BCts=; b=FBURCH8CW2lpvly8/2QdT+a6WV
        8kzR47TjYHTSwwUdjoNefF/biBJnI843/SYOdF9WhFk6YPc8FNsubW+U8DJT0tlh5mwFegiYsggNX
        CvMUd1vbNflSjvqp34VuqGoGL+c6eQtb+5GkMwiqHPtFYx9Y9Hx7VTJabL3kb3yqI62qlSJR+6B12
        HS7hqLH8DHAAlZjYIFOWrSK+sIRx+bteZTUKK9q19qN3zJM7Poblsyji+P1QLxVTmLD0ygjDkm5H/
        +wsNaJonOuGpUK9TZxJs6AgHOVMaE4xmHntz1dgZSomtuLr2JhY45zRhlZ2u0rWFpzvA8apaXZtmI
        ts5QcFJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSIvR-006ERC-Jq; Wed, 15 Feb 2023 14:38:25 +0000
Date:   Wed, 15 Feb 2023 06:38:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, smfrench@gmail.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v14 00/17] iov_iter: Improve page extraction (pin or just
 list)
Message-ID: <Y+zuYWK1ggcor8jJ@infradead.org>
References: <867e1e3e-681b-843b-1704-effed736e13d@kernel.dk>
 <20230214171330.2722188-1-dhowells@redhat.com>
 <2877092.1676415412@warthog.procyon.org.uk>
 <2895995.1676448478@warthog.procyon.org.uk>
 <Y+zqy7kyWWo9v/Wt@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+zqy7kyWWo9v/Wt@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

And who is using filemap_splice_read directly anyway?  I can't find a
modular user in any of the branches.
