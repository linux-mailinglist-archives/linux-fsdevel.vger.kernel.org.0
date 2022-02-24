Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CDE4C3C90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 04:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbiBYDp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 22:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiBYDpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:45:23 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E592692A8;
        Thu, 24 Feb 2022 19:44:51 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220225034449epoutp0454529f6363f3f2f29cbc69367439caa4~W6qCj06eN1072710727epoutp04C;
        Fri, 25 Feb 2022 03:44:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220225034449epoutp0454529f6363f3f2f29cbc69367439caa4~W6qCj06eN1072710727epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645760689;
        bh=NG/IL88Cl8lqgSuGQ/Apf7wtDtAM8jMj2OGLyD5YvRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=exg/X1NZIStEiXXmgsH5fAmzrlm0DU/L4RoRtn0Hh5NeZ6pQ0wxfvazrJh67/M6xR
         ZKIFIl21UhuS650BDjq3prjbbUxwdNp0uoIqt4BlHKVahns0Yp6rNBm7m2sgqs5fhj
         osXqrQ1oUJW2mwSLFbkngvukdcjOfQt8qStiHkAE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220225034449epcas5p4465c2410a24e7f56ea2b18353c2c9e03~W6qCLdBa62547825478epcas5p4P;
        Fri, 25 Feb 2022 03:44:49 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K4bHr2T2rz4x9QC; Fri, 25 Feb
        2022 03:44:40 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.1D.46822.DBF48126; Fri, 25 Feb 2022 12:40:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220224123104epcas5p2dcd648165a43bbcc9374d61d27a8cca6~WuMO1sqah2860728607epcas5p2e;
        Thu, 24 Feb 2022 12:31:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220224123104epsmtrp2bfc11f91c4849ed260cdf4934818c183~WuMOzjhY33101731017epsmtrp24;
        Thu, 24 Feb 2022 12:31:04 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-39-62184fbda365
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.22.29871.88A77126; Thu, 24 Feb 2022 21:31:04 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220224123100epsmtip27e025628a07ecd9ca8cb4f0f0113b5fc~WuMKmUXOJ3190931909epsmtip2X;
        Thu, 24 Feb 2022 12:30:59 +0000 (GMT)
