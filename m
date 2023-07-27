Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C241765BF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 21:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjG0TRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 15:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjG0TRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:17:02 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC957273D;
        Thu, 27 Jul 2023 12:17:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4A86B3200413;
        Thu, 27 Jul 2023 15:16:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 27 Jul 2023 15:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690485416; x=1690571816; bh=pcNiNhrll0db3/pGj7a1myKE0cm4Rqboepn
        uCODXks0=; b=EzDw5Td0VtL4ldq1dW9CoBoed5IP9YhJv5DBgNU2G0enxSB7R6I
        CilqgE1osjSqbocA9gVDKEeNTbXVc3fF4vxXmbeWxp7z9Vl52cw0WuDrL8w8nJBI
        D5bXxFMYu96I9hWrOZ+iqaEEnMaI1wSp/W4UGEPSKEhg7hQ9son1fHV/208CHqfm
        IU94wzjqUCVfAD9Cgs8JpjQM8H9oXLRLQ8k7Ny37YOR4JhR6g4DmYMnLREPn8KTd
        ehDc0ttiFdc2wCe+FH+H3ZgK+JpZ2X5GBvFve9RkP5pkGjfpmmy1rsnVR0htcyrc
        Lg52mH57frrgl4unjp40mlGqh1Haq+xrtKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690485416; x=1690571816; bh=pcNiNhrll0db3/pGj7a1myKE0cm4Rqboepn
        uCODXks0=; b=XqT4CFf1dxSNokLSZ9jUkRYytuM5h6NFy/X54+yjYDiK1Bm/Vck
        Y94fJMpVW+mrdqyTOi6qn8cpa/I3qd9z0hzQl1Ym8fEH6NK80ZP4ZHZ7zLWY8MAr
        NkmOMmJp9SJn8XS0DW/BEWn2dy8jMafgP2Z3fxFjcj3/az0wx7KlQjSg7zi9hnI5
        ao2q4IWb2Qk0UFmDnzVhOoWvEcLZh0BMUdb8X1gW3wxK0kNCRXiE43r6z6M7zkKy
        XWt7zJKvFmFzXIezU6jXoXe1zqhCvxjkvJkuviHs7ajwNCD6y9mRjeDzyztuTcxw
        V1V98W6EMnJfvQpBdZZokDFA/RQHy/zwA0A==
X-ME-Sender: <xms:qMLCZOBKKbfk1lUgb4jFOdGxN4wr5Ofg2OCxCjLOSfqZR4BPsMhAzw>
    <xme:qMLCZIg9UKQcramuUIakQBlKvG2nt3mVAEq2qve7owtdQyGUknF2P1CZUlEDCHDVL
    fr4HTWvBQgVo36y>
X-ME-Received: <xmr:qMLCZBm7Mq5I1DCzMX4vy4zafTFPxc9rnNeUkIyOHTKlqcmSdYU0Uwm-GDNK1x8-nLCzarNOZTHsrq2_Xu5S-zvd3L0P_WMYogrts8E9my90u1YKchVT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredt
    tdefjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthh
    husggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeel
    keekjefhheegfedtffduudejjeeiheehudeuleelgefhueekfeevudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgs
    vghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:qMLCZMyLoS32l5TsjGMZYPox5R0VLJrkf8KRUoOiGBRrJZee_IuOPw>
    <xmx:qMLCZDSStZUG2Dl1jMdFkIDf8syddVU0YDTH4fwuMS86u3sDgdPGfA>
    <xmx:qMLCZHaUgEAVCHZy12hc4culprSgFWWZA3w0dMMJqat75bLlw7ut_Q>
    <xmx:qMLCZBOPNM1xm9GXdNSaEUFS9PDYt_RyqGhH9UAecZqLuP9kvZ4rfg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 15:16:55 -0400 (EDT)
Message-ID: <15fad0eb-b161-b87d-9964-e77a7193de48@fastmail.fm>
Date:   Thu, 27 Jul 2023 21:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir [v2].
To:     Miklos Szeredi <miklos@szeredi.hu>, Jaco Kroon <jaco@uls.co.za>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Antonio SJ Musumeci <trapexit@spawn.link>
References: <20230726105953.843-1-jaco@uls.co.za>
 <20230727081237.18217-1-jaco@uls.co.za>
 <CAJfpegvJ7FOS35yiKsTAzQh5Uf71FatU-kTJpXJtDPQbXeMgxA@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegvJ7FOS35yiKsTAzQh5Uf71FatU-kTJpXJtDPQbXeMgxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/27/23 17:35, Miklos Szeredi wrote:
> On Thu, 27 Jul 2023 at 10:13, Jaco Kroon <jaco@uls.co.za> wrote:
>>
>> This patch does not mess with the caching infrastructure like the
>> previous one, which we believe caused excessive CPU and broke directory
>> listings in some cases.
>>
>> This version only affects the uncached read, which then during parse adds an
>> entry at a time to the cached structures by way of copying, and as such,
>> we believe this should be sufficient.
>>
>> We're still seeing cases where getdents64 takes ~10s (this was the case
>> in any case without this patch, the difference now that we get ~500
>> entries for that time rather than the 14-18 previously).  We believe
>> that that latency is introduced on glusterfs side and is under separate
>> discussion with the glusterfs developers.
>>
>> This is still a compile-time option, but a working one compared to
>> previous patch.  For now this works, but it's not recommended for merge
>> (as per email discussion).
>>
>> This still uses alloc_pages rather than kvmalloc/kvfree.
>>
>> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
>> ---
>>   fs/fuse/Kconfig   | 16 ++++++++++++++++
>>   fs/fuse/readdir.c | 18 ++++++++++++------
>>   2 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
>> index 038ed0b9aaa5..0783f9ee5cd3 100644
>> --- a/fs/fuse/Kconfig
>> +++ b/fs/fuse/Kconfig
>> @@ -18,6 +18,22 @@ config FUSE_FS
>>            If you want to develop a userspace FS, or if you want to use
>>            a filesystem based on FUSE, answer Y or M.
>>
>> +config FUSE_READDIR_ORDER
>> +       int
>> +       range 0 5
>> +       default 5
>> +       help
>> +               readdir performance varies greatly depending on the size of the read.
>> +               Larger buffers results in larger reads, thus fewer reads and higher
>> +               performance in return.
>> +
>> +               You may want to reduce this value on seriously constrained memory
>> +               systems where 128KiB (assuming 4KiB pages) cache pages is not ideal.
>> +
>> +               This value reprents the order of the number of pages to allocate (ie,
>> +               the shift value).  A value of 0 is thus 1 page (4KiB) where 5 is 32
>> +               pages (128KiB).
>> +
>>   config CUSE
>>          tristate "Character device in Userspace support"
>>          depends on FUSE_FS
>> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
>> index dc603479b30e..47cea4d91228 100644
>> --- a/fs/fuse/readdir.c
>> +++ b/fs/fuse/readdir.c
>> @@ -13,6 +13,12 @@
>>   #include <linux/pagemap.h>
>>   #include <linux/highmem.h>
>>
>> +#define READDIR_PAGES_ORDER            CONFIG_FUSE_READDIR_ORDER
>> +#define READDIR_PAGES                  (1 << READDIR_PAGES_ORDER)
>> +#define READDIR_PAGES_SIZE             (PAGE_SIZE << READDIR_PAGES_ORDER)
>> +#define READDIR_PAGES_MASK             (READDIR_PAGES_SIZE - 1)
>> +#define READDIR_PAGES_SHIFT            (PAGE_SHIFT + READDIR_PAGES_ORDER)
>> +
>>   static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
>>   {
>>          struct fuse_conn *fc = get_fuse_conn(dir);
>> @@ -328,25 +334,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>>          struct fuse_mount *fm = get_fuse_mount(inode);
>>          struct fuse_io_args ia = {};
>>          struct fuse_args_pages *ap = &ia.ap;
>> -       struct fuse_page_desc desc = { .length = PAGE_SIZE };
>> +       struct fuse_page_desc desc = { .length = READDIR_PAGES_SIZE };
> 
> Does this really work?  I would've thought we are relying on single
> page lengths somewhere.
> 
>>          u64 attr_version = 0;
>>          bool locked;
>>
>> -       page = alloc_page(GFP_KERNEL);
>> +       page = alloc_pages(GFP_KERNEL, READDIR_PAGES_ORDER);
>>          if (!page)
>>                  return -ENOMEM;
>>
>>          plus = fuse_use_readdirplus(inode, ctx);
>>          ap->args.out_pages = true;
>> -       ap->num_pages = 1;
>> +       ap->num_pages = READDIR_PAGES;
> 
> No.  This is the array lenght, which is 1.  This is the hack I guess,
> which makes the above trick work.
> 
> Better use kvmalloc, which might have a slightly worse performance
> than a large page, but definitely not worse than the current single
> page.
> 
> If we want to optimize the overhead of kvmalloc (and it's a big if)
> then the parse_dir*file() functions would need to be converted to
> using a page array instead of a plain kernel pointer, which would add
> some complexity for sure.

One simple possibility might be to do pos=0 with a small buffer size 
single page and only if pos is set  we switch to a larger buffer - that 
way small directories don't get the overhead of the large allocation. 
Although following your idea to to the getdents buffer size - this is 
something libc could already start with.


Cheers,
Bernd
