Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD58C728A40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 23:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjFHV3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjFHV3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:29:06 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31F92D4A
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 14:29:04 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6B163320093E;
        Thu,  8 Jun 2023 17:29:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Jun 2023 17:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1686259741; x=1686346141; bh=UQUTRqN5ar8ruO/OgMQ4NpqIFbB3xL2rAa+
        mym27F3I=; b=IQzO8ayosTmvjFhO9cvzHjhrVJbXE4FB8SvbjUyVNj1odz1q6A2
        QL/dOym49kv9P1AiNYd37kQVhDlvZlhfCIFWEegWpWWZbmETlmIwaMJgUGnRRj1G
        PDYk8kIeb4yQ9FeHZ853FTqhtUqAz6CXJAbXQSLaS7W12WJAo9Se+MYaC4rRAmEC
        KUfLKq5yDXeCfyOK8KgCLYCt6VPTb7Z86X+dQE7V+MDV7NRVE1a0AtMyBbsm1kXH
        wmnwFoAsXh03q0ROHUVyddwjkxF5hVkoulPPSlx+wifheDsNTHmcsX8zHbN/YhYp
        2MnZwSyubChWHFY6Ny4yFMPjEXigrbXGmUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686259741; x=1686346141; bh=UQUTRqN5ar8ruO/OgMQ4NpqIFbB3xL2rAa+
        mym27F3I=; b=yUiCe1J5wV31ziFUebcv27SgsG9AyYkblLzyBN+L6AUsAld09xS
        eq8SMxIgL/DxSU8sKca+4v9Keoa32TKvzNabCR6uWg5fuynxfs99GZ3HVJXzRuyM
        iCEm158+qdUyi+G2nrmkj2TsMr4EVddn67QyvSKKhT5+J4XbDLuzVHRrG0r01zDq
        BVOCXkNshHo43UWj1eu7XrzNBggD0zudIVIsTUMO7StQ3H/lQaftft4Z3q4EhQch
        OjQGMurlZxJMc1qN0sV1mwWDAWIDZHJYF4JlvYsWeKo2xBF3jwfPA87XDPyiq7w9
        hazJmzFFQkwYAzizAOnnEIr+w9VG8CSFoQw==
X-ME-Sender: <xms:HEiCZMcdSU5D6_osl8j35tXhMERRqoFQkEzX_xlqoB_-iWw6NFcNQw>
    <xme:HEiCZOOTTFOaC_gMiuBnqxfYX1FhV__nhN1luTZsbw8s3w0JgUdYANBexdAaGZCOr
    IPYAywH7xJaBU7f>
X-ME-Received: <xmr:HEiCZNhBHWs-Byq8P0It2py5d36K5crnetx_-TxxXn9roGA6OTMk_cB5CySd2oD6cWSaZOtzzGDORARvjNRlOxW3Je73K2GG3UVabiR2LUXTT0iEfw0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtiedgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkffggfgfuvfevfhfh
    jggtgfesthekredttdefjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosg
    gvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgv
    rhhnpefhjedvgfeiffehffdtfffgvdeuueetteehueegfeeviedtteegtdeftdegteffie
    enucffohhmrghinhepshhouhhrtggvfhhorhhgvgdrnhgvthenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrth
    esfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:HEiCZB-FoCxbZJfXOqXImdnD2dvi5LjcAtpxjXAQ6iaFbmGEb9gY2Q>
    <xmx:HEiCZItMyg7lXTRWhlZ24BrhIKQhu2yUdZ_q6Tms0k4t9ynR6C_eJQ>
    <xmx:HEiCZIEV8qfrnMiz071dKdCDWDzpGcKW5J6Ie1yKsAE_WMXDLaUNWg>
    <xmx:HUiCZB5AgK_LPgBl5GE-qdRrMYJ_cT5gmcTZPIIDDN9uW2tXeUcKqg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jun 2023 17:28:59 -0400 (EDT)
