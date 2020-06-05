Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089661EF6CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 13:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFELv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgFELv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:51:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B34C08C5C2;
        Fri,  5 Jun 2020 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XMIUr7QQnBAMG/5n56k4P+c+DXhD2JhaWi3/bfA8kU0=; b=AmUizXlhfS4T140zZqpI0Yfzmp
        JH+u5PKoAX0bZNDzeRNaDmdLeSyuWIqPb6JcttVdRebusPaSMCGXAO3ToV7RPVg/HZ8MP/kS67eqo
        kYB3rPYKUEZGEIDuf8DiKRK1a5VccmhsJ8F/zzVr2cHJpIt7HBBhhJMzyd1dLNSWULfDA9bHUwuqt
        8g6OVELcIR54uJXNNcBVbTGkB5bXn3EeBDAN2yJ/uNH5nnJ54pqYaKUycRvbPtgDjc/wEKzv7Z8it
        xlTdbDJ0TpH+VIUp1fuZSWUSMhatsHuMk5QF2Q/ztmb8Az/2zu2rLnFN2AyMP+JelN/eCnY2hOc7N
        l2/Njn6A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhAtC-0001E0-BT; Fri, 05 Jun 2020 11:51:58 +0000
Date:   Fri, 5 Jun 2020 04:51:58 -0700
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
Message-ID: <20200605115158.GD19604@bombadil.infradead.org>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
 <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111049.GA19604@bombadil.infradead.org>
 <b6c8ebd7-ccd3-2a94-05b2-7b92a30ec8a9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c8ebd7-ccd3-2a94-05b2-7b92a30ec8a9@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 01:48:43PM +0200, Markus Elfring wrote:
> >> I am trying to contribute a bit of patch review as usual.
> >
> > Please stop criticising people's commit messages.  Your suggestions
> > are usually not improvements.
> 
> The details can vary also for my suggestions.
> Would you point any more disagreemnents out on concrete items?

That's exactly the problem with many of your comments.  They're
vague to the point of unintelligibility.

> > But refcount -> reference count is not particularly interesting.
> 
> Can a wording clarification become helpful also for this issue?

This is a great example.  I have no idea what this sentence means.
I speak some German; how would you say this in German?
