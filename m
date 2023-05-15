Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAD703F68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 23:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbjEOVLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 17:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242603AbjEOVLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 17:11:40 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE56129
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 14:11:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id ECF3432007BE;
        Mon, 15 May 2023 17:11:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 May 2023 17:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1684185094; x=1684271494; bh=tTM6Ma7Tqg5ENG0TOTiHn6TgbPp6GpSZcIf
        D9qgO+wM=; b=3OZDYuqgSjl9rpNQLnVhYG0Zr1FbKFgzjtx3U9spfg7c3jvsmur
        j9FPVo0Q+F45CdW/YcgDct0oIQqNmN7t1CjLfTnfIa72Zm+CVKhNwi9s+ZZFim7H
        K2riRpS74OlQVtwNCa1qMiNSEYUw0E1a867+tPXCiFAlkdPM85Ophyzkkdd+7aTX
        +WUJdpfTs8J6jswoXSfYRk3RKwuxogknyWxFCX6SZNjmMwlTG96gXjsUtS5TBgk9
        uq25cwujA990CLxclgosnRFexhxzutCLXm0KeftA2iVZgUyp9GlBH57gyID0QbQ9
        31c/LL4z5rd1mMHrddFGvR3M9+/wFQJFZfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684185094; x=
        1684271494; bh=tTM6Ma7Tqg5ENG0TOTiHn6TgbPp6GpSZcIfD9qgO+wM=; b=N
        jfXVf6PvhznUhXSSB+QXRz27lBIYhgSqM/X5FNPrAHpb5B/gNgM30qn4DUzDy6s7
        o9CdxcnYYk60vXhMoTj5MsY43HtxF91UxRsFaUQ1HXqR3cr0i4mB0VIiRrfTIa8n
        UCYaI1AyejR4csqywzBKJhUbhpWp1ukruZGVeZqTmnG0hz4ZJVqAkWIA9yHlAYPN
        k50p6Zrg9wJ9kCr/pBBrtQ3+4tYJtpIQHmJh5kxXI6ywxRus20XjsPsmxP/wXWBy
        F4PXDwm5Ob3YaeDHIDE7s5mDac26lQ2edvSXS+zxtIM1zkPokj8iJrmPfU+ki4Wv
        6YgbjfI4TH19siwbDe+YA==
X-ME-Sender: <xms:BqBiZOSaSiynNGGGnZM2IrFsJ9wJMJQQ8RyjLut-n6WTyeupZFK4Sg>
    <xme:BqBiZDznEq3GzTn615nC56mupTf-shyOr-K4in8iCEwi7nxFxRuRLg6gUkWaEEuMg
    l_WaxshYacCD0A->
X-ME-Received: <xmr:BqBiZL20fNfleS5UjCt7Sq4N-g4QrvkNgipUfwOBMBSLhTcihA5nqwIqcOa-akIvWtDtHrjqkZrhiLUeDRjZmGrkh-_TtCDVMNBMTE3QOg2gfOcR2ZQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnheptdduueeuveegkeefheeiueekvdduleeiveet
    veeutdeufffhueetieevvdfhuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:BqBiZKAumpN62Xm8-Q9xDT3O91HJduwkuN6RGTODTK0dRc7ynHj5Tw>
    <xmx:BqBiZHheTVYnDktZTqc_h5iv0yLeKmErCjFlrTpwqolBEpq7TRiTVw>
    <xmx:BqBiZGqlV-klnTMieGM5h7QQeKMGBHtcz-dsw-YIgqKKH3rtCuouFQ>
    <xmx:BqBiZHxblG_C4GfheyhXkZaRFcr_qNtdJNKXUhcvpGBa_fFdf_EkWg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 17:11:32 -0400 (EDT)
