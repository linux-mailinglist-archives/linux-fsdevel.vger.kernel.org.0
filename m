Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED1A766228
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 04:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjG1C6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 22:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG1C6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:58:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC2213A
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 19:57:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bb2468257fso9816995ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 19:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690513068; x=1691117868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQDPDf8JZAFiL6Rq9P4Wi7ecqzmU4ri9UYAO1Af8OMI=;
        b=ZxMOdJ6IwUrpVQzUsbucF1ehTSICSH2eWs0MYmuw0Dl7uzNcnuwrLfa3EBNKgT8gb0
         oI+2oF3Zk86fzJb9X7OH+SDolZjMpDXl0piWRvNM5K+r7AejNr79DalbVecDwCD9uo04
         y09kzezbR1r4bMKmZaAqAbwSkR1pkT2j5oFJk89R2Q+ct9hxQ54xArJuqDxJ9mi3z3e1
         gD6CkPOFArOp6SwHZtE4n+Fui4D8gry6XdSCXkEvqbE9qbl9BqGD1WH5zvYvkxrcLXdT
         vRFqtPI/sErG24QNuegDQdO3uL8wBalb9HF1ho6TuOMnvsCTXoK28GyKKidlynP3dUA7
         zOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690513068; x=1691117868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQDPDf8JZAFiL6Rq9P4Wi7ecqzmU4ri9UYAO1Af8OMI=;
        b=BQ3hpW38fOoVTdy7AgHjIlQci1peJHc4QEhANMlrZzumVAGa9ZcPU6zfJLUs9XQeuJ
         UPpOy5DU+68ms0NPtEB0CxkVkeHvl0dCAGyVU7oxKdhEkISu9RIlcmm7VGrWJJd3xKi5
         w84mQJQe4tzZwcTlRfecq77YgCUfaG6bNro0ay+hBeWkmASbR+Z380CfyYaQ9bMC4j5V
         h9W3DG3dTTgguc8nyUt9YIokyaj/SOFzzsX3yZqCSCb+9K7Qy3t6tdYWUGJ5yJMGUYXi
         7Db/OSUSZ1RHDApAmwluVxiFnsMNUWRGenMpudiRYXGx/v2bnolFtSHwQN6o9PBUsfGy
         6BtQ==
X-Gm-Message-State: ABy/qLZQS7OA+W1kKACVfF0LarbxLIqBHNFZ4wh+8AOpYg8y9E3po4un
        KSfBDr5GwIjBXg0msJe4Pb+rJA==
X-Google-Smtp-Source: APBJJlEoSUFYAoNyEjUxprw92DkS9SGnnUh1rbqPqjd9cv3iBuTNlLDRWmBagdsdXzuLe3jGdMsA/g==
X-Received: by 2002:a17:902:e546:b0:1b8:aef2:773e with SMTP id n6-20020a170902e54600b001b8aef2773emr380798plf.46.1690513068318;
        Thu, 27 Jul 2023 19:57:48 -0700 (PDT)
Received: from [10.3.208.155] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001b8ad8382a4sm2334461plb.216.2023.07.27.19.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 19:57:47 -0700 (PDT)
Message-ID: <ef357671-0f31-32bd-9638-66455a70a626@bytedance.com>
Date:   Fri, 28 Jul 2023 10:57:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [fuse-devel] [PATCH 3/3] fuse: write back dirty pages before
 direct write in direct_io_relax mode
To:     Hao Xu <hao.xu@linux.dev>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net, miklos@szeredi.hu
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <20230630094602.230573-4-hao.xu@linux.dev>
 <e5266e11-b58b-c8ca-a3c8-0b2c07b3a1b2@bytedance.com>
 <2622afd7-228f-02f3-3b72-a1c826844126@linux.dev>
 <396A0BF4-DA68-46F8-9881-3801737225C6@fastmail.fm>
 <9b0a164d-3d0e-cc57-81b7-ae32bef4e9d7@linux.dev>
 <cb8c18e6-b5cb-e891-696f-b403012eacb7@fastmail.fm>
 <45da6206-8e34-a184-5ba4-d40be252cfd2@linux.dev>
 <6856f435-a589-e044-881f-3a80aefa1174@bytedance.com>
 <b4fb751f-abb2-5618-31a0-f0cdacc49506@linux.dev>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <b4fb751f-abb2-5618-31a0-f0cdacc49506@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/7/27 18:31, Hao Xu wrote:
