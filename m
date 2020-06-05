Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328CC1EF85C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 14:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFEMwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFEMwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:52:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47250C08C5C3;
        Fri,  5 Jun 2020 05:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=24/Ag3uRPr1ITptA3jwtdwHGaOLUrNVpE3X6iUn5kfE=; b=AugcbZzon+RFrMEeFO0RC1Yqez
        uTq4ufZl332eqt4beOCHqtMeoA47j6DPIIivvaZGFtKJN6kpAqueQNdh6ucIzEHPsVDB2QDEnTp3d
        xvH4kmFr5qjtVjcO4oiBe4zmQH8dTsTEq6siNP6dYs8DXc+GuB5Mo3MqdoRSYuKDHajXPPLb4eXIJ
        eQkGGVmZKWBxUDBWd/cEcQx/HFALw5Da28p2Pd8DJFH6p07yjOaKL3EfSNYvA2q7WbNb8v6R2rT7h
        hkRhyte/bcd2KmYbH8DmbzrrOt7iD1F5n5y1e46ChM/7jF1JjfA8InZvfJvJsF4fZdizMOojInbuk
        vpPOFfdw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhBpR-0008Bp-SJ; Fri, 05 Jun 2020 12:52:09 +0000
Date:   Fri, 5 Jun 2020 05:52:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Yan <yanaijie@huawei.com>, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Subject: Re: block: Fix use-after-free in blkdev_get()
Message-ID: <20200605125209.GG19604@bombadil.infradead.org>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
 <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111039.GL22511@kadam>
 <63e57552-ab95-7bb4-b4f1-70a307b6381d@web.de>
 <20200605114208.GC19604@bombadil.infradead.org>
 <a050788f-5875-0115-af31-692fd6bf3a88@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a050788f-5875-0115-af31-692fd6bf3a88@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 02:47:00PM +0200, Markus Elfring wrote:
> >> Some developers found parts of my reviews helpful, didn't they?
> >
> > Overall you are a net negative to kernel development.
> 
> Which concrete items do you like less here?

Your feedback is unhelpful and you show no signs of changing it in
response to the people who are telling you that it's unhelpful.

> > Please change how you contribute.
> 
> I am curious to find the details out which might hinder progress
> in desirable directions (according to your views)?

Become an expert at something.  You seem to know about a millimetre deep
across many hectares.  Learn something deeply, then your opinion about
it will be meaningful.
