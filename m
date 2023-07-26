Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B1763752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 15:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjGZNQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 09:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjGZNQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:16:08 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C1A26A2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 06:15:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 70CA932001C6;
        Wed, 26 Jul 2023 09:15:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 Jul 2023 09:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690377351; x=1690463751; bh=M7bA6BLsq3bH+NKnWU9UHETeiUpG/IYn5fV
        wUd4zFbg=; b=d5Ax8BYUM+k0uKglpRsCUAL43xHQwyzS8NQbcJQgCXnGwZHj/m6
        OoLGDzV7lkA32Q0xPY0ZfF42xY8gOJkKjpgRPKJL7dqBqHDNydl7Ny2BnWYpn2j3
        Q7L5elcZDWlsTmhhahf5HYEjUc227rUyN7eh0lT11wN216hzToiEVjbXyFFA3LDm
        7Kv4ZB5/kaPx51IvOajd9tPeiBa725rFiqkOV2CdR94WtZqvfSveXUhmcR6n/8nj
        3brcEy7sUDozIxytrPFgozP8yHPv7qydoHupu6/QaBXDA/UrI9+Is0s9577/QScu
        zmekq5kn4fwQsh5zQMxcKT2xKTiCiLjoEFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690377351; x=1690463751; bh=M7bA6BLsq3bH+NKnWU9UHETeiUpG/IYn5fV
        wUd4zFbg=; b=MRjbC4D95bEKjh15HE348fjQWyyG4GAp9Gh0Ka0/ULvu4uFHXAL
        h9HdV1s+dNEReNH8KwGkfkFi30q1yAkwd5PhKzC2I5NtC+8C1w6fN971nb5iVtAR
        z7OlwNOMugtL8MFrCxkGhCHU2Cen/gbjRNWvOcpmaxxPAv2a/HG8DT4ibXxojwRi
        g++CXnCOXeLTvAPK6Sw6oLBUcxrZFD+ayU8DnDv5ReVOOBwIO4maSGrvHKnfjRAk
        qu1pjYIbFHldXO7ujpD9T8TUkBGUxjjPSsVoXYEzAx73ypDgPyuEnlJgX7sTiMFn
        DFfgr3WtlswWEM9t/O5DnDaE5Gk11VY71Iw==
X-ME-Sender: <xms:hRzBZF1PNSAyo4q-5l0WFyZP-843igG7oog3P3byEwkOCXGY7LL-og>
    <xme:hRzBZMF0srNGgwtAIkw_kTeIkRE6bvMzajQulofjUmf13JgelB5akOVPkHYzgX8Gz
    nC8ZULshqiT1MSy>
X-ME-Received: <xmr:hRzBZF50Lc8myNm58VUlc7j3gLBmotl1WUwp5sASnEAeZeW_HlZ7nAtmvWA_mkDc6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpefgudevueevveeiudejveeffeejkeegvdduheek
    vdefhfetgeegheekkeetleehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:hRzBZC1schz0duJvuylkOG4EvMu6LxDYVf0clLrgM34W5BKM8VHSvA>
    <xmx:hRzBZIFBqOWGGmfbA9voug9_vYtY0XGbED2AZVWG6-se45Qpa5yAow>
    <xmx:hRzBZD9mULU_40WKVKbwzgNFTnzDcl0tcklJiphC8odnhH6syKjj-g>
    <xmx:hxzBZNO1OuWjC_u7EbhxuvN5go4NIz4_7Blw1nApEXt2_ibW-MwGHg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 09:15:48 -0400 (EDT)
Message-ID: <5d504536-e0bc-3fc3-8f7b-dc4b579250aa@fastmail.fm>
Date:   Wed, 26 Jul 2023 15:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [fuse-devel] [PATCH 3/3] fuse: write back dirty pages before
 direct write in direct_io_relax mode
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
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
Content-Language: en-US
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <6856f435-a589-e044-881f-3a80aefa1174@bytedance.com>
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



