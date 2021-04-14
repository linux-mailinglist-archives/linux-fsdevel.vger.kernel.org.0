Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8807735EA57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 03:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbhDNBZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 21:25:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29621 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhDNBZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618363483; x=1649899483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lHWqtMyRbGs3rNdBtC4/dHF2eS83aOio02zWOLwP6ME=;
  b=lymyIcGyQZ5ttyLSVvvh4cHLmbgxCf02Z49XNmTzXDmQ/PeI4hds20M2
   jiuR7Olxgqdf/To+gaPrcyjc1/uSKrdRpPOw7I2q2u0ck4Zl3YPtwrHZt
   ld7+7ZmSXEXH+qFsMmuoFSYgug8p2aGGDdyJ2PAu/8gt0W+zomsUmkHUT
   cY9hPUzOQErqn4WxpFbAXkAzSW1EGzb1C8FRMrdfpngRZ08Muj4tRGMvH
   W8zaLY0WuOJIWKeqvyDS0aGKcoP6QoGRuzcWn+jLxF5aTLNXRdjIRkFVh
   WQtynEtBpxE1k03WgMgI//r4DjYNTRC6rIGaFYrma+7hbBBObtsrWoOWp
   A==;
IronPort-SDR: ac0ynA4AYQ2aEbLxC0Uhr9V8791DuvdgDivm5CWZ5/Y3KQan8loxx+lK2WSnCzQ/Wd67V7nv4g
 vUhYzCKUbUnrjwzKYvY2FiOEUYUOzN73R92OddxlfPIKCunXsnORwSTiz8NvNF8dxqdsCdmQq2
 Zpqmst+uNTr5qyTjjZ9CmOl4VU/spS7ZM1vrgSNq8Sl4Yy99e0xkrQyG2yZHBCTFFTgaWzUVmz
 E7GF+z/WJg3gUSOTmJivsRrEwdw4vjinu7M0THuxUCJpLsJbvXzhZhpHJrDQJ6o2xEqfVLSFOs
 PMk=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="164263917"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 09:24:02 +0800
IronPort-SDR: dfYx0br51MmtYUL3cHKzNKl3x5VPvfEmrOBHY2YtGBIN+aRYtjHyqhS3PcatV7QHqe96uB5FrK
 TBxVGBKrH6UXOtUGC+4cbt2L+u83bLY5JtD7F6Adyy659ul2r7dobWmNAgfyyiZb0omPaA2c1y
 3eADKZ0dhpk8ovH4xMCUmPszVVoByjElKes86LbQdtQDul9+5JK7ft2LpXVPCsNbZEIm6H8Twz
 mckWQmdR6Jo1b+kR5vfti7eKdLjHDSStN+T8oXy6FDiopwSByJRtT2o/QVe9u4OJYN6AA31THz
 xGhIC/jw+EDcMu18jUHsKRao
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:03:20 -0700
IronPort-SDR: KV504C4iUkLmNWQuzbvkbnqjsQF9nZSCXDu2/fk5OD9CLKXbCw1R51w06eZ7+w8ps+YQ6VxZ6u
 QCA/3FeZcKpjFADmqkJzBJzfRSFgKMMMS19UnXD6zWqsp/ZFTKp1XvYZo3z5H51rre6LrfRCTk
 FH+9MAfy+VSh5TfpQRP23Ix6ZXCEDm7bqzsLJD4Dd9Xx1pHuA6VMOTA+rGtK3uozptCB5MHakY
 Mio6z+065BZlh/MbcL3GGYdap5Vgui3b0K9Km6od5mroLBTHJ8MFIFSCPytLG0jO6dMQ+gKDDg
 cMk=
