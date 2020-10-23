Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC99D296D46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 13:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462666AbgJWLD1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 07:03:27 -0400
Received: from mx4.veeam.com ([104.41.138.86]:52752 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462618AbgJWLD0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:03:26 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 6D9A8887F2;
        Fri, 23 Oct 2020 14:03:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1603451002; bh=65sH+UMPTiYCb05Btrrm4bWQp8NDibtw9NY4NHi6CiU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=FVRYdNY4iU3fryanL+UcAz/hDXzgEbgZP/dN7KMYRZ/my5KPzb1LupgLfz5nx0rts
         d6uwIFh++QA1slMQ0phsgOo/Dqs+ABXRfXgHxjCpuKrD2YULI2KOxQ3cjxpTiFcOZN
         rqp2382d6jWDTvDYgPIp+o9hPZuHB2UraC1JzjNI=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Fri, 23 Oct 2020
 13:03:20 +0200
Date:   Fri, 23 Oct 2020 14:04:07 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Damien Le Moal" <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
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
Message-ID: <20201023110407.GA23020@veeam.com>
References: <71926887-5707-04a5-78a2-ffa2ee32bd68@suse.de>
 <20201021141044.GF20749@veeam.com>
 <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de>
 <20201022094402.GA21466@veeam.com>
 <BL0PR04MB6514AC1B1FF313E6A14D122CE71D0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201022135213.GB21466@veeam.com>
 <20201022151418.GR9832@magnolia>
 <CAMM=eLfO_L-ZzcGmpPpHroznnSOq_KEWignFoM09h7Am9yE83g@mail.gmail.com>
 <20201023091346.GA25115@infradead.org>
 <d50062cd-929d-c8ff-5851-4e1d517dc4cb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <d50062cd-929d-c8ff-5851-4e1d517dc4cb@suse.de>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A677764
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 10/23/2020 13:31, Hannes Reinecke wrote:
> On 10/23/20 11:13 AM, hch@infradead.org wrote:
> > On Thu, Oct 22, 2020 at 01:54:16PM -0400, Mike Snitzer wrote:
> >> On Thu, Oct 22, 2020 at 11:14 AM Darrick J. Wong
> >>> Stupid question: Why don't you change the block layer to make it
> >>> possible to insert device mapper devices after the blockdev has been set
> >>> up?
> >>
> >> Not a stupid question.  Definitely something that us DM developers
> >> have wanted to do for a while.  Devil is in the details but it is the
> >> right way forward.
> >>
> > 
> > Yes, I think that is the right thing to do.  And I don't think it should
> > be all that hard.  All we'd need in the I/O path is something like the
> > pseudo-patch below, which will allow the interposer driver to resubmit
> > bios using submit_bio_noacct as long as the driver sets BIO_INTERPOSED.
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index ac00d2fa4eb48d..3f6f1eb565e0a8 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1051,6 +1051,9 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
> >   		return BLK_QC_T_NONE;
> >   	}
> >   
> > +	if (blk_has_interposer(bio->bi_disk) &&
> > +	    !(bio->bi_flags & BIO_INTERPOSED))
> > +		return __submit_bio_interposed(bio);
> >   	if (!bio->bi_disk->fops->submit_bio)
> >   		return __submit_bio_noacct_mq(bio);
> >   	return __submit_bio_noacct(bio);
> > 

It`s will be great! Approximately this interception capability is not
enough now.

> My thoughts went more into the direction of hooking into ->submit_bio, 
> seeing that it's a NULL pointer for most (all?) block drivers.
> 
> But sure, I'll check how the interposer approach would turn out.

If anyone will do the patch blk-interposer, please add me to CC.
I will try to offer my module that will use blk-interposer.

-- 
Sergei Shtepa
Veeam Software developer.
