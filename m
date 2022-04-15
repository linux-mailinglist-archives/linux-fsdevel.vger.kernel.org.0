Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5850239B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiDOFNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbiDOFM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:12:57 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF5F6EC69
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 22:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649999397; x=1681535397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wC6/PVYH+J9es8aT7sK5ZaGwsGnDQHOFu7y4PW6r0NI=;
  b=TCZ8DMUvxvu+ao2LfSJKP70qG5jpzLnvakheVouCzXj6UASdABGLmhX7
   0Ur3ipsBlMSxQunhvgIrY4xy3CYF9QQCJY9LcmBTHGqA3SnAKrKA6ZCWm
   A9AU8xTPs2fgXKyBgtR4t5hBj0+ajt/NVzkwW6JWEk6ubCzhWUSVrHeyd
   HnF+O2MyeO+cXuSm3QliW3BKQxlsBu4bEk4XBvb6I+pgKxYkM6RzfqgBG
   DzU3M6TEaELDubLrfHYMmLdAxG1THATaJJOwuzSSE3BqL1ID5uO+exPiy
   J3buFRzMgv50RSr8frVglYTx+m9KP8K6+ZJYwQGFCyzv3wVSy+Ys7GYJ0
   w==;
X-IronPort-AV: E=Sophos;i="5.90,261,1643644800"; 
   d="scan'208";a="197970123"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2022 13:09:47 +0800
IronPort-SDR: qmp1A0gj7T/JsacVSaQFSyn0yYW/4WWaKgqkiOcxAvcvShifUU2hT/b3sZYOQstf24/f/NBY0g
 JigSSMP4S2yQdnNIiLS7+nE5Pz4PItZcV/Qwi6pEn45jRhJgWto7AKAtixlHyEzt+NbW2iAaWd
 hNLpq0UnQCYi2xSTtI3JAKzaluI5UD5OUy6NQVnVg2MxVdh+5kcbua/clbptupqDtdgTaOaLTQ
 9z4Qu6vRli3ISd9a2RKWAwVHghpKBoE52UqHqdT64oSGGfr3p20/kh1dueSL/kdF6h2T7g7Frl
 YkYZOvL9Vn0i1L1rzXfcMtyh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 21:40:14 -0700
IronPort-SDR: qxWyLtg9kJ8zJ0zFyfhhGXp0vJY9TwwiEob8ZeBEz4Octpjg3Y+PYSqir8xbjwZCF9H/XTruee
 FOShhH5jDcdDBIUXOD6XFDBIe5y+fuzI1Z9CXBD6E2V1oAIrVfCqZttdGoU2IphMwi+6wHCJGU
 77a3nj6LNr0lTPuW3z7KWc7wyBh7gDzV7F+C0q9raq0hjXUVX/CiXF80aE6A6hDoo61R0K/5KN
 K7ih4y5oWJdGztJbluvsoGCSQcInlgTN5d87yrVuhZRv1qldM28k5XQyk40Ytyv4K88K77XfLe
 POE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 22:09:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KfksS0r34z1SVny
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 22:09:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649999387; x=1652591388; bh=wC6/PVYH+J9es8aT7sK5ZaGwsGnDQHOFu7y
        4PW6r0NI=; b=A2KBgHYSLIEiloAT36KBlSnrdHo/5oKL9FrIFynJT5WRtSMAWFY
        bOfFXbV9aPU/SW14KWhWGoxgvZNpDxlNmySfQsvY8YKVzB0GPsCqMriDKUnvzDGe
        gxI79wWgz9d4ps/B6Xlf+gQiJxT1WJ1ZvXg2qG+PSKztllpdqubmLYAwOO/nz5St
        h4S8KA8vLEE0CNTHJjAA8Hcfkt3KCfxgWm/synsXo5jFqWGlKXVMBpl0q6F/zUl8
        QMkInWk2S7O06U7jACfYKTCYPrMyVz97bbnYwKLXgej41iNgxlqjzLyt5sjDI1Lg
        BUEAK+PEVHrx0bfVbsoqkvKO8/sBQvwsP4Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aYKJAXF9XcO6 for <linux-fsdevel@vger.kernel.org>;
        Thu, 14 Apr 2022 22:09:47 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KfksM3c9Fz1Rvlx;
        Thu, 14 Apr 2022 22:09:43 -0700 (PDT)
Message-ID: <62ebc311-e5ef-cea5-5236-0c83d1a3eb64@opensource.wdc.com>
Date:   Fri, 15 Apr 2022 14:09:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 10/27] mm: use bdev_is_zoned in claim_swapfile
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-11-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220415045258.199825-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/22 13:52, Christoph Hellwig wrote:
> Use the bdev based helper instead of poking into the queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/swapfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 63c61f8b26118..4c7537162af5e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2761,7 +2761,7 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>  		 * write only restriction.  Hence zoned block devices are not
>  		 * suitable for swapping.  Disallow them here.
>  		 */
> -		if (blk_queue_is_zoned(p->bdev->bd_disk->queue))
> +		if (bdev_is_zoned(p->bdev))
>  			return -EINVAL;
>  		p->flags |= SWP_BLKDEV;
>  	} else if (S_ISREG(inode->i_mode)) {

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
