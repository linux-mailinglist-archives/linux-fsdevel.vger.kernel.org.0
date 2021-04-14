Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0EB35F73B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350217AbhDNPJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 11:09:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21213 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349964AbhDNPJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618412947; x=1649948947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1mQzr+ZGrDrLyOxw5V0H8xW7Lo9+NLNMHswRDvEeVY=;
  b=G0HfuLw4bRPodNDoZv76WmI1QWvRWw0+ZuSGJuOhu41GS1o7ySfJ26hg
   KP/6eaCqKmUnaifv/HD24twN05mcKzxUp4bZI9HP0WHUAuTVH/gPWkAAg
   jnIFr4oahY7HGPDxgN/xz6vNHOn/hZ0HyRQnr0pDbJ1v9lCZgOZKs0xNq
   aN27CS8oTtkT07SV56qIblhkZm/tK/eDDIViqEF+PKpE4xu9EDbn4olT6
   LpF5I0izwXPhhO3Gg6BNGcmIJR+7gKWiXciECtlFvLQL5qGYYLHFAB8c6
   sWLzgVTaH7gC8w99FxYYPsT06b9EqUmSB+3BW8CnNcBYRMCd176POWEqX
   Q==;
IronPort-SDR: eB3+Y1BbVyjxS1nN1jtj3muzh4jfgUj37A792XKtFZ25hq7ENjWj29g3MaUFPNwfhWMZgpZv25
 FYSJigTHnh38aCCKU87lhfa4PTaNVdReHtV9RfxjLbDWr8W54O/XgANyeHqp1UL6wdKvE6aqPM
 f0DxmwcBOOibjBlNtKnOY/QuwWtrdaEr5vzchuavQoNbRvY+3J3cy5VBqe+X2hnJUFvGUKQOEh
 9EQV0pYXsaybV4qMbdw6xu6I5Bkj+XaLnkXEc5Pm2GaK2bkUCqQvpV5wfqF3iSUjzMI315Pnt1
 fQ4=
X-IronPort-AV: E=Sophos;i="5.82,222,1613404800"; 
   d="scan'208";a="164307041"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 23:08:54 +0800
IronPort-SDR: x9jxu1lww1UBG9+eXeNaqGFVJNQhYXQz7VepursbVBDpViVV8a28iXsdMw+zaJQRg1n3ZqE8tE
 29a5kbotGl2fOZPFle4Mtrn5naK5z12uRfZF/1OG556wGqWIPMITQohnO/knVJ2BUhmdYiMVt4
 y6KqUWhS5m/sPkI3SR/kHhJn0g2OeN8FVS7tGnjo2YIyj9IRzFoMDCawVVMxBh2NUPFEd3WOQ7
 b3swVT/jrdqBF6tLg1LkP+n6nLSPeyHRxqi5T+89AbQdQes9R+GigepyuSoyWpB9AvnfYwpVma
 18cZZF0lrionU8Vy+Zp8IK57
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 07:48:13 -0700
IronPort-SDR: nP1i7DQKlUp9l7oAB4yRFE4vWNtIsRCgtxLM4IJOvFwycoJZvXlESDomgGmPl7ig7PJjutRqRt
 FETGOLhILp/cwjSNDDuB2q0ofVHZpjt9xowmdBJwyisYhnsUe5sDmVoaj9WKU4x9zce37qp5e+
 RzxiMeRKOYo5IAxUzwmH5mNxn4O6aoEtf01QuPUvCEcgSgtorzeZn0ypYXqI9NI0htl0SEK65V
 vL7CMQeqomycm/VOY4+yV8GKSmcEWsDQb63LihW7h/X0huj/OiAa0GmbZ6EM6D1UT0VwjW5QmJ
 26I=
WDCIronportException: Internal
Received: from ind006838.ad.shared (HELO naota-xeon) ([10.225.53.197])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 08:08:50 -0700
Date:   Thu, 15 Apr 2021 00:08:48 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/3] blkid: add magic and probing for zoned btrfs
Message-ID: <20210414150848.3ylrbzth7yjvgxgi@naota-xeon>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-3-naohiro.aota@wdc.com>
 <20210414134708.t475gnqa7bor7bc6@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414134708.t475gnqa7bor7bc6@ws.net.home>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 03:47:08PM +0200, Karel Zak wrote:
