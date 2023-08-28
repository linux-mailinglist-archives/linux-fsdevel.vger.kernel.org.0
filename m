Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AB78B2E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjH1OVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjH1OVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:21:24 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0114B106
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 07:21:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 75F2B320055E;
        Mon, 28 Aug 2023 10:21:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 28 Aug 2023 10:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693232475; x=1693318875; bh=iwgkzoscov7Yd9hEiIC8s4REFO4qMtvDEWt
        mA+2afmg=; b=aW9I50r2ZRP4bdaDzEqgXpC7L6MtHkcQi0XK5DAJ/gfS67IK/Pl
        Ly+BuO0cVNozNsj6sstnrXDkwoyQZCsPdHB+bUcZeUhe5Pr4xkVaTbhbF4emuSz8
        nHcAqz4d7gADgjU+x7uKlhlbQQpeS4RMFr4jflo/t0hOtbxq9YeKWF2aImF5HPu0
        qm325E3cszXEpQowrEy2N/sz0//4btvApCfgmUzzUR0HwO9XaSnU23HEEOS0GO/W
        dIwb85hj1qszfZn+XibgaM30u0men2mZXh1Ve9ZF20Bq4vfjHpC9mBZWj0szRAFo
        +Fx1olcIw3/IdELilellflWsankImILkPIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693232475; x=1693318875; bh=iwgkzoscov7Yd9hEiIC8s4REFO4qMtvDEWt
        mA+2afmg=; b=TiHzV1Ilgo4EXDF2/ybT6f8cZEh3sz48+sMaqspGWlVF2DFDeQE
        IcSm3EiALYnuEivXLglV07N7V3yod8VFIJ59DOm6XwIUelS6V4B1VmwyUdUXaCV0
        KvBIm9cIuQIyeZnJ0KdPjiS1CCN41OnmWbDyiDpMylzBICwWleStu++4NBsDWlyE
        TjfljnbbnsOGpoMmWGsSqDgjJ1rEOJugNetEX9pV9lAvBbDqbsUn/C578pMTBKTt
        qTa06BpaN8nwW+qEkcxVLTQEjbSquHpLR7Rrr83l5wlzW3hVE4OoeXFF76QyPysz
        scBLQ2BgwLF7EM9LmFUDOl4M8eoLfiXR17g==
X-ME-Sender: <xms:Wq3sZLFkVq1JmhU6yJOTccAGz26UwZpZ7MjiENC0EkB5EPJx5FRlcA>
    <xme:Wq3sZIUBYgWa-XeH-JTH4-Z_Q9YO3mKL4OCtxCFtfM_1RhpoNWWS4tdLCeLn7kgHc
    OOqHBLiLhF0YB9z>
X-ME-Received: <xmr:Wq3sZNJ7FAza8Yd7zc_60YEO5-HED3EMw-S4lgk3in1Xp4TjyJP0bmh13FIADFMmxj5By4-IHT9Tr7ixWGcO60B_n4k1QB9SffRvBtRVX_BUD2C67jCH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:Wq3sZJHQchLm8tis-ToHajWAfy8aiBHmBPjR6RnggXvLekNfVzcj-w>
    <xmx:Wq3sZBXYNEIsZaRD_Dycuu_qcj-TudmhUpGkpIXmHgo9I-fzFoReow>
    <xmx:Wq3sZEN75ZQ92h2zgAu0KPnhMZYFk4zfNta04dtBv18T7i_aDFeqjw>
    <xmx:W63sZETmegwE7jPZs1F0ZChzLBNh67LShUku5ZZMnQjPKEzIpJhAQg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Aug 2023 10:21:13 -0400 (EDT)
Message-ID: <daaf4e73-959f-46b7-5e99-e13c70b81d6e@fastmail.fm>
Date:   Mon, 28 Aug 2023 16:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] fuse: Allow parallel direct writes for O_DIRECT
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, dsingh@ddn.com,
        Hao Xu <howeyxu@tencent.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
 <20230824150533.2788317-4-bschubert@ddn.com>
 <CAJfpegveOAgam0Zb+xit9QLfLHpRNyqB=aGRt+JBvhO6g7JYVQ@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegveOAgam0Zb+xit9QLfLHpRNyqB=aGRt+JBvhO6g7JYVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/28/23 12:42, Miklos Szeredi wrote:
> On Thu, 24 Aug 2023 at 17:08, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> Take a shared lock in fuse_cache_write_iter.
>>
>> Cc: Hao Xu <howeyxu@tencent.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Dharmendra Singh <dsingh@ddn.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>   fs/fuse/file.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index a16f9b6888de..905ce3bb0047 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1314,9 +1314,10 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
>>          struct file *file = iocb->ki_filp;
>>          struct fuse_file *ff = file->private_data;
>>
>> -       return  !(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
>> -               iocb->ki_flags & IOCB_APPEND ||
>> -               fuse_direct_write_extending_i_size(iocb, from);
>> +       return ((!(iocb->ki_flags & IOCB_DIRECT)) ||
>> +               (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES)) ||
> 
> Why the extra parenthesis around the negation in the above two conditions?
> 
> So this condition will always be true at this point when called from
> fuse_cache_write_iter()?  If so, you need to explain in the commit
> message why are you doing this at this point (e.g. future patches
> depend on this).

Oh, thanks for spotting, the double parenthesis were accidentally. 
Although I don't think it would have an effect, it just results in

return ((!(condition1)) || ...

I.e. does not change the condition itself?

Anyway, yeah, agreed on your comment in the patch before, with one 
condition per line it becomes easier to read and avoids parenthesis. I 
had just tried to keep the code as it is to make the patch easier to read.


Thanks,
Bernd
