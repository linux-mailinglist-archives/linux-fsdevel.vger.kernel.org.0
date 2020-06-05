Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2A1EFC50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgFEPPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgFEPPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:15:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75891C08C5C2;
        Fri,  5 Jun 2020 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jl1Kn7GkJvC8qt6XzZZc68xpV5QCZpDybEJ2sphFKBM=; b=idI/RYE7F0Cba2L9/XA4faqob+
        wIRJs6yt+SJSWP11K+dKzwOS2Rwzwp4QmJflsOmGx77PK4fdW65gCHngH69/bhszljtKbQjpe1MqN
        0OuA+cRlqw9r+fTTxlP1Q4rrjbaFWfTUqIXFU4yrMX6z1APoGNm3VE0OTW+bVKs3xX9YrmgIoqn+d
        f7BNlJvnVlpb56aeD9zvOtFdM72pQBe9dj/8SBO9wjWm1v5XnR4HoRNwb9xK8NsS60XJafdvrUxwW
        8Dp99igLo6CTucwzu5e2e9i+WGhJUEc4LGzdET9kVdL3xh6vIC55BCUqmBmniZVbXMWvXE1lLDv9Q
        FXnY8wTw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhE4H-00024h-BF; Fri, 05 Jun 2020 15:15:37 +0000
Date:   Fri, 5 Jun 2020 08:15:37 -0700
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
Message-ID: <20200605151537.GH19604@bombadil.infradead.org>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
 <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111039.GL22511@kadam>
 <63e57552-ab95-7bb4-b4f1-70a307b6381d@web.de>
 <20200605114208.GC19604@bombadil.infradead.org>
 <a050788f-5875-0115-af31-692fd6bf3a88@web.de>
 <20200605125209.GG19604@bombadil.infradead.org>
 <366e055b-6a00-662e-2e03-f72053f67ae6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366e055b-6a00-662e-2e03-f72053f67ae6@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 03:12:08PM +0200, Markus Elfring wrote:
> > Your feedback is unhelpful
> 
> Do you find proposed spelling corrections useful?

To commit messages?  No.

> > and you show no signs of changing it in response to the people
> > who are telling you that it's unhelpful.
> 
> Other adjustments can occasionally be more challenging
> besides the usual communication challenges.

I think I'm going to ask Greg if I can borrow his bot.

Many hackers start out by just making spelling fixes to code.  And that's
fine, often they progress to more substantial contributions.  You do not
seem to progress, and making spelling corrections to changelog messages
is a level of nitpicking that just isn't helpful.
