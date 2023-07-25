Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF367620C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 19:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGYR7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjGYR7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:59:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8DF1FF7
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 10:59:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F0295C018D;
        Tue, 25 Jul 2023 13:59:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 25 Jul 2023 13:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690307953; x=1690394353; bh=H5Lt2LapYcQATw9WO8eUUlNhEIzRMnMZ3X+
        ijUtWJqI=; b=ZB8TVkzdx1Hdpmc3/fRd24RxgBZM2JFb5vEGq2xykSptrgEI3lC
        MpGC3PmT8guSci41oB4Y5o7Sxp8lMrt31vvQ7eXgoR3pdWMVIrGTeFAn90lGknbL
        dPVCUZC6oLdSova1wcja2xj/Bm5gceFGjoZsZ8RGHpJlPUvrEbNEMrQQgJloyXWC
        tOmbYihfV2swQElGs8z19pbhuWPV1m2MfqYxOG1/Um2x4DbezXm4ULnQ3hYrGWwc
        Z8T7verAeipiq2lkN50ZIcXQJbWOMAuloD8HgNv9FSfB7NrbCTr/iELkG9B/jFkj
        W0hP4GGNiNhuOtBKr2+JIZhSHfokQP2uCAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690307953; x=1690394353; bh=H5Lt2LapYcQATw9WO8eUUlNhEIzRMnMZ3X+
        ijUtWJqI=; b=HdhlqQpsipPksIOyjZi03v7h6n23GTrTybgNtG5tHdXfYc9GHml
        1CBoIS12Ky8g1kxmkMQaYLE3Fj2uzTKZ1K/b5TW5SMZFjW8iCfkqgsO1VMDODixx
        uHVOYupWycmDXGAOvtpi1rMf4hXf9+V7zI+YddqaBwlVi6XBxt42IxxGhnn5NeJD
        AOx/3CNhGotOsUVcnPWstu/eU+TSdZ4tyzc950gAX2LawZm1qIlcOvzFLctFZCxQ
        u/gVIqPTl0grOrNDIjVYqtrM8NzLhJQRgD5pNucuAyEBnlTqy27/zYJ3wHZz3E6d
        roHg7zScsZ+v2mktESbVhD19MCGcpsYE30g==
X-ME-Sender: <xms:bw3AZJZorYL25Tj1Rw5YF9a3Ei3kaennlzMB2mn_Wa9uByjHXwGf5Q>
    <xme:bw3AZAZoCjaJ8L0X1ze_ak-SUWPwCsZ-ZWBu92PQgL-sjc3VVGZCvc6odr-YxlNJC
    03O_xUTbjfUaHS2>
X-ME-Received: <xmr:bw3AZL8GzGyvyKMOxGA8KP4T4hEC0TjtXsXTBfSh_pVFc7QT-FTezEq3psPipRjDjpev8zZ6C9p6bajGgULFYrdOw2m5woiXeawOdetyFkYIvyr51nVd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:bw3AZHrl5b8lxzkAL-1UqB5zaDdLCdWZS0VIQoypuOoSWIZTH-zFSA>
    <xmx:bw3AZEoVytVTCMl9JOdKlW-nis9yQ_qqtg-fS2jPixP9l-iwCYcmlw>
    <xmx:bw3AZNQoSuOjXKJwgVPv9Wi1hnr0HSxisz2c0FkY_saa5U7RGB_rsQ>
    <xmx:cQ3AZJB9u2FCND6-Z2VGQKCg4TBHVM5l8PCxwnDL94JSSpkXUYLo0g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 13:59:10 -0400 (EDT)
Message-ID: <02444c76-ea2e-3931-d49e-5cd0518711a7@fastmail.fm>
Date:   Tue, 25 Jul 2023 19:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [External] [fuse-devel] [PATCH 3/3] fuse: write back dirty pages
 before direct write in direct_io_relax mode
