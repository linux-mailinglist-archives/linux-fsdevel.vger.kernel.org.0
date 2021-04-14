Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9785035EA51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 03:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349017AbhDNBV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 21:21:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40063 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348988AbhDNBVz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618363318; x=1649899318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xnnT2/pvHM+3Vkc9ijfbXho/lI7rNQYEmt4whg+ay7Q=;
  b=GHLq9FX6HUmi9ulki20rpJoFojaI2BvQ8aX+KdbN7mdmcDyHLqW7wyvT
   8BJ+NwBpYFniyKpnyTUpdhSa7ZDRRHZj2Lv/H2xVEd1v5M/3iYR47IWex
   GifYeuriQEQkXRz2e0iY5JDP2GpSTOKTC1vUPqRlWDj+uxKAxOclKsvUj
   Sng+/l7p95NAALippidjqlAXvh5yucW1hlVqHEjmt6b6kxDgPg0T1lpJp
   /J/GiRmqJOk3W0LokzvEWvHJX11zPSJhPtATtk+Kz2ZDlJ1gPvsr8RPLU
   kDUftr9WRKBcqDsDYnTx3S1KpqmnJ2tUGtexhUQu1u0odAtIrc+4z8WGp
   Q==;
IronPort-SDR: NZfyQCcCM2jGCPtnHqPoqbDOdb9g9zIIEEplgGZT1D4YF6EC1u/zD7EDFHh4G8RjHdlD8J6fIi
 jSFlhMUm0+IzT/ZLZLLbc33QSZHrOapC+qloHd6uKEQLg+DV+vakDcs92YFQplKuarqDtTVe19
 ivwU1ALvjRRng5qH0CVRMc95khxA/q5v+4/x2MWA/xBA+LmNSCEY1H/v84/r/RNDf2VTnOozwf
 dEMtfH1bPYLDcPTLUGYhctqr75+6nhWuukNlhwnJv24KY0i29flYkbHspbiGcy+EIR5qiSTdXV
 +Lk=
X-IronPort-AV: E=Sophos;i="5.82,220,1613404800"; 
   d="scan'208";a="268881729"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 09:21:12 +0800
IronPort-SDR: CM4IQ79Um28TJ6oAAah4jSCJFElFOo/jMdxPQEZYDVXx+TQ3wl7REdfKFAh/AS/wIUFxrIQAQA
 kECLZeTcaqu64zELsCekJ4ZY/oizfwfgDedaVqhwrTKSfo4F+V3oWST4CBe/H2+H70N7UUPSuo
 4+qDFpXS5vKFDAYbWOb2/MVshIJq4S9Yq5noOma0EhjTLnWvVssbaL2tAc1MpTi4k6EBn/svvq
 2L5OhLfjl564bPCp9qHDd9pqr9cohPAPJDXkS8/zhj8AS81zEj7TbBzcV4hXUzGMMam+stSFan
 qXK7RjoPiGXAY9SpY0ToPwUF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:01:57 -0700
IronPort-SDR: fcfnS8zkQloh4dew0diT1ym9jBadX6isc6rpYKvV/MSlPDC1xw3tJHUtum/eZIp7+KopOMRMN6
 pRd11tEWwVAXU1JvT6KGxf0aHk0vEkXVt+COgT7YBona0D9/hFF6EySb26ajapqYBCd3MaKqX3
 cpFVT5YroEKwzNPFLkKIyPXdCNryI2EX7/xJhQu6bmP3DyyBGEg9M0+4v6NTgMfienZ9TJe7Ei
 tcgxLBeJhHAYIJYzfoCPT6WB+BBBRIk7CMUR/mRBvJ/otFqMkkru67+5xtVp8vd2rpSdg3vMHA
 W/c=
