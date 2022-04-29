Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD12B515173
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379457AbiD2RUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379100AbiD2RUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:20:00 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869458878E;
        Fri, 29 Apr 2022 10:16:41 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220429171638usoutp02eb11944212bbad4d6c61b377f484439f~qbX1sF-kC2806928069usoutp02K;
        Fri, 29 Apr 2022 17:16:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220429171638usoutp02eb11944212bbad4d6c61b377f484439f~qbX1sF-kC2806928069usoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651252598;
        bh=2XGdYd/SjcBGd5d7dysZkIrck12E/j/iG27vLdTdMNM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=VPmgXZQK0/RfLExiUeX2A62bn/alMCrbSg6gAKYVsTlURT1kjYybA1dcCa8eSfwGv
         DQKRvZney48e4UeLY3dmOcsqJwyGBGwlnKNNkTQtAdQC1HXVW2nwwiYOX1aaF/3ZkL
         fVJVFK+SeAwtaCFEFWaR26IvRwSkrIXrq1XK5o08=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220429171638uscas1p131c2d50f50206b6e406bc36481e59170~qbX1f9CZE2081520815uscas1p1x;
        Fri, 29 Apr 2022 17:16:38 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id EA.10.09642.67D1C626; Fri,
        29 Apr 2022 13:16:38 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220429171638uscas1p23b334cc35b918428c7c3938fb1df6ef2~qbX06f9RV3222232222uscas1p2u;
        Fri, 29 Apr 2022 17:16:38 +0000 (GMT)
X-AuditID: cbfec36f-c15ff700000025aa-e6-626c1d76f171
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id C4.43.09672.57D1C626; Fri,
        29 Apr 2022 13:16:37 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.7; Fri, 29 Apr 2022 10:16:36 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.007; Fri,
        29 Apr 2022 10:16:36 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "clm@fb.com" <clm@fb.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "agk@redhat.com" <agk@redhat.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/16] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Thread-Topic: [PATCH 01/16] block: make blkdev_nr_zones and
        blk_queue_zone_no generic for npo2 zsze
