Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295929C96C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfHZG3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 02:29:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64936 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfHZG3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566800971; x=1598336971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QD84KaAY4BwdmEcTRzWWp6K5JpbIG3RvemC4vbSEAR4=;
  b=SdytJla8VFxkv0chC9OeuCbjht2KKX4PVrWHoGxaqLSG7SNcVBYDnK6V
   hNX6KbQ17DraXznWg6BhWKXuxkwU2WbpyzsOBa5k4sAY/FvGOnaASUnNi
   Sl4t2ztoOK5ttcKWHvG0bpFx8y+oxCoVMn++7yhOPJqxf8I1FcLYxGWz/
   68J0o7jQB2+BtD7HK248Llb5CjlivCBhsQCX+OPtfa+bRoTTF+wL+LiHO
   8rJwVlcXPL/XWwNOavtUJOOm+/ishTklB+Vmv9g7Jtym1dn/lgpZqMcee
   hyWSuT1qdyRq8rgFyyUhJIgL8uQF6racFaXWiImf924IkDpHZltOmEHHZ
   w==;
IronPort-SDR: XOJL5U/GW92iyGSl5ccwx1+KjP+i+ONFyyMjzvJ4lMvReqnW4nwTGrEL3544hTJwP2DvVlR2bm
 DHMzxj1KOwVaiN8L3jUd9KIgz6p5QByZFseRgErZZIUeE2e+r6Lo6+5M+phADZ31TPlW43c35o
 DQoLVSf1daoE///yhFqT2WBARyLufZ4jXUbU2ZDtmQZpM3TsI6+eXbLlB/3C0A9RarIHaNk5ad
 9KZvyH6i5elkNWH1pOEQhXp9pbf5E6aHyOWU1zbq0AGy+HLiCMuSfzC8HrV5tbOU06hCaWT1MY
 cWw=
X-IronPort-AV: E=Sophos;i="5.64,431,1559491200"; 
   d="scan'208";a="223282342"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2019 14:29:12 +0800
IronPort-SDR: yzXJDDxVq7gykejZnrotBdutKT3qXGXuMfGovu5tT5EFCKklNx34Ttd3uHHC9vlFZMw6xYzFpo
 U/nFTg+raZ09S/a0pJSoSVZ0ApwBLjIkhOy1HGwiEqiNE9KtTEpmGZnjzpoWUxUFbZx+k5U6BV
 1uCQahESMzx8NRO0QGkKrOXn7M6qb3ZwAOCO7ZVp5RqN9KXEf+Jm80KOBMobWDlV2VsDa47Xrt
 A6VgUAS4UqGkUrxC1LvW9H8fe62sa7I7o6yh3hn8WC+2EksUkxSXLjTsJlmejanLAKU5JFoMuf
 a6FEYb8ZMXMjz3lk/Z4Mzee6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2019 23:26:26 -0700
IronPort-SDR: GIfJR3Yl3THioz1ODV8qhi7SnK/oR9Xbaz+orjcXWgZ5QchUlEh3ucxNjp7dXNZjuDwjfI0S8f
 vYbZ+j6K/yUhlnLAunxkt4oJWqEtJGFus3/a8eBcX+eZoFVf5cXmmEt6HCNpGpnr+XYJhvifzL
 1oBewzMY5L2RaoWV+jrETGIhzk+W8iVGSqjbWyrOad/+WnVgW/HOiUT4H6Mc/rf5CEZE3ksmPl
 /nQB/GmRWEt9jqEi/HOBIs0vxdgZg38/28PKh+pxm4vuKHO3kjLOOJdw/vil2DS//O+LITRAd+
 4Q4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 25 Aug 2019 23:29:11 -0700
Received: (nullmailer pid 321826 invoked by uid 1000);
        Mon, 26 Aug 2019 06:29:10 -0000
Date:   Mon, 26 Aug 2019 15:29:10 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 02/27] btrfs: Get zone information of zoned block
 devices
Message-ID: <20190826062910.7kbbreqmpl4bri6v@naota.dhcp.fujisawa.hgst.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
 <20190823101036.796932-3-naohiro.aota@wdc.com>
 <ae5e9761-7191-20fa-02c5-abe8b81d278c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae5e9761-7191-20fa-02c5-abe8b81d278c@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 01:57:33PM +0200, Johannes Thumshirn wrote:
>On 23/08/2019 12:10, Naohiro Aota wrote:
>[...]
>> +int btrfs_get_dev_zone_info(struct btrfs_device *device)
>> +{
>> +	struct btrfs_zoned_device_info *zone_info = NULL;
>> +	struct block_device *bdev = device->bdev;
>> +	sector_t nr_sectors = bdev->bd_part->nr_sects;
>> +	sector_t sector = 0;
>> +	struct blk_zone *zones = NULL;
>> +	unsigned int i, nreported = 0, nr_zones;
>> +	unsigned int zone_sectors;
>> +	int ret;
>> +
>> +	if (!bdev_is_zoned(bdev))
>> +		return 0;
>> +
>> +	zone_info = kzalloc(sizeof(*zone_info), GFP_KERNEL);
>> +	if (!zone_info)
>> +		return -ENOMEM;
>> +
>> +	zone_sectors = bdev_zone_sectors(bdev);
>> +	ASSERT(is_power_of_2(zone_sectors));
>> +	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
>> +	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
>> +	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
>> +	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
>> +		zone_info->nr_zones++;
>> +
>> +	zone_info->seq_zones = kcalloc(BITS_TO_LONGS(zone_info->nr_zones),
>> +				       sizeof(*zone_info->seq_zones),
>> +				       GFP_KERNEL);
>> +	if (!zone_info->seq_zones) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	zone_info->empty_zones = kcalloc(BITS_TO_LONGS(zone_info->nr_zones),
>> +					 sizeof(*zone_info->empty_zones),
>> +					 GFP_KERNEL);
>> +	if (!zone_info->empty_zones) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +
>> +	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
>> +			sizeof(struct blk_zone), GFP_KERNEL);
>> +	if (!zones)
>> +		return -ENOMEM;
>
>Won't this will leak zone_info, zone_info->seq_zones and
>zone_info->empty_zones.

Ah, yes. I'll fix that using the suggested style below.

Thanks

>
>[...]
>
>> +out:
>> +	kfree(zones);
>> +
>> +	if (ret) {
>> +		kfree(zone_info->seq_zones);
>> +		kfree(zone_info->empty_zones);
>> +		kfree(zone_info);
>> +	}
>
>Which is why I think it would be more clear to have:
>free_zones:
>	kfree(zones);
>free_zi_emp_zones:
>	kfree(zone_info->empty_zones);
>free_zi_seq_zones:
>	kfree(zone_info->seq_zones);
>free_zi:
>	kfree(zone_info);
>
>
>
>-- 
>Johannes Thumshirn                            SUSE Labs Filesystems
>jthumshirn@suse.de                                +49 911 74053 689
>SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
>GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
>HRB 21284 (AG Nürnberg)
>Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
