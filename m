Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DFA777CAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjHJPuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHJPuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:50:16 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C791BF7
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 08:50:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 60E03320092B;
        Thu, 10 Aug 2023 11:50:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 10 Aug 2023 11:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1691682613; x=1691769013; bh=qWxepfrgK4tQW/0GY4AgagYC89vuPcsBSJA
        i8c8ZKX4=; b=KCnHSYkq2VEN+xLL2bhavw1FodySXNr4B5q+TzlXFkGnsuGP7Nb
        lw6kgwBN5sJ6BakwBqcwJjfb+PZ0QqNAAQLzJjYcIxObJTWYla4wHKNHkQXg3LsK
        f6zZBSSI0oQQVvD1c5gKf0+kO5fKCYX3T2YTYFBgPNCKj3scX8ISrU5QIU0PQWxc
        WBH/3bJJNghU5IaWIVkKBLvrnlE5N4fJaDqDMg6cUseqL8pL7nVDn6HuFO6Zx59L
        VO4d5jHFiNsZdR/s/DCPClJIkxCiOVJ1WGOv72aadgY8h69MVciimLUwLhNg3z79
        eDzC+K4Cz3vksdJ6cK1fFfMePz7MO79zX0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691682613; x=1691769013; bh=qWxepfrgK4tQW/0GY4AgagYC89vuPcsBSJA
        i8c8ZKX4=; b=F8tTvejoXsiFQxCSZTvYGYZ55PIIgmNJ2Wj+ZRpl0qih+k2vm97
        aNw2w542ufWHdNCrZZCYlQz396WSwnvPSd3Dtds1Jf1pew2IggYLZcruXW1vFV2P
        YANblqqqWV1EWi0QoFuTgi7Cwl0JIBb5r9saC/oBGeO9cRgyE9LtmDXDbUKwRD5/
        2fxdormgeZlLTH+Cc6jD5uXqV10Yjrgx/dLBYpiRZCbbPmKLJuiJJj/XStTMIzG5
        /jj8v7/0HJGfNGBMWzUaQXLpL0Tpjkh9pklX+siiOjzkDiLvWMlhC6oaQAe1avwg
        YXoqJGw4chIPB8n3h+xgzcWxJ5HLZHTceOg==
X-ME-Sender: <xms:NQfVZDAYCTEdTZW5DIVleb5_YkOvjOhLWS3qlCqXbLZzMl02bj1cvg>
    <xme:NQfVZJiI0ECdCa6XioSBz91mraNS8kGgcCWR884gvWPDyIv_AOSihPHVlNnacDpSP
    mmK_jcGgJOYXmS9>
X-ME-Received: <xmr:NQfVZOkQA6cIhSa0NrmqQQbB72LXYaC38AYMDiS1vJJzgAF1zTMXhNRSxHRNXI2XlsbWAHGCbflJ3mEZ2aFNEl3F9FQ5dUBi14tjw6GddFUfUGRY5NfXkXYP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:NQfVZFz1LscB1myYVWd_gPpj0i6Zjd0LMR-qcDEF4SIgZDeXFfPdAQ>
    <xmx:NQfVZITkgjQSujrjMjn1xjcJHw-eSYFCXDK4jei_afhIrTdXPoNxww>
    <xmx:NQfVZIaAoJdL7HOfTbiF9io4VgSzgk5rKKRl1KPwTXJDL-__X8HPTg>
    <xmx:NQfVZDLQFI1mCPALZBwL3s2YU8VC33wAwQwAzwPI7z6wba6hM-wu9Q>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Aug 2023 11:50:12 -0400 (EDT)
Message-ID: <21beaffb-cf47-61e7-62a4-463da478d1ab@fastmail.fm>
Date:   Thu, 10 Aug 2023 17:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/5] fuse: add STATX request
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20230810105501.1418427-1-mszeredi@redhat.com>
 <20230810105501.1418427-3-mszeredi@redhat.com>
 <e7979772-7e7b-9078-7b25-24e5bdb91342@fastmail.fm>
 <CAJfpegugchRF8JagD7-zViQVeT_7-h33F+AvpmHhr8FHUcZ4sg@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegugchRF8JagD7-zViQVeT_7-h33F+AvpmHhr8FHUcZ4sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/10/23 16:08, Miklos Szeredi wrote:
> On Thu, 10 Aug 2023 at 15:23, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 8/10/23 12:54, Miklos Szeredi wrote:
>>> Use the same structure as statx.
>>
>> Wouldn't it be easier to just include struct statx? Or is there an issue
>> with __u32, etc? If so, just a sufficiently large array could be used
>> and statx values just mem-copied in/out?
> 
> <linux/uapi/fuse.h> is OS independent.  Ports can grab it and use it
> in their userspace and kernel implementations.

Ok, but why not just like this?

struct fuse_statx {
	uint8_t fuse_statx_values[256];
}

struct fuse_statx fuse_statx;
struct statx *statx_ptr = (struct statx *)&fuse_statx.fuse_statx_values;


Hmm, I see an issue if that struct is passed over network and different 
OS are involved, which _might_ have different structs or sizes. So yeah, 
the copy approach is safest. Although as fuse_statx is between kernel 
and userspace only - it should not matter?

> 
> 
>>
>>>
>>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>>> ---
>>>    include/uapi/linux/fuse.h | 56 ++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 55 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>> index b3fcab13fcd3..fe700b91b33b 100644
>>> --- a/include/uapi/linux/fuse.h
>>> +++ b/include/uapi/linux/fuse.h
>>> @@ -207,6 +207,9 @@
>>>     *  - add FUSE_EXT_GROUPS
>>>     *  - add FUSE_CREATE_SUPP_GROUP
>>>     *  - add FUSE_HAS_EXPIRE_ONLY
>>> + *
>>> + *  7.39
>>> + *  - add FUSE_STATX and related structures
>>>     */
>>>
>>>    #ifndef _LINUX_FUSE_H
>>> @@ -242,7 +245,7 @@
>>>    #define FUSE_KERNEL_VERSION 7
>>>
>>>    /** Minor version number of this interface */
>>> -#define FUSE_KERNEL_MINOR_VERSION 38
>>> +#define FUSE_KERNEL_MINOR_VERSION 39
>>>
>>>    /** The node ID of the root inode */
>>>    #define FUSE_ROOT_ID 1
>>> @@ -269,6 +272,40 @@ struct fuse_attr {
>>>        uint32_t        flags;
>>>    };
>>>
>>> +/*
>>> + * The following structures are bit-for-bit compatible with the statx(2) ABI in
>>> + * Linux.
>>> + */
>>> +struct fuse_sx_time {
>>> +     int64_t         tv_sec;
>>> +     uint32_t        tv_nsec;
>>> +     int32_t         __reserved;
>>> +};
>>> +
>>> +struct fuse_statx {
>>> +     uint32_t        mask;
>>> +     uint32_t        blksize;
>>> +     uint64_t        attributes;
>>> +     uint32_t        nlink;
>>> +     uint32_t        uid;
>>> +     uint32_t        gid;
>>> +     uint16_t        mode;
>>> +     uint16_t        __spare0[1];
>>> +     uint64_t        ino;
>>> +     uint64_t        size;
>>> +     uint64_t        blocks;
>>> +     uint64_t        attributes_mask;
>>> +     struct fuse_sx_time     atime;
>>> +     struct fuse_sx_time     btime;
>>> +     struct fuse_sx_time     ctime;
>>> +     struct fuse_sx_time     mtime;
>>> +     uint32_t        rdev_major;
>>> +     uint32_t        rdev_minor;
>>> +     uint32_t        dev_major;
>>> +     uint32_t        dev_minor;
>>> +     uint64_t        __spare2[14];
>>> +};
>>
>> Looks like some recent values are missing?
> 
> It doesn't matter, since those parts are not used.
> 
>>
>>          /* 0x90 */
>>          __u64   stx_mnt_id;
>>          __u32   stx_dio_mem_align;      /* Memory buffer alignment for direct I/O */
>>          __u32   stx_dio_offset_align;   /* File offset alignment for direct I/O */
>>          /* 0xa0 */
>>          __u64   __spare3[12];   /* Spare space for future expansion */
>>          /* 0x100 */
>>
>> Which is basically why my personal preference would be not to do have a
>> copy of the struct - there is maintenance overhead.
> 
> Whenever the new fields would be used in the kernel the fields can be
> added.  So no need to continually update the one in fuse, since those

Maybe I'm over optimizing, I just see that userspace side then also 
needs an updated struct - which can be easily forgotten. While plain 
struct statx would't have that issue.



Thanks,
Bernd
