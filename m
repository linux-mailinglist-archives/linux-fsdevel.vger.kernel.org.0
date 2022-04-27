Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA4511E49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbiD0SMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 14:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244659AbiD0SMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:12:17 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C421340D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 11:08:53 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220427180851epoutp0166633be9fb9bf8f2faa969488b0deb29~p0y2e0JV02003120031epoutp01x
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 18:08:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220427180851epoutp0166633be9fb9bf8f2faa969488b0deb29~p0y2e0JV02003120031epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651082931;
        bh=e71Dd+3t+lXTIXD0CZ9hJbK/v/nCtOa9CaKTA4ioWwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M+6luN4/EKpZ1OJVpyLQRq1Ggz55cF5P2w4XfahG0/ocghVmROLbqk4z3+v7Nq7fE
         KqsgJTb3xFO31v9ZdIhP3NQ2myI0DHqfhDRiJvkyrxGbiJNu/Cog1fxixliewzzMs8
         uAxBHTchZkJBIayuWCZ/ByTAN/qt4AF7JowaIZQ4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220427180849epcas5p4d687e667801590b1d1cb96a8c5f43253~p0y1Fu1iV3079930799epcas5p4L;
        Wed, 27 Apr 2022 18:08:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KpRZj6vXMz4x9Pq; Wed, 27 Apr
        2022 18:08:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.27.09762.DA689626; Thu, 28 Apr 2022 03:08:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220427153603epcas5p238cad2ea79fe1a4b45296e3ed8b7f925~pytb6ggwm2921129211epcas5p2w;
        Wed, 27 Apr 2022 15:36:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220427153603epsmtrp2030caccb27dac74935a6208297e87f3d~pytb4yJeP1069610696epsmtrp2B;
        Wed, 27 Apr 2022 15:36:03 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-44-626986ad7787
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.98.08853.2E269626; Thu, 28 Apr 2022 00:36:02 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427153601epsmtip11a1a088d8656e58926af10faedc7af5d~pytaqONS-1329113291epsmtip14;
        Wed, 27 Apr 2022 15:36:01 +0000 (GMT)
Date:   Wed, 27 Apr 2022 21:00:53 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        inux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] block: Introduce queue limits for copy-offload
 support
