Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B58296D65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462803AbgJWLNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462757AbgJWLNV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:13:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23D3C0613CE;
        Fri, 23 Oct 2020 04:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L5+0ZOmshEWGRjYQbZQfyKQ/jkbENBN4GZDIbl9am3E=; b=Ie9QJ2wqfW+8LSUdxH/tSg8hAa
        8C2mIC2GrZ8PI1MXKvN9BsfRilt8jYdEkGxyFOfAVDvy6Td3hQ9uBq6ez/h9E2ABxawDSJiOLHdJI
        LsZGNhEw0cC/ka2DrAdzFFZOie+px6AWbWK1jzCBTuyNuGJIbDc7Ua0tb1SKyYrwGa4R7W5BG1jO8
        lxiEoi4nFgMohtN2CS2nX2Xcq7PIeN+Dvq+4Kp4WllzbqLpZqVP7tQsfMfzuy3e8gjTCMhW6FI+3k
        4bz8a/7pem0jnI9l+DNScgPNKZTBfOKlV0f3hYQ2enHlqjYNexs64ubBaoTEtoMg6kzVaSt0292L4
        yhh0jICQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVv09-0005sV-5b; Fri, 23 Oct 2020 11:12:53 +0000
Date:   Fri, 23 Oct 2020 12:12:53 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        device-mapper development <dm-devel@redhat.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "steve@sk2.org" <steve@sk2.org>,
        "osandov@fb.com" <osandov@fb.com>,
        Alasdair G Kergon <agk@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Sergei Shtepa <sergei.shtepa@veeam.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [dm-devel] [PATCH 0/2] block layer filter and block device
 snapshot module
Message-ID: <20201023111253.GA22468@infradead.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d50062cd-929d-c8ff-5851-4e1d517dc4cb@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 23, 2020 at 12:31:05PM +0200, Hannes Reinecke wrote:
> My thoughts went more into the direction of hooking into ->submit_bio,
> seeing that it's a NULL pointer for most (all?) block drivers.
> 
> But sure, I'll check how the interposer approach would turn out.

submit_bio is owned by the underlying device, and for a good reason
stored in a const struct..