On 7/26/23 13:07, Jiachen Zhang wrote:
> 
> 
> On 2023/7/26 00:57, Hao Xu wrote:
>>
>> On 7/25/23 21:00, Bernd Schubert wrote:
>>>
>>>
>>> On 7/25/23 12:11, Hao Xu wrote:
>>>> On 7/21/23 19:56, Bernd Schubert wrote:
>>>>> On July 21, 2023 1:27:26 PM GMT+02:00, Hao Xu <hao.xu@linux.dev> 
>>>>> wrote:
>>>>>> On 7/21/23 14:35, Jiachen Zhang wrote:
>>>>>>>
>>>>>>> On 2023/6/30 17:46, Hao Xu wrote:
>>>>>>>> From: Hao Xu <howeyxu@tencent.com>
>>>>>>>>
>>>>>>>> In direct_io_relax mode, there can be shared mmaped files and 
>>>>>>>> thus dirty
>>>>>>>> pages in its page cache. Therefore those dirty pages should be 
>>>>>>>> written
>>>>>>>> back to backend before direct write to avoid data loss.
>>>>>>>>
>>>>>>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>>>>>>> ---
>>>>>>>>    fs/fuse/file.c | 7 +++++++
>>>>>>>>    1 file changed, 7 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>>>>>> index 176f719f8fc8..7c9167c62bf6 100644
>>>>>>>> --- a/fs/fuse/file.c
>>>>>>>> +++ b/fs/fuse/file.c
>>>>>>>> @@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct 
>>>>>>>> fuse_io_priv *io, struct iov_iter *iter,
>>>>>>>>        if (!ia)
>>>>>>>>            return -ENOMEM;
>>>>>>>> +    if (fopen_direct_write && fc->direct_io_relax) {
> 
> 
> Hi,
> 
> Seems this patchset flushes and invalidates the page cache before doing 
> the direct-io writes, which avoids data loss caused by flushing staled 
> data to FUSE daemon. And I tested it works well.
> 
> But there is also another side of the same problem we should consider. 
> If a file is modified through its page cache (shared mmapped regions, or 
> non-FOPEN_DIRECT_IO files), the following direct-io reads may bypass the 
> new data in dirty page cache and read the staled data from FUSE daemon. 
> I think this is also a problem that should be fixed. It could be fixed 
> by uncondictionally calling filemap_write_and_wait_range() before 
> direct-io read.
> 
> 
>>>>>>>> +        res = filemap_write_and_wait_range(mapping, pos, pos + 
>>>>>>>> count - 1);
>>>>>>>> +        if (res) {
>>>>>>>> +            fuse_io_free(ia);
>>>>>>>> +            return res;
>>>>>>>> +        }
>>>>>>>> +    }
>>>>>>>>        if (!cuse && fuse_range_is_writeback(inode, idx_from, 
>>>>>>>> idx_to)) {
>>>>>>>>            if (!write)
>>>>>>>>                inode_lock(inode);
>>>>>>>
>>>>>>> Tested-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
>>>>>>>
>>>>>>>
>>>>>>> Looks good to me.
>>>>>>>
>>>>>>> By the way, the behaviour would be a first FUSE_WRITE flushing 
>>>>>>> the page cache, followed by a second FUSE_WRITE doing the direct 
>>>>>>> IO. In the future, further optimization could be first write into 
>>>>>>> the page cache and then flush the dirty page to the FUSE daemon.
>>>>>>>
>>>>>>
>>>>>> I think this makes sense, cannot think of any issue in it for now, so
>>>>>> I'll do that change and send next version, super thanks, Jiachen!
>>>>>>
>>>>>> Thanks,
>>>>>> Hao
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Jiachen
>>>>>>
>>>>>
>>>>> On my phone, sorry if mail formatting is not optimal.
>>>>> Do I understand it right? You want DIO code path copy into pages 
>>>>> and then flush/invalidate these pages? That would be punish DIO for 
>>>>> for the unlikely case there are also dirty pages (discouraged IO 
>>>>> pattern).
>>>>
>>>> Hi Bernd,
>>>> I think I don't get what you said, why it is punishment and why it's 
>>>> discouraged IO pattern?
>>>> On my first eyes seeing Jiachen's idea, I was thinking "that sounds
>>>> disobeying direct write semantics" because usually direct write is
>>>> "flush dirty page -> invalidate page -> write data through to backend"
>>>> not "write data to page -> flush dirty page/(writeback data)"
>>>> The latter in worst case write data both to page cache and backend
>>>> while the former just write to backend and load it to the page cache
>>>> when buffered reading. But seems there is no such "standard way" which
>>>> says we should implement direct IO in that way.
>>>
>>> Hi Hao,
>>>
>>> sorry for being brief last week, I was on vacation and 
>>> reading/writing some mails on my phone.
>>>
>>> With 'punishment' I mean memory copies to the page cache - memory 
>>> copies are expensive and DIO should avoid it.
>>>
>>> Right now your patch adds filemap_write_and_wait_range(), but we do 
>>> not know if it did work (i.e. if pages had to be flushed). So unless 
>>> you find a way to get that information, copy to page cache would be 
>>> unconditionally - overhead of memory copy even if there are no dirty 
>>> pages.
>>
>>
>> Ah, looks I understood what you mean in my last email reply. Yes, just 
>> like what I said in last email:
>>
>> [1] flush dirty page --> invalidate page --> write data to backend
>>
>>     This is what we do for direct write right now in kernel, I call 
>> this policy "write-through", since it doesn't care much about the cache.
>>
>> [2] write data to page cache --> flush dirty page in suitable time
>>
>>     This is  "write-back" policy, used by buffered write. Here in this 
>> patch's case, we flush pages synchronously, so it still can be called 
>> direct-write.
>>
>> Surely, in the worst case, the page is clean, then [2] has one extra 
>> memory copy than [1]. But like what I pointed out, for [2], next time 
>> buffered
>>
>> read happens, the page is in latest state, so no I/O needed, while for 
>> [1], it has to load data from backend to page cache.
>>
> 
> Write-through, write-back and direct-io are also exlained in the kernel 
> documentation [*], of which write-through and write-back are cache 
> modes. According to the document, the pattern [2] is similar to the FUSE 
> write-back mode, but the pattern [1] is different from the FUSE 
> write-through mode. The FUSE write-through mode obeys the 'write data to 
> page cache --> flush dirty page synchronously' (let us call it pattern 
> [3]), which keeps the clean cache in-core after flushing.
> 
> To improve performance while keeping the direct-io semantics, my 
> thoughts was in the future, maybe we can fallback to the pattern [3] if 
> the target page is in-core, otherwise keep the original direct-io 
> pattern without reading from whole pages from FUSE daemon.
> 
> [*] https://www.kernel.org/doc/Documentation/filesystems/fuse-io.txt

Hmm, ok, so mode 3 would be be basically look up a pages  folio in the 
buffer range (__filemap_get_folio?), check if it is dirty and if so, 
copy to it?
I see that it makes sense to reduce IOs, but then it also makes the code 
more complex. Do you have a use case / application that does mixed DIO / 
page cache IO?


Thanks,
Bernd
