Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617FD76191F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjGYNAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 09:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjGYNAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:00:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8A19BF
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 06:00:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 95A665C00ED;
        Tue, 25 Jul 2023 09:00:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 25 Jul 2023 09:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690290036; x=1690376436; bh=fOjGKS0iyEC2YEI3p0zAZXW9c6ZXQYijkYi
        hAAr49f8=; b=lzUtPMtvxQLAn7n2yuyXoailxyFBaw0j6AFAM/CFKr++oLc7hQO
        J88krUpyjWj5Fra2WUtG5HvQ/3hON+T22rdAn5fDajJKDkcof7kS6qj5zIeL3ga2
        7RopaQ41I9qe890W4XDaKqOTuJAjMxKfy5jnhhziA0nYdUiMBSaQ37Gr3WMV/GjU
        LsjW54IeuvQCfDozzjMFdlAfyoUZxFywzz1wq5ulkN1YmLa1LtZZy8oCWLPGZScU
        lSL/F54UOeESXeRfOsfWPBudnzRPsPZ1RBPSJft/uae3ux3gtpfv5gVUbflMXyaE
        eYyVnt0gbLwG/FA8Imsf3xvyO3hMhT621fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690290036; x=1690376436; bh=fOjGKS0iyEC2YEI3p0zAZXW9c6ZXQYijkYi
        hAAr49f8=; b=OWZSv5ynheQ5WS8/nFHIRImbGDY/6VSzAXfiGw3ls3Gdi3cYYuE
        bza5NNtLpRdItRGOkkd0A8aAAQ+TU+zoIbf7/tVM1flekC9iMqBWGFGqa8DKyAZN
        GMmEgA8oY3o/EFRIUir9MKXkppPEm15oVjBKE0w+smVLgfPfELDcUNkQUIyg0iS+
        cPJq5zZEs96eWJmpaQRzne88R+44tjh9cQtB250s9mCwwKCPo8nivjYa+VPX60YB
        +Niann0swxZzldtORzlwWtr2BQ7pwlG/66xlOuEYl+bjVC/YwDd7sTtzUODbEW8W
        WnT+JrNr/xb5pgjWw4qjRUj3HX8IqTtPSxA==
X-ME-Sender: <xms:cce_ZFEPukqZkKFzxr65RONkQRqKTq5jPgyQhGlp_ZkdxXEMSxCZ6g>
    <xme:cce_ZKVnnZ8RqctuS11l3wmXA5rQjHe5BX9NT3Nnt2DTXjKJlGil_cf08WvQRazBb
    4L9l1buMwcnNJyp>
X-ME-Received: <xmr:cce_ZHK3n_oo4sUQFsucc4Cp2tyZRlRQR1tyn01nJCoJYtgrmSwoXvilASQYJyjByv7ouhWaQKqmjjQ8elAVTMYotaPaBWyQheABK7b-dCT2OU2_R5uC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeffhfdtvdeviedvudeuudejteffkeeklefgvdef
    gfeuffeifeejgfejffehtddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:cse_ZLHzzHIeJ8D8FH0pR8Q_0B4pMakgH3zzBrxNr0mgdJw2-DuAog>
    <xmx:cse_ZLWMpGU6LTa7RYRhtrAW-MV-76xQbyk6D-qqmWz7PAfkhge7pA>
    <xmx:cse_ZGMjPUscbjRqTUJX-eVZQqScPeEjjz28OMfYFfS-K7YWrL2UZg>
    <xmx:dMe_ZBfmiX-_UfnlcxXhYOGz7-D5RPUdMhyuZ9JQlXGkbgI0exE6Nw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 09:00:32 -0400 (EDT)