> On 7/26/23 19:07, Jiachen Zhang wrote:
>>
>>
>> On 2023/7/26 00:57, Hao Xu wrote:
>>>
>>> On 7/25/23 21:00, Bernd Schubert wrote:
>>>>
>>>>
>>>> On 7/25/23 12:11, Hao Xu wrote:
>>>>> On 7/21/23 19:56, Bernd Schubert wrote:
>>>>>> On July 21, 2023 1:27:26 PM GMT+02:00, Hao Xu <hao.xu@linux.dev> 
>>>>>> wrote:
>>>>>>> On 7/21/23 14:35, Jiachen Zhang wrote:
>>>>>>>>
>>>>>>>> On 2023/6/30 17:46, Hao Xu wrote:
>>>>>>>>> From: Hao Xu <howeyxu@tencent.com>
>>>>>>>>>
>>>>>>>>> In direct_io_relax mode, there can be shared mmaped files and 
>>>>>>>>> thus dirty
>>>>>>>>> pages in its page cache. Therefore those dirty pages should be 
>>>>>>>>> written
>>>>>>>>> back to backend before direct write to avoid data loss.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>>>>>>>> ---
>>>>>>>>>    fs/fuse/file.c | 7 +++++++
>>>>>>>>>    1 file changed, 7 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>>>>>>> index 176f719f8fc8..7c9167c62bf6 100644
>>>>>>>>> --- a/fs/fuse/file.c
>>>>>>>>> +++ b/fs/fuse/file.c
>>>>>>>>> @@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct 
>>>>>>>>> fuse_io_priv *io, struct iov_iter *iter,
>>>>>>>>>        if (!ia)
>>>>>>>>>            return -ENOMEM;
>>>>>>>>> +    if (fopen_direct_write && fc->direct_io_relax) {
>>
>>
>> Hi,
>>
>> Seems this patchset flushes and invalidates the page cache before 
>> doing the direct-io writes, which avoids data loss caused by flushing 
>> staled data to FUSE daemon. And I tested it works well.
>>
>> But there is also another side of the same problem we should consider. 
>> If a file is modified through its page cache (shared mmapped regions, 
>> or non-FOPEN_DIRECT_IO files), the following direct-io reads may 
>> bypass the new data in dirty page cache and read the staled data from 
>> FUSE daemon. I think this is also a problem that should be fixed. It 
>> could be fixed by uncondictionally calling 
>> filemap_write_and_wait_range() before direct-io read.
>>
>>
>>>>>>>>> +        res = filemap_write_and_wait_range(mapping, pos, pos + 
>>>>>>>>> count - 1);
>>>>>>>>> +        if (res) {
>>>>>>>>> +            fuse_io_free(ia);
>>>>>>>>> +            return res;
>>>>>>>>> +        }
>>>>>>>>> +    }
>>>>>>>>>        if (!cuse && fuse_range_is_writeback(inode, idx_from, 
>>>>>>>>> idx_to)) {
>>>>>>>>>            if (!write)
>>>>>>>>>                inode_lock(inode);
>>>>>>>>
>>>>>>>> Tested-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
>>>>>>>>
>>>>>>>>
>>>>>>>> Looks good to me.
>>>>>>>>
>>>>>>>> By the way, the behaviour would be a first FUSE_WRITE flushing 
>>>>>>>> the page cache, followed by a second FUSE_WRITE doing the direct 
>>>>>>>> IO. In the future, further optimization could be first write 
>>>>>>>> into the page cache and then flush the dirty page to the FUSE 
>>>>>>>> daemon.
>>>>>>>>
>>>>>>>
>>>>>>> I think this makes sense, cannot think of any issue in it for 
>>>>>>> now, so
>>>>>>> I'll do that change and send next version, super thanks, Jiachen!
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Hao
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Jiachen
>>>>>>>
>>>>>>
>>>>>> On my phone, sorry if mail formatting is not optimal.
>>>>>> Do I understand it right? You want DIO code path copy into pages 
>>>>>> and then flush/invalidate these pages? That would be punish DIO 
>>>>>> for for the unlikely case there are also dirty pages (discouraged 
>>>>>> IO pattern).
>>>>>
>>>>> Hi Bernd,
>>>>> I think I don't get what you said, why it is punishment and why 
>>>>> it's discouraged IO pattern?
>>>>> On my first eyes seeing Jiachen's idea, I was thinking "that sounds
>>>>> disobeying direct write semantics" because usually direct write is
>>>>> "flush dirty page -> invalidate page -> write data through to backend"
>>>>> not "write data to page -> flush dirty page/(writeback data)"
>>>>> The latter in worst case write data both to page cache and backend
>>>>> while the former just write to backend and load it to the page cache
>>>>> when buffered reading. But seems there is no such "standard way" which
>>>>> says we should implement direct IO in that way.
>>>>
>>>> Hi Hao,
>>>>
>>>> sorry for being brief last week, I was on vacation and 
>>>> reading/writing some mails on my phone.
>>>>
>>>> With 'punishment' I mean memory copies to the page cache - memory 
>>>> copies are expensive and DIO should avoid it.
>>>>
>>>> Right now your patch adds filemap_write_and_wait_range(), but we do 
>>>> not know if it did work (i.e. if pages had to be flushed). So unless 
>>>> you find a way to get that information, copy to page cache would be 
>>>> unconditionally - overhead of memory copy even if there are no dirty 
>>>> pages.
>>>
>>>
>>> Ah, looks I understood what you mean in my last email reply. Yes, 
>>> just like what I said in last email:
>>>
>>> [1] flush dirty page --> invalidate page --> write data to backend
>>>
>>>     This is what we do for direct write right now in kernel, I call 
>>> this policy "write-through", since it doesn't care much about the cache.
>>>
>>> [2] write data to page cache --> flush dirty page in suitable time
>>>
>>>     This is  "write-back" policy, used by buffered write. Here in 
>>> this patch's case, we flush pages synchronously, so it still can be 
>>> called direct-write.
>>>
>>> Surely, in the worst case, the page is clean, then [2] has one extra 
>>> memory copy than [1]. But like what I pointed out, for [2], next time 
>>> buffered
>>>
>>> read happens, the page is in latest state, so no I/O needed, while 
>>> for [1], it has to load data from backend to page cache.
>>>
>>
>> Write-through, write-back and direct-io are also exlained in the 
>> kernel documentation [*], of which write-through and write-back are 
>> cache modes. According to the document, the pattern [2] is similar to 
>> the FUSE 
> 
> Yep, in previous mail write-through and write-back I mentioned are
> generic concepts for any cache system, e.g. cpu cache, page cache.
> 
> 
>> write-back mode, but the pattern [1] is different from the FUSE 
>> write-through mode. The FUSE write-through mode obeys the 'write data 
>> to page cache --> flush dirty page synchronously' (let us call it 
>> pattern [3]), which keeps the clean cache in-core after flushing.
> 
> I read the fuse doc, I think you are right, in !FOPEN_DIRECT_IO mode,
> the IO model for fuse is different with other filesystems. Specifically,
> its 'write-back' branch is just following other filesystems and
> 'write-through' forces all writes go to both page cache and back-end,
> this is actually closer to the concept write-through.
> 
>>
>> To improve performance while keeping the direct-io semantics, my 
>> thoughts was in the future, maybe we can fallback to the pattern [3] 
>> if the target page is in-core, otherwise keep the original direct-io 
>> pattern without reading from whole pages from FUSE daemon.
> 
> Why will we reading from whole pages from backend?
> That case happens for buffered write, because for buffered write, if we
> partially write to a page that is not in the front-end cache, it causes
> reading the whole page from back-end. But here we always do direct write
> in FOPEN_DIRECT_IO mode, so we just invalidate the pages involved.
> 

