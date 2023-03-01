Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5088F6A685D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 08:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCAHpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 02:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCAHpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:45:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4B23116
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 23:44:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so12122583pja.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 23:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677656683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyS0C1HTG0tduNh0L7kbfvu/lzkj/LLnrbNqiht2ZzQ=;
        b=K9cAlseifIqk8MiACuzD0FGxhZR1aO2o9ZI8Os17fFA2mqSVr3dKiYJTt/IYZ7fl+u
         ph0RgCHRQsX5j+/PFetqA0UZzNvofS3/Dv1itfS9vNFho8Msr4EOmv5uvqKjH1sJFitg
         Ipq/ff3fRNu/rOEERARAji3c2kKrBUgRcEYBz7Buj0+tkckiZI7xOrVGkcLVAknLO40H
         vCCp4Z3R2BUOda+siG2WGrSE18a9VgvjpH5HfaXJ9eZppUpXcgb1JNeNbkPuxmKYXXhT
         1EFNgd6CjRvv3aO7iChwxCFKN+F5lgSTXXEWRJ1vGeQLQJ9bSx29v/3TXgIrlKhQA3az
         sQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677656683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jyS0C1HTG0tduNh0L7kbfvu/lzkj/LLnrbNqiht2ZzQ=;
        b=K1w4DWiwJrzrrn2qD1dugolOFN6lP6gpM19aaZW72VvCCWfCSqRoerCm3ZdWN+Hxta
         nxT7Bo4Bv4M0a7phCAtcb3tQuAChtKs0D/oPlMH2RrKRd6balsDNJrQefMz0yjZmQnUP
         ILev9qW8JbVRffWzIB95HFj0kG8PPHcEoCI2DDzXz/AzrM4kQz0VcqBu/x8xgnsMzP1y
         Dw6sVUV2/fS6EuQ5/Kq/9kgwXL+sylwT1lXbRmlreZgUN9ykpQjrpTlCma82wdwIPlWj
         8NWTixRU9l/PedCC/1US4JQbRBPHZemLUO5nWkB9vX8KmjOuMjzZPA8O+EyColXJ0h7D
         V6OA==
X-Gm-Message-State: AO0yUKWPPc9QGLnmr36GfepZsIrImyYSMME7hQrSPhFxqqUQKuXmYtLO
        DDEr/qsUfP6z5TavyDaPaMXGIw==
X-Google-Smtp-Source: AK7set/RvUa8pCt4yFC8gzSIzxh9lcNDOWsMuNnBPKvNbcp5EZJSGPNF8q5pVqT9V7lAOUXoxsmxcQ==
X-Received: by 2002:a17:903:2447:b0:19c:c9da:a62e with SMTP id l7-20020a170903244700b0019cc9daa62emr6447929pls.54.1677656683026;
        Tue, 28 Feb 2023 23:44:43 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b0019a6cce2060sm7663725pld.57.2023.02.28.23.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 23:44:42 -0800 (PST)
Message-ID: <1c8b966e-8208-e9c9-c75b-9ebf2a138059@bytedance.com>
Date:   Wed, 1 Mar 2023 15:44:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: Re: [PATCH] erofs: support for mounting a single block device
 with multiple devices
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, gerry@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        Xin Yin <yinxin.x@bytedance.com>
References: <20230301070417.13084-1-zhujia.zj@bytedance.com>
 <c3c10f27-7941-6ccc-fa60-b5a289bf03ba@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <c3c10f27-7941-6ccc-fa60-b5a289bf03ba@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/3/1 15:08, Gao Xiang 写道:
> Hi Jia,
> 
> On 2023/3/1 15:04, Jia Zhu wrote:
>> In order to support mounting multi-layer container image as a block
>> device, add single block device with multiple devices feature for EROFS.
> 
> In order to support mounting multi-blob container image as a single
> flattened block device, add flattened block device feature for EROFS.
> 
Thanks, I would revise it.
>>
>> In this mode, all meta/data contents will be mapped into one block 
>> address.
>> User could directly mount the block device by EROFS.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
>> ---
>>   fs/erofs/data.c  | 8 ++++++--
>>   fs/erofs/super.c | 5 +++++
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index e16545849ea7..870b1f7fe1d4 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -195,9 +195,9 @@ int erofs_map_dev(struct super_block *sb, struct 
>> erofs_map_dev *map)
>>   {
>>       struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
>>       struct erofs_device_info *dif;
>> +    bool flatdev = !!sb->s_bdev;
> 
> I'd like to land it in sbi and set it in advance?
> 
I'll revise that in next version.
> Also, did you test this patch?

I've tested the patch using the following steps mentioned by
https://github.com/dragonflyoss/image-service/pull/1111

1. Compose a (nbd)block device from an EROFS image.
2. mount -t erofs /dev/nbdx /mnt/
3. compare the md5sum between source dir and /mnt dir.

> 
> Thanks,
> Gao Xiang
> 
> 
>>       int id;
>> -    /* primary device by default */
>>       map->m_bdev = sb->s_bdev;
>>       map->m_daxdev = EROFS_SB(sb)->dax_dev;
>>       map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
>> @@ -210,12 +210,16 @@ int erofs_map_dev(struct super_block *sb, struct 
>> erofs_map_dev *map)
>>               up_read(&devs->rwsem);
>>               return -ENODEV;
>>           }
>> +        if (flatdev) {
>> +            map->m_pa += blknr_to_addr(dif->mapped_blkaddr);
>> +            map->m_deviceid = 0;
>> +        }
>>           map->m_bdev = dif->bdev;
>>           map->m_daxdev = dif->dax_dev;
>>           map->m_dax_part_off = dif->dax_part_off;
>>           map->m_fscache = dif->fscache;
>>           up_read(&devs->rwsem);
>> -    } else if (devs->extra_devices) {
>> +    } else if (devs->extra_devices && !flatdev) {
>>           down_read(&devs->rwsem);
>>           idr_for_each_entry(&devs->tree, dif, id) {
>>               erofs_off_t startoff, length;
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 19b1ae79cec4..4f9725b0950c 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -226,6 +226,7 @@ static int erofs_init_device(struct erofs_buf 
>> *buf, struct super_block *sb,
>>       struct erofs_fscache *fscache;
>>       struct erofs_deviceslot *dis;
>>       struct block_device *bdev;
>> +    bool flatdev = !!sb->s_bdev;
>>       void *ptr;
>>       ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
>> @@ -248,6 +249,10 @@ static int erofs_init_device(struct erofs_buf 
>> *buf, struct super_block *sb,
>>           if (IS_ERR(fscache))
>>               return PTR_ERR(fscache);
>>           dif->fscache = fscache;
>> +    } else if (flatdev) {
>> +        dif->bdev = sb->s_bdev;
>> +        dif->dax_dev = EROFS_SB(sb)->dax_dev;
>> +        dif->dax_part_off = sbi->dax_part_off;
>>       } else {
>>           bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
>>                         sb->s_type);
