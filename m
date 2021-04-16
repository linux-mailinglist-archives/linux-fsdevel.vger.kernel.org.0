Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D754362523
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhDPQHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 12:07:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:47520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235629AbhDPQHI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:07:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA6BCB137;
        Fri, 16 Apr 2021 16:06:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9799DA790; Fri, 16 Apr 2021 18:04:25 +0200 (CEST)
Date:   Fri, 16 Apr 2021 18:04:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Karel Zak <kzak@redhat.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, util-linux@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 3/3] blkid: support zone reset for wipefs
Message-ID: <20210416160425.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Karel Zak <kzak@redhat.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, util-linux@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-4-naohiro.aota@wdc.com>
 <20210414135742.qayizmwjck5dx377@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414135742.qayizmwjck5dx377@ws.net.home>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 03:57:42PM +0200, Karel Zak wrote:
> On Wed, Apr 14, 2021 at 10:33:39AM +0900, Naohiro Aota wrote:
> >  /**
> >   * blkid_do_wipe:
> >   * @pr: prober
> > @@ -1267,6 +1310,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
> >  	const char *off = NULL;
> >  	size_t len = 0;
> >  	uint64_t offset, magoff;
> > +	bool conventional;
> 
> BTW, nowhere in libblkid we use "bool". It would be probably better to include
> <stdbool.h> to blkidP.h.

Pulling a whole new header just for one local variable that can be int
seems too much.
