Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89FC62C39E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiKPQK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 11:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiKPQKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:10:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B364C267;
        Wed, 16 Nov 2022 08:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B0kDkUWYUK/q8mtpuh1BWXWaKhsWYAxYUFkjbnqVJH8=; b=thO7BiFg5aqpLnc3cgzT1wKqnO
        IILQd1fVsSULH5hj6XWy4ooH4xNP+lEFabVKnAXM6z2X4JxUxK4V8WymD/iypvQyYfkLMyjxccyqG
        bpua8iH1KdMd7EY6dWA8Ommi23UQWsFT4lshnghq569/nq/B3UWcC+96xFztx/s6vWYXDjmd13zOb
        sXY14NMpvb/BO274axghAT/40yJ4MyLwpGPBU0Df6Hced2deBF2BmWGoYXwhQCq96QP9YJcEmm6lz
        ZyN2659O2bYGtUstv8HFf82dzaWIfRdf/rP5oAIk9D648rX4nJSlqoGaYI4ptgL4CxAm+NxO9x68q
        eVXwsYkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovKzY-005jDu-SW; Wed, 16 Nov 2022 16:10:24 +0000
Date:   Wed, 16 Nov 2022 08:10:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        chuck.lever@oracle.com, viro@zeniv.linux.org.uk, hch@lst.de,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH 6/7] nfs: use locks_inode_context helper
Message-ID: <Y3ULcJhkjCno4Hrg@infradead.org>
References: <20221116151726.129217-1-jlayton@kernel.org>
 <20221116151726.129217-7-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116151726.129217-7-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:17:25AM -0500, Jeff Layton wrote:
> nfs currently doesn't access i_flctx safely. This requires a
> smp_load_acquire, as the pointer is set via cmpxchg (a release
> operation).

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