Message-ID: <20220427153053.GD9558@test-zns>
MIME-Version: 1.0
In-Reply-To: <0d52ad34-ab75-9672-321f-34053421c0c4@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmhu7atswkg3OHTC1+nz3PbLH33WxW
        iz/LQKxb2hZ79p5ksZi/7Cm7Rff1HWwWO540MjpweOycdZfdY/OSeo+drfdZPd7vu8rm8XmT
        XABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAl
        SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1Og
        woTsjJdvZzIXTE2v+PjqCGMD4+agLkZODgkBE4mts/6wdTFycQgJ7GaUuD7rOjuE84lRoqnp
        PCuE841RoufFf6YuRg6wlvWPeSHiexklVk+4xALhPGOUWHX4ASPIXBYBVYl3S98wgjSwCWhL
        nP7PARIWETCVeNvTClbPLHCaUeL/q5/MIAlhgTCJC/8fs4DYvAI6Es3LTzJD2IISJ2c+AYtz
        CrhJPOubB2aLCihLHNh2nAlkkIRAI4fExI4pjBAPuUjs6JnICmELS7w6voUdwpaS+PxuLxuE
        XS6xvW0BVHMLo0TXqVMsEAl7iYt7/jKB2MwCGRKzOu8zQcRlJaaeWgcV55Po/f0EKs4rsWMe
        jK0ssWb9AqgFkhLXvjdC2R4SCxbOZYYE0W9GicWXnjJNYJSfheS7WUj2Qdg6Egt2f2KbBQw9
        ZgFpieX/OCBMTYn1u/QXMLKuYpRMLSjOTU8tNi0wzksth0d5cn7uJkZwUtXy3sH46MEHvUOM
        TByMhxglOJiVRHi/7M5IEuJNSaysSi3Kjy8qzUktPsRoCoyticxSosn5wLSeVxJvaGJpYGJm
        ZmZiaWxmqCTOeyp9Q6KQQHpiSWp2ampBahFMHxMHp1QD0xSNvCLzJhmDqMbg0kncj7buPi/e
        H3hXydN90cs/t5wfPXlidWvfBZmbFy4rPpp4+pqSh+zuTarzd4h99VYwYl/5w/yNG0/b0yBT
        UdvfTtUbNi2/2KR5jf3D03b3LXK7jez6+98YXtK7+XKN60ydKPOlSy+///h2a0FoRJzaLvGA
        Ak0lJqPVTmJFs9fknV6/i09ehUv0DlNVzZMwhuZjR/eeOPlXeNfaH1YiK9xbD6WJCP3bta4i
        +rbycZ6C54LybTvnBU1d4uGwz+C1NdMc0XULLETOLtE4efXrc0u9N2m3fe0W3M22Cpjte1ws
        qMzHq685qNPZy3TVwZL0+y+kwniFKjQ0uA5dcVK96i+wWomlOCPRUIu5qDgRAArT14EzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO6jpMwkg4mnrS1+nz3PbLH33WxW
        iz/LQKxb2hZ79p5ksZi/7Cm7Rff1HWwWO540MjpweOycdZfdY/OSeo+drfdZPd7vu8rm8XmT
        XABrFJdNSmpOZllqkb5dAlfGxsV7GAuuplSc2vCcqYGxJ6CLkYNDQsBEYv1j3i5GLg4hgd2M
        Enda2pm7GDmB4pISy/4egbKFJVb+e84OUfSEUeLN08lsIAkWAVWJd0vfMIIMYhPQljj9nwMk
        LCJgKvG2p5UFpJ5Z4DSjxP9XP8EGCQuESVz4/5gFxOYV0JFoXn6SGWLob0aJQ9PuMkEkBCVO
        znwCVsQsoCVx499LJpAFzALSEsv/gS3gFHCTeNY3D6xEVEBZ4sC240wTGAVnIemehaR7FkL3
        AkbmVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwZGgpbmDcfuqD3qHGJk4GA8xSnAw
        K4nwftmdkSTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD
        U+LG1KPFp7uXvLtm+SJ06u4gFx6RyMZv1/ncPLsFjn2bYfou4pFCtpLy09wLt2aravm4zhfa
        9ejT3bQ9DMLVGjFi5S1Py9K2vU75OiF41uL7PqV3Mu1M92rl71FYd+nuwYSSq9JL2mbHX+hV
        cNMKnpP2ltd1S9nmhL0Cu5kWbnuS42PBXfNQ3CY3VMsuoKVDv70hw3lb5U7NI/42m3JTI5Z9
        Scq6Waqpsqp/KmvQwaK34QXTj+fckhWvtJQRM93kbv3yzc2DJa8UXVnKzRYsF4w6OPH6vDNS
        vZZML09diTQLeD2dm32fT03x7aXdUk2/pfd9/DR9pmH95K9b/055LyL8+oES66oDpoq9v4SS
        lViKMxINtZiLihMBN3QId/MCAAA=
X-CMS-MailID: 20220427153603epcas5p238cad2ea79fe1a4b45296e3ed8b7f925
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----KqMzgBRJR.Fsk82YJsMcER2lgAm37zzR_kphVf-KeEbAMdws=_17fd8_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101910epcas5p4fd64f83c6da9bbd891107d158a2743b5
References: <20220426101241.30100-1-nj.shetty@samsung.com>
        <CGME20220426101910epcas5p4fd64f83c6da9bbd891107d158a2743b5@epcas5p4.samsung.com>
        <20220426101241.30100-2-nj.shetty@samsung.com>
        <0d52ad34-ab75-9672-321f-34053421c0c4@opensource.wdc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------KqMzgBRJR.Fsk82YJsMcER2lgAm37zzR_kphVf-KeEbAMdws=_17fd8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Apr 27, 2022 at 10:59:01AM +0900, Damien Le Moal wrote:
