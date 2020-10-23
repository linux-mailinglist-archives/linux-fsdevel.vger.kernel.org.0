Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5D2296BDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 11:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461221AbgJWJOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 05:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461183AbgJWJOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:14:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C989C0613CE;
        Fri, 23 Oct 2020 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bc/Tl7QrHQ8TS00H9eZHX8HpJf7gnLju80W3+dBio3s=; b=lHd/Y1XEta78XOwzEbRgq/UpU2
        A73VJLFqdMTxta2mKEIuA4xhXip9HWuId1knbAKvRkldwoW/HCUVhiDtojltIj8JcsLhWqCrMVJVu
        TWggv/tZBG2rywCZT9hxTZ1KWViMWFeX+/1jN8Q4GJNcQl/5tO1GpHlomoV7+s5pg4/GoXkBAHxXl
        N9bvOBR1/3BgkmHsIoiihX/L2LKkryJc3oI7y7muTeVt4v66HZE/jkji3cbb6myWrMgnKFX/EW0HI
        3FYEGvf4D5QnGxvF83oZCyFuAF/SKnjGgp9x4wtd8xSoAh69Cgmt+1sg259JZHpXkc0NkMJbJafpJ
        P8zwFb2Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVt8s-0006xU-8j; Fri, 23 Oct 2020 09:13:46 +0000
Date:   Fri, 23 Oct 2020 10:13:46 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        device-mapper development <dm-devel@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: [PATCH 0/2] block layer filter and block device snapshot module
Message-ID: <20201023091346.GA25115@infradead.org>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <71926887-5707-04a5-78a2-ffa2ee32bd68@suse.de>
 <20201021141044.GF20749@veeam.com>
 <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de>
 <20201022094402.GA21466@veeam.com>
 <BL0PR04MB6514AC1B1FF313E6A14D122CE71D0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201022135213.GB21466@veeam.com>
 <20201022151418.GR9832@magnolia>
 <CAMM=eLfO_L-ZzcGmpPpHroznnSOq_KEWignFoM09h7Am9yE83g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMM=eLfO_L-ZzcGmpPpHroznnSOq_KEWignFoM09h7Am9yE83g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:54:16PM -0400, Mike Snitzer wrote:
> On Thu, Oct 22, 2020 at 11:14 AM Darrick J. Wong
> > Stupid question: Why don't you change the block layer to make it
> > possible to insert device mapper devices after the blockdev has been set
> > up?
> 
> Not a stupid question.  Definitely something that us DM developers
> have wanted to do for a while.  Devil is in the details but it is the
> right way forward.
> 

Yes, I think that is the right thing to do.  And I don't think it should
be all that hard.  All we'd need in the I/O path is something like the
pseudo-patch below, which will allow the interposer driver to resubmit
bios using submit_bio_noacct as long as the driver sets BIO_INTERPOSED.

diff --git a/block/blk-core.c b/block/blk-core.c
index ac00d2fa4eb48d..3f6f1eb565e0a8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1051,6 +1051,9 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
+	if (blk_has_interposer(bio->bi_disk) &&
+	    !(bio->bi_flags & BIO_INTERPOSED))
+		return __submit_bio_interposed(bio);
 	if (!bio->bi_disk->fops->submit_bio)
 		return __submit_bio_noacct_mq(bio);
 	return __submit_bio_noacct(bio);
