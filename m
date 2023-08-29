Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C178C679
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 15:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjH2Nw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjH2Nw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:52:27 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2959C
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 06:52:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 049505C00C3;
        Tue, 29 Aug 2023 09:52:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 29 Aug 2023 09:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693317144; x=1693403544; bh=VeDaEr8XCebGRLZuR7RQweA/XHq0rXvvS9T
        TD1b+Kv4=; b=mRcNatrMSNk8RNfwWUtaiyRs0ta0csqQBVPQlkCwgOAK07fsDS7
        Z7k9VAfPSVKc3UpENGkVVVnjf0upSnd1kkLvPromITWUmzOf+DzrNktYCt0xS7lY
        dXXbYdEC3AlkIxfii0SH7B0oPguyUQFnYDYTS+ZU32YTmbgVwNYSAoY7QtUwSKD4
        oHPmQTh3VJia/9awgrXkIxgucjgul/baUeHN95mZIJnnmXuywxTtnJCdtwK4YoJT
        oqgdjnXi4DGSSOP3ArAVMXBc2wlviGaXNfL1gfFZytoc+H22N8N5EnbCNv1uxtvL
        DhFLvmMcC1jQzINj+paPRoIqu93OqdmWIJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693317144; x=1693403544; bh=VeDaEr8XCebGRLZuR7RQweA/XHq0rXvvS9T
        TD1b+Kv4=; b=rfRo1PQqAic1X9dk5L4KIPbCZfZSaIJzeNPtyzxjya1d9rTpNvT
        F/BV7hJiWdjfBVYsHt6ZxL299TLw/DCvlCY1aDwWaXMCo/ea/rxyEYFIR4eW1u5z
        hnZTBRdbAQxLle5YH6Ja4DjppXskDqZyWUGlKJbqo1NIcFOFJuuqQx7RRaz8xJG3
        KDOAbhnmmSFTOghJRUE9p9exuyGZtCDp+gGlbWcGx4Cv8eRG7oKX5VSwK1QsZy0o
        D/Xcbos/Pvc7bnOHEorQKpSxrkgAgbRBuRzfQCn9ZT54q2c9vDTrlWH7Rbz77WZI
        QV4jBP5mBBXborcKxTnulIgFMntYo8/Zifg==
X-ME-Sender: <xms:F_jtZEAyI17BEOVrivfBH1wS4ov_6SlBjO7_I4cM6ESNj9yEL9RqGg>
    <xme:F_jtZGgBGM9lyQMW5slnFPpRGMkvX81DA9S8lq5rImhjzHF5mgCCIUMokH3eulLwe
    zW-tpKklRcm3tqs>
X-ME-Received: <xmr:F_jtZHlhvDHma1E8C4p-GF34yFAspFKI6de-CX7n_0FUUOd8-1MlLLUZit1cYw28iJOEtdYAH0CG1ngQpdDNNf-gLNQptwRLPGPn0XzNeaZvhlv_EJ3P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefiedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:F_jtZKyiN3swZxL9ROSRzhKAAvI34VqmwPRzeZ3-JofPnB5WL8Um7g>
    <xmx:F_jtZJSPqs0MvnXtQUkmsaRCgpIR78mRYtTz3ZHG55eG1x662jKcDA>
    <xmx:F_jtZFa29AOy8SKg29qFUjoVa53iKgG42YRFeJnA56aXhl5NSXsvvg>
    <xmx:GPjtZLdQ4SnFkx9m6fbxDvMA85CXoLo8cb-Ge4bY7BPJQCOU6iq2EA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 09:52:22 -0400 (EDT)
Message-ID: <4f80aad3-8c40-551f-05bb-eb5e47472015@fastmail.fm>
Date:   Tue, 29 Aug 2023 15:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/5] [RFC] fuse: Set and use IOCB_DIRECT when
 FOPEN_DIRECT_IO is set
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
 <20230824150533.2788317-5-bschubert@ddn.com>
 <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com>
 <d2a7e7a3-6273-475c-8e7c-96de547a5d71@fastmail.fm>
 <CAJfpegu9MDSB-pCmZr_mz64Cc1r-q8TkNmR7BH6TO3SCq2HAVA@mail.gmail.com>
 <6e0cc058-7163-ffc6-3b7e-b459af4d6f8c@fastmail.fm>
 <058bb99c-b722-c5f1-6f0c-759f194ed5ff@fastmail.fm>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <058bb99c-b722-c5f1-6f0c-759f194ed5ff@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/29/23 15:26, Bernd Schubert wrote:
> 
> 
> On 8/29/23 15:08, Bernd Schubert wrote:
>>
>>
>> On 8/28/23 17:05, Miklos Szeredi wrote:
>>> On Mon, 28 Aug 2023 at 16:48, Bernd Schubert 
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> On 8/28/23 13:59, Miklos Szeredi wrote:
>>>>> On Thu, 24 Aug 2023 at 17:07, Bernd Schubert <bschubert@ddn.com> 
>>>>> wrote:
>>>
>>>>>> -               if (!is_sync_kiocb(iocb) && iocb->ki_flags & 
>>>>>> IOCB_DIRECT) {
>>>>>> -                       res = fuse_direct_IO(iocb, from);
>>>>>> -               } else {
>>>>>> -                       res = fuse_direct_io(&io, from, 
>>>>>> &iocb->ki_pos,
>>>>>> -                                            FUSE_DIO_WRITE);
>>>>>> -                       fuse_write_update_attr(inode, 
>>>>>> iocb->ki_pos, res);
>>>>>
>>>>> While I think this is correct, I'd really like if the code to be
>>>>> replaced and the replacement are at least somewhat comparable.
>>>>
>>>> Sorry, I have a hard to time to understand "I'd really like if the code
>>>> to be replaced".
>>>
>>> What I meant is that generic_file_direct_write() is not an obvious
>>> replacement for the  above lines of code.
>>>
>>> The reason is that fuse_direct_IO() is handling the sync and async
>>> cases in one function, while the above splits handling it based on
>>> IOCB_DIRECT (which is now lost) and is_sync_kiocb(iocb).  If it's okay
>>> to lose IOCB_DIRECT then what's the explanation for the above
>>> condition?  It could be historic garbage, but we still need to
>>> understand what is exactly happening.
>>
>> While checking all code path again, I found an additional difference, 
>> which I had missed before. FOPEN_DIRECT_IO will now act on 
>> ff->fm->fc->async_dio when is is_sync_kiocb(iocb) is set.
>>
>> Do you think that is a problem? If so, I could fix it in fuse_direct_IO.
> 
> What I mean is something like this
> 
> +    /* FOPEN_DIRECT_IO historically does not use async for blocking 
> O_DIRECT */
> +    if (ff->open_flags & FOPEN_DIRECT_IO) {
> +        if (!is_sync_kiocb(iocb) && ff->iocb_direct) {
> +            /* no change */
> +        } else {
> +            io->async = 0;
> +        }
> +    }

Besides that it could use file->f_flags & O_DIRECT, I guess we can keep 
async. It relates to commit
23c94e1cdcbf5953cd380555d0781caa42311870, which actually introduced 
async for FOPEN_DIRECT_IO. I'm just going to add it to the commit message.


Thanks,
Bernd
