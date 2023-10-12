Return-Path: <linux-fsdevel+bounces-160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED147C67E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 10:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC171C20F0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 08:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324671F19B;
	Thu, 12 Oct 2023 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oz9ILr5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15657D531
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 08:49:14 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E6B91
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 01:49:11 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231012084908epoutp01b3e85f7df266e3d6cca63ac26b9fa80c~NT-UFls0O3003430034epoutp01u
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 08:49:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231012084908epoutp01b3e85f7df266e3d6cca63ac26b9fa80c~NT-UFls0O3003430034epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697100548;
	bh=Exa89S2Wts3NHPBrMgNejGIxJv/QE+F5EA7r83atG4o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=oz9ILr5zuciMOH51svImtlHH6hNH6mZ6h4QH7oNIAjI5dLWZsuXTasCg7tTA8u5Ce
	 gwQkv5SHTVYGijMzmnsvLP5INaOSCtwf9JQY/KWOLF58/jNmq38bcDqdBC0arYGd+0
	 EtycUw7xlcTfetJkC6iiIS1iqA3XCgXrkt9AVJ9E=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231012084908epcas5p450f1a3250c22261db0ace64133e3f162~NT-Twoqlk1338813388epcas5p46;
	Thu, 12 Oct 2023 08:49:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4S5jwx6tKlz4x9Pp; Thu, 12 Oct
	2023 08:49:05 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.3E.09949.103B7256; Thu, 12 Oct 2023 17:49:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231012084905epcas5p1ea61930cd9a16256b9e997c7493163cc~NT-RU6l9I3182531825epcas5p1c;
	Thu, 12 Oct 2023 08:49:05 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231012084905epsmtrp1cd297a9c86d4a860e9456e043857542a~NT-RSsNiR0247002470epsmtrp1X;
	Thu, 12 Oct 2023 08:49:05 +0000 (GMT)
X-AuditID: b6c32a49-98bff700000026dd-f8-6527b3018d62
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	92.55.08649.103B7256; Thu, 12 Oct 2023 17:49:05 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231012084903epsmtip2a2cdd03771c4f59346b428cc81b4ff03~NT-PkYwk50937009370epsmtip2I;
	Thu, 12 Oct 2023 08:49:03 +0000 (GMT)
