Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD9765D7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjG0Ufl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 16:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjG0Ufj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:35:39 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431C52736;
        Thu, 27 Jul 2023 13:35:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B3075320094B;
        Thu, 27 Jul 2023 16:35:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 27 Jul 2023 16:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690490134; x=1690576534; bh=8EtEmjr8ap2Hz2DcaXveDr0qco1V0aQHiRl
        MiasL9Fc=; b=G6Wyxf1LnZrveM2I45Ub5taqepidDuXsO8qKsr138TDa0Ik1INQ
        uD6l0jWQ4kig4oc2oWW/raZw4HsM/iLjCyR1lRtcaPUrtRPsIq+k1dS1rkOQ2oIg
        O+V7N5zvZxkOkjuwH1y9nOQxcq3nSf7byHieA+Njs7atRsDtmuXvlXOwvXGmkf0+
        7nQddLgNkWA9Ct6ZICHDOVVBfnvX1vdVPpV+4EpLf3z/iDY7zRJg+rXQkAlKu/b6
        2amNH0BXWLvm7B0VsaL4ecgeYeC7DhE5RQYsVnMw1l033QN9C5K4vkRaFkb7XnHf
        n3flNhU5OlnhnQB3ITSvSDxvpPWW/A0R8sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690490134; x=1690576534; bh=8EtEmjr8ap2Hz2DcaXveDr0qco1V0aQHiRl
        MiasL9Fc=; b=vadqZpOxHGzEldM5yGAYRiBiFL/eLDO+Fh12L+/fMoY16rw1VIB
        FstOycAQKq5iJYyd4VWt08r7P/OeaiUrXBxOLZWy9v78FFKxoPK0wOhwNr4H3sv5
        o0BuSiDWIUw/n4fK9C9LWH+uQhPJZwtYtMfc5AsQSWnS/DWqmpjDYXuUUI6nz5JI
        scJPGNOfIvHZDg//fYxJWfIlTe6f1ZYgVJEYGjLzmExLavj6FtAp7DLvlHTmgytV
        9MzGvGNhpr9RlWg5sSWRRZlaR/QAq008DNLPrZfkJUNaA0LiFCGcT9ysBfCYmaFy
        vs7UKUfx3CYneL7dlc2mzKl5h/bsjVqvexA==
X-ME-Sender: <xms:FdXCZGJ-rS0sphIAKfJk8lGaaPr_nwt7j_HrRFEBniRU7v5RxtKeXg>
    <xme:FdXCZOL3uBgfUFil-EovlcCM1rjgU5Mxd42PX6nfUvanqAg2Ddrafyxa3vBWMuoSe
    PjW0Kvinhj0zTQ8>
X-ME-Received: <xmr:FdXCZGvvLi1K9zpLiPt47watWyfLVRclyMuABb3vqM_X0Xz0XDvjZDRK_QWSFysbrT6GGbPhyOpiGNqyWfj3HikVY9EKonQaBKal2RINvYxehoNkI-BY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredt
    tdefjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthh
    husggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeel
    keekjefhheegfedtffduudejjeeiheehudeuleelgefhueekfeevudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgs
    vghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:FdXCZLZ-nS2wD3F7gm2Rm3C_lGLifPJPhUXwZmxz_B6ALBVYCydyCA>
    <xmx:FdXCZNY78st261SBr6ZUs687QHgprcNw9bBL-KsoBvQN09UhTAYUZg>
    <xmx:FdXCZHBaFLZdjm3DSXtdylKbGtwhUFvv0UfRbJIgt4MIqCPoIc6nQA>
    <xmx:FtXCZMUy7WdM3mtJicBG95n0XoLzn9Dyt9F-OLGx_0gUuFzty2-zbA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 16:35:32 -0400 (EDT)
Message-ID: <d9ec13de-ebb2-af50-6026-408b49ff979b@fastmail.fm>
Date:   Thu, 27 Jul 2023 22:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir [v2].
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>, Jaco Kroon <jaco@uls.co.za>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Antonio SJ Musumeci <trapexit@spawn.link>
References: <20230726105953.843-1-jaco@uls.co.za>
 <20230727081237.18217-1-jaco@uls.co.za>
 <CAJfpegvJ7FOS35yiKsTAzQh5Uf71FatU-kTJpXJtDPQbXeMgxA@mail.gmail.com>
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

Hmm, ap->num_pages / ap->pages[] is used in fuse_copy_pages, but so is 
ap->descs[] - shouldn't the patch caused an out-of-bound access?
Out of interest, would you mind to explain how the hack worked?


Thanks,
Bernd
