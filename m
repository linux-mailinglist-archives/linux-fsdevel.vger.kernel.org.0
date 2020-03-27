Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBEE195BFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgC0RHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:07:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0RHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zAJnQVjh/YVJIZRUZkiJ2T3AR5t6zi7EMh14k3BhrXg=; b=VBaHRcm1PEOoqcSewYlG5PE8be
        rcLqB4rh1JW51bZRnk/FPUpSul6MZ98Ffd6Gs335cuy4I6D80j+qizINujUO/eYmNlGZqwSyWpIC7
        P2uolCD7zWJvrmHw5NnLYZs0sd/TIHwufmdywDKwPrgEe89awzRMon51Ot2amI3pO9BXAo+OQasNc
        enj2+LorLWT/wOTnIB7lOFNAZdYyPpLLPQA4ERcK/0kgqYObYGpJiBppRRRweJ02PQvvV/9BeQURx
        8n1o20RSloRKRyoxA85Ep/7koC7Ruf6/RumZcgtpwx0lnn+lEIwC/2wnKsdBLt2wlO2cHP9DpUa1p
        BRNip3zg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHsRw-0003LQ-Ry; Fri, 27 Mar 2020 17:07:16 +0000
Date:   Fri, 27 Mar 2020 10:07:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] block: export bio_release_pages and
 bio_iov_iter_get_pages
Message-ID: <20200327170716.GA11524@infradead.org>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-10-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165012.34443-10-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 01:50:11AM +0900, Johannes Thumshirn wrote:
> +EXPORT_SYMBOL(bio_release_pages);
>  
>  static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>  {
> @@ -1111,6 +1112,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		bio_set_flag(bio, BIO_NO_PAGE_REF);
>  	return bio->bi_vcnt ? 0 : ret;
>  }
> +EXPORT_SYMBOL(bio_iov_iter_get_pages);

EXPORT_SYMBOL_GPL, please.
