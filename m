Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F95D785C02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbjHWPY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjHWPYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:24:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5116F10F9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 08:24:35 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EF6473200926;
        Wed, 23 Aug 2023 11:24:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 23 Aug 2023 11:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692804273; x=1692890673; bh=GlgqpgvjoBj2d0YVL9RyBXf6N9fA3PacZmH
        cRODSsk0=; b=AqfFfXZZE+0C03nvmgWPDEL5ic2J5p69pjTgxTbsWl46h5Nv+gN
        4Mq3BGKf6y+HUpNyEIvO+i047ZQMbCPjdTFXjtMwUvP0LuP+HPCoFAy62H8Q/NvR
        vMH+HWpUgyLpXuezgeVQg1UYOsp6Qhe93gZjgjOCq+XH9E3Ehk/FQIq2XADTblxP
        3Ae19qiWFnqioL0p0EN90S9M3XOj8Bw0xkkTs9DPbbXSWLsi4bFcsVGu6nBR/6il
        xkeo4x4IWceDuuF7LZGC0cMWzPt1BO6YjtfIAiWmlsbrIp1rw1ghi5ia1uHuRgci
        l2YWRHoA24t6F4BE0OYeMGlKwTsuFvALHmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692804273; x=1692890673; bh=GlgqpgvjoBj2d0YVL9RyBXf6N9fA3PacZmH
        cRODSsk0=; b=o4LuXz1khR9feTV096NIeGqo2yFKz+Us8pHM2xpPQ7rAGLacYx5
        Zijz3Igd44wbrfvlzFV10DRDybnZ8Ok8BmI2bwa2LinqMwYd5VzMGzcp0Vdizoe5
        Hj8NypMnRKWzR0QGVz9ruZwnUxaemkI7pZ/UEF2NPKc1ZcTpfqLOX0ZQkt+UGj8b
        M9cRzKPvPpUIdLJbuSKwlylEW6SoVHOWlE2+SvY6riYaRCplZ2bpgnZEnfrP8Apy
        ef6GpgzoTtTrg2yQ0ypefk5TGodH+f0PgJWNXtxr09P6VEbUhujdXGQiTjN2zKNq
        JAGzeigACFz11JQWKAZQUwKUu29eD0J1Amg==
X-ME-Sender: <xms:sSTmZKjEX0JhMuFc9VqZNzzfWTli1dIRKP7H0C56uVTwQD-B6h38mQ>
    <xme:sSTmZLDHS5CHOPpfmqFkBFSmnBKcFbOiqiihKA-eOBsTvuUW8o0DC8YfyWw6s2BQW
    QN1xcBrf6lfyXz_>
X-ME-Received: <xmr:sSTmZCF-TDPay9SQrXkGVSAVfQn8a5RlH55etptJriCw6Rkn-IXJXQVXx6JRya_cizHkcemA6qW0Exv6rmevjClNtTJbghG1LPqzdO8mn48zPsOW3tmD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:sSTmZDTGMrrt5p-MYM3MYQ1lfEBn7mmskOIMz5IBElQyV7bP6s4KUg>
    <xmx:sSTmZHzg5PErlqnYxxLjLTtFosUCZgr7QaRvjwyhZvHd67mg_XNYzg>
    <xmx:sSTmZB6ZWZtoQQqlFu3kc_dIeZjxdVQwkYn-Hg2BPELvEEcfVGgsJg>
    <xmx:sSTmZArkgJYcwszDs5NAU5owuzSTFlATK1WHuqrCfKjyRjspjirn_Q>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 11:24:32 -0400 (EDT)
