Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C8136AA68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 03:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhDZBjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 21:39:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48463 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhDZBjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619401109; x=1650937109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsRGEC8Z1J5o3VJ9uLNCdI2+6zJrkvNmHiVsJ/REU18=;
  b=JXu3SiI75Q+jjCUfoz4Y10df2twxaF0BcwB/9lr3/JK46Der2Zpa6F6I
   KtgU9VnvSo1MNpkeHlR7FphCLNNL7zy5wT6SC1I3eFRT08/KJzgr6RxK6
   wGTo/IIvTav6yAFtU7c70QkXC7IBw22XcPpNuDdHEaHAptkKyhWo/9TAy
   p3qhMGFFFgS3t8LxPZ2IVsoqQqlPKaWzg9UTAZQV/S194/w61R8bxB42k
   ddu3xfw/e8C/qZAgRVOML7B8Ozc1RajJuVPCZEIxD+4mPp51CGaHUOzUI
   RZO5dYHPyknd65pdu9jk8kmz5oS6B2ZVqn47kcRF4gKLmgKXXibcZMrAb
   g==;
IronPort-SDR: ZQSkgS4GaWfXAhan/BubqJSYUjwDH5qHXs59xGyRSVwuI60BKFTzZAxSmxa6oaHbDWsdyuDwMR
 UmFEXJRDrQyUy5aK8c05ZS5BrilX221F1pltIsjqt82gxlHGwoZqQghj86T+HX8OIjGtCRNSt6
 E/jdtz4ZUDkXvGiUl8yapvIwanrLExl+OFzUgzfillAuvk8bTM/IextxgcVOLoH9RlLDBlAojq
 OCvccAhuDxiQ2AFmopd7A1IE2hJYUhraLEdd5bFBJ7Nh04cRB7TcpgWwhg/TUGhK+rnwZQ1IYs
 SeI=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="166230282"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 09:38:29 +0800
IronPort-SDR: aNPK10zEvpLarkjV6WlWhHALE31diD7ickaj+l6C+HszXF19XNssmj8hmicH4xrtVRNWBIl4I9
 sOGBn3b7XVIcZXdTwOasTy/Q3rHccQDtK3vY3Bw6QDz/dgz4I0d2vALjfUyOiOnepeiAirVRnl
 ne1ium39y+kVyuYxyv7SjusTJpS6Qtv/bPfD1paKNtzMZnpK4MYetNxTIrKUH+RVB7Rq447wQt
 8L2otzKeqb7D+snbfDa+VUM+SKoYcesLo+97Sijpu6ZzQrwH6hKaN446kvl97yQg5nxyO7+/Ta
 oleDblkJzful/deOoF3mqrpW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 18:17:26 -0700
IronPort-SDR: 7KfzHh8m46zkU61gqkpQPm6XtgRJjhpOp1AzyquiLQ3oI9oqUoqSsSjqOPTqjheBMg9kJYTTlK
 z+GwpIYE5ZlGvKp9NRUk+MKq32tQVQVGPPV2R+5cdG+PFc3xtc9/50KunuAqcM3CaOkh/J/QTw
 KOO8IxvYIdzvVa3m36e/KSUCBjhr+C/TEaE+AEHCQl70KNl4VTNdiEOG6CTPSqWxOKuE8m1RV2
 0AlIHqToRKvcYDa8xZK9TJNCqdDsFJ3y0R+0m28ggduEcCDa5KVYqJ8eIVmuBQH5B42f4grrr9
 jEU=
WDCIronportException: Internal
Received: from 3sdmw33.ad.shared (HELO naota-xeon) ([10.225.48.32])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 18:38:29 -0700
Date:   Mon, 26 Apr 2021 10:38:27 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/3] blkid: add magic and probing for zoned btrfs
Message-ID: <20210426013827.rijm2p2gba7wonlx@naota-xeon>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-3-naohiro.aota@wdc.com>
 <20210416155241.GY7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416155241.GY7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:52:41PM +0200, David Sterba wrote:
> On Wed, Apr 14, 2021 at 10:33:38AM +0900, Naohiro Aota wrote:
> > It also supports temporary magic ("!BHRfS_M") in zone #0. The mkfs.btrfs
> > first writes the temporary superblock to the zone during the mkfs process.
> > It will survive there until the zones are filled up and reset. So, we also
> > need to detect this temporary magic.
> 
> > +	  /*
> > +	   * For zoned btrfs, we also need to detect a temporary superblock
> > +	   * at zone #0. Mkfs.btrfs creates it in the initialize process.
> > +	   * It persits until both zones are filled up then reset.
> > +	   */
> > +	  { .magic = "!BHRfS_M", .len = 8, .sboff = 0x40,
> > +	    .is_zoned = 1, .zonenum = 0, .kboff_inzone = 0 },
> 
> Should we rather reset the zone twice so the initial superblock does not
> have the temporary signature?

OK, sure. I'll modify the mkfs.btrfs to reset the superblock log zone
before writing out final superblock.

> For the primary superblock at offset 64K and as a fallback the signature
> should be valid for detection purposes (ie. not necessarily to get the
> latest superblock).
