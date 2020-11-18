Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742642B7DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgKRMu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 07:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRMu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:50:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC3C0613D4;
        Wed, 18 Nov 2020 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HSUzUyKTU/QS1kBHnPfjuFObEMrIAG6LjkrRvHzZF6g=; b=mpIozshx6aJo2QoKkj03Sj4lqv
        eATDwM5+pyAtrhOHDUVD77b65789cHxYoWQANXOTIXt7qV/KGnbJ83izmUrP2MQ/2l3mBwDw4mdoW
        Y5kbGddaa/QKi7M9RwOUo9SSjzPgbiiV1208faqzs+g6W2VUCPYuQiOn803XJb/o/nettEMMrZhNr
        200kJLaXlHseKJHdT2eZ+hl3ThDl9guSn9OMId2L1GwrdkO42exGupejK69RQO+t1ajwPpeevqxwt
        f3XgZhPQ7s2PLOBKSeN45qsCk6Fy+tmNaH6Rrigl3ju4Z9SvL4rjgUhEPeklvtVToHeHs9jg6H9jx
        JzIvniVg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfMuz-0006LA-DU; Wed, 18 Nov 2020 12:50:37 +0000
Date:   Wed, 18 Nov 2020 12:50:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: merge struct block_device and struct hd_struct
Message-ID: <20201118125037.GE29991@casper.infradead.org>
References: <20201118084800.2339180-1-hch@lst.de>
 <22ca5396-0253-f286-9eab-d417b2e0b3ad@suse.com>
 <20201118085804.GA20384@lst.de>
 <1ded2079-f1be-6d5d-01df-65754447df78@suse.com>
 <X7Tky/6dDN8+DrU7@kroah.com>
 <61044f85-cd41-87b5-3f41-36e3dffb6f2a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61044f85-cd41-87b5-3f41-36e3dffb6f2a@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:23:51AM +0100, Jan Beulich wrote:
> On 18.11.2020 10:09, Greg KH wrote:
> > On Wed, Nov 18, 2020 at 10:04:04AM +0100, Jan Beulich wrote:
> >> On 18.11.2020 09:58, Christoph Hellwig wrote:
> >>> On Wed, Nov 18, 2020 at 09:56:11AM +0100, Jan Beulich wrote:
> >>>> since this isn't the first series from you recently spamming
> >>>> xen-devel, may I ask that you don't Cc entire series to lists
> >>>> which are involved with perhaps just one out of the many patches?
> >>>> IMO Cc lists should be compiled on a per-patch basis; the cover
> >>>> letter may of course be sent to the union of all of them.
> >>>
> >>> No way.  Individual CCs are completely broken as they don't provide
> >>> the reviewer a context.
> >>
> >> That's the view of some people, but not all. Context can be easily
> >> established by those who care going to one of the many archives on
> >> which the entire series lands. Getting spammed, however, can't be
> >> avoided by the dozens or hundreds of list subscribers.
> > 
> > kernel patches are never "spam", sorry, but for developers to try to
> > determine which lists/maintainers want to see the whole series and which
> > do not is impossible.
> > 
> > Patches in a series are easily deleted from sane mail clients with a
> > single click/keystroke all at once, they aren't a problem that needs to
> > be reduced in volume.
> 
> This doesn't scale, neither in the dimension of recipients nor in
> the dimension of possible sources of such series.
> 
> While it may seem small, it's also a waste of resources to have mails
> sent to hundreds of even thousands of people. So while from a
> technical content perspective I surely agree with you saying 'kernel
> patches are never "spam"', they still are from the perspective of
> what "spam mail" originally means: Mail the recipients did not want
> to receive.

What doesn't scale is developers who only care about their tiny
sliver of Linux and don't stick their heads up from time to time and
look around.  This is an opportunity for people to become more involved
in the development of Linux as a whole, instead of just worrying about
their bit.  You're not "a Xen developer".  You're a Linux developer
whose current focus is on Xen.