Message-ID: <455e7d7e-e81c-dbf3-987f-a8b6e7fd51d5@fastmail.fm>
Date:   Wed, 23 Aug 2023 17:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] fuse: implement statx
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20230810105501.1418427-1-mszeredi@redhat.com>
 <20230810105501.1418427-5-mszeredi@redhat.com>
 <067fcdfa-0a99-4731-0ea1-a799fff51480@fastmail.fm>
 <CAJfpeguEmafkUPqZO2_EAOWbw+7XUm0E9whVpnnj_MVf2fnStQ@mail.gmail.com>
 <9ebc2bcb-5ffd-e82f-9836-58f375f881ea@fastmail.fm>
 <CAJfpegvqdAa+XjHA2VefEu=QZNQHyYnXC988UxPfPMisCj93jA@mail.gmail.com>
 <410b7d7d-b930-4580-3342-c66b3985555d@fastmail.fm>
 <CAJfpeguFuXPPB-SqNizDEoiemqCZGKm_zHYvYfOMGqGM66viSw@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpeguFuXPPB-SqNizDEoiemqCZGKm_zHYvYfOMGqGM66viSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/23/23 16:58, Miklos Szeredi wrote:
> On Wed, 23 Aug 2023 at 16:51, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 8/23/23 08:18, Miklos Szeredi wrote:
>>> On Tue, 22 Aug 2023 at 18:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>>
>>>>
>>>> On 8/22/23 17:33, Miklos Szeredi wrote:
>>>>> On Tue, 22 Aug 2023 at 17:20, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>>>>
>>>>>> Hi Miklos,
>>>>>>
>>>>>> sorry for late review.
>>>>>>
>>>>>> On 8/10/23 12:55, Miklos Szeredi wrote:
>>>>>> [...]
>>>>>>> +static int fuse_do_statx(struct inode *inode, struct file *file,
>>>>>>> +                      struct kstat *stat)
>>>>>>> +{
>>>>>>> +     int err;
>>>>>>> +     struct fuse_attr attr;
>>>>>>> +     struct fuse_statx *sx;
>>>>>>> +     struct fuse_statx_in inarg;
>>>>>>> +     struct fuse_statx_out outarg;
>>>>>>> +     struct fuse_mount *fm = get_fuse_mount(inode);
>>>>>>> +     u64 attr_version = fuse_get_attr_version(fm->fc);
>>>>>>> +     FUSE_ARGS(args);
>>>>>>> +
>>>>>>> +     memset(&inarg, 0, sizeof(inarg));
>>>>>>> +     memset(&outarg, 0, sizeof(outarg));
>>>>>>> +     /* Directories have separate file-handle space */
>>>>>>> +     if (file && S_ISREG(inode->i_mode)) {
>>>>>>> +             struct fuse_file *ff = file->private_data;
>>>>>>> +
>>>>>>> +             inarg.getattr_flags |= FUSE_GETATTR_FH;
>>>>>>> +             inarg.fh = ff->fh;
>>>>>>> +     }
>>>>>>> +     /* For now leave sync hints as the default, request all stats. */
>>>>>>> +     inarg.sx_flags = 0;
>>>>>>> +     inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
>>>>>>
>>>>>>
>>>>>>
>>>>>> What is actually the reason not to pass through flags from
>>>>>> fuse_update_get_attr()? Wouldn't it make sense to request the minimal
>>>>>> required mask and then server side can decide if it wants to fill in more?
>>>>>
>>>>> This and following commit is about btime and btime only.  It's about
>>>>> adding just this single attribute, otherwise the logic is unchanged.
>>>>>
>>>>> But the flexibility is there in the interface definition, and
>>>>> functionality can be added later.
>>>>
>>>> Sure, though what speaks against setting (limiting the mask) right away?
>>>
>>> But then the result is basically uncacheable, until we have separate
>>> validity timeouts for each attribute.  Maybe we need that, maybe not,
>>> but it does definitely have side effects.
>>
>> Ah right, updating the cache timeout shouldn't be done unless the reply
>> contains all attributes. Although you already handle that in fuse_do_statx
> 
> Yes, correctness is guaranteed.
> 
> However not setting the full mask might easily result in a performance
> regression. At this point just avoid such issues by not allowing
> partial masks to reach the server.


Hmm ok, I see a bit more like "these flags are absolutely needed, if you 
(daemon/server) can provide more/all, I can update my cache timeout".


Thanks,
Bernd
