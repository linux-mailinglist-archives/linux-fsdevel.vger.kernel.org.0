Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4952731C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgIUSSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 14:18:45 -0400
Received: from verein.lst.de ([213.95.11.211]:41467 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgIUSSp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:18:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 259D968B02; Mon, 21 Sep 2020 20:18:42 +0200 (CEST)
Date:   Mon, 21 Sep 2020 20:18:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Coly Li <colyli@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 03/13] bcache: inherit the optimal I/O size
Message-ID: <20200921181841.GB2067@lst.de>
References: <20200921080734.452759-1-hch@lst.de> <20200921080734.452759-4-hch@lst.de> <b547a1b6-ab03-0520-012d-86d112c83d92@suse.de> <20200921140010.GA14672@lst.de> <5bcc52dc-ca8f-bbdd-69ef-4b6312e7994a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bcc52dc-ca8f-bbdd-69ef-4b6312e7994a@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:09:48PM +0800, Coly Li wrote:
> I feel this is something should be fixed. Indeed I overlooked it until
> you point out the issue now.
> 
> The optimal request size and read ahead pages hint are necessary, but
> current initialization is simple. A better way might be dynamically
> setting them depends on the cache mode and some special configuration.
> 
> By your inspiration, I want to ACK your original patch although it
> doesn't work fine for all condition. Then we may know these two settings
> (ra_pages and queue_io_opt) should be improved for more situations. At
> lease for most part of the situations they provide proper hints.
> 
> How do you think of the above idea ?

Sounds like a plan.  I'd reall like to get this series in to get
some soaking before the end of the merge window, but we should still
have plenty of time for localized bcache updates.
