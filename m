Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E14785C00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjHWPY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjHWPYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:24:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA2C10CF
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 08:24:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6D8E5320095B;
        Wed, 23 Aug 2023 11:24:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 23 Aug 2023 11:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692804261; x=1692890661; bh=CQLvsPZqStcjzZTD8c0tNIj2IjwfiJ5iKtf
        OJXEyZzQ=; b=TM6BJqTVHe8PVL2QUs3EK/l7FpFtqYlo47A3PzVTJZ81iHaGGra
        lLLPx/Phystvp0X7WehwhHrHq63eFaC9bBAb38ITLMgYsXZSyB7o3OKFjUsFfhn2
        vXormTr46pnTPYhWBKlCsQfRr8xTRMmGoo1yxfHUC9vSnxL0eY4DfffGtgaUXqoX
        TsqR+Hoo3A8kCUy7jE9HHI7L8v5zfjHOabDwzzvoWhIvMrZo0svMeq1s6u6dlq9L
        lWyiXws4nr5OPeEzOChOz6nurj1JwY5nwi/rNJV5lIlYmzuGYriIgyCH4j8nnCKO
        y2RzDQuAQrcsvVCurfLe1HOprozMnWqT33g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692804261; x=1692890661; bh=CQLvsPZqStcjzZTD8c0tNIj2IjwfiJ5iKtf
        OJXEyZzQ=; b=t4jh28LObUThZ5fEZdoCUMSZgpaNtqDWfEZ4fdXgOCE8Cz5ItoP
        7RT9n4SYCtbuIzDzuRv7/xImDGoOUcOxOcs6CO3w6/XyokcVRrUwBa2+vpjODpJv
        cEqzkhATRZQBRgPozC1Iwlraoovg/LkO2iWO1DK1sSVltG3N4Geq8r1lOkSGMSyZ
        pXuKkcbkoa9Tu8qrhJeDH25kZ0OOUWyoIw9iJ/4bui6ok6YVjAif6SQZ1fq8/Q9o
        9u2SkCFCzRNQ8JM7vlaDxILIxN9xUEjOHv1QrqqCB765ba7DkdalYr5RZoEiF7cT
        pcKRtqUstQ2isY5upCXFO6BJFnZ3+0YY/dA==
X-ME-Sender: <xms:pSTmZM_DEudsYbpfaaaP7LfXpU4sLLiwY-9d-xnW1VSSa_dAcPDaVQ>
    <xme:pSTmZEt1s4sNh4hu4_iHp2Hn6JJfYgawqeiyFPfg2iYSG4vLwFQH05zWAHAlVLTlD
    D_4I6sCRjYCqqvs>
X-ME-Received: <xmr:pSTmZCCrTtnpHp9_6A61HwX19mgQHnvfgGqymX4VHsatZDa17bJPwLfFXVbQmPl3LlrJwHFEznb4okjxRvfc2wvREWrxTHiz1fZpPHm1PA9F5G3OtFGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:pSTmZMcIofr7QVOQ2KCTHm_EXcle8aq_DKEJ3RtWqmj6VhoVpNgo1w>
    <xmx:pSTmZBNLK0rn8FN3d9-UY_1VLVPZ34CyGgusvOok4f-ZLq3dwM13Wg>
    <xmx:pSTmZGmlTKqJz0N__6ll0LswwkN7fCNKtfvv5JTYPcUhhELMgYPOGg>
    <xmx:pSTmZP3FT0zCviebnAuZmoCy3KnuO7zUa5uW4RfyLbrMVFnN9ESbpw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 11:24:21 -0400 (EDT)
Message-ID: <c6157f71-5d5c-05fe-ffe7-03d83b52ca17@fastmail.fm>
Date:   Wed, 23 Aug 2023 17:24:19 +0200
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
