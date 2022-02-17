Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB04BB11B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 06:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiBRFB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 00:01:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiBRFBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:01:14 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711852BCA83;
        Thu, 17 Feb 2022 21:00:54 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220218050052epoutp03d91cfa16b6fa4a5938cf3c95b83c923c~UyLb-sZkN1838918389epoutp03_;
        Fri, 18 Feb 2022 05:00:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220218050052epoutp03d91cfa16b6fa4a5938cf3c95b83c923c~UyLb-sZkN1838918389epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645160452;
        bh=qK0Db7DE4FPkYkFTizqzCYGIigvy1nkNn6Hr9Lykvoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gOtFxKEQVPkzhX30rY5YgMnbj5s/xh7CiVZTaDACsNpphU8HeO5VxX9LNWxhgH+2o
         I4X1EYctLQqIfI8zqzDxBf+EXro33sPKB5nQq8Qc3gTC5YOeG5i8QYxP4XPuataa/x
         Uynud4WA7A5EfX8UUOQAZxhYJ8CSHbwSrNJqfbT0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220218050051epcas5p1364c8f46134da12ab9f98c6e135615f5~UyLbWQtpz0935609356epcas5p15;
        Fri, 18 Feb 2022 05:00:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K0KJr1m5Dz4x9Q8; Fri, 18 Feb
        2022 05:00:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.F7.05590.BF72F026; Fri, 18 Feb 2022 14:00:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220217130401epcas5p1c671c22f1b3d8ff7c662763f0cdb9bb5~UlIATE4D-3210232102epcas5p1K;
        Thu, 17 Feb 2022 13:04:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220217130401epsmtrp23758e5a1d5a2620ddbd620ec4d9c6a90~UlIARikU73066630666epsmtrp2C;
        Thu, 17 Feb 2022 13:04:01 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-59-620f27fb9e31
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.BD.08738.1C74E026; Thu, 17 Feb 2022 22:04:01 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217130356epsmtip28c51f7f8d8b35afe7c013782e59c1ca4~UlH7t34aT1085610856epsmtip2R;
        Thu, 17 Feb 2022 13:03:56 +0000 (GMT)
