Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B4878E888
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbjHaIlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbjHaIlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:41:31 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C220E42
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 01:41:04 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 83FAB320034E;
        Thu, 31 Aug 2023 04:33:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 31 Aug 2023 04:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693470801; x=1693557201; bh=3GJYzIgqz1UW+u766BCb3DjMPsP0ftMxbRb
        PPaif/IM=; b=XgqF2iIQkGwDzQXryLLFHBnhVAVGJeplkIWh5Ntlo0VGm4GAzJX
        vZCKGyseFlZgScGMg/9mgJCzn3aPPl+3T6eldwnhB+xxVDtyMQNodoK+kbzvF5eF
        z1h0iFf2kmfmDscXzxQMeVhFqu/9zzBKdWKXkBZ7H/rAscjFpA90nPLQwUT7MHm0
        TrzZwjyd8mDZ4+CunXoxuk+utZLbd8kEHO3Us+UXEPqRJHNF7Vj37lWrWViEcKSl
        KrTTXDD4I+2xgrMX20l5i4SHRsXH6l7OOT9M24cxm/imj1Vyjx3rqeABiwOhckY2
        DprVplo7lNIYF0++22oluctbpbzWipmZOKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693470801; x=1693557201; bh=3GJYzIgqz1UW+u766BCb3DjMPsP0ftMxbRb
        PPaif/IM=; b=oNWpgwc4F9wer8n2ZAGuoJL4VDL/qj6igT7uxExzkHtJmywys4R
        9gbTE/OCB4eurNdjDiUwGBVmiEHu49W5UmhtJroshERRwn3AoKVFGReRzZg87UEE
        S1N5a990zIwgKEu6itvvNI/UR3yYXUU9RqmBX4WvQ8TF4TObCXYnaA7Hz3R3z5MX
        GM1vbm4Op3RTM0mY3lv+ebflS64k9QIphpklnA+xpY+zJJrerY/JqtTd8QSM2rIJ
        RomeDhq/sXQlM32i2qlM/+ZIAl9Eh3asYVIAzR7/z422bCe4XxgpF5YRMv5U9Voi
        KUXNM6acEdAiO2D87QQcjJAvWC/tG9ftjXA==
X-ME-Sender: <xms:UFDwZNtKbDjm8rxC4_6-UunMrFqF14knUbmV-Tc7v3KKTkh2TBwgYA>
    <xme:UFDwZGe9NoVnd7tBo2_AhYcoIegbGxCENp_7h505tOVf3UWQ1YpwdpyGN2WKN_Xes
    Bu5Wpg8g79JtHdf>
X-ME-Received: <xmr:UFDwZAyHzcri8qkKW_1P2rl_nDBxdpVz-XzR3t6LRVJFWeV77keVq0Z9ne8SWT2piA1JLJooRVCbf69g44gJZrlrbJYCawYUqhH7QP3zOw__10FTEqiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegtddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:UFDwZEO0yiy7HhXwVFS6tibRw4ovbiOH03MNtqV1J6TZJDo8JbMA5w>
    <xmx:UFDwZN-2SrTSwF2eVyhr6mxMlLBMVaY1bDWcdu-lxC76GNvYvk-0jA>
    <xmx:UFDwZEXTllwtU66Fh9Q4Cj5cu017XdD2gnloBJ2Ry5cH_6tL6N8OPA>
    <xmx:UVDwZJYIs9GQh71QVd6tSlQheZhKu8YgSSO-ey8EJbUCW1-PB0BTSw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Aug 2023 04:33:19 -0400 (EDT)
Message-ID: <fe4ac4ae-e6d7-4343-4774-516b40dedf6a@fastmail.fm>
Date:   Thu, 31 Aug 2023 10:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/6] fuse: Allow parallel direct writes for O_DIRECT
To:     Hao Xu <hao.xu@linux.dev>, Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org
Cc:     miklos@szeredi.hu, dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
 <20230829161116.2914040-4-bschubert@ddn.com>
 <a7c2c7bf-f4ea-22cb-86a0-f24461c87fe7@linux.dev>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <a7c2c7bf-f4ea-22cb-86a0-f24461c87fe7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/31/23 10:30, Hao Xu wrote:
> On 8/30/23 00:11, Bernd Schubert wrote:
>> Take a shared lock in fuse_cache_write_iter. This was already
>> done for FOPEN_DIRECT_IO in
>>
>> commit 153524053bbb ("fuse: allow non-extending parallel direct
>> writes on the same file")
>>
>> but so far missing for plain O_DIRECT. Server side needs
>> to set FOPEN_PARALLEL_DIRECT_WRITES in order to signal that
>> it supports parallel dio writes.
>>
>> Cc: Hao Xu <howeyxu@tencent.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Dharmendra Singh <dsingh@ddn.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>   fs/fuse/file.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 6b8b9512c336..a6b99bc80fe7 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1314,6 +1314,10 @@ static bool fuse_dio_wr_exclusive_lock(struct 
>> kiocb *iocb, struct iov_iter *from
>>       struct file *file = iocb->ki_filp;
>>       struct fuse_file *ff = file->private_data;
>> +    /* this function is about direct IO only */
>> +    if (!(iocb->ki_flags & IOCB_DIRECT))
>> +        return false;
> 
> This means for buffered write in fuse_cache_write_iter(), we grab shared 
> lock, looks not right.
> 

Yeah, sorry, I made all values the other way around, consistently. 
Miklos had already noticed.


Thanks,
Bernd
