Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4245B73E719
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFZR76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjFZR75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:59:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297B1A1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 10:59:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 425F55C0184;
        Mon, 26 Jun 2023 13:59:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Jun 2023 13:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687802393; x=1687888793; bh=MNrgYl7w7RUmrqzT7GC0tSc7RZnCY40zks/
        IqMqjjmw=; b=NXdLzC9VswIoaM8sye1vnsiTKAKuF33n9Q6PeoJes+HeMVaufnf
        JbDxpFmTlciPxOF2jQcZfa6gY3oO3j4l9zrhc1heYunRV5SJT+S4ELn9Xo5L62eP
        /AjfmUkFUOjUe8y7XhTBI7g5zWTniUL4pTDu+1j1uDeOPRSr/AI9/1Ez+LVp+oEt
        6HIG10cqSy2w2YK7Svq3WFU4f55cko97XizuiadEXvEgB6GpnkCIsg2ixxadh3yy
        d6FgkN+8iYfjVW32CegMoOIr5LTkTfj9n2aCA8fUHYQ1q3TeNIgb9mq5b2M+S5vP
        YcuY0oA1JfQiBW+Q2X2n6HQVSdJ04ytHHlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687802393; x=1687888793; bh=MNrgYl7w7RUmrqzT7GC0tSc7RZnCY40zks/
        IqMqjjmw=; b=iMOq7jBK4lCBQNymvjggcLc73VSLFmrDiDvvu/cCGOkAbsTyB57
        tihLWkbuPw9+AFz3ZwkOEXuafZNFeyHRt1ZUsbT1rZHjP3ewIhuVm/7Qf0+QWWZr
        p7YdnxvUJxuwsvouX2h/AzMGez8f+8zW5kUm4YQy6+eTCvat8HcJD/Jw9jbyu8WT
        vXVMRPPg5iCmH4akHDh7Qz4VMDXh+lo+I0t8Ktv8UFpf4s82a+1l5u7IOxwEfBeM
        NFXJBg+ckCt3mron+8tihoHqQRmTQXSuME7W1cJZbWDjpRZNYdCg4RCeKm9ZFpGl
        52TLpuKKalbmwbUE+yWM+yWeU29YdGLWVNg==
X-ME-Sender: <xms:GNKZZAaAPRXV30Unmd2A2hrG37QiRgTp4k1fr8kfPKKZcF2jVmdo9g>
    <xme:GNKZZLYCs83Z9ZQs12_DvNgvp3b-FfVu7qSoV-wQbAU4rQPZ6A4X0NXyL_b5HyLmB
    7SZqnTubVkzK4hK>
X-ME-Received: <xmr:GNKZZK8D0LTVHROD7g1ec-G4LhURXYfH0Vzd_RwLz9jIRflOYaoe6z0PXonrTTNUIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeffhfdtvdeviedvudeuudejteffkeeklefg
    vdefgfeuffeifeejgfejffehtddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:GNKZZKo3GEx4Is8AeGzzNzLMa9liXS8s36bK9YQJiQe8x1M-Cd2qTA>
    <xmx:GNKZZLozTiEOHhA0hOQVjW0pM26pL7bqkgtv0XlUXozazortkWvHuQ>
    <xmx:GNKZZIS-I-2-wWnqD7_S0t7KSRyeNzkjn-66rS0Lj7lfcRo7d_JuwQ>
    <xmx:GdKZZC0-4pl6r2nAHxEoyBZAPv7h9AyTwbYoG79tjv9sR0R0IIFA7w>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 13:59:52 -0400 (EDT)
