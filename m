Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380497B0E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 23:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjI0VoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 17:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:44:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C37D6;
        Wed, 27 Sep 2023 14:44:05 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RLeDM2017419;
        Wed, 27 Sep 2023 21:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=se51p/MqpkArSngnFBRzkX1YJmLtShBmb9EktIdtgGQ=;
 b=lO4HT8Cb21mPyqZt3jz2LLeIik8zu5m6yqZbdnXK6v7jFwOQjtbEcoDRkkKlMRZ8eBL0
 AH8xSoSsUI+zswjTl0ZbILpHw/F+nK9/c0WsuBCqYpmdNWQ6ST3JSD6cC3AC7WSrqcod
 dpwTaeATgUNEcbJA+o1IMm/CFlpf3GqxhylK/4ggzV3dCyZmLklEk9JXgut4mh55ifWG
 NB2tcUHsomqzv/VjBBSfPEKjAs3giQ8itRJWaaD6nnO4frsCX3vBaHMHWiBz/BoWSIiX
 1j94rJb+IOWpbBrhOwYXXguRLrjosW5JzPrPQPPYKN6ztEy8/D02FmiwBHULP5rFMQoM EA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcrsde2tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 21:43:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RKVuIr008143;
        Wed, 27 Sep 2023 21:43:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqyq4ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 21:43:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RLhjqM43450858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 21:43:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5662A2004D;
        Wed, 27 Sep 2023 21:43:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A45F32004F;
        Wed, 27 Sep 2023 21:43:44 +0000 (GMT)
Received: from [9.171.37.160] (unknown [9.171.37.160])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 21:43:44 +0000 (GMT)
Message-ID: <51e1e42a-2ed8-a664-f26f-bc5bc1762884@linux.ibm.com>
Date:   Wed, 27 Sep 2023 23:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/29] s390/dasd: Convert to bdev_open_by_path()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-14-jack@suse.cz>
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20230823104857.11437-14-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gNioCTpAK6quqH6t38vjfE2eIeyhywLj
X-Proofpoint-ORIG-GUID: gNioCTpAK6quqH6t38vjfE2eIeyhywLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_15,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 clxscore=1011 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270185
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 23.08.23 um 12:48 schrieb Jan Kara:
> Convert dasd to use bdev_open_by_path() and pass the handle around.
>
> CC: linux-s390@vger.kernel.org
> CC: Christian Borntraeger <borntraeger@linux.ibm.com>
> CC: Sven Schnelle <svens@linux.ibm.com>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

The DASD part does not compile. please see below.

Beside of this the patch looks OK to me.

with the error fixed:
Acked-by: Stefan Haberland <sth@linux.ibm.com>

>   drivers/s390/block/dasd.c       | 12 +++++----
>   drivers/s390/block/dasd_genhd.c | 45 ++++++++++++++++-----------------
>   drivers/s390/block/dasd_int.h   |  2 +-
>   drivers/s390/block/dasd_ioctl.c |  2 +-
>   4 files changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 215597f73be4..16a2d631a169 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -412,7 +412,8 @@ dasd_state_ready_to_online(struct dasd_device * device)
>   					KOBJ_CHANGE);
>   			return 0;
>   		}
> -		disk_uevent(device->block->bdev->bd_disk, KOBJ_CHANGE);
> +		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
> +			    KOBJ_CHANGE);
>   	}
>   	return 0;
>   }
> @@ -432,7 +433,8 @@ static int dasd_state_online_to_ready(struct dasd_device *device)
>   
>   	device->state = DASD_STATE_READY;
>   	if (device->block && !(device->features & DASD_FEATURE_USERAW))
> -		disk_uevent(device->block->bdev->bd_disk, KOBJ_CHANGE);
> +		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
> +			    KOBJ_CHANGE);
>   	return 0;
>   }
>   
> @@ -3590,7 +3592,7 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
>   	 * in the other openers.
>   	 */
>   	if (device->block) {
> -		max_count = device->block->bdev ? 0 : -1;
> +		max_count = device->block->bdev_handle ? 0 : -1;
>   		open_count = atomic_read(&device->block->open_count);
>   		if (open_count > max_count) {
>   			if (open_count > 0)
> @@ -3636,8 +3638,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
>   		 * so sync bdev first and then wait for our queues to become
>   		 * empty
>   		 */
> -		if (device->block)
> -			bdev_mark_dead(device->block->bdev, false);
> +		if (device->block && device->block->bdev_handle) {

the brace is not needed here and there is no matching right brace.

> +			bdev_mark_dead(device->block->bdev_handle->bdev, false);
>   		dasd_schedule_device_bh(device);
>   		rc = wait_event_interruptible(shutdown_waitq,
>   					      _wait_for_empty_queues(device));
>