Message-ID: <cb8c18e6-b5cb-e891-696f-b403012eacb7@fastmail.fm>
Date:   Tue, 25 Jul 2023 15:00:30 +0200
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
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <9b0a164d-3d0e-cc57-81b7-ae32bef4e9d7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/25/23 12:11, Hao Xu wrote:
> On 7/21/23 19:56, Bernd Schubert wrote:
>> On July 21, 2023 1:27:26 PM GMT+02:00, Hao Xu <hao.xu@linux.dev> wrote:
>>> On 7/21/23 14:35, Jiachen Zhang wrote:
>>>>
>>>> On 2023/6/30 17:46, Hao Xu wrote:
>>>>> From: Hao Xu <howeyxu@tencent.com>
>>>>>
>>>>> In direct_io_relax mode, there can be shared mmaped files and thus 
>>>>> dirty
>>>>> pages in its page cache. Therefore those dirty pages should be written
>>>>> back to backend before direct write to avoid data loss.
>>>>>
>>>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>>>> ---
>>>>>    fs/fuse/file.c | 7 +++++++
>>>>>    1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>>> index 176f719f8fc8..7c9167c62bf6 100644
>>>>> --- a/fs/fuse/file.c
>>>>> +++ b/fs/fuse/file.c
>>>>> @@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv 
>>>>> *io, struct iov_iter *iter,
>>>>>        if (!ia)
>>>>>            return -ENOMEM;
>>>>> +    if (fopen_direct_write && fc->direct_io_relax) {
>>>>> +        res = filemap_write_and_wait_range(mapping, pos, pos + 
>>>>> count - 1);
>>>>> +        if (res) {
>>>>> +            fuse_io_free(ia);
>>>>> +            return res;
>>>>> +        }
>>>>> +    }
>>>>>        if (!cuse && fuse_range_is_writeback(inode, idx_from, 
>>>>> idx_to)) {
>>>>>            if (!write)
>>>>>                inode_lock(inode);
>>>>
>>>> Tested-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
>>>>
>>>>
>>>> Looks good to me.
>>>>
>>>> By the way, the behaviour would be a first FUSE_WRITE flushing the 
>>>> page cache, followed by a second FUSE_WRITE doing the direct IO. In 
>>>> the future, further optimization could be first write into the page 
>>>> cache and then flush the dirty page to the FUSE daemon.
>>>>
>>>
>>> I think this makes sense, cannot think of any issue in it for now, so
>>> I'll do that change and send next version, super thanks, Jiachen!
>>>
>>> Thanks,
>>> Hao
>>>
>>>>
>>>> Thanks,
>>>> Jiachen
>>>
>>
>> On my phone, sorry if mail formatting is not optimal.
>> Do I understand it right? You want DIO code path copy into pages and 
>> then flush/invalidate these pages? That would be punish DIO for for 
>> the unlikely case there are also dirty pages (discouraged IO pattern).
> 
> Hi Bernd,
> I think I don't get what you said, why it is punishment and why it's 
> discouraged IO pattern?
> On my first eyes seeing Jiachen's idea, I was thinking "that sounds
> disobeying direct write semantics" because usually direct write is
> "flush dirty page -> invalidate page -> write data through to backend"
> not "write data to page -> flush dirty page/(writeback data)"
> The latter in worst case write data both to page cache and backend
> while the former just write to backend and load it to the page cache
> when buffered reading. But seems there is no such "standard way" which
> says we should implement direct IO in that way.

Hi Hao,

sorry for being brief last week, I was on vacation and reading/writing 
some mails on my phone.

With 'punishment' I mean memory copies to the page cache - memory copies 
are expensive and DIO should avoid it.

Right now your patch adds filemap_write_and_wait_range(), but we do not 
know if it did work (i.e. if pages had to be flushed). So unless you 
find a way to get that information, copy to page cache would be 
unconditionally - overhead of memory copy even if there are no dirty pages.

With 'discouraged' I mean mix of page cache and direct-io. Typically one 
should only do either of both (page cache or DIO), but not a mix of 
them. For example see your patch, it flushes the page cache, but without 
a lock - races are possible. Copying to the page cache might be a 
solution, but it has the overhead above.

Thanks,
Bernd
