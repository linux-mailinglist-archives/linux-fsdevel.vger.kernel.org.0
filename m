Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B528229464
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 11:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgGVJEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 05:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:57230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729894AbgGVJEy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:04:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA40FABD2;
        Wed, 22 Jul 2020 09:04:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8AA96DA70B; Wed, 22 Jul 2020 11:04:26 +0200 (CEST)
Date:   Wed, 22 Jul 2020 11:04:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@tron.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
Message-ID: <20200722090426.GQ3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>, linux-mtd@lists.infradead.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@tron.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
References: <20200722062552.212200-1-hch@lst.de>
 <20200722062552.212200-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722062552.212200-5-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 08:25:42AM +0200, Christoph Hellwig wrote:
> Set up a readahead size by default, as very few users have a good
> reason to change it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

For the btrfs bits

>  fs/btrfs/disk-io.c    | 1 -

Acked-by: David Sterba <dsterba@suse.com>