> On 4/26/22 19:12, Nitesh Shetty wrote:
> > Add device limits as sysfs entries,
> >         - copy_offload (RW)
> >         - copy_max_bytes (RW)
> >         - copy_max_hw_bytes (RO)
> >         - copy_max_range_bytes (RW)
> >         - copy_max_range_hw_bytes (RO)
> >         - copy_max_nr_ranges (RW)
> >         - copy_max_nr_ranges_hw (RO)
> > 
> > Above limits help to split the copy payload in block layer.
> > copy_offload, used for setting copy offload(1) or emulation(0).
> > copy_max_bytes: maximum total length of copy in single payload.
> > copy_max_range_bytes: maximum length in a single entry.
> > copy_max_nr_ranges: maximum number of entries in a payload.
> > copy_max_*_hw_*: Reflects the device supported maximum limits.
> > 
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> > ---
> >  Documentation/ABI/stable/sysfs-block |  83 ++++++++++++++++
> >  block/blk-settings.c                 |  59 ++++++++++++
> >  block/blk-sysfs.c                    | 138 +++++++++++++++++++++++++++
> >  include/linux/blkdev.h               |  13 +++
> >  4 files changed, 293 insertions(+)
> > 
> > diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> > index e8797cd09aff..65e64b5a0105 100644
> > --- a/Documentation/ABI/stable/sysfs-block
> > +++ b/Documentation/ABI/stable/sysfs-block
> > @@ -155,6 +155,89 @@ Description:
> >  		last zone of the device which may be smaller.
> >  
> >  
> > +What:		/sys/block/<disk>/queue/copy_offload
> > +Date:		April 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RW] When read, this file shows whether offloading copy to
> > +		device is enabled (1) or disabled (0). Writing '0' to this
> > +		file will disable offloading copies for this device.
> > +		Writing any '1' value will enable this feature.
> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_bytes
> > +Date:		April 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RW] While 'copy_max_hw_bytes' is the hardware limit for the
> > +		device, 'copy_max_bytes' setting is the software limit.
> > +		Setting this value lower will make Linux issue smaller size
> > +		copies.
> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_hw_bytes
> > +Date:		April 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RO] Devices that support offloading copy functionality may have
> > +		internal limits on the number of bytes that can be offloaded
> > +		in a single operation. The `copy_max_hw_bytes`
> > +		parameter is set by the device driver to the maximum number of
> > +		bytes that can be copied in a single operation. Copy
> > +		requests issued to the device must not exceed this limit.
> > +		A value of 0 means that the device does not
> > +		support copy offload.
> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_nr_ranges
> > +Date:		April 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RW] While 'copy_max_nr_ranges_hw' is the hardware limit for the
> > +		device, 'copy_max_nr_ranges' setting is the software limit.
> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_nr_ranges_hw
> > +Date:		April 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RO] Devices that support offloading copy functionality may have
> > +		internal limits on the number of ranges in single copy operation
> > +		that can be offloaded in a single operation.
> > +		A range is tuple of source, destination and length of data
> > +		to be copied. The `copy_max_nr_ranges_hw` parameter is set by
> > +		the device driver to the maximum number of ranges that can be
> > +		copied in a single operation. Copy requests issued to the device
> > +		must not exceed this limit. A value of 0 means that the device
> > +		does not support copy offload.
> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_range_bytes
> > +Date:		April 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RW] While 'copy_max_range_hw_bytes' is the hardware limit for
> > +		the device, 'copy_max_range_bytes' setting is the software
> > +		limit.
> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_range_hw_bytes
> > +Date:		April 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RO] Devices that support offloading copy functionality may have
> > +		internal limits on the size of data, that can be copied in a
> > +		single range within a single copy operation.
> > +		A range is tuple of source, destination and length of data to be
> > +		copied. The `copy_max_range_hw_bytes` parameter is set by the
> > +		device driver to set the maximum length in bytes of a range
> > +		that can be copied in an operation.
> > +		Copy requests issued to the device must not exceed this limit.
> > +		Sum of sizes of all ranges in a single opeartion should not
> > +		exceed 'copy_max_hw_bytes'. A value of 0 means that the device
> > +		does not support copy offload.
> > +
> > +
> >  What:		/sys/block/<disk>/queue/crypto/
> >  Date:		February 2022
> >  Contact:	linux-block@vger.kernel.org
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 6ccceb421ed2..70167aee3bf7 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -57,6 +57,12 @@ void blk_set_default_limits(struct queue_limits *lim)
> >  	lim->misaligned = 0;
> >  	lim->zoned = BLK_ZONED_NONE;
> >  	lim->zone_write_granularity = 0;
> > +	lim->max_hw_copy_sectors = 0;
> 
> For readability, I would keep "hw" next to sectors/nr_ranges:
> 
> max_copy_hw_sectors
> max_copy_sectors
> max_copy_hw_nr_ranges
> max_copy_nr_ranges
> max_copy_range_hw_sectors
> max_copy_range_sectors
>

