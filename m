Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53308786C39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 11:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbjHXJn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 05:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbjHXJnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:43:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F210FA
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 02:43:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 539CB5C00AB;
        Thu, 24 Aug 2023 05:43:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 24 Aug 2023 05:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692870201; x=1692956601; bh=TWumVowBCvT4kqM8s2fbFJiPp/bbL9Aj85T
        Fcceyx0w=; b=X2KATbs0/vyh81qXBuW35Mku235yycZVPRvF8yeMnhxOvBtQxl6
        F8BsQvRXxBWZUuleBHxp4WkyRKY8xuHeO7njwlrnefMAuDW2XmLmZoUA8Or77P3H
        z6nPLk54AiUv38BSMSqmyyCK9nyHGJHKnabi6SY4WQA5SuW4d3py6yPkFmRM63OF
        wnHM/GBXlyC/GCXdE8HN15RG4rxlR0IYAOoYn21Rv3WlCg2Y80j91+pUM4cbkiZb
        HSUNG7ZCQnNuu/ZgFQwPgzW6sn2y8mYUWos0mB6XRCQhYrG3lvlzZkbDUTGTs9Kf
        a15lzB6vv5UG1iUHZ/5hLegA7W8ECQyWaIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692870201; x=1692956601; bh=TWumVowBCvT4kqM8s2fbFJiPp/bbL9Aj85T
        Fcceyx0w=; b=aDNRoI12sAWCHIqeb4cj9xi+oem1t+tVBwU1KE9Zz6cuurQNjGM
        e2DYsdeSYzYzaRNPpRvlpB7i/VumOr7twHoaB+xrbML4VDmEgqSHSJ7Ybqdt2Owl
        djy6nfAVDHfHdUMt5O7asWq2iMsrZwfeyPqfHrmyCk3RfJ9gSrLlHZONXyCZN7hv
        G3CLAEEqs2UHZ55SsNl5lOWkPs65wF1Qf9WHeYpsKBvt2xSV2pcgGPV+99gv6hT6
        6Du6Djnv2oRtUE4Y1/B4d0oO45op7pxSkwG4x1QIcKTtUQH096bV34PKwXCiGjeU
        bxQCNjN7a0PEjniuzVpJdF3zGVucnsbGECA==
X-ME-Sender: <xms:OCbnZHWdJkodTuT45ZvI7pSdGi44dugiA3G5H783cRns3tvzfV5B9g>
    <xme:OCbnZPlEuim1Nudtp_rUP5_xlsO8INFkuyjwRJG5iifiMY1G48Fbd_of7GzCUoAvK
    VSYzQboKSV_wVjf>
X-ME-Received: <xmr:OCbnZDZsM5mljQ4VvKN3gbLoLY7zappjrFULycYV54iZZID4UHCM-gWn5CIyBaXJvh7C-ZjCvgf7JmBVQjlwxwb__Nen2iIf8DngWxanMnj0KCpRJTOp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddviedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepgfehveetueevleektddukefffedvheeuveff
    jeeivdejleehvddtvedukeejheejnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:OCbnZCUDyUjXogpVwq-mTliQVY09RQZf2KC0LRrhlWv3sojvx7wCrQ>
    <xmx:OCbnZBlZyc6DFmxUraUbdFoxZBZGTi8TmNml365QevfN-QKsbIJbuw>
    <xmx:OCbnZPcBukNUZWI_hmO6NYbePHdHNyaHDNdW3P-Bt5vnj_vB09UX8w>
    <xmx:OSbnZPZJegXiN8XLJMCjnx1n7Fku4cdvPqUohvxL02O6jXogLbizHg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Aug 2023 05:43:19 -0400 (EDT)
Message-ID: <6cd82251-beb9-9657-dba0-37624a6a47c5@fastmail.fm>
Date:   Thu, 24 Aug 2023 11:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [fuse-devel] [PATCH 1/2] [RFC for fuse-next ] fuse: DIO writes
 always use the same code path
Content-Language: en-US, de-DE
To:     Hao Xu <hao.xu@linux.dev>, Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     fuse-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>,
        Hao Xu <howeyxu@tencent.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        linux-fsdevel@vger.kernel.org
References: <20230821174753.2736850-1-bschubert@ddn.com>
 <20230821174753.2736850-2-bschubert@ddn.com>
 <CAJfpegv6Q5O435xSrYUMEQAvvkObV6gWws8Ju7C+PrSKwjmSew@mail.gmail.com>
 <a4d031fa-c5cb-2fe8-5869-ec8ad35cc4ee@linux.dev>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <a4d031fa-c5cb-2fe8-5869-ec8ad35cc4ee@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/24/23 06:32, Hao Xu wrote:
> 
> On 8/22/23 17:53, Miklos Szeredi via fuse-devel wrote:
>> On Mon, 21 Aug 2023 at 19:48, Bernd Schubert <bschubert@ddn.com> wrote:
>>> There were two code paths direct-io writes could
>>> take. When daemon/server side did not set FOPEN_DIRECT_IO
>>>      fuse_cache_write_iter -> direct_write_fallback
>>> and with FOPEN_DIRECT_IO being set
>>>      fuse_direct_write_iter
>>>
>>> Advantage of fuse_direct_write_iter is that it has optimizations
>>> for parallel DIO writes - it might only take a shared inode lock,
>>> instead of the exclusive lock.
>>>
>>> With commits b5a2a3a0b776/80e4f25262f9 the fuse_direct_write_iter
>>> path also handles concurrent page IO (dirty flush and page release),
>>> just the condition on fc->direct_io_relax had to be removed.
>>>
>>> Performance wise this basically gives the same improvements as
>>> commit 153524053bbb, just O_DIRECT is sufficient, without the need
>>> that server side sets FOPEN_DIRECT_IO
>>> (it has to set FOPEN_PARALLEL_DIRECT_WRITES), though.
>> Consolidating the various direct IO paths would be really nice.
>>
>> Problem is that fuse_direct_write_iter() lacks some code from
>> generic_file_direct_write() and also completely lacks
> 
> 
> I see, seems the page invalidation post direct write is needed
> 
> as well.
> 

I'm in the middle of verifying code paths, but I wonder if we can
remove the entire function at all.


https://github.com/bsbernd/linux/commit/fe082a0795fe5839211488e9645732b5f3809bea

on this branch

https://github.com/bsbernd/linux/commits/o-direct-shared-lock


Also totally untested - I hope I did not miss anything...


Thanks,
Bernd