Date:   Thu, 24 Feb 2022 17:56:03 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, Alasdair Kergon <agk@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] dm: Add support for copy offload.
Message-ID: <20220224122603.GC9117@test-zns>
MIME-Version: 1.0
In-Reply-To: <YhUIny/Huielcit9@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHPffu3l1s1i4L6BGGoHV0cFlwl1cHBiEndG7oDFRWWBYucIdl
        WHZ39mFARiBhKRCCRrY+QHlsQDwEIQSWURwgHgbxChkeKpAMJi8xwVDa5WL13+f3Pd/v+f3O
        OXO4OL+LY8uNUmhptUIqFxAbWTW3djq5GINgmPjJ8VdQeXsLjhruPGajkpEMAmXPLeNo9uY4
        G2VlnOOg3olNyDhzno26l5IwNF65iqGGK1kYKippxtADQx5A9ZfnMXSyoxtDK/ckqHn1EYGy
        mgYAmuzXY8g45IwajG0s1Ft3gUA5hZMclPp7LYEaHxpxZGh9gaFf9SsEqp1IAujWaD8LlT2c
        ZaETV58AlJK2zEFdz1vZb75O9fbtp/RjtwkqM3mGQ13Xj3CortGrLCo5d5hF9d7WUZXFJwmq
        Kv9L6sygAVD1dxIJ6nhnM06dW1gkqPTkGYKanxxiUbON/UTw5o+ifWW0NIJWO9KKcGVElCJy
        t2D/e6FvhXp6iSUuEm/0hsBRIY2hdwsCDgS77IuSm65O4HhUKteZpGCpRiPY5eerVuq0tKNM
        qdHuFtCqCLnKQ+WqkcZodIpIVwWt9ZGIxW6eJuORaJl+7gKhMm6PnTDexxNBj/0pYMGFpAds
        r8lhnQIbuXyyHsDzPzYAplgAMNuQyGGKvwDsO1mKv4wkp39LMAtGAO/qv2YzxR8A6iufsc0u
        FrkdZnWOmJjLJUhn2LHKNaO1SR7KDjDbcdJAwGe95YTZbkX6w/qfL61FeaQIlhuGWQxbwrYf
        JtbYghTC4s5sjpltyG3wRk0rZt4Ikic2wtqpasBMFwCrBrsIhq3gdOs1DsO28PGMkWACqQAu
        dY6tp88BmHw6eT3hD39reI6ZR8VJGZweDmdke/hdexlmZpzcBNP/nsAYnQdrL73kbfCn8tz1
        bbbCgadJ60zBG18tr10dnxwBsHHM7zRw0P/vcPr/uunXOohgbv0Cwch20PCCy+BOWF63Kxew
        i8FWWqWJiaQ1nio3Bf3Zvw8eroypBGs/SxhYC+7dnXNtAhgXNAHIxQXWvPEvtoTxeRHSuHha
        rQxV6+S0pgl4mp4qE7e1CVeavqZCGyrx8BZ7eHl5eXi7e0kEW3gdkRVSPhkp1dLRNK2i1S9z
        GNfCNhHTHXIL2Xd0Q3d7S6VDW7OooGKxefFiXcGOlnyRw5HM14qqRU7pwskdHdpjG9TLvp+k
        9GXGxkd/CO2qWoKsgs/0ZCxesKp+mp7zS+G8dUKo0wj3VF31gQfD6qAI3tm0j8NbFf5eF7U2
        e5LkzwLibrrLUnh+zVP89kfzYl31Qbt32XFNpTfi92TWJHxe9adbbIjPN9Fh3c5t9DHLQwdX
        SjqHbcrd7V0T5PlX0FwoZ/Or2Xml9NsH0j4N/CClsUy4rf9wEev766p57eXBvIwpYZfMfq94
        rq94PqdbmdtVcHi6wi4vovC+j4Wq5lrK+RDq/aXAs8KwJ6J34ntaJBusRlMt7QaCAgUsjUwq
        EeJqjfQfWeKdzeIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH977n9PS0SZdDqfJSootdzCJOBLPF94MXDDBP4pZIpotZZqCV
        E0Apdr14IduEtSyCA6FNCOtGxVsbyrwARsBSVKQ2SBGQIZdQqrMdcUagoE5SCrM2y/z2y/+W
        58NDE+JqnpTOL9Ry6kJ5gYwSktfvyD7YcLIoTpFcXyXBV+7dJXDH2DwPN3pPU7hmdoHAM7ef
        8LDxdC0fD/nfx87pX3l44HUJxE+alyHuOGeEuKHRBfGU7TzAjrNBiMt6ByBefJyCXcvPKWzs
        eghwYNgMsXN8Pe5w9pB46MZvFD5jDfDxqZE2Cnc+cxLY5l6C+L55kcJt/hKA70wOk/jysxkS
        /9T0EuDSnxf4uD/s5qWuYYf+2MWafX0UW62f5rPtZi+f7Z9sIll9/QTJDvXp2GZ7GcW2XDjB
        mkZtgHWMFVPsjx4XwdbOvaDYCv00xQYD4yQ70zlM7V75tXBLDleQf4RTb9yWLcx72TQIVWHZ
        scFX9bAYNCaUAwGNmE+QvqKSKgdCWsw4ALJ0e6moEY+s4W4iyrGoYWmKHw35AZo3PeJHDJJZ
        i4weL68c0DTFrEe9y3QEJW/k8Zr0SJxgLlFoqqUfRuKxzHbkaLXwIixiPkZXbBNkdNMHUPCi
        i4oaMajnFz8ZYYJJRKNLT2FklGASkG2JjsiCN7LdU/P2hBXMh+jWdTesAjHmd9rmd9rm/9v1
        gLCDeE6lUeYqNSmqlELuaJJGrtToCnOTDhxWNoO3X5O4rg202meTugCkQRdANCGTiD79dqVC
        LMqRHy/i1Iez1LoCTtMFEmhSFicaKO/JEjO5ci13iONUnPo/F9ICaTFMtx9sMX7vfv3nCq0l
        UJT8e15syFO1GKOfE94aTGuVju38fE2Jdh+8OXwXooc7H5VKb2ccyDgjST4/nf/3kQe+0qf3
        rAvZlqtlvYKg68IE3eezjPyQeVGwa/V4RdwOb/zGB8KQ40SSQWDPNKaWjVSK2p9f0xukx8He
        r/rqNryK/WZ1xY6t1hcKxWAw1P3FDb/pviML1nk2T3Wf/K5FsT10yWQwdkpGi0GNKjSXU3dz
        LjXz8ar9PtFR2SnTqC4u37k1rXTTMUu1dkvlnr2Q2/ZleoCoXvVX5eZr7wmtZ2N42WkfzQ5M
        hg3hq8r2zAZxrTtw+Z/Pzun2y0cKDmbM9+82yEhNnjwlkVBr5P8C+UQeB6QDAAA=