acked

> > +	lim->max_copy_sectors = 0;
> > +	lim->max_hw_copy_nr_ranges = 0;
> > +	lim->max_copy_nr_ranges = 0;
> > +	lim->max_hw_copy_range_sectors = 0;
> > +	lim->max_copy_range_sectors = 0;
> >  }
> >  EXPORT_SYMBOL(blk_set_default_limits);
> >  
> > @@ -81,6 +87,12 @@ void blk_set_stacking_limits(struct queue_limits *lim)
> >  	lim->max_dev_sectors = UINT_MAX;
> >  	lim->max_write_zeroes_sectors = UINT_MAX;
> >  	lim->max_zone_append_sectors = UINT_MAX;
> > +	lim->max_hw_copy_sectors = ULONG_MAX;
> > +	lim->max_copy_sectors = ULONG_MAX;
> > +	lim->max_hw_copy_range_sectors = UINT_MAX;
> > +	lim->max_copy_range_sectors = UINT_MAX;
> > +	lim->max_hw_copy_nr_ranges = USHRT_MAX;
> > +	lim->max_copy_nr_ranges = USHRT_MAX;
> >  }
> >  EXPORT_SYMBOL(blk_set_stacking_limits);
> >  
> > @@ -177,6 +189,45 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
> >  }
> >  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
> >  
> > +/**
> > + * blk_queue_max_copy_sectors - set max sectors for a single copy payload
> > + * @q:  the request queue for the device
> > + * @max_copy_sectors: maximum number of sectors to copy
> > + **/
> > +void blk_queue_max_copy_sectors(struct request_queue *q,
> 
> This should be blk_queue_max_copy_hw_sectors().
>

acked. Reasoning being, this function is used only by driver once for setting hw
limits ?

> > +		unsigned int max_copy_sectors)
> > +{
> > +	q->limits.max_hw_copy_sectors = max_copy_sectors;
> > +	q->limits.max_copy_sectors = max_copy_sectors;
> > +}
> > +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors);
> > +
> > +/**
> > + * blk_queue_max_copy_range_sectors - set max sectors for a single range, in a copy payload
> > + * @q:  the request queue for the device
> > + * @max_copy_range_sectors: maximum number of sectors to copy in a single range
> > + **/
> > +void blk_queue_max_copy_range_sectors(struct request_queue *q,
> 
> And this should be blk_queue_max_copy_range_hw_sectors(). Etc for the
> other ones below.
> 

acked

> > +		unsigned int max_copy_range_sectors)
> > +{
> > +	q->limits.max_hw_copy_range_sectors = max_copy_range_sectors;
> > +	q->limits.max_copy_range_sectors = max_copy_range_sectors;
> > +}
> > +EXPORT_SYMBOL_GPL(blk_queue_max_copy_range_sectors);
> > +
> > +/**
> > + * blk_queue_max_copy_nr_ranges - set max number of ranges, in a copy payload
> > + * @q:  the request queue for the device
> > + * @max_copy_nr_ranges: maximum number of ranges
> > + **/
> > +void blk_queue_max_copy_nr_ranges(struct request_queue *q,
> > +		unsigned int max_copy_nr_ranges)
> > +{
> > +	q->limits.max_hw_copy_nr_ranges = max_copy_nr_ranges;
> > +	q->limits.max_copy_nr_ranges = max_copy_nr_ranges;
> > +}
> > +EXPORT_SYMBOL_GPL(blk_queue_max_copy_nr_ranges);
> > +
> >  /**
> >   * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
> >   * @q:  the request queue for the device
> > @@ -572,6 +623,14 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >  	t->max_segment_size = min_not_zero(t->max_segment_size,
> >  					   b->max_segment_size);
> >  
> > +	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
> > +	t->max_hw_copy_sectors = min(t->max_hw_copy_sectors, b->max_hw_copy_sectors);
> > +	t->max_copy_range_sectors = min(t->max_copy_range_sectors, b->max_copy_range_sectors);
> > +	t->max_hw_copy_range_sectors = min(t->max_hw_copy_range_sectors,
> > +						b->max_hw_copy_range_sectors);
> > +	t->max_copy_nr_ranges = min(t->max_copy_nr_ranges, b->max_copy_nr_ranges);
> > +	t->max_hw_copy_nr_ranges = min(t->max_hw_copy_nr_ranges, b->max_hw_copy_nr_ranges);
> > +
> >  	t->misaligned |= b->misaligned;
> >  
> >  	alignment = queue_limit_alignment_offset(b, start);
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index 88bd41d4cb59..bae987c10f7f 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -212,6 +212,129 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
> >  	return queue_var_show(0, page);
> >  }
> >  
> > +static ssize_t queue_copy_offload_show(struct request_queue *q, char *page)
> > +{
> > +	return queue_var_show(blk_queue_copy(q), page);
> > +}
> > +
> > +static ssize_t queue_copy_offload_store(struct request_queue *q,
> > +				       const char *page, size_t count)
> > +{
> > +	unsigned long copy_offload;
> > +	ssize_t ret = queue_var_store(&copy_offload, page, count);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (copy_offload && !q->limits.max_hw_copy_sectors)
> > +		return -EINVAL;
> > +
> > +	if (copy_offload)
> > +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> > +	else
> > +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t queue_copy_max_hw_show(struct request_queue *q, char *page)
> > +{
> > +	return sprintf(page, "%llu\n",
> > +		(unsigned long long)q->limits.max_hw_copy_sectors << 9);
> > +}
> > +
> > +static ssize_t queue_copy_max_show(struct request_queue *q, char *page> +{
> > +	return sprintf(page, "%llu\n",
> > +		(unsigned long long)q->limits.max_copy_sectors << 9);
> > +}
> > +
> > +static ssize_t queue_copy_max_store(struct request_queue *q,
> > +				       const char *page, size_t count)
> > +{
> > +	unsigned long max_copy;
> > +	ssize_t ret = queue_var_store(&max_copy, page, count);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (max_copy & (queue_logical_block_size(q) - 1))
> > +		return -EINVAL;
> > +
> > +	max_copy >>= 9;
> > +	if (max_copy > q->limits.max_hw_copy_sectors)
> > +		max_copy = q->limits.max_hw_copy_sectors;
> > +
> > +	q->limits.max_copy_sectors = max_copy;
> > +	return ret;
> > +}
> > +
> > +static ssize_t queue_copy_range_max_hw_show(struct request_queue *q, char *page)
> > +{
> > +	return sprintf(page, "%llu\n",
> > +		(unsigned long long)q->limits.max_hw_copy_range_sectors << 9);
> > +}
> > +
> > +static ssize_t queue_copy_range_max_show(struct request_queue *q,
> > +		char *page)
> > +{
> > +	return sprintf(page, "%llu\n",
> > +		(unsigned long long)q->limits.max_copy_range_sectors << 9);
> > +}
> > +
> > +static ssize_t queue_copy_range_max_store(struct request_queue *q,
> > +				       const char *page, size_t count)
> > +{
> > +	unsigned long max_copy;
> > +	ssize_t ret = queue_var_store(&max_copy, page, count);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (max_copy & (queue_logical_block_size(q) - 1))
> > +		return -EINVAL;
> > +
> > +	max_copy >>= 9;
> > +	if (max_copy > UINT_MAX)
> 
> On 32-bits arch, unsigned long and unsigned int are the same so this test
> is useless for these arch. Better have max_copy declared as unsigned long
> long.
>

acked

--
Nitesh Shetty

------KqMzgBRJR.Fsk82YJsMcER2lgAm37zzR_kphVf-KeEbAMdws=_17fd8_
Content-Type: text/plain; charset="utf-8"


------KqMzgBRJR.Fsk82YJsMcER2lgAm37zzR_kphVf-KeEbAMdws=_17fd8_--