Message-ID: <fdf765a0-54a0-a9e9-fffa-3e733c2535b0@samsung.com>
Date: Thu, 12 Oct 2023 14:19:02 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 01/15] block: Make bio_set_ioprio() modify fewer
 bio->bi_ioprio bits
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>, Niklas Cassel
	<Niklas.Cassel@wdc.com>, Avri Altman <Avri.Altman@wdc.com>, Bean Huo
	<huobean@gmail.com>, Daejun Park <daejun7.park@samsung.com>, Damien Le Moal
	<dlemoal@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <bfb7e2be-79f8-4f5e-b87e-3045d9c937b4@acm.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmli7jZvVUg3MLTCxe/rzKZrH6bj+b
	xbQPP5ktVj0It3iw395i5eqjTBZzzjYwWey9pW2xZ+9JFovu6zvYLJYf/8dk8eDPY3YHHo/L
	V7w9ds66y+5x+Wypx6ZVnWweu282sHl8fHqLxaNvyypGj8+b5DzaD3QzBXBGZdtkpCampBYp
	pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2rpFCWmFMKFApILC5W
	0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOmPhyHmvBIcWK
	mSfXsjQwPpbuYuTkkBAwkXj39DBLFyMXh5DAbkaJgwt+M4IkhAQ+MUrcvOsIkfjGKLFrVys7
	TMfqvxdZIRJ7GSVet++Fct4ySnx7swGsilfATuLNvn/MIDaLgKrEhrkXmSHighInZz5hAbFF
	BZIkfl2dA7ZOWCBWYuHHOWC9zALiEreezGcCsUUE3CQaru5iA1nALPCWSeLhlgNA2zg42AQ0
	JS5MLgWp4RSwlti9aw4TRK+8RPPW2cwg9RICJzgkdq17AXW2i0TTl9WMELawxKvjW6DiUhIv
	+9ug7GSJSzPPMUHYJRKP9xyEsu0lWk/1M4PsZQbau36XPsQuPone30+YQMISArwSHW1CENWK
	EvcmPWWFsMUlHs5YAmV7SGy/cRAa1IuZJJY8vscygVFhFlKwzELy/iwk78xC2LyAkWUVo2Rq
	QXFuemqxaYFhXmo5PMKT83M3MYJTs5bnDsa7Dz7oHWJk4mA8xCjBwawkwvsoUyVViDclsbIq
	tSg/vqg0J7X4EKMpMH4mMkuJJucDs0NeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6Yklqdmp
	qQWpRTB9TBycUg1M6y/91pgXc3zvnKqpljsvrvgrLdUSxtc3iWlDlGCvn8Y1awuZFxHTPk34
	JGScmm3hceQZj2bC2gPT8hjbl+a7p2X7sLwT2HgnfenMiKtlARKzXzlFawntaozf0JrtJ3aV
	X0mvL+61ksEEVaGQmUffszRe13G8uVTp8zcz6R09be7NjffWXZW1evLycIeYx2XdP9IZzw+v
	TVrOzJ/QctF6174Yjlf3Zv+axyDNU1aZqvXmq/0Ru+9TTjaskBadYiN+tSksb2PyQgn2YKNN
	F2Z8fuOrzDHtwdxnTVxMrewrM9ljf3VFORQZ9YqzH3SR2351jeXjp5+0/V6w7/RjzrtwWKfu
	4OnFOfFHS7ZnbChTYinOSDTUYi4qTgQAWBZh+1YEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvC7jZvVUg2UTBCxe/rzKZrH6bj+b
	xbQPP5ktVj0It3iw395i5eqjTBZzzjYwWey9pW2xZ+9JFovu6zvYLJYf/8dk8eDPY3YHHo/L
	V7w9ds66y+5x+Wypx6ZVnWweu282sHl8fHqLxaNvyypGj8+b5DzaD3QzBXBGcdmkpOZklqUW
	6dslcGVMfDmPteCQYsXMk2tZGhgfS3cxcnJICJhIrP57kbWLkYtDSGA3o8Te90fZIBLiEs3X
	frBD2MISK/89Z4coes0o0XhqPwtIglfATuLNvn/MIDaLgKrEhrkXmSHighInZz4BqxEVSJLY
	c7+RCcQWFoiVWPhxDthQZqAFt57MB4uLCLhJNFzdxQaygFngLZPEhJbLTBDbFjNJzLn1BijD
	wcEmoClxYXIpSAOngLXE7l1zmCAGmUl0be1ihLDlJZq3zmaewCg0C8kds5Dsm4WkZRaSlgWM
	LKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYIjUUtjB+O9+f/0DjEycTAeYpTgYFYS
	4X2UqZIqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQimCwTB6dUA5Mp
	H+e1Ze/77l611Pc85/ry+SIFs5mT1vGo6Sa/+rfy/r7z4Xl92tkscX/jlxZrJFW19B25Wvvg
	Uq40t5VPltXE/y9mP7HatnVinezHx1tKL95xqZ3QNzHrv/7kKfuNj3EcSP+01fbHmiCpg8fF
	Sza1N9jbNwpZuF7ncdvmdez+5pOX9qrHX/A+YL5gvS1PzPeQerXWX8u/teyY8rmwo4A/3bBw
	td6+pfJhqw5O9t8d0LNfSFDkRp3C2eSYuc/aYxeuUZ34+2BdyM+zL9wqfpt4T3HdnRv5PeNf
	mLiWbly2nHBf3Oz3vfMnVK/sz7FSqnr7XNLPrVPSSd74lVYP56PcBH9JvaT78Y59ztUGokos
	xRmJhlrMRcWJABIuKcYzAwAA
X-CMS-MailID: 20231012084905epcas5p1ea61930cd9a16256b9e997c7493163cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231005194156epcas5p14c65d7fbecc60f97624a9ef968bebf2e
References: <20231005194129.1882245-1-bvanassche@acm.org>
	<CGME20231005194156epcas5p14c65d7fbecc60f97624a9ef968bebf2e@epcas5p1.samsung.com>
	<20231005194129.1882245-2-bvanassche@acm.org>
	<28f21f46-60f1-1651-e6a9-938fd2340ff5@samsung.com>
	<bfb7e2be-79f8-4f5e-b87e-3045d9c937b4@acm.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/2023 10:22 PM, Bart Van Assche wrote:
>>> @@ -2926,7 +2926,8 @@ static void bio_set_ioprio(struct bio *bio)
>>>    {
>>>        /* Nobody set ioprio so far? Initialize it based on task's 
>>> nice value */
>>>        if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
>>> -        bio->bi_ioprio = get_current_ioprio();
>>> +        ioprio_set_class_and_level(&bio->bi_ioprio,
>>> +                       get_current_ioprio());
>>>        blkcg_set_ioprio(bio);
>>>    }
>>> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
>>> index 7578d4f6a969..f2e768ab4b35 100644
>>> --- a/include/linux/ioprio.h
>>> +++ b/include/linux/ioprio.h
>>> @@ -71,4 +71,14 @@ static inline int ioprio_check_cap(int ioprio)
>>>    }
>>>    #endif /* CONFIG_BLOCK */
>>> +#define IOPRIO_CLASS_LEVEL_MASK ((IOPRIO_CLASS_MASK << 
>>> IOPRIO_CLASS_SHIFT) | \
>>> +                 (IOPRIO_LEVEL_MASK << 0))
>>> +
>>> +static inline void ioprio_set_class_and_level(u16 *prio, u16 
>>> class_level)
>>> +{
>>> +    WARN_ON_ONCE(class_level & ~IOPRIO_CLASS_LEVEL_MASK);
>>> +    *prio &= ~IOPRIO_CLASS_LEVEL_MASK;
>>> +    *prio |= class_level;
>>
>> Return of get_current_ioprio() will touch all 16 bits here. So
>> user-defined value can alter whatever was set in bio by F2FS (patch 4 in
>> this series). Is that not an issue?
> 
> The above is incomprehensible to me. Anyway, I will try to answer.
> 
> It is not clear to me why it is claimed that "get_current_ioprio() will
> touch all 16 bits here"? The return value of get_current_ioprio() is
> passed to ioprio_set_class_and_level() and that function clears the hint
> bits from the get_current_ioprio() return value.

Function does OR bio->bi_ioprio with whatever is the return of 
get_current_ioprio(). So if lifetime bits were set in 
get_current_ioprio(), you will end up setting that in bio->bi_ioprio too.


> ioprio_set_class_and_level() preserves the hint bits set by F2FS.
> 
>> And what is the user interface you have in mind. Is it ioprio based, or
>> write-hint based or mix of both?
> 
> Since the data lifetime is encoded in the hint bits, the hint bits need
> to be set by user space to set a data lifetime.

I asked because more than one way seems to emerge here. Parts of this 
series (Patch 4) are taking inode->i_write_hint (and not ioprio value) 
and putting that into bio.
I wonder what to expect if application get to send one lifetime with 
fcntl (write-hints) and different one with ioprio. Is that not racy?


> In case you would help,
> the blktest test that I wrote to test this functionality is available
> below.
> 
> Thanks,
> 
> Bart.
> 
> 
> diff --git a/tests/scsi/097 b/tests/scsi/097
> new file mode 100755
> index 000000000000..01d280021653
> --- /dev/null
> +++ b/tests/scsi/097
> @@ -0,0 +1,62 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2022 Google LLC
> +
> +. tests/zbd/rc
> +. common/null_blk
> +. common/scsi_debug
> +
> +DESCRIPTION="test block data lifetime support"
> +QUICK=1
> +
> +requires() {
> +    _have_fio
> +    _have_module scsi_debug
> +}
> +
> +test() {
> +    echo "Running ${TEST_NAME}"
> +
> +    local scsi_debug_params=(
> +        delay=0
> +        dev_size_mb=1024
> +        sector_size=4096
> +    )
> +    _init_scsi_debug "${scsi_debug_params[@]}" &&
> +    local dev="/dev/${SCSI_DEBUG_DEVICES[0]}" fail &&
> +    ls -ld "${dev}" >>"${FULL}" &&
> +    local i fio_args=(
> +        --group_reporting=1
> +        --gtod_reduce=1
> +        --ioscheduler=none
> +        --norandommap
> +        --direct=1
> +        --rw=randwrite
> +        --ioengine=io_uring
> +        --time_based
> +    ) &&
> +    for ((i=1; i<=3; i++)); do
> +        fio_args+=(
> +            --name=whint"$i"
> +            --filename="${dev}"
> +            --prio=$((i<<6))

This will not work as prio can only take values between 0-7.
Perhaps you want to use "priohint" to send lifetime.

