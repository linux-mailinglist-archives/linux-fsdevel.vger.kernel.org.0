Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937CE6C6665
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjCWLST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 07:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCWLSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:18:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD13D523
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 04:18:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 45D685C021A;
        Thu, 23 Mar 2023 07:18:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 23 Mar 2023 07:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1679570295; x=1679656695; bh=e/m1IdhOn5ytGc9HHiF1ilW2zKhLXJTuMa6
        tJCsKPl8=; b=GWl4Lm3+wlxfMSI5TvNjBuzS9Bwd2hXErsoveEKl2hv349bR0j+
        PyN0XYKrSTXWNipym+G+Jva1LVnT1aq6df88KG47gG++VKVm+O8WwsdPxNzlSrEz
        oQLWIqtEuJgkrhuAroF9VKt3mu8MptciM9+qiTqH2aF9r9MLlUdpZnQXhl5JeauT
        D1cp74bQ8RdIqLXY7i6UdqtD3twlDYW96sGFEoaFTL+aVNUeq65XqdALkzb5Jagj
        mhZQibSfg/Rqn0GRXfaIepPA6+5mWAkwDi33zrpw8E3ujub54dsL707tZEMkxUQP
        9yN2MOKZTz0Ih/F1QlPm+piX14tHZDh2cug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679570295; x=1679656695; bh=e/m1IdhOn5ytGc9HHiF1ilW2zKhLXJTuMa6
        tJCsKPl8=; b=CYwKl3C7xdpWxePZZauYXDwCjkFTIhMao/gHZ/AiKucbcDHPz4M
        UtycMxM/5YgW3RmisPEr03+ZYEug1W9jhq4TrJJIVAzCwZHS/xrybn2cm4y83Vi0
        +bLanVSL895flySxjh78+twWUxdoD0yUi65nZtNp3RkSWlTLdRlZudGblsBver0+
        9IwVZVhsVbCRJhBoz2jsgDt/35pNPyh5EAeFdRnAkWSfKvmJwqg132v5MmwQPgaz
        fII+kqXBS9YAfHYcAwoghlm9KNYPKQYc8FIaO1p4MMb9aBGn8ou25JpB+PTCyCMR
        puJf34l8YHXEijRk8tv0r45C9dsZh6qEwnQ==
X-ME-Sender: <xms:dzUcZOO8EBND7B1T5RLcd9LP5eeeUIL7DEFr5O0e4bTBSlzTisvq4A>
    <xme:dzUcZM96DmtI6bI8CfdOecw-Ie-7kZRXZPRGXPcMyfIOP9CHUQ1DuqIqOVvTspz6d
    0vjtpLd0SqRT9oO>
X-ME-Received: <xmr:dzUcZFSctEcKbsZurteMKOqLPzqR1ZMCq3n_lmrozgkIaiKwBJk5yBqQ8dE8udE8-_-6MU0oGoESOK8QJj6IEUgNZmBVWckCKd-69KDL5LaTnlvJBNym>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:dzUcZOtzrQb2FXGpvOzdbQhhkTRs5WTMXV1QSI2fHt0mk6bW6KuKpg>
    <xmx:dzUcZGdB55A5widOr8GCQDr9ebPQxoDjOKD0RIFTCJhweDSCh4qWNQ>
    <xmx:dzUcZC3_E5Wv-CVdbRZSm9kHnjjo6L8bGO_QajHXda_3Xe5qwgBcug>
    <xmx:dzUcZF6b-OLQU10FpQ5XT6w-ShjYKkRFg5_onskUVXMa3epDQG0Cfw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 07:18:14 -0400 (EDT)
Message-ID: <02f19f49-47f8-b1c5-224d-d7233b62bf32@fastmail.fm>
Date:   Thu, 23 Mar 2023 12:18:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 00/13] fuse uring communication
Content-Language: en-US, de-DE
To:     Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        fuse-devel@lists.sourceforge.net
References: <20230321011047.3425786-1-bschubert@ddn.com>
 <CAOQ4uxjXZHr3DZUQVvcTisRy+HYNWSRWvzKDXuHP0w==QR8Yog@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxjXZHr3DZUQVvcTisRy+HYNWSRWvzKDXuHP0w==QR8Yog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/21/23 10:35, Amir Goldstein wrote:
