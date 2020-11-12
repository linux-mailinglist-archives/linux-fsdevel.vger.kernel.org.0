Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670B42B0543
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 13:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgKLM5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 07:57:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13445 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLM5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605185856; x=1636721856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1bl1/g4yugnt01+UOLbMe57GpRsHkWxbyoPn864AtUI=;
  b=QAPKBu+Q7SORD9hUsLAuhpAg9AlWECGAcUC+fc5KouMUZ6Bfyll81KSu
   kKHP2eFomPo19imDCDBmz3BtCYH0SGh9TMrGTG6G5ycKPQDDYRH/yq2LB
   wQuGsaTEMfJKl79XahDmp5+a27rIVhHN3t++f97dFJD8313dFZAUs4hD8
   XAiqZG7jap1tOffXbwQxpQXDNUafWqJJRhep+8Fp1ayZT9tv+3ZKMuiJi
   nYUQtaJYZQYcrujc8qu4wkh+P+SoWrcYqztHt594f+v7f5IEFNs5/cz+L
   Fc/WLwu+XJxBPz8JMO6LMFxwPsaGnvMdlMm6b34X1uq7xQRZhyE1LcpcT
   A==;
IronPort-SDR: IR5BhVYEnjcCZq31sxxBZCsmV7fmat4oz2YJpz5akwT8JNsc5qCcLh0WMr8DbuvhDB6rWXadBG
 miGzmV8rh+H6KShw+6qGqXLYz3Sk5d/ZYdkFjmdJKDjQivg0Vk3IY5OiZJxiQML/84TPiL/ZAw
 3GS5Izt85TBjDoES0xAUTxEEFz++Hdhsg5m/Z6xjmLQ5n/Dh1pkz9Yl8pYSR04dVHQGkETTDpO
 f5SSJBbEHQJjIbbGHx4dFeFpT+2CUN+dm+JehzSF9mUJj8ehBZWka4bgKqa9zj/lA++A+Q/aGT
 Eho=
X-IronPort-AV: E=Sophos;i="5.77,472,1596470400"; 
   d="scan'208";a="262495822"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 20:57:36 +0800
IronPort-SDR: 1Wf1+T2/h01nvKaIhaSUsjPwnttn/1wonfREG+5s+nul8LMI0OWKwSo+dY4FJigQQQ7O2wx6vw
 obpB5ZjzBQrDkRFWlIfGTZP20vICttnx9Sa3Lo7JKKF6GtxTB0YuclEokicz9cnh0k77WrGHND
 WoeDPz//BBEXa9/snQa+rcpw05TJbnGgOdkpkJbCymYZbNstzIH1kR07UbFRxP0bcPrqQLPfsL
 QI9cavlEFqWay/aSaewRbO9cm/S/lbjXZS+rZsDsLtrPR0DZ1frk+zzao1hdr0+mU3vRDGyayS
 YfseWBvfsgRyzAFBzPTaatfu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 04:42:18 -0800
IronPort-SDR: rm0kxo8SWx4sVrdzb7HouAvoakOqFjFGAJSR64+/6iioc8rVH2fXDw0WbVH3n86aTtum0i5X4S
 W9QrHLityDnv06WAFRQBg86SQGQUs60n7XTreFbxKG14vZKK7aQYF3nylktYFsZcw21VPnhY74
 AXMJ205jjlGoYxdAwblB00tDlSXBwYR17Xe7n++INdCDUyMh3Z+m4N2FITujbSN+UCBdBSoH1e
 AaTKu1AUxxzlG8Q5Db3CunDeBlqej5NoXN8cLdtzzi+cHByfmxdEaAggoCW5w5gQA11mpG83Ea
 ios=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 12 Nov 2020 04:57:34 -0800
Received: (nullmailer pid 3109689 invoked by uid 1000);
        Thu, 12 Nov 2020 12:57:34 -0000
Date:   Thu, 12 Nov 2020 21:57:34 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Message-ID: <20201112125734.dcxk5q7cuf5e7hje@naota.dhcp.fujisawa.hgst.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 02:57:42PM +0800, Anand Jain wrote:
>
>
>>diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>index 8840a4fa81eb..ed55014fd1bd 100644
>>--- a/fs/btrfs/super.c
>>+++ b/fs/btrfs/super.c
>>@@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)
>>  #endif
>>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>  			", ref-verify=on"
>>+#endif
>>+#ifdef CONFIG_BLK_DEV_ZONED
>>+			", zoned=yes"
>>+#else
>>+			", zoned=no"
>>  #endif
>
>IMO, we don't need this, as most of the generic kernel will be compiled
>with the CONFIG_BLK_DEV_ZONED defined.
>For review purpose we may want to know if the mounted device
>is a zoned device. So log of zone device and its type may be useful
>when we have verified the zoned devices in the open_ctree().
>
>>@@ -374,6 +375,7 @@ void btrfs_free_device(struct btrfs_device *device)
>>  	rcu_string_free(device->name);
>>  	extent_io_tree_release(&device->alloc_state);
>>  	bio_put(device->flush_bio);
>
>>+	btrfs_destroy_dev_zone_info(device);
>
>Free of btrfs_device::zone_info is already happening in the path..
>
> btrfs_close_one_device()
>   btrfs_destroy_dev_zone_info()
>
> We don't need this..
>
> btrfs_free_device()
>  btrfs_destroy_dev_zone_info()

Ah, yes, I once had it only in btrfs_free_device() and noticed that it does
not free the device zone info on umount. So, I added one in
btrfs_close_one_device() and forgot to remove the other one. I'll drop it
from btrfs_free_device().

>
>
>>@@ -2543,6 +2551,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>  	}
>>  	rcu_assign_pointer(device->name, name);
>>+	device->fs_info = fs_info;
>>+	device->bdev = bdev;
>>+
>>+	/* Get zone type information of zoned block devices */
>>+	ret = btrfs_get_dev_zone_info(device);
>>+	if (ret)
>>+		goto error_free_device;
>>+
>>  	trans = btrfs_start_transaction(root, 0);
>>  	if (IS_ERR(trans)) {
>>  		ret = PTR_ERR(trans);
>
>It should be something like goto error_free_zone from here.
>
>
>>@@ -2707,6 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>  		sb->s_flags |= SB_RDONLY;
>>  	if (trans)
>>  		btrfs_end_transaction(trans);
>
>
>error_free_zone:

And, I'll do something like this.

>>+	btrfs_destroy_dev_zone_info(device);
>>  error_free_device:
>>  	btrfs_free_device(device);
>>  error:
>
> As mentioned we don't need btrfs_destroy_dev_zone_info()
> again in  btrfs_free_device(). Otherwise we end up calling
> btrfs_destroy_dev_zone_info twice here.
>
>
>Thanks, Anand
