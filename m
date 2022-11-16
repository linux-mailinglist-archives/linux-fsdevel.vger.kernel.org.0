Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81062C3A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 17:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiKPQK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 11:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiKPQK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:10:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91E957B5E;
        Wed, 16 Nov 2022 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u8pM+4vUJLzA9wegq8Q2wocQoUHI07oy0+pM6z59248=; b=BgK8yGuksK/8uEchNJ6oPqmee9
        AWJOeseN9XlptFYcaTLa5l22iBLR8xdSqghiKpGs5RTFV5mq4evZ5e7fUxTDu45M8exR+tcfDktDK
        lPYsfJ+mLIpvLL7EhI0T1Lw/wI7fdygJP4NlOx6rWdvdLmD8JxRxUtpQYLqiOhTQUxPcvwJ9F3FSB
        5W5wpQPHEkbpr1+atUN9cPbCzBSWF0n6bFLwRRIV8pe0kB3UxijdyCcu/hPg7b0i24Xy2tjIJjgLT
        54h7SpYHo9UjX51s3nPZuS+0xKGoj1dWIvgp8fDyZ3ym8tT2sJUcxOv1O2OSEmkDdrT1jUUORgOrL
        9HWsb9Vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovL03-005jUr-F6; Wed, 16 Nov 2022 16:10:55 +0000
Date:   Wed, 16 Nov 2022 08:10:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        chuck.lever@oracle.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 7/7] nfsd: use locks_inode_context helper
Message-ID: <Y3ULjxdeB2GnijAr@infradead.org>
References: <20221116151726.129217-1-jlayton@kernel.org>
 <20221116151726.129217-8-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116151726.129217-8-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:17:26AM -0500, Jeff Layton wrote:
> nfsd currently doesn't access i_flctx safely everywhere. This requires a
> smp_load_acquire, as the pointer is set via cmpxchg (a release
> operation).

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