> On Tue, Mar 21, 2023 at 3:11 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> This adds support for uring communication between kernel and
>> userspace daemon using opcode the IORING_OP_URING_CMD. The basic
>> appraoch was taken from ublk.  The patches are in RFC state -
>> I'm not sure about all decisions and some questions are marked
>> with XXX.
>>
>> Userspace side has to send IOCTL(s) to configure ring queue(s)
>> and it has the choice to configure exactly one ring or one
>> ring per core. If there are use case we can also consider
>> to allow a different number of rings - the ioctl configuration
>> option is rather generic (number of queues).
>>
>> Right now a queue lock is taken for any ring entry state change,
>> mostly to correctly handle unmount/daemon-stop. In fact,
>> correctly stopping the ring took most of the development
>> time - always new corner cases came up.
>> I had run dozens of xfstest cycles,
>> versions I had once seen a warning about the ring start_stop
>> mutex being the wrong state - probably another stop issue,
>> but I have not been able to track it down yet.
>> Regarding the queue lock - I still need to do profiling, but
>> my assumption is that it should not matter for the
>> one-ring-per-core configuration. For the single ring config
>> option lock contention might come up, but I see this
>> configuration mostly for development only.
>> Adding more complexity and protecting ring entries with
>> their own locks can be done later.
>>
>> Current code also keep the fuse request allocation, initially
>> I only had that for background requests when the ring queue
>> didn't have free entries anymore. The allocation is done
>> to reduce initial complexity, especially also for ring stop.
>> The allocation free mode can be added back later.
>>
>> Right now always the ring queue of the submitting core
>> is used, especially for page cached background requests
>> we might consider later to also enqueue on other core queues
>> (when these are not busy, of course).
>>
>> Splice/zero-copy is not supported yet, all requests go
>> through the shared memory queue entry buffer. I also
>> following splice and ublk/zc copy discussions, I will
>> look into these options in the next days/weeks.
>> To have that buffer allocated on the right numa node,
>> a vmalloc is done per ring queue and on the numa node
>> userspace daemon side asks for.
>> My assumption is that the mmap offset parameter will be
>> part of a debate and I'm curious what other think about
>> that appraoch.
>>
>> Benchmarking and tuning is on my agenda for the next
>> days. For now I only have xfstest results - most longer
>> running tests were running at about 2x, but somehow when
>> I cleaned up the patches for submission I lost that.
>> My development VM/kernel has all sanitizers enabled -
>> hard to profile what happened. Performance
>> results with profiling will be submitted in a few days.
> 
> When posting those benchmarks and with future RFC posting,
> it's would be useful for people reading this introduction for the
> first time, to explicitly state the motivation of your work, which
> can only be inferred from the mention of "benchmarks".
> 
> I think it would also be useful to link to prior work (ZUFS, fuse2)
> and mention the current FUSE performance issues related to
> context switches and cache line bouncing that was discussed in
> those threads.

Oh yes sure, entirely forgot to mention the motivation. Will do in the 
next patch round. You don't have these links by any chance? I know that 
there were several zufs threads, but I don't remember discussions about 
cache line - maybe I had missed it. I can try to read through the old 
threads, in case you don't have it.
Our own motivation for ring basically comes from atomic-open benchmarks, 
which gave totally confusing benchmark results in multi threaded libfuse 
mode - less requests caused lower IOPs - switching to single threaded 
then gave expect IOP increase. Part of it was due to a libfuse issue - 
persistent thread destruction/creation due to min_idle_threads, but 
another part can be explained with thread switching only. When I added 
(slight) spinning in fuse_dev_do_read(), the hard part/impossible part 
was to avoid letting multiple threads spin - even with a single threaded 
application creating/deleting files (like bonnie++), multiple libfuse 
threads started to spin for no good reason. So spinning resulted in a 
much improved latency, but high cpu usage, because multiple threads were 
spinning. I will add those explanations to the next patch set.

Thanks,
Bernd

