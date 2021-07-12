Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4733C4752
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 12:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhGLGcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 02:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbhGLGa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:30:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42633C0613BF;
        Sun, 11 Jul 2021 23:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FG/iT78/oQ54SybYw5GKCu27WpTpEqbvYfp5VuXTjUY=; b=cwCckUHBSW2+VJCGnUnAh9jyed
        gDjxXJiJMEHQyMebKbYi1BVDUpNKGVbHThCMUr104hxQVNQY2FKd9PicSRi40Iz1BetbVBNCwBTVD
        9iMb+WdMOfYKfzoqq86507FJ/I+Y32o+o0+qQlR/V0h6bqG8qWDoeX5iTEVNjTBhhcaMlRZisB9ip
        PAnciSpk33SSXJI5gGBow48qhGvtxg6IjL///9S/I+6WyJx4DF5fnyJm5WRtsS5mFoiMz8+FNmh/M
        MsiJEsnhUL8XA8TqrZipFqMI39IZS8HYRycK4kxdCHpKhey5acg4Dp2dqgJVzMyWbG8BLWdRaLyho
        QvnUVewA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2pNZ-00Gxnx-At; Mon, 12 Jul 2021 06:25:43 +0000
Date:   Mon, 12 Jul 2021 07:25:21 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v4 1/5] block: add disk sequence number
Message-ID: <YOvgUcLeocxQxZNY@infradead.org>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
 <20210711175415.80173-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711175415.80173-2-mcroce@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 11, 2021 at 07:54:11PM +0200, Matteo Croce wrote:
> +void inc_diskseq(struct gendisk *disk)
> +{
> +	disk->diskseq = atomic64_inc_return(&diskseq);
> +}
> +EXPORT_SYMBOL_GPL(inc_diskseq);

No need to export inc_diskseq in the new world order.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