Message-ID: <aea85aa9-0af0-287d-bdad-b203e7258872@fastmail.fm>
Date:   Mon, 26 Jun 2023 19:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [fuse-devel] [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <20230505081652.43008-1-hao.xu@linux.dev>
 <fc6fe539-64ae-aa35-8b6e-3b22e07af31f@fastmail.fm>
 <92595369-f378-b6ac-915f-f046921f1d59@linux.dev>
Content-Language: en-US
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <92595369-f378-b6ac-915f-f046921f1d59@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/6/23 09:03, Hao Xu wrote:
> Hi Bernd,
> 
> 
> On 5/5/23 22:39, Bernd Schubert wrote:
>>
>>
>> On 5/5/23 10:16, Hao Xu wrote:
>>> From: Hao Xu <howeyxu@tencent.com>
>>>
>>> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
>>> coherency, e.g. network filesystems. Thus shared mmap is disabled since
>>> it leverages page cache and may write to it, which may cause
>>> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
>>> reduce memory footprint as well, e.g. reduce guest memory usage with
>>> virtiofs. Therefore, add a new flag FOPEN_DIRECT_IO_SHARED_MMAP to allow
>>> shared mmap for these cases.
>>>
>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>> ---
>>>   fs/fuse/file.c            | 11 ++++++++---
>>>   include/uapi/linux/fuse.h |  2 ++
>>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index 89d97f6188e0..655896bdb0d5 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -161,7 +161,8 @@ struct fuse_file *fuse_file_open(struct 
>>> fuse_mount *fm, u64 nodeid,
>>>       }
>>>         if (isdir)
>>> -        ff->open_flags &= ~FOPEN_DIRECT_IO;
>>> +        ff->open_flags &=
>>> +            ~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
>>>         ff->nodeid = nodeid;
>>>   @@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file, 
>>> struct vm_area_struct *vma)
>>>           return fuse_dax_mmap(file, vma);
>>>         if (ff->open_flags & FOPEN_DIRECT_IO) {
>>> -        /* Can't provide the coherency needed for MAP_SHARED */
>>> -        if (vma->vm_flags & VM_MAYSHARE)
>>> +        /* Can't provide the coherency needed for MAP_SHARED.
>>> +         * So disable it if FOPEN_DIRECT_IO_SHARED_MMAP is not
>>> +         * set, which means we do need strong coherency.
>>> +         */
>>> +        if (!(ff->open_flags & FOPEN_DIRECT_IO_SHARED_MMAP) &&
>>> +            vma->vm_flags & VM_MAYSHARE)
>>>               return -ENODEV;
>>>             invalidate_inode_pages2(file->f_mapping);
>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>> index 1b9d0dfae72d..003dcf42e8c2 100644
>>> --- a/include/uapi/linux/fuse.h
>>> +++ b/include/uapi/linux/fuse.h
>>> @@ -314,6 +314,7 @@ struct fuse_file_lock {
>>>    * FOPEN_STREAM: the file is stream-like (no file position at all)
>>>    * FOPEN_NOFLUSH: don't flush data cache on close (unless 
>>> FUSE_WRITEBACK_CACHE)
>>>    * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on 
>>> the same inode
>>> + * FOPEN_DIRECT_IO_SHARED_MMAP: allow shared mmap when 
>>> FOPEN_DIRECT_IO is set
>>>    */
>>>   #define FOPEN_DIRECT_IO        (1 << 0)
>>>   #define FOPEN_KEEP_CACHE    (1 << 1)
>>> @@ -322,6 +323,7 @@ struct fuse_file_lock {
>>>   #define FOPEN_STREAM        (1 << 4)
>>>   #define FOPEN_NOFLUSH        (1 << 5)
>>>   #define FOPEN_PARALLEL_DIRECT_WRITES    (1 << 6)
>>> +#define FOPEN_DIRECT_IO_SHARED_MMAP    (1 << 7)
>>
>> Thanks, that is what I had in my mind as well.
>>
>> I don't have a strong opinion on it (so don't change it before Miklos 
>> commented), but maybe FOPEN_DIRECT_IO_WEAK? Just in case there would 
>> be later on other conditions that need to be weakened? The comment 
>> would say then something like
>> "Weakens FOPEN_DIRECT_IO enforcement, allows MAP_SHARED mmap"
>>
>> Thanks,
>> Bernd
>>
> 
> Hi Bernd,
> 
> BTW, I have another question:
> 
> ```
> 
>    static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
> {
>            struct fuse_file *ff = file->private_data;
> 
>            /* DAX mmap is superior to direct_io mmap */
>            if (FUSE_IS_DAX(file_inode(file)))
>                    return fuse_dax_mmap(file, vma);
> 
>            if (ff->open_flags & FOPEN_DIRECT_IO) {
>                    /* Can't provide the coherency needed for MAP_SHARED */
>                    if (vma->vm_flags & VM_MAYSHARE)
>                            return -ENODEV;
> 
> invalidate_inode_pages2(file->f_mapping);
> 
>                    return generic_file_mmap(file, vma);
> }
> 
>            if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & 
> VM_MAYWRITE))
> fuse_link_write_file(file);
> 
> file_accessed(file);
>            vma->vm_ops = &fuse_file_vm_ops;
>            return 0;
> }
> 
> ```
> 
> For FOPEN_DIRECT_IO and !FOPEN_DIRECT_IO case, the former set vm_ops to 
> generic_file_vm_ops
> 
> while the latter set it to fuse_file_vm_ops, and also it does the 
> fuse_link_write_file() stuff. Why is so?
> 
> What causes the difference here?

Sorry, this slipped through and I had been busy with other work.

Looks rather similar, I actually wonder if fuse_page_mkwrite() shouldn't 
be replaced with filemap_page_mkwrite. Going back in history, fuse got 
mmap in 2.6.26 and had page_mkwrite method, but 2.6.26 didn't have the 
filemap_page_mkwrite method - when it was added fuse was just not updated?
So that leaves the additional fuse_vma_close, I guess the direct-io code 
path could also use fuse_file_vm_ops.


Bernd
