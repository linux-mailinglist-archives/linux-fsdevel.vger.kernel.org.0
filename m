Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA4475788F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjGRJzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 05:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGRJyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:54:53 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98DB19B1;
        Tue, 18 Jul 2023 02:54:10 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 9297E42563;
        Tue, 18 Jul 2023 05:54:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1689674047;
        bh=Sg246O/TazSM39iHd05ZU6o4U+k3CZNhb15fFZTECkc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=O5/LvrqGtPjO9zdpddRv5hZhBDAY6nztKsaUA2ByiobCDu1a0Hx7x0ZVNsBjeDNCk
         88Mmfjg+2vnpVViPsuB+380QwlD/KMd4TCimlFOmwH/NCdu96LBi/T2DHBU6G0y26d
         cM7DB/ysNImUpG44scEitw683MilHOVC3zsXu5iALEasNZR81XZrp1l3MD0/7uNVkf
         fGm5sBJzBesGJB0Tjbk3BfFH73Ae4muR96O8tgLYNFI0pZfYVRZlFNYtY0VuboXNb3
         5zsmICeqI5zrXNNtteaPS1MqCzgq8Km3NAo2vQH4ZCZyIk7ZQPvM5gQ4uvIQv6SNI5
         S0qjMOSR+ojWA==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Tue, 18 Jul
 2023 11:54:01 +0200
Message-ID: <6168e4d5-efc3-0c84-66c7-aea460c9fcaa@veeam.com>
Date:   Tue, 18 Jul 2023 11:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 04/11] blksnap: header file of the module interface
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
CC:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <dchinner@redhat.com>, <willy@infradead.org>,
        <dlemoal@kernel.org>, <jack@suse.cz>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-5-sergei.shtepa@veeam.com>
 <822909b0-abd6-4e85-b739-41f8efa6feff@t-8ch.de>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <822909b0-abd6-4e85-b739-41f8efa6feff@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx01.amust.local (172.31.112.31) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155B677763
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
Thanks for the review.

On 7/17/23 20:57, Thomas Weißschuh wrote:
> Subject:
> Re: [PATCH v5 04/11] blksnap: header file of the module interface
> From:
> Thomas Weißschuh <thomas@t-8ch.de>
> Date:
> 7/17/23, 20:57
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>
> CC:
> axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org, jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>
> 
> 
> On 2023-06-12 15:52:21+0200, Sergei Shtepa wrote:
> 
>> [..]
>> diff --git a/include/uapi/linux/blksnap.h b/include/uapi/linux/blksnap.h
>> new file mode 100644
>> index 000000000000..2fe3f2a43bc5
>> --- /dev/null
>> +++ b/include/uapi/linux/blksnap.h
>> @@ -0,0 +1,421 @@
>> [..]
>> +/**
>> + * struct blksnap_snapshotinfo - Result for the command
>> + *	&blkfilter_ctl_blksnap.blkfilter_ctl_blksnap_snapshotinfo.
>> + *
>> + * @error_code:
>> + *	Zero if there were no errors while holding the snapshot.
>> + *	The error code -ENOSPC means that while holding the snapshot, a snapshot
>> + *	overflow situation has occurred. Other error codes mean other reasons
>> + *	for failure.
>> + *	The error code is reset when the device is added to a new snapshot.
>> + * @image:
>> + *	If the snapshot was taken, it stores the block device name of the
>> + *	image, or empty string otherwise.
>> + */
>> +struct blksnap_snapshotinfo {
>> +	__s32 error_code;
>> +	__u8 image[IMAGE_DISK_NAME_LEN];
> Nitpick:
> 
> Seems a bit weird to have a signed error code that is always negative.
> Couldn't this be an unsigned number or directly return the error from
> the ioctl() itself?

Yes, it's a good idea to pass the error code as an unsigned value.
And this positive value can be passed in case of successful execution
of ioctl(), but I would not like to put different error signs in one value.

> 
>> +};
>> +
>> +/**
>> + * DOC: Interface for managing snapshots
>> + *
>> + * Control commands that are transmitted through the blksnap module interface.
>> + */
>> +enum blksnap_ioctl {
>> +	blksnap_ioctl_version,
>> +	blksnap_ioctl_snapshot_create,
>> +	blksnap_ioctl_snapshot_destroy,
>> +	blksnap_ioctl_snapshot_append_storage,
>> +	blksnap_ioctl_snapshot_take,
>> +	blksnap_ioctl_snapshot_collect,
>> +	blksnap_ioctl_snapshot_wait_event,
>> +};
>> +
>> +/**
>> + * struct blksnap_version - Module version.
>> + *
>> + * @major:
>> + *	Version major part.
>> + * @minor:
>> + *	Version minor part.
>> + * @revision:
>> + *	Revision number.
>> + * @build:
>> + *	Build number. Should be zero.
>> + */
>> +struct blksnap_version {
>> +	__u16 major;
>> +	__u16 minor;
>> +	__u16 revision;
>> +	__u16 build;
>> +};
>> +
>> +/**
>> + * define IOCTL_BLKSNAP_VERSION - Get module version.
>> + *
>> + * The version may increase when the API changes. But linking the user space
>> + * behavior to the version code does not seem to be a good idea.
>> + * To ensure backward compatibility, API changes should be made by adding new
>> + * ioctl without changing the behavior of existing ones. The version should be
>> + * used for logs.
>> + *
>> + * Return: 0 if succeeded, negative errno otherwise.
>> + */
>> +#define IOCTL_BLKSNAP_VERSION							\
>> +	_IOW(BLKSNAP, blksnap_ioctl_version, struct blksnap_version)
> Shouldn't this be _IOR()?
> 
>   "_IOW means userland is writing and kernel is reading. _IOR
>   means userland is reading and kernel is writing."
> 
> The other ioctl definitions seem to need a review, too.
> 

Yeah. I need to replace _IOR and _IOW in all ioctl.
Thanks!