Date:   Thu, 17 Feb 2022 18:29:01 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@lst.de, javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Message-ID: <20220217125901.GA3781@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220217090700.b7n33vbkx5s4qbfq@garbanzo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BTRxTG3ZvkJtAGrwFhhYmmYWxEXglCWCpYx1p7W+wIQ1tHWwevcAsM
        kGTysK11FEQ6Gh4CFguxYGo7BdHyKlrkJSCY4SUoBUEEoTxkCgKCKChKEwJt//vtN9939uye
        ORwGr5Ntz4mQqWmljIoS4pbMazedRK4vRasPiRcTeaig8RYDVXTPsNDl3jM4Ojc1z0CTNYMs
        lHYmg43ah6xQ5cR5Fmqbi8XQYPEihioupmHo0uV6DD3K+Rmg8p+eYOh0UxuGFgYkqH7xMY7S
        ajsBGu7QYajyvjOqqGxgovayH3F04ddhNkq4V4qjqrFKBsoxvMZQV8owQLd1CzgqHYoF6GZf
        BxPlj00y0dhcA46+K5oFKD5xno1aXxlY2x3J9j/9Sd3DFpxMjZtgk9d1vWyyta+IScbpHzDJ
        9hYNWZx3Gid//+U4ebYrB5Dl3TE4eaK5nkFmTD/FyaS4CZx8MnyfSU5WdeABtvsjfcNpKpRW
        CmhZiDw0QhbmJ/QPCn4v2EsqlrhKfJC3UCCjomk/4c7dAa67IqKMnygUHKaiNEYpgFKphO7b
        fJVyjZoWhMtVaj8hrQiNUngq3FRUtEojC3OT0ep3JGKxh5fReDAyPLa0i6WYl36dmyuKAQMu
        WmDBgYQnLGtux7TAksMjygGsKTnBMh+mAUwZHWKbXDxiBsDY+K0riZFzXcumMmOiu5BtPowA
        mPXi0VKCSWyEj7XFRheHgxPOsGmRY5JtiE2wKiUJMzGDmMVh6u39Jos18Rlsq95okrmEC0w4
        1coy8xrYkDnENLEF4Q0vzOmXeC3hCKuvGZa6hkSmJXxW1QNMdSCxE/b0K8x9WsO/DSVsM9vD
        mYlK3OxPAHCu+eFyOAPAuJQ43Ox6F96peIWZCjGIcJiWKTHLfJjemL/csxVMejmEmXUuLM1e
        YUd4pUC/XGYd7Hweu8wkNLSP4ub/GQdwNruOkQI26P73ON1/1+mWrnCB+vJp3Cw7wJzXHDM6
        wYIydz1g5YF1tEIVHUarvBRbZPRX/047RB5dDJYWbLN/Kfirf8qtFmAcUAsghyG04U7VcA/x
        uKHUN0dopTxYqYmiVbXAyzipVIb92hC5cUNl6mCJp4/YUyqVevpskUqEdtzGsEKKR4RRajqS
        phW0ciWHcSzsYzAHOUMXZLshN8l2MOb5bqtsjy+aHAzrA6n4T3yo+sQHQRcTUA+6Uey4V5v8
        VpDdVkrcm2+b47tNfooe44ssQjfta5G6p2YSvgenkoOqpCibVfqtI8RffPl+wXgg2Pub93HF
        gFPwQmHWScK6rqQ/dp6trY7u2CVL/jSR5ydade8pP/7OpZqrJ9UOoyU5zw4fE+h7q2yyk99c
        nZXhXEsdW1M7uP2uRvuh2vUqNXj3ut/nctLJ/sCemFseuG4wqUCXLg4+u35iqC49u+vtP66c
        1+0I4H8kEhzt49/oXdUTaKn6QYNxM/OU+yaOWB/4+IM3+NQeN2LmqJ3vCFkYOf590ZjYVshU
        hVOSzQylivoHaFGXcekEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH87v39vZSU70Udb9qmFsVMMXhYEzO2Nh8BW9i2EhmjNscWuUO
        HBRYCwImizw2JwUGQyVSZVQhNmK2hfpYhZa0ddAhryqipYgLQjXa8dxkEAtshS3zv2/O9/M5
        55/DkJIzglXMobRMXpWmSJXRIuraDdma16w7lh54fbY3EH662UqCqe8PAVwaKKOhcnyGhDHr
        kAAqyk4LoWd4KZhHzwjAMZ1PwJBhngDT+QoCLl5qIeCxvhZB07kJAoraHQR4B8OhZX6Ehgrb
        XQTuXi0BZlcomMxtFPQ0nqWh5oJbCMX3jDQ0e8wk6O1zBDjL3Qi6tF4ajMP5CG486KXgR88Y
        BZ7pNhqONTxD8HXJjBC6Z+2CzWu5njs7Oe1vnTT3XeGokLuuHRBy3Q8aKK5Qd5/iejqzOEN9
        Ec1drjvKnXDqEdfUl0dzBR0tJHd68k+aKy0cpbkJt4vixpp76fiVH4veSeRTDx3mVRvf3S9K
        vmstEGYYI3MmS2oEeahRrkF+DGYj8aNKp0CDRIyENSJ8snZSuFhI8YXZX8jFHIAvzj0WLkLD
        CFssEwsFxQbhEY3hH5thaDYUt88zvvFydj1uLi8lfDzJPqdxQ7WV9DEB7G7ssAT5GDG7ARcf
        7/738O8Ie+2d9GLhj9uqhilfJlk5ds49IXwuya7G+rmF/X5sFK6Z1i0gK9i12HLNTpQjf+0L
        tvYFW/u/rUNkPZLyGWplklIdnhGRxmeHqRVKdVZaUtjBdKUBLfyPXG5EpvrxMBsiGGRDmCFl
        y8XjVvEBiThRkXuEV6XvU2Wl8mobWs1QspfEDk3bPgmbpMjkU3g+g1f91xKM36o84lxK/hNl
        wrcrX9WnTyXXuY4/fTOFehTctbu0f2f/kuxcictRUOTwblsz9srllCF3wlbviabnsRtGt3UW
        Sb98pgs5teuWq/HkN+uKq0gzGbFpy9tv1YKl6haeGahcEhP11GNadzS+qvUvSegXtz9ICEne
        DpaOwIaHgVNXdB1xnzZvvBI7G3A1Zj9Xqv9c53ffHt1yJDImOI79eZnhs9hl328aTAwZeLn+
        vS0a6UfVhfKuuDvXSzyi1K/WO+h4zp/8xBrlX5YZXIanf90hzK0jm+Jvtr5RfXvPZoPn/IcH
        D2fuehjdbuH3KM72B72/IsJzT2rL7hsk8qci9v6wFeVEu0Yo57EcGaVOVoTLSZVa8TfrqJgv
        rgMAAA==
X-CMS-MailID: 20220217130401epcas5p1c671c22f1b3d8ff7c662763f0cdb9bb5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----8TtN9ZnHmYbjupaEpeShJ04PQlBV3ZvePY_ZWnFgjSBPeLtG=_8e144_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
        <20220214080002.18381-3-nj.shetty@samsung.com>
        <20220217090700.b7n33vbkx5s4qbfq@garbanzo>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------8TtN9ZnHmYbjupaEpeShJ04PQlBV3ZvePY_ZWnFgjSBPeLtG=_8e144_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

 Thu, Feb 17, 2022 at 01:07:00AM -0800, Luis Chamberlain wrote:
> The subject says limits for copy-offload...
> 
> On Mon, Feb 14, 2022 at 01:29:52PM +0530, Nitesh Shetty wrote:
> > Add device limits as sysfs entries,
> >         - copy_offload (RW)
> >         - copy_max_bytes (RW)
> >         - copy_max_hw_bytes (RO)
> >         - copy_max_range_bytes (RW)
> >         - copy_max_range_hw_bytes (RO)
> >         - copy_max_nr_ranges (RW)
> >         - copy_max_nr_ranges_hw (RO)
> 
> Some of these seem like generic... and also I see a few more max_hw ones
> not listed above...
>
queue_limits and sysfs entries are differently named.
All sysfs entries start with copy_* prefix. Also it makes easy to lookup
all copy sysfs.
For queue limits naming, I tried to following existing queue limit
convention (like discard).

> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > +/**
> > + * blk_queue_max_copy_sectors - set max sectors for a single copy payload
> > + * @q:  the request queue for the device
> > + * @max_copy_sectors: maximum number of sectors to copy
> > + **/
> > +void blk_queue_max_copy_sectors(struct request_queue *q,
> > +		unsigned int max_copy_sectors)
> > +{
> > +	q->limits.max_hw_copy_sectors = max_copy_sectors;
> > +	q->limits.max_copy_sectors = max_copy_sectors;
> > +}
> > +EXPORT_SYMBOL(blk_queue_max_copy_sectors);
> 
> Please use EXPORT_SYMBOL_GPL() for all new things.
> 
acked.

> Why is this setting both? The documentation does't seem to say.
> What's the point?
>

This function is used only by driver, while intializing request queue.
I will put this as part of description next time.

> > +
> > +/**
> > + * blk_queue_max_copy_range_sectors - set max sectors for a single range, in a copy payload
> > + * @q:  the request queue for the device
> > + * @max_copy_range_sectors: maximum number of sectors to copy in a single range
> > + **/
> > +void blk_queue_max_copy_range_sectors(struct request_queue *q,
> > +		unsigned int max_copy_range_sectors)
> > +{
> > +	q->limits.max_hw_copy_range_sectors = max_copy_range_sectors;
> > +	q->limits.max_copy_range_sectors = max_copy_range_sectors;
> > +}
> > +EXPORT_SYMBOL(blk_queue_max_copy_range_sectors);
> 
> Same here.
> 
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
> > +EXPORT_SYMBOL(blk_queue_max_copy_nr_ranges);
> 
> Same.
> 
> > +
> >  /**
> >   * blk_queue_max_write_same_sectors - set max sectors for a single write same
> >   * @q:  the request queue for the device
> > @@ -541,6 +592,14 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
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
> > index 9f32882ceb2f..9ddd07f142d9 100644
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
> 
> 
> If the kernel schedules, copy_offload may still be true and
> max_hw_copy_sectors may be set to 0. Is that an issue?
>

This check ensures that, we dont enable offload if device doesnt support
offload. I feel it shouldn't be an issue.

> > +
> > +	if (copy_offload)
> > +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> > +	else
> > +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
> 
> The flag may be set but the queue flag could be set. Is that an issue?
> 
> > @@ -597,6 +720,14 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
> >  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
> >  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
> >  
> > +QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
> > +QUEUE_RO_ENTRY(queue_copy_max_hw, "copy_max_hw_bytes");
> > +QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
> > +QUEUE_RO_ENTRY(queue_copy_range_max_hw, "copy_max_range_hw_bytes");
> > +QUEUE_RW_ENTRY(queue_copy_range_max, "copy_max_range_bytes");
> > +QUEUE_RO_ENTRY(queue_copy_nr_ranges_max_hw, "copy_max_nr_ranges_hw");
> > +QUEUE_RW_ENTRY(queue_copy_nr_ranges_max, "copy_max_nr_ranges");
> 
> Seems like you need to update Documentation/ABI/stable/sysfs-block.
>

acked. 

> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index efed3820cbf7..792e6d556589 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -254,6 +254,13 @@ struct queue_limits {
> >  	unsigned int		discard_alignment;
> >  	unsigned int		zone_write_granularity;
> >  
> > +	unsigned long		max_hw_copy_sectors;
> > +	unsigned long		max_copy_sectors;
> > +	unsigned int		max_hw_copy_range_sectors;
> > +	unsigned int		max_copy_range_sectors;
> > +	unsigned short		max_hw_copy_nr_ranges;
> > +	unsigned short		max_copy_nr_ranges;
> 
> Before limits start growing more.. I wonder if we should just
> stuff hw offload stuff to its own struct within queue_limits.
> 
> Christoph?
> 
>   Luis
>
Yeah, would like to know community opinion on this.


-- Nitesh

------8TtN9ZnHmYbjupaEpeShJ04PQlBV3ZvePY_ZWnFgjSBPeLtG=_8e144_
Content-Type: text/plain; charset="utf-8"


------8TtN9ZnHmYbjupaEpeShJ04PQlBV3ZvePY_ZWnFgjSBPeLtG=_8e144_--