Message-ID: <93b77b5d-a1bc-7bb9-ffea-3876068bd369@fastmail.fm>
Date:   Mon, 15 May 2023 23:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [fuse-devel] [PATCH RESEND V12 3/8] fuse: Definitions and ioctl
 for passthrough
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stefano Duo <duostefano93@gmail.com>,
        David Anderson <dvander@google.com>, wuyan <wu-yan@tcl.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Akilesh Kailash <akailash@google.com>,
        Martijn Coenen <maco@android.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com>
 <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
 <CAOQ4uxg2k3DsTdiMKNm4ESZinjS513Pj2EeKGW4jQR_o5Mp3-Q@mail.gmail.com>
 <CAJfpegv1ByQg750uHTGOTZ7CJ4OrYp6i4MKXU13mwZPUEk+pnA@mail.gmail.com>
 <CAOQ4uxjrhf8D081Z8aG71=Kjjub28MwR3xsaAHD4cK48-FzjNA@mail.gmail.com>
 <87353xjqoj.fsf@vostro.rath.org>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <87353xjqoj.fsf@vostro.rath.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/15/23 22:16, Nikolaus Rath wrote:
> On May 15 2023, Amir Goldstein <amir73il@gmail.com> wrote:
>> On Mon, May 15, 2023 at 10:29 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>> On Fri, 12 May 2023 at 21:37, Amir Goldstein <amir73il@gmail.com> wrote:
>>>
>>>> I was waiting for LSFMM to see if and how FUSE-BPF intends to
>>>> address the highest value use case of read/write passthrough.
>>>>
>>>>  From what I've seen, you are still taking a very broad approach of
>>>> all-or-nothing which still has a lot of core design issues to address,
>>>> while these old patches already address the most important use case
>>>> of read/write passthrough of fd without any of the core issues
>>>> (credentials, hidden fds).
>>>>
>>>> As far as I can tell, this old implementation is mostly independent of your
>>>> lookup based approach - they share the low level read/write passthrough
>>>> functions but not much more than that, so merging them should not be
>>>> a blocker to your efforts in the longer run.
>>>> Please correct me if I am wrong.
>>>>
>>>> As things stand, I intend to re-post these old patches with mandatory
>>>> FOPEN_PASSTHROUGH_AUTOCLOSE to eliminate the open
>>>> questions about managing mappings.
>>>>
>>>> Miklos, please stop me if I missed something and if you do not
>>>> think that these two approaches are independent.
>>>
>>> Do you mean that the BPF patches should use their own passthrough mechanism?
>>>
>>> I think it would be better if we could agree on a common interface for
>>> passthough (or per Paul's suggestion: backing) mechanism.
>>
>> Well, not exactly different.
>> With BFP patches, if you have a backing inode that was established during
>> LOOKUP with rules to do passthrough for open(), you'd get a backing file and
>> that backing file would be used to passthrough read/write.
>>
>> FOPEN_PASSTHROUGH is another way to configure passthrough read/write
>> to a backing file that is controlled by the server per open fd instead of by BFP
>> for every open of the backing inode.
>>
>> Obviously, both methods would use the same backing_file field and
>> same read/write passthrough methods regardless of how the backing file
>> was setup.
>>
>> Obviously, the BFP patches will not use the same ioctl to setup passthrough
>> (and/or BPF program) to a backing inode, but I don't think that matters much.
>> When we settle on ioctls for setting up backing inodes, we can also add new
>> ioctls for setting up backing file with optional BPF program.
> 
>> I don't see any reason to make the first ioctl more complicated than this:
>>
>> struct fuse_passthrough_out {
>>          uint32_t        fd;
>>          /* For future implementation */
>>          uint32_t        len;
>>          void            *vec;
>> };
>>
>> One advantage with starting with FOPEN_PASSTHROUGH, besides
>> dealing with the highest priority performance issue, is how it deals with
>> resource limits on open files.
> 
> One thing that struck me when we discussed FUSE-BPF at LSF was that from
> a userspace point of view, FUSE-BPF presents an almost completely
> different API than traditional FUSE (at least in its current form).
> 
> As long as there is no support for falling back to standard FUSE
> callbacks, using FUSE-BPF means that most of the existing API no longer
> works, and instead there is a large new API surface that doesn't work in
> standard FUSE (the pre-filter and post-filter callbacks for each
> operation).
> 
> I think this means that FUSE-BPF file systems won't work with FUSE, and
> FUSE filesystems won't work with FUSE-BPF.

Is that so? I think found some incompatibilities in the patches (need to 
double check), but doesn't it just do normal fuse operations and then 
replies with an ioctl to do passthrough? BPF is used for additional 
filtering, that would have to be done otherwise in userspace.

Really difficult in the current patch set and data structures is to see 
what is actually BPF and what is passthrough.


Thanks,
Bernd
