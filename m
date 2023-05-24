Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6B70ED60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 07:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjEXFw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 01:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjEXFwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 01:52:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A413E;
        Tue, 23 May 2023 22:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d7MoCPoMkvP5oxJ0+Yi2KmOwD9poIx2eN6JRQtb6+cE=; b=Phq0aK4u1ny6dIgTVa6MbcJnPw
        X+odKdmcxVmjaAc1BNURyrCoOmyCeSUJAgfqHLd2RnztfJbUK22BU7jfEpE73VdYZZURPZ6LoxH5K
        AvfxrmdlI/ILS0fZHFmS9Ky/oAjEox+akTMtfX5WbzbySyJkR/A6h6I/ztqKNscx7j8XIoQ5p7qp0
        /cI4UvdjP6whgAzRR9/YxzkF8fkJ0uUMH9BBTVernGpcLkQqxVHj/uOc+Bbo4MEvK57Md5JCzc7E+
        z0a8l0TYw2E3S+Zqv6YYLTupF3ZwFbrX78jFmO4pOaFzQSTvIMYdYqGrwDyfdULk4yHqiJt2lKVph
        wzTUsyaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1hQO-00CRM1-0A;
        Wed, 24 May 2023 05:52:40 +0000
Date:   Tue, 23 May 2023 22:52:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v21 0/6] block: Use page pinning
Message-ID: <ZG2mKMus29qquHia@infradead.org>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <168487791137.449781.3170440352656135902.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168487791137.449781.3170440352656135902.b4-ty@kernel.dk>
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

On Tue, May 23, 2023 at 03:38:31PM -0600, Jens Axboe wrote:
> Applied, thanks!

This ended up on the for-6.5/block branch, but I think it needs to be
on the splice one, as that is pre-requisite unless I'm missing
something.