> On Wed, Apr 14, 2021 at 10:33:38AM +0900, Naohiro Aota wrote:
> > +#define ASSERT(x) assert(x)
> 
> Really? ;-)
> 
> > +typedef uint64_t u64;
> > +typedef uint64_t sector_t;
> > +typedef uint8_t u8;
> 
> I do not see a reason for u64 and u8 here.

Yep, these are here just to make it easy to copy the code from
kernel. But this code won't change so much, so I can drop these.

> > +
> > +#ifdef HAVE_LINUX_BLKZONED_H
> > +static int sb_write_pointer(int fd, struct blk_zone *zones, u64 *wp_ret)
> > +{
> > +	bool empty[BTRFS_NR_SB_LOG_ZONES];
> > +	bool full[BTRFS_NR_SB_LOG_ZONES];
> > +	sector_t sector;
> > +
> > +	ASSERT(zones[0].type != BLK_ZONE_TYPE_CONVENTIONAL &&
> > +	       zones[1].type != BLK_ZONE_TYPE_CONVENTIONAL);
> 
> assert()

I will use it.

>  ...
> > +		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> > +			u64 bytenr;
> > +
> > +			bytenr = ((zones[i].start + zones[i].len)
> > +				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
> > +
> > +			ret = pread64(fd, buf[i], BTRFS_SUPER_INFO_SIZE,
> > +				      bytenr);
> 
>  please, use  
> 
>      ptr = blkid_probe_get_buffer(pr, BTRFS_SUPER_INFO_SIZE, bytenr);
> 
>  the library will care about the buffer and reuse it. It's also
>  important to keep blkid_do_wipe() usable.

Sure. I'll use it.

> > +			if (ret != BTRFS_SUPER_INFO_SIZE)
> > +				return -EIO;
> > +			super[i] = (struct btrfs_super_block *)&buf[i];
> 
>   super[i] = (struct btrfs_super_block *) ptr;
> 
> > +		}
> > +
> > +		if (super[0]->generation > super[1]->generation)
> > +			sector = zones[1].start;
> > +		else
> > +			sector = zones[0].start;
> > +	} else if (!full[0] && (empty[1] || full[1])) {
> > +		sector = zones[0].wp;
> > +	} else if (full[0]) {
> > +		sector = zones[1].wp;
> > +	} else {
> > +		return -EUCLEAN;
> > +	}
> > +	*wp_ret = sector << SECTOR_SHIFT;
> > +	return 0;
> > +}
> > +
> > +static int sb_log_offset(blkid_probe pr, uint64_t *bytenr_ret)
> > +{
> > +	uint32_t zone_num = 0;
> > +	uint32_t zone_size_sector;
> > +	struct blk_zone_report *rep;
> > +	struct blk_zone *zones;
> > +	size_t rep_size;
> > +	int ret;
> > +	uint64_t wp;
> > +
> > +	zone_size_sector = pr->zone_size >> SECTOR_SHIFT;
> > +
> > +	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone) * 2;
> > +	rep = malloc(rep_size);
> > +	if (!rep)
> > +		return -errno;
> > +
> > +	memset(rep, 0, rep_size);
> > +	rep->sector = zone_num * zone_size_sector;
> > +	rep->nr_zones = 2;
> 
> what about to add to lib/blkdev.c a new function:
> 
>    struct blk_zone_report *blkdev_get_zonereport(int fd, uint64 sector, int nzones);
> 
> and call this function from your sb_log_offset() as well as from blkid_do_wipe()?
> 
> Anyway, calloc() is better than malloc()+memset().

Indeed. I will do so.

> > +	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
> > +		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
> > +		ret = 0;
> > +		goto out;
> > +	} else if (zones[1].type == BLK_ZONE_TYPE_CONVENTIONAL) {
> > +		*bytenr_ret = zones[1].start << SECTOR_SHIFT;
> > +		ret = 0;
> > +		goto out;
> > +	}
> 
> what about:
> 
>  for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
>    if (zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
>       *bytenr_ret = zones[i].start << SECTOR_SHIFT;
>       ret = 0;
>       goto out;
>    }
>  }

Yes, this looks cleaner. Thanks.

> 
> 
> 
>  Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 