Hi Hao,

Yes, and I did say that if the page is not in-core, we can still keep 
the direct-io pattern, which avoids paging-in of the write-through and 
write-back modes.

> And just like Bernd said, "if the target page is in-core" is not enough,
> if the target page is not dirty, following pattern [3] make one extra
> page cache write.
> 

Yes, I agree the further checking of the dirtyness is better for 
improving performance.

Thanks,
Jiachen


>>
>> [*] https://www.kernel.org/doc/Documentation/filesystems/fuse-io.txt
>>
>> Thanks,
>> Jiachen
>>
>>>
>>>>
>>>> With 'discouraged' I mean mix of page cache and direct-io. Typically 
>>>> one should only do either of both (page cache or DIO), but not a mix 
>>>> of them. For example see your patch, it flushes the page cache, but 
>>>> without a lock - races are possible. Copying to the page cache might 
>>>> be a solution, but it has the overhead above.
>>>
>>>
>>> For race, we held inode lock there, do I miss anything?
>>>
>>>
>>>>
>>>> Thanks,
>>>> Bernd
>>>
>>>
>>> I now think it's good to keep the pattern same as other filesystems 
>>> which is [1] to avoid possible performance issues in the future, 
>>> thanks Bernd.
>>>
>>>
>>> Hao
>>>
>>>
> 