WDCIronportException: Internal
Received: from jpf004864.ad.shared (HELO naota-xeon) ([10.225.53.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:20:53 -0700
Date:   Wed, 14 Apr 2021 10:20:52 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 1/3] blkid: implement zone-aware probing
Message-ID: <20210414012052.pksgcgf3co7ppris@naota-xeon>
References: <20210413221051.2600455-1-naohiro.aota@wdc.com>
 <20210413221051.2600455-2-naohiro.aota@wdc.com>
 <BL0PR04MB65142AE5036A0B15E82B8FA8E74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65142AE5036A0B15E82B8FA8E74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:38:37PM +0000, Damien Le Moal wrote:
> On 2021/04/14 7:11, Naohiro Aota wrote:
> > This patch makes libblkid zone-aware. It can probe the magic located at
> > some offset from the beginning of some specific zone of a device.
> > 
> > Ths patch introduces some new fields to struct blkid_idmag. They indicate
> > the magic location is placed related to a zone, and the offset in the zone.
> > 
> > Also, this commit introduces `zone_size` to struct blkid_struct_probe. It
> > stores the size of zones of a device.
> > 
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  configure.ac          |  1 +
> >  libblkid/src/blkidP.h |  5 +++++
> >  libblkid/src/probe.c  | 26 ++++++++++++++++++++++++--
> >  3 files changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index bebb4085425a..52b164e834db 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -302,6 +302,7 @@ AC_CHECK_HEADERS([ \
> >  	lastlog.h \
> >  	libutil.h \
> >  	linux/btrfs.h \
> > +	linux/blkzoned.h \
> >  	linux/capability.h \
> >  	linux/cdrom.h \
> >  	linux/falloc.h \
> > diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
> > index a3fe6748a969..e3a160aa97c0 100644
> > --- a/libblkid/src/blkidP.h
> > +++ b/libblkid/src/blkidP.h
> > @@ -150,6 +150,10 @@ struct blkid_idmag
> >  	const char	*hoff;		/* hint which contains byte offset to kboff */
> >  	long		kboff;		/* kilobyte offset of superblock */
> >  	unsigned int	sboff;		/* byte offset within superblock */
> > +
> > +	int		is_zoned;	/* indicate magic location is calcluated based on zone position  */
> > +	long		zonenum;	/* zone number which has superblock */
> > +	long		kboff_inzone;	/* kilobyte offset of superblock in a zone */
> >  };
> >  
> >  /*
> > @@ -206,6 +210,7 @@ struct blkid_struct_probe
> >  	dev_t			disk_devno;	/* devno of the whole-disk or 0 */
> >  	unsigned int		blkssz;		/* sector size (BLKSSZGET ioctl) */
> >  	mode_t			mode;		/* struct stat.sb_mode */
> > +	uint64_t		zone_size;	/* zone size (BLKGETZONESZ ioctl) */
> >  
> >  	int			flags;		/* private library flags */
> >  	int			prob_flags;	/* always zeroized by blkid_do_*() */
> > diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
> > index a47a8720d4ac..102766e57aa0 100644
> > --- a/libblkid/src/probe.c
> > +++ b/libblkid/src/probe.c
> > @@ -94,6 +94,9 @@
> >  #ifdef HAVE_LINUX_CDROM_H
> >  #include <linux/cdrom.h>
> >  #endif
> > +#ifdef HAVE_LINUX_BLKZONED_H
> > +#include <linux/blkzoned.h>
> > +#endif
> >  #ifdef HAVE_SYS_STAT_H
> >  #include <sys/stat.h>
> >  #endif
> > @@ -871,6 +874,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
> >  #ifdef CDROM_GET_CAPABILITY
> >  	long last_written = 0;
> >  #endif
> > +	uint32_t zone_size_sector;
> 
> Move this declaration under the # ifdef HAVE_LINUX_BLKZONED_H where it is used
> below ?
> 
> >  
> >  	blkid_reset_probe(pr);
> >  	blkid_probe_reset_buffers(pr);
> > @@ -897,6 +901,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
> >  	pr->wipe_off = 0;
> >  	pr->wipe_size = 0;
> >  	pr->wipe_chain = NULL;
> > +	pr->zone_size = 0;
> >  
> >  	if (fd < 0)
> >  		return 1;
> > @@ -996,6 +1001,11 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
> >  #endif
> >  	free(dm_uuid);
> >  
> > +# ifdef HAVE_LINUX_BLKZONED_H
> > +	if (S_ISBLK(sb.st_mode) && !ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector))
> > +		pr->zone_size = zone_size_sector << 9;
> > +# endif
> 
> So something like:
> 
> # ifdef HAVE_LINUX_BLKZONED_H
> 	if (S_ISBLK(sb.st_mode)) {
> 		 uint32_t zone_size_sector;
> 
> 		if (!ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector))
> 			pr->zone_size = zone_size_sector << 9;
> 	}
> # endif
> 
> Otherwise, you probably will get a compiler warning as zone_size_sector will be
> unused if HAVE_LINUX_BLKZONED_H is false.

My bad. I should have undef the HAVE_LINUX_BLKZONED_H and compile
it. I'll rewrite and send a new series.

Thanks,

> > +
> >  	DBG(LOWPROBE, ul_debug("ready for low-probing, offset=%"PRIu64", size=%"PRIu64"",
> >  				pr->off, pr->size));
> >  	DBG(LOWPROBE, ul_debug("whole-disk: %s, regfile: %s",
> > @@ -1064,12 +1074,24 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
> >  	/* try to detect by magic string */
> >  	while(mag && mag->magic) {
> >  		unsigned char *buf;
> > +		uint64_t kboff;
> >  		uint64_t hint_offset;
> >  
> >  		if (!mag->hoff || blkid_probe_get_hint(pr, mag->hoff, &hint_offset) < 0)
> >  			hint_offset = 0;
> >  
> > -		off = hint_offset + ((mag->kboff + (mag->sboff >> 10)) << 10);
> > +		/* If the magic is for zoned device, skip non-zoned device */
> > +		if (mag->is_zoned && !pr->zone_size) {
> > +			mag++;
> > +			continue;
> > +		}
> > +
> > +		if (!mag->is_zoned)
> > +			kboff = mag->kboff;
> > +		else
> > +			kboff = ((mag->zonenum * pr->zone_size) >> 10) + mag->kboff_inzone;
> > +
> > +		off = hint_offset + ((kboff + (mag->sboff >> 10)) << 10);
> >  		buf = blkid_probe_get_buffer(pr, off, 1024);
> >  
> >  		if (!buf && errno)
> > @@ -1079,7 +1101,7 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
> >  				buf + (mag->sboff & 0x3ff), mag->len)) {
> >  
> >  			DBG(LOWPROBE, ul_debug("\tmagic sboff=%u, kboff=%ld",
> > -				mag->sboff, mag->kboff));
> > +				mag->sboff, kboff));
> >  			if (offset)
> >  				*offset = off + (mag->sboff & 0x3ff);
> >  			if (res)
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