To:     Hao Xu <hao.xu@linux.dev>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
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
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <45da6206-8e34-a184-5ba4-d40be252cfd2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/25/23 18:57, Hao Xu wrote:
> 
> On 7/25/23 21:00, Bernd Schubert wrote:
>>
>>
>> On 7/25/23 12:11, Hao Xu wrote:
>>> On 7/21/23 19:56, Bernd Schubert wrote:
>>>> On July 21, 2023 1:27:26 PM GMT+02:00, Hao Xu <hao.xu@linux.dev> wrote:
>>>>> On 7/21/23 14:35, Jiachen Zhang wrote:
>>>>>>
>>>>>> On 2023/6/30 17:46, Hao Xu wrote:
>>>>>>> From: Hao Xu <howeyxu@tencent.com>
>>>>>>>
>>>>>>> In direct_io_relax mode, there can be shared mmaped files and 
>>>>>>> thus dirty
>>>>>>> pages in its page cache. Therefore those dirty pages should be 
>>>>>>> written
>>>>>>> back to backend before direct write to avoid data loss.
>>>>>>>
>>>>>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>>>>>> ---
>>>>>>>    fs/fuse/file.c | 7 +++++++
>>>>>>>    1 file changed, 7 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>>>>> index 176f719f8fc8..7c9167c62bf6 100644
>>>>>>> --- a/fs/fuse/file.c
>>>>>>> +++ b/fs/fuse/file.c
>>>>>>> @@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv 
>>>>>>> *io, struct iov_iter *iter,
>>>>>>>        if (!ia)
>>>>>>>            return -ENOMEM;
>>>>>>> +    if (fopen_direct_write && fc->direct_io_relax) {
>>>>>>> +        res = filemap_write_and_wait_range(mapping, pos, pos + 
>>>>>>> count - 1);
>>>>>>> +        if (res) {
>>>>>>> +            fuse_io_free(ia);
>>>>>>> +            return res;
>>>>>>> +        }
>>>>>>> +    }
>>>>>>>        if (!cuse && fuse_range_is_writeback(inode, idx_from, 
>>>>>>> idx_to)) {
>>>>>>>            if (!write)
>>>>>>>                inode_lock(inode);
>>>>>>
>>>>>> Tested-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
>>>>>>
>>>>>>
>>>>>> Looks good to me.
>>>>>>
>>>>>> By the way, the behaviour would be a first FUSE_WRITE flushing the 
>>>>>> page cache, followed by a second FUSE_WRITE doing the direct IO. 
>>>>>> In the future, further optimization could be first write into the 
>>>>>> page cache and then flush the dirty page to the FUSE daemon.
>>>>>>
>>>>>
>>>>> I think this makes sense, cannot think of any issue in it for now, so
>>>>> I'll do that change and send next version, super thanks, Jiachen!
>>>>>
>>>>> Thanks,
>>>>> Hao
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Jiachen
>>>>>
>>>>
>>>> On my phone, sorry if mail formatting is not optimal.
>>>> Do I understand it right? You want DIO code path copy into pages and 
>>>> then flush/invalidate these pages? That would be punish DIO for for 
>>>> the unlikely case there are also dirty pages (discouraged IO pattern).
>>>
>>> Hi Bernd,
>>> I think I don't get what you said, why it is punishment and why it's 
>>> discouraged IO pattern?
>>> On my first eyes seeing Jiachen's idea, I was thinking "that sounds
>>> disobeying direct write semantics" because usually direct write is
>>> "flush dirty page -> invalidate page -> write data through to backend"
>>> not "write data to page -> flush dirty page/(writeback data)"
>>> The latter in worst case write data both to page cache and backend
>>> while the former just write to backend and load it to the page cache
>>> when buffered reading. But seems there is no such "standard way" which
>>> says we should implement direct IO in that way.
>>
>> Hi Hao,
>>
>> sorry for being brief last week, I was on vacation and reading/writing 
>> some mails on my phone.
>>
>> With 'punishment' I mean memory copies to the page cache - memory 
>> copies are expensive and DIO should avoid it.
>>
>> Right now your patch adds filemap_write_and_wait_range(), but we do 
>> not know if it did work (i.e. if pages had to be flushed). So unless 
>> you find a way to get that information, copy to page cache would be 
>> unconditionally - overhead of memory copy even if there are no dirty 
>> pages.
> 
> 
> Ah, looks I understood what you mean in my last email reply. Yes, just 
> like what I said in last email:
> 
> [1] flush dirty page --> invalidate page --> write data to backend
> 
>     This is what we do for direct write right now in kernel, I call this 
> policy "write-through", since it doesn't care much about the cache.
> 
> [2] write data to page cache --> flush dirty page in suitable time
> 
>     This is  "write-back" policy, used by buffered write. Here in this 
> patch's case, we flush pages synchronously, so it still can be called 
> direct-write.
> 
> Surely, in the worst case, the page is clean, then [2] has one extra 
> memory copy than [1]. But like what I pointed out, for [2], next time 
> buffered
> 
> read happens, the page is in latest state, so no I/O needed, while for 
> [1], it has to load data from backend to page cache.
> 
> 
>>
>> With 'discouraged' I mean mix of page cache and direct-io. Typically 
>> one should only do either of both (page cache or DIO), but not a mix 
>> of them. For example see your patch, it flushes the page cache, but 
>> without a lock - races are possible. Copying to the page cache might 
>> be a solution, but it has the overhead above.
> 
> 
> For race, we held inode lock there, do I miss anything?

We hold inode lock in write path, but not in read path. That ensures 
invalidate_inode_pages2_range() is not racing, but DIO read might race 
with a page cache writing happening in parallel. I guess results are 
then a bit unexpected anyway, although differently if we would hold the 
lock.


> 
> 
>>
>> Thanks,
>> Bernd
> 
> 
> I now think it's good to keep the pattern same as other filesystems 
> which is [1] to avoid possible performance issues in the future, thanks 
> Bernd.

Thanks, I think we should keep fuse consistent with what other fs do.


Thanks,
Bernd
