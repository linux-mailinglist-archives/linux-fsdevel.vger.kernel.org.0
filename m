Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A164294BE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 13:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442039AbgJULo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439593AbgJULoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:44:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B383EC0613CE;
        Wed, 21 Oct 2020 04:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8zzsgfeCz+OvMf8zlEZunmz93FbN8Y4rF8K/uFWA5ks=; b=QGd9o9rBa2iW7Cyr2v7NAiwDn8
        0Et+wmPKEP4cW4o7FgHtSsDY6es0NhSFUbxGZAbLK59bexfbkGxsMpCbQen6TaoNpLDcdQsevt0VU
        H4AGXhHPvO3YZr+wsmik1x6wQTgzJ5eGaa5IGNq/lqRd7ErRe8XAlFx4DV0uaUX92bZH8/aXToY7O
        k2JfovW8cwvr2tg6YmnVsNfvVSe0yuwilN3JKm50avUs+I2c2xhL+LbswIPmKm3d7oxIaYGVOxtMs
        4A1gqTSPAVbV5JaQzGfjKC2b6vexUcL6Vl6BoDkedhL5rc5p+SaPBT23PJ2QUhYzC3R+IwUev6MWW
        a6JfcM+A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVCXm-0002kB-L9; Wed, 21 Oct 2020 11:44:38 +0000
Date:   Wed, 21 Oct 2020 12:44:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] Block layer filter - second version
Message-ID: <20201021114438.GK20115@casper.infradead.org>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
 <BL0PR04MB65141320C7BF75B7142CA30CE71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65141320C7BF75B7142CA30CE71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 09:21:36AM +0000, Damien Le Moal wrote:
> > + * submit_bio_direct - submit a bio to the block device layer for I/O
> > + * bypass filter.
> > + * @bio:  The bio describing the location in memory and on the device.
> >   *
> > + * Description:

You don't need this line.

> > + *    This is a version of submit_bio() that shall only be used for I/O
> > + *    that cannot be intercepted by block layer filters.
> > + *    All file systems and other upper level users of the block layer
> > + *    should use submit_bio() instead.
> > + *    Use this function to access the swap partition and directly access
> > + *    the block device file.

I don't understand why O_DIRECT gets to bypass the block filter.  Nor do
I understand why anybody would place a block filter on the swap device.
But if somebody did place a filter on the swap device, why should swap
be able to bypass the filter?