X-CMS-MailID: 20220224123104epcas5p2dcd648165a43bbcc9374d61d27a8cca6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_b24cc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080649epcas5p36ab21e7d33b99eac1963e637389c8be4
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080649epcas5p36ab21e7d33b99eac1963e637389c8be4@epcas5p3.samsung.com>
        <20220214080002.18381-9-nj.shetty@samsung.com> <YhUIny/Huielcit9@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_b24cc_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Feb 22, 2022 at 11:00:31AM -0500, Mike Snitzer wrote:
> On Mon, Feb 14 2022 at  2:59P -0500,
> Nitesh Shetty <nj.shetty@samsung.com> wrote:
> 
> > Before enabling copy for dm target, check if underlying devices and
> > dm target support copy. Avoid split happening inside dm target.
> > Fail early if the request needs split, currently splitting copy
> > request is not supported.
> > 
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > ---
> >  drivers/md/dm-table.c         | 45 +++++++++++++++++++++++++++++++++++
> >  drivers/md/dm.c               |  6 +++++
> >  include/linux/device-mapper.h |  5 ++++
> >  3 files changed, 56 insertions(+)
> > 
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index e43096cfe9e2..8dc9ae6a6a86 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -1903,6 +1903,38 @@ static bool dm_table_supports_nowait(struct dm_table *t)
> >  	return true;
> >  }
> >  
> > +static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
> > +				      sector_t start, sector_t len, void *data)
> > +{
> > +	struct request_queue *q = bdev_get_queue(dev->bdev);
> > +
> > +	return !blk_queue_copy(q);
> > +}
> > +
> > +static bool dm_table_supports_copy(struct dm_table *t)
> > +{
> > +	struct dm_target *ti;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < dm_table_get_num_targets(t); i++) {
> > +		ti = dm_table_get_target(t, i);
> > +
> > +		if (!ti->copy_supported)
> > +			return false;
> > +
> > +		/*
> > +		 * target provides copy support (as implied by setting
> > +		 * 'copy_supported') and it relies on _all_ data devices having copy support.
> > +		 */
> > +		if (ti->copy_supported &&
> > +		    (!ti->type->iterate_devices ||
> > +		     ti->type->iterate_devices(ti, device_not_copy_capable, NULL)))
> > +			return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
> >  				      sector_t start, sector_t len, void *data)
> >  {
> > @@ -2000,6 +2032,19 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
> >  	} else
> >  		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> >  
> > +	if (!dm_table_supports_copy(t)) {
> > +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
> > +		/* Must also clear discard limits... */
> 
> copy-and-paste mistake: s/discard/copy/ ^
>

acked

> > +		q->limits.max_copy_sectors = 0;
> > +		q->limits.max_hw_copy_sectors = 0;
> > +		q->limits.max_copy_range_sectors = 0;
> > +		q->limits.max_hw_copy_range_sectors = 0;
> > +		q->limits.max_copy_nr_ranges = 0;
> > +		q->limits.max_hw_copy_nr_ranges = 0;
> > +	} else {
> > +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> > +	}
> > +
> >  	if (dm_table_supports_secure_erase(t))
> >  		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
> >  
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index ab9cc91931f9..3b4cd49c489d 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1372,6 +1372,12 @@ static int __split_and_process_non_flush(struct clone_info *ci)
> >  	if (__process_abnormal_io(ci, ti, &r))
> >  		return r;
> >  
> > +	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
> > +				max_io_len(ti, ci->sector) < ci->sector_count)) {
> > +		DMERR("%s: Error IO size(%u) is greater than maximum target size(%llu)\n",
> > +				__func__, ci->sector_count, max_io_len(ti, ci->sector));
> > +		return -EIO;
> > +	}
> >  	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
> >  
> >  	r = __clone_and_map_data_bio(ci, ti, ci->sector, &len);
> 
> There isn't a need for __func__ prefix here.
> 
> You'll also need to rebase on latest dm-5.18 (or wait until 5.18 merge
> window opens) because there has been some conflicting changes since
> you posted.
>

acked

> > diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> > index b26fecf6c8e8..acfd4018125a 100644
> > --- a/include/linux/device-mapper.h
> > +++ b/include/linux/device-mapper.h
> > @@ -362,6 +362,11 @@ struct dm_target {
> >  	 * zone append operations using regular writes.
> >  	 */
> >  	bool emulate_zone_append:1;
> > +
> > +	/*
> > +	 * copy offload is supported
> > +	 */
> > +	bool copy_supported:1;
> >  };
> 
> Would prefer this be "copy_offload_supported".
> 

acked, will update in next series.

--
Nitesh Shetty

------w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_b24cc_
Content-Type: text/plain; charset="utf-8"


------w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_b24cc_--