Message-ID: <09200d9b-20cb-5864-c42f-e08035d07cd9@fastmail.fm>
Date:   Thu, 8 Jun 2023 23:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [fuse-devel] [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <20230505081652.43008-1-hao.xu@linux.dev>
 <ef307cf6-6f3a-adf8-f4aa-1cd780a0afc6@linux.dev>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <ef307cf6-6f3a-adf8-f4aa-1cd780a0afc6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/8/23 09:17, Hao Xu wrote:
> ping...
> 
> On 5/5/23 16:16, Hao Xu wrote:
>> From: Hao Xu <howeyxu@tencent.com>
>>
>> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
>> coherency, e.g. network filesystems. Thus shared mmap is disabled since
>> it leverages page cache and may write to it, which may cause
>> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
>> reduce memory footprint as well, e.g. reduce guest memory usage with
>> virtiofs. Therefore, add a new flag FOPEN_DIRECT_IO_SHARED_MMAP to allow
>> shared mmap for these cases.
>>
>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>> ---
>>   fs/fuse/file.c            | 11 ++++++++---
>>   include/uapi/linux/fuse.h |  2 ++
>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 89d97f6188e0..655896bdb0d5 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -161,7 +161,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount 
>> *fm, u64 nodeid,
>>       }
>>       if (isdir)
>> -        ff->open_flags &= ~FOPEN_DIRECT_IO;
>> +        ff->open_flags &=
>> +            ~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
>>       ff->nodeid = nodeid;
>> @@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file, 
>> struct vm_area_struct *vma)
>>           return fuse_dax_mmap(file, vma);
>>       if (ff->open_flags & FOPEN_DIRECT_IO) {
>> -        /* Can't provide the coherency needed for MAP_SHARED */
>> -        if (vma->vm_flags & VM_MAYSHARE)
>> +        /* Can't provide the coherency needed for MAP_SHARED.
>> +         * So disable it if FOPEN_DIRECT_IO_SHARED_MMAP is not
>> +         * set, which means we do need strong coherency.
>> +         */
>> +        if (!(ff->open_flags & FOPEN_DIRECT_IO_SHARED_MMAP) &&
>> +            vma->vm_flags & VM_MAYSHARE)
>>               return -ENODEV;
>>           invalidate_inode_pages2(file->f_mapping);
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index 1b9d0dfae72d..003dcf42e8c2 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -314,6 +314,7 @@ struct fuse_file_lock {
>>    * FOPEN_STREAM: the file is stream-like (no file position at all)
>>    * FOPEN_NOFLUSH: don't flush data cache on close (unless 
>> FUSE_WRITEBACK_CACHE)
>>    * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on 
>> the same inode
>> + * FOPEN_DIRECT_IO_SHARED_MMAP: allow shared mmap when 
>> FOPEN_DIRECT_IO is set
>>    */
>>   #define FOPEN_DIRECT_IO        (1 << 0)
>>   #define FOPEN_KEEP_CACHE    (1 << 1)
>> @@ -322,6 +323,7 @@ struct fuse_file_lock {
>>   #define FOPEN_STREAM        (1 << 4)
>>   #define FOPEN_NOFLUSH        (1 << 5)
>>   #define FOPEN_PARALLEL_DIRECT_WRITES    (1 << 6)
>> +#define FOPEN_DIRECT_IO_SHARED_MMAP    (1 << 7)
>>   /**
>>    * INIT request/reply flags
> 
> 
> 

Sorry, currently get distracted by non-fuse work :/

I think see the reply from Miklos on the initial question, which is on 
fuse-devel. Ah, I see you replied to it.

https://sourceforge.net/p/fuse/mailman/message/37849170/


I think what Miklos asks for, is to add a new FUSE_INIT reply flag and 
then to set something like fc->dio_shared_mmap. That way it doesn't need 
to be set for each open, but only once in the server init handler.
@Miklos, please correct me if I'm wrong.


Thanks,
Bernd