WDCIronportException: Internal
Received: from jpf004864.ad.shared (HELO naota-xeon) ([10.225.53.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:23:53 -0700
Date:   Wed, 14 Apr 2021 10:23:51 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 3/3] blkid: support zone reset for wipefs
Message-ID: <20210414012351.eejntj3ribpg6nmr@naota-xeon>
References: <20210413221051.2600455-1-naohiro.aota@wdc.com>
 <20210413221051.2600455-4-naohiro.aota@wdc.com>
 <BL0PR04MB65141A1374C49EC06DDCCBB9E74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65141A1374C49EC06DDCCBB9E74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:47:00PM +0000, Damien Le Moal wrote:
> On 2021/04/14 7:11, Naohiro Aota wrote:
> > We cannot overwrite superblock magic in a sequential required zone. So,
> > wipefs cannot work as it is. Instead, this commit implements the wiping by
> > zone resetting.
> > 
> > Zone resetting must be done only for a sequential write zone. This is
> > checked by is_conventional().
> > 
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  libblkid/src/probe.c | 65 ++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 59 insertions(+), 6 deletions(-)
> > 
> > diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
> > index 102766e57aa0..7454a14bdfe6 100644
> > --- a/libblkid/src/probe.c
> > +++ b/libblkid/src/probe.c
> > @@ -107,6 +107,7 @@
> >  #include <stdint.h>
> >  #include <stdarg.h>
> >  #include <limits.h>
> > +#include <stdbool.h>
> >  
> >  #include "blkidP.h"
> >  #include "all-io.h"
> > @@ -1225,6 +1226,40 @@ int blkid_do_probe(blkid_probe pr)
> >  	return rc;
> >  }
> >  
> > +static int is_conventional(blkid_probe pr, uint64_t offset)
> > +{
> > +	struct blk_zone_report *rep = NULL;
> > +	size_t rep_size;
> > +	bool conventional;
> > +	int ret;
> > +
> > +	if (!pr->zone_size)
> > +		return 1;
> > +
> > +	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone);
> > +	rep = malloc(rep_size);
> > +	if (!rep)
> > +		return -1;
> > +
> > +	memset(rep, 0, rep_size);
> 
> Use calloc() to get the zeroing done at the same time as allocation, may be ?

Will do.

> > +	rep->sector = (offset & pr->zone_size) >> 9;
> 
> Why the "& pr->zone_size" ? This seems wrong. To get the zone info of the zone
> containing offset, you can just have:
> 
> 	rep->sector = offset >> 9;
> 
> And if you want to align to the zone start, then:
> 
> 	rep->sector = (offset & (~(pr->zone_size - 1))) >> 9;

Ouch. I was silly and missed this bug because it was only doing reset
on zone #0 and #1. I'll introduce "zone_mask" and do the correct
calculation.

> > +	rep->nr_zones = 1;
> > +	ret = ioctl(blkid_probe_get_fd(pr), BLKREPORTZONE, rep);
> > +	if (ret) {
> > +		free(rep);
> > +		return -1;
> > +	}
> > +
> > +	if (rep->zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL)
> > +		ret = 1;
> > +	else
> > +		ret = 0;
> > +
> > +	free(rep);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * blkid_do_wipe:
> >   * @pr: prober
> > @@ -1264,6 +1299,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
> >  	const char *off = NULL;
> >  	size_t len = 0;
> >  	uint64_t offset, magoff;
> > +	bool conventional;
> >  	char buf[BUFSIZ];
> >  	int fd, rc = 0;
> >  	struct blkid_chain *chn;
> > @@ -1299,6 +1335,11 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
> >  	if (len > sizeof(buf))
> >  		len = sizeof(buf);
> >  
> > +	rc = is_conventional(pr, offset);
> > +	if (rc < 0)
> > +		return rc;
> > +	conventional = rc == 1;
> > +
> >  	DBG(LOWPROBE, ul_debug(
> >  	    "do_wipe [offset=0x%"PRIx64" (%"PRIu64"), len=%zu, chain=%s, idx=%d, dryrun=%s]\n",
> >  	    offset, offset, len, chn->driver->name, chn->idx, dryrun ? "yes" : "not"));
> > @@ -1306,13 +1347,25 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
> >  	if (lseek(fd, offset, SEEK_SET) == (off_t) -1)
> >  		return -1;
> >  
> > -	memset(buf, 0, len);
> > -
> >  	if (!dryrun && len) {
> > -		/* wipen on device */
> > -		if (write_all(fd, buf, len))
> > -			return -1;
> > -		fsync(fd);
> > +		if (conventional) {
> > +			memset(buf, 0, len);
> > +
> > +			/* wipen on device */
> > +			if (write_all(fd, buf, len))
> > +				return -1;
> > +			fsync(fd);
> > +		} else {
> > +			struct blk_zone_range range = {
> > +			    (offset & pr->zone_size) >> 9,
> > +			    pr->zone_size >> 9,
> > +			};
> 
> Please add the field names for clarity and fix the sector position (it looks
> very wrong):
> 
> 			struct blk_zone_range range = {
> 			    .sector = (offset & (~(pr->zone_size - 1))) >> 9,
> 			    .nr_sectors = pr->zone_size >> 9,
> 			};

Will do the same.

> > +
> > +			rc = ioctl(fd, BLKRESETZONE, &range);
> > +			if (rc < 0)
> > +				return -1;
> > +		}
> > +
> >  		pr->flags &= ~BLKID_FL_MODIF_BUFF;	/* be paranoid */
> >  
> >  		return blkid_probe_step_back(pr);
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