Thread-Index: AQHYWlBSHPfSzcQATUGVFhddlprDmK0HmneA
Date:   Fri, 29 Apr 2022 17:16:36 +0000
Message-ID: <20220429171628.GA174938@bgt-140510-bm01>
In-Reply-To: <20220427160255.300418-2-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E6427266D2D7F4C8C5CD9B93D12C2A5@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0xTVxTHd997fX3tQB6VwR2oG43OORkDAuRmKmEBwzNG47YMM8RplceP
        WChpgU3mYhWRUTVUHIRVGFA6EOuGwLJosbqV8dOxThHQDjSV1miQioBKi5BZXk363/fc8/me
        8z3JpXCRiQymsnLyWHmORComhcTv3c/MHxaslO6LqH4Uilr6u3GkHysjUeWUE0fXKwYwVF5W
        xUfzA2YcGR1neejfuSMYatZ3YcjWosHRyT+mCLSguvvq7ZgVRy+tkajcNAyQfUiDIaNlPbo5
        fo6PbmqT0BVjH4EGDdUkqm2085H6+DMc3VbbATrd085Dv048IVCvJSQ+hBm8tZVZ7L1AMqeL
        HHzGfLeVYAYH8pm286UkU6+swJl23WGmo24GYzruKEnmVJGDZC4X3+MxT64OkUzLb0MEo25v
        5TEzbat2+KcIN6ax0qwCVv5R3F5hZm2Nk5/bLPpmsqucrwQlfiogoCAdDQf0TqACQkpENwOo
        vP+IzxXFGDyp/R57TbmOzGFc4xcA60qbPJanAFb94/IUjQA2O2dJt4WkI+B8Tyvu1gH0+/DB
        rfalUTitehOOVUSrAEUtp9OgpfcTDmFhQ9Mgj9NR0G69SLg1Qa+B3ZXFS1ZfOga2W48uMQJ6
        A1woa1hiAB0IX/Rf8IwPghZbrSe1P9SevYJzOhAuGqwkp0PhvRfuM918GKzrmCY5HQeNRZWe
        9/WwsX4C5/b6w74fbQTnfRv+ee424b4X0q1C+EP9IJ9rJEKbXulZEAIXxhoxDioBcEp9lccV
        agBHJ50eagNcLB3mq8FqjVdyjVcqjVcqjVcqjVeqOsA7D4LyFYrsDFYRlcN+Ha6QZCvyczLC
        98uy28Crb359sVN2CYxYnoabAEYBE4AULg7wne3I3CfyTZMcLGTlsj3yfCmrMIEQihAH+TZm
        XZSI6AxJHnuAZXNZ+esuRgmCldg7175a2x9k+bYpbe1DY/fRKLMzPsOanezwebAiJHJseouh
        f/lOw8tVbHBn0870UZcu2Qc7tSyxYapAl5qw29dYvT+084uJmKTRA+JgvzX/9fbJNpOOxwtv
        /Nw0xzuo3Xhms0rq0l6e/ZKtiR0ZdhpG7IcT1tU93qXbliAmQ/Wp2ufH2mIjojVzsQJR3vx4
        ceSy+98VplREFH7OWzF66T1JybVdYXk1PeqZpIdnJidyWbPuRHpvVfwJvy2H2vbeSd3tSP4p
        ZdN2157qGJmN1xGWvM0YNxsYsOkGWv1WxnMQ5Zfz8Thf2ZX+t+6z1MTj44K/ZNPrPt0hP1R6
        Y2T+XR/9SqewX0woMiWRH+ByheR/joyx41UEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxiHPffe3nvpZFw7Z88E2WRbhmMi9SM52VD0D9x1ZgaTLdtkEYvc
        ALOAttSBZFmhQKVu6UdCJ50EEMJAmBUKuI0ysaN8SGoJX8Fua9NQTJgbqIxgUcgo1yX973nP
        +z6/95zk0LjIK9hKZ+fmc/JcqSyGFBLZKsywU7lNlp6gdexDljv9OGr5U0ci08MAjoYrnRgy
        6i5T6KnThaOeue8FaORJMYaaWxwY8lvMOPqm9yGBVrSetbNSH46e+STIaJ8EaGbCjKEedxwa
        nW6i0OjV95GtZ4hAY79cIVFN4wyF9OWLOJrSzwBkGLAK0PUH8wQadEcejGTHxo+yq4OtJGtQ
        z1Gsy9NGsGNOJdt+rYJk61SVOGtt+Jrtrl3A2O57KpL9Vj1Hsj+XeQXs/K8TJGvpmCBYvbVN
        wC60R6dsOiFMzOBk2ec5+a4Dp4RZNdUB6myzqOAfh5FSAU2EFoTRkNkLl4ufYFogpEVMC4Ar
        kzcEfPEIwIXHI4AvGgHUqH8kgwrJJMCnA214kDczsfD+uHVdx5mLL8DFQMOaQdMvMRnQPXiI
        n+Gg6QcT4Hk3nPHdIIJMMG/CflMZFuRwZh+0+kqeb74FYHmFmwo2wpj34Iqufl0AzBa4dKd1
        XcAZMXT7azD+DQxssLlwnl+Gs9OrAp63Q+/SLMXPvwNrux+TPB+APWrT8/M42Fj3AOcvsQkO
        VfkJ3n0F3m6aIvQAmkPWmUOizCFR5pAoc0hULRBcA2KlQpGTWaDYnct9Ga+Q5iiUuZnxp/Ny
        2sHaHxxe/S31J/C7+1G8HWA0sANI4zGbw//tzkoXhWdICy9w8rw0uVLGKewgkiZixOGzJwxp
        IiZTms+d4biznPz/LkaHbVVh0hc7dF7dpa64122f9CX8MW4anSx5tXSvcJs67t1T8JDNvvNk
        ctcXlX07quskUrFBGr3xmMx1ZMj3kb+13tnq8xxZ1nfozxn/Kjg8PGXLwizTH+6qIZfuVUdd
        vzW3/9IZbXJib3ItITuWPnb36tBoQdX+tD1FgLgtGo+qdFT8fTm1r9PYNRD4rOnThNi6CGo1
        +/TJZcPIFkm5zbnRVXwxdrv74w1LRZaIwjz/cSP1bEPKG2FVnZ78196KKvHcTDVqnCWaaUkR
        U3b/4OeJdSDpcOYH4vikZvUOdWepTv7VHk2XLynFSx5fZO42wiiPQKgJRM+f/27Ze+Fc/c3e
        QoetP4ZQZEklb+NyhfQ/zjd7GvIDAAA=
X-CMS-MailID: 20220429171638uscas1p23b334cc35b918428c7c3938fb1df6ef2
CMS-TYPE: 301P
X-CMS-RootMailID: 20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895@eucas1p2.samsung.com>
        <20220427160255.300418-2-p.raghav@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:02:40PM +0200, Pankaj Raghav wrote:
> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
> also work for non-power-of-2 zone sizes.
>=20
> As the existing deployments of zoned devices had power-of-2
> assumption, power-of-2 optimized calculation is kept for those devices.
>=20
> There are no direct hot paths modified and the changes just
> introduce one new branch per call.
>=20
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-zoned.c      | 8 +++++++-
>  include/linux/blkdev.h | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 38cd840d8838..1dff4a8bd51d 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -117,10 +117,16 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>  unsigned int blkdev_nr_zones(struct gendisk *disk)
>  {
>  	sector_t zone_sectors =3D blk_queue_zone_sectors(disk->queue);
> +	sector_t capacity =3D get_capacity(disk);
> =20
>  	if (!blk_queue_is_zoned(disk->queue))
>  		return 0;
> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return (capacity + zone_sectors - 1) >>
> +		       ilog2(zone_sectors);
> +
> +	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>  }
>  EXPORT_SYMBOL_GPL(blkdev_nr_zones);
> =20
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 60d016138997..c4e4c7071b7b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -665,9 +665,15 @@ static inline unsigned int blk_queue_nr_zones(struct=
 request_queue *q)
>  static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  					     sector_t sector)
>  {
> +	sector_t zone_sectors =3D blk_queue_zone_sectors(q);
> +
>  	if (!blk_queue_is_zoned(q))
>  		return 0;
> -	return sector >> ilog2(q->limits.chunk_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return sector >> ilog2(zone_sectors);
> +
> +	return div64_u64(sector, zone_sectors);
>  }
> =20
>  static inline bool blk_queue_zone_is_seq(struct request_queue *q,
> --=20
> 2.25.1
>


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
