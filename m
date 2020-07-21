Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F92277D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 07:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgGUFAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 01:00:52 -0400
Received: from verein.lst.de ([213.95.11.211]:50467 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgGUFAw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:00:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 42A716736F; Tue, 21 Jul 2020 07:00:48 +0200 (CEST)
Date:   Tue, 21 Jul 2020 07:00:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-raid@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Song Liu <song@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        drbd-dev@lists.linbit.com
Subject: Re: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
Message-ID: <20200721050047.GA9707@lst.de>
References: <20200720075148.172156-1-hch@lst.de> <20200720075148.172156-5-hch@lst.de> <CAFLxGvxNHGEOrj6nKTtDeiU+Rx4xv_6asjSQYcFWXhk5m=1cBA@mail.gmail.com> <20200720120734.GA29061@lst.de> <2827a5dbd94bc5c2c1706a6074d9a9a32a590feb.camel@gmail.com> <CAFLxGvyxtYnJ5UdD18uNA97zQaDB8-Wv8MHQn2g9GYD74v7cTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvyxtYnJ5UdD18uNA97zQaDB8-Wv8MHQn2g9GYD74v7cTg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 11:27:57PM +0200, Richard Weinberger wrote:
> On Mon, Jul 20, 2020 at 2:37 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
> >
> > On Mon, 2020-07-20 at 14:07 +0200, Christoph Hellwig wrote:
> > > What about jffs2 and blk2mtd raw block devices?
> 
> I don't worry much about blk2mtd.
> 
> > If my memory serves me correctly JFFS2 did not mind readahead.
> 
> This covers my knowledge too.
> I fear enabling readahead on JFFS2 will cause performance issues, this
> filesystem
> is mostly used on small and slow NOR devices.

I'm going to wait for Hans for feedback on vboxsf, but in doubt I'll
ust add a prep patch or fold for this one to explicit set ra_pages to 0
with a comment then.
