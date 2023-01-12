Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1C666BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 08:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbjALH4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 02:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbjALH4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:56:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC77F25;
        Wed, 11 Jan 2023 23:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3juqZYwYPTt6tYEzQZfyxL5E5PLSuO+2HSviGS3R84Q=; b=yHH+FvQEgFBHDaoK7vAimdW6QQ
        mlQx+dHomBLYLTETU/w8pivXgj/VKBndhNI/vLBEh3+c+nmCQvJqIMwz3g/fP4BK5IYQSVwc8iN/I
        GZcumX2URlF+kG4ol10ClDTVLZKeB5P5HUaoEe1j7xShPynHoVubvwvBI5lSyRlNbvlJuHEMQJWOD
        8WHZZ1Nd57scQpLchQQiAULaeG09penseslfGyWVVmCM2YxKk+YXhpT+lTTzgK0dHHyFcExCrpt2L
        4raHtXhkJinUZnbHhhauHChgWfjC/pw3H7pN0WZVqLaJoJ+JUGh6H2db9XdsozB+lOQ71Hifa6qwx
        E3OwZkdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFsRD-00E3Dq-VL; Thu, 12 Jan 2023 07:55:51 +0000
Date:   Wed, 11 Jan 2023 23:55:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y7+9B/GB3M2HyRs+@infradead.org>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344728530.2425628.9613910866466387722.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167344728530.2425628.9613910866466387722.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	BUG(); // if it had been empty, we wouldn't get called

Please use a normal /* */ comment here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
