Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD835F730
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347984AbhDNPFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 11:05:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61698 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347874AbhDNPFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618412705; x=1649948705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AxHV9CquGv4LpokLwlUcIh8zYRqTqA2vlXv6HiT3TuA=;
  b=VlZ16tPNyaga1UkUNpLRrfTQa73qO1QWWoHuyzBcp1LHkzEONmbJaREV
   PlZKRXFZbdfKECBr+Dcrn0VHOkZ/jzoBT7t7/MYeaKXcWD4N3Fjw04SNK
   7uedNDF0sH3zq80QwA/QX6wkPUUEpLzUIssTCm7/N8+7agBKeCHThW3qC
   qlc1SaTZ5j+M6vhlvELYns52HZsw4jf1fp4eRO/9slA6y3KzuOTUePQI3
   hqJ0NXFo7Hv0lI+vVUwf2Z72FypymYMPIeEb7MJVnDWmoBvpt2m9euwTE
   qLFBasORgVh+c/21efRr0MAWS9kgwa6r3TDRXVUluwUEUQjOfjCdT0mtl
   A==;
IronPort-SDR: NgD8113IFAg0jD0J/6uanLuPww8mLryrd4FJEfOQIGOjFmmxoqnZc3BfJEJRwUD+HInUHHdKuS
 emdfKgyhSLyUCg7fyxJZQcqPoDpe1K4GDf7pPs0BytbWaVwbw7Um3Qo++FnWnef1t/HXzLMAk/
 R4zbbg76lW50oo+IxPQC1oeY2W8cE4USKQ1yvSJNNLqvBtTPHLkrx0DH1OZDalXshChilD6deG
 +HTnYj2aOII4EPs+Ld9Reqso+VveaquGYDfy9KC3TbzS9+OA8WK0nVa3LSfUBAXhN9l2yYylom
 ROE=
X-IronPort-AV: E=Sophos;i="5.82,222,1613404800"; 
   d="scan'208";a="268925356"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 23:04:03 +0800
IronPort-SDR: hy2R08h06yi/lk8DS1LIetG2uSkyVnMk/EpTvHJNCl6SmR8WwOEGHGMPgzqPGyKOfboARJt6iM
 EGmK540G78rvjUzRyr5U4PuN82s4bMkFEX1F6jWYsqcaA5pp8K9prO/AVGpT+F10G/ddwmGIJ3
 Hw+hQKS32EZqBNRcFA9cvC5v1iIEKIiM+KW9RfgkB3zdC00hiB+n0lckvVWINn00UpXXzHkQpW
 nkkhfig7g9fDzcwYvoFx8x3zzomt7y4i/X95RwKzf/ligTbyuW7YCVBhj3zDgybsWfqFJSHmiL
 bq5b0pp1qnCnSLai6SiOFm8S
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 07:43:15 -0700
IronPort-SDR: 7mz8XM1d3p25L4d789LPzov85JL895gDdDVgWqQkJ4PK4ZemKVKSentdJEN6EAesr9nrv2UgsQ
 q/oRJfdlRWQ/LVyZBH59eOJyQs+L6e3AiPsu9oGLkUGBDhWn/R3izDoYUsCxj0QkaBF0+Nyaq1
 wEt3JFedl8EWkxDtf+dq3o2ZuRIVkrsWueIAJlkpNf6Tx3k01hNYctUmCBO30yWchXZFjh8VEu
 09PfktfQIGyPdWqyiZ15dpF4aFOhoC8XlVGke65Px7EMMica0mqddcfyKn/1oxJkpfNupYgnHG
 n7Q=
WDCIronportException: Internal
Received: from ind006838.ad.shared (HELO naota-xeon) ([10.225.53.197])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 08:03:51 -0700
Date:   Thu, 15 Apr 2021 00:03:50 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 1/3] blkid: implement zone-aware probing
Message-ID: <20210414150350.srqsmzyoscec6phy@naota-xeon>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-2-naohiro.aota@wdc.com>
 <20210414133101.p5amev6tkfroiyw5@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414133101.p5amev6tkfroiyw5@ws.net.home>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 03:31:01PM +0200, Karel Zak wrote:
> On Wed, Apr 14, 2021 at 10:33:37AM +0900, Naohiro Aota wrote:
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -302,6 +302,7 @@ AC_CHECK_HEADERS([ \
> >  	lastlog.h \
> >  	libutil.h \
> >  	linux/btrfs.h \
> > +	linux/blkzoned.h \
> 
> unnecessary, there is already AC_CHECK_HEADERS([linux/blkzoned.h]) on
> another place.

Ah, I missed that. I will drop it.

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
> 
> It would be better to use 'flags' struct field and
> 
>   #define BLKID_FL_ZONED_DEV (1 << 6)
> 
> like we use for another stuff.

BLKID_FL_* flags looks like to indicate a device's property. Instead,
this one indicates a magic is placed relative to a zone. I do not see
blkid_idmag is currently using "flags" filed. Should we really add it
and follow the flag style? I thought, we can do it later when other
use case exists.

> > diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
> > index a47a8720d4ac..9d180aab5242 100644
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
> > @@ -897,6 +900,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
> >  	pr->wipe_off = 0;
> >  	pr->wipe_size = 0;
> >  	pr->wipe_chain = NULL;
> > +	pr->zone_size = 0;
> 
> you also need to update blkid_clone_probe() function

Will do. I completely missed that. Thanks.

>   Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 
