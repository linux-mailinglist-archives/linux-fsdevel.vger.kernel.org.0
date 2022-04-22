Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91650BC04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449464AbiDVPtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449440AbiDVPtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:49:14 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126625D677;
        Fri, 22 Apr 2022 08:46:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 60D563202315;
        Fri, 22 Apr 2022 11:46:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Apr 2022 11:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1650642375; x=
        1650728775; bh=SifKSPDyvx0wNhlclXfBAhbr+Pgz7ygQ4Y7/YLhfxLo=; b=i
        npea3gFHY3XYXCfsQ8tWc1kCzsUG1963XVsVBk0mwZiIKS8tdVhf5W4QSadBpf1I
        nD9ACTHZ+YwWsnee+x2fz+YSUdmPJarvejXOBuOK+oKCnQ+iXOPlyxZXLlK5i1RF
        hUk+3XdqcwsmPn0UgObj1n14VgEztIrr2ZqfuAEFYyePneppnqmktRrfwNotZCdU
        Wr8M8LjeZD0tc2/RAJDmf1/pPr8MfRcuy/TNHZtJw6QAQACQkPFDmUoV+C6r7l0c
        1CJcXPEH/tR37GGXraTmXu6kMj+j2FLon4au705SA/JRIzH2bEOhKvTbYdmAm/lD
        TUi+0+SdiUi+HEBGp8HCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650642375; x=1650728775; bh=SifKSPDyvx0wN
        hlclXfBAhbr+Pgz7ygQ4Y7/YLhfxLo=; b=zDAwbpDum7FdvkXrKPgZNmfbpgXA7
        0MRW4ZVw8muMSI3D0JkKlhWHUHY47YcwstqAMJEL+Vbmym81qHTuqKcMMUYXfyy9
        3XmMVFQdNMz+Ex5T7UVEuX6k4A6X67aK8/lueJmLFKTYA5F770Ra1IO4PWCrDHkW
        mJ4pbbfxfi6SbISh2Kf2ha9lsoJk1p761qlS9LRtHDmwLGnU0hSX2vM4bXYghUzy
        vhiNwiXaDo/FJTCknAaZo7zV1kFSwEgXYXIMvoJaKJW+QRzDEVadJhc4hVT+23X5
        dSyfrIAbZa9YxCLFYah8It189uST/yVOgfmjzhS9Y+bravW7cCSwzGmOQ==
X-ME-Sender: <xms:x81iYt8XiM8b-cL76FP9K-pO1MoPmcRCIN_FsubA3Q_JRvqEpq4cqw>
    <xme:x81iYhug7k1d0oKXqrUL01HtNePPs5vykycOFgpaxydZGW9rR73ti3Zd80MMvN7Gb
    Bjg0LsSB9c7S4Ii>
X-ME-Received: <xmr:x81iYrDFtoxqeZNSkR67TNxFS8iCfBGajYBad15bkyznCDjcN718h-Tr3_KcTOwDkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeggdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekgfekiefhleejfeetffeigfetleeutdekfffh
    veefgfevteeikeevjeetledvveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:x81iYhe4kUK7dGjHAhsZc8ornjVv6LvxhgYQQY7UHaGhU_K3rNfpUg>
    <xmx:x81iYiPQ5yZ8IZI48eozjv-hlbvy80W8ZUglN0A2xcef_TvzbPeTnQ>
    <xmx:x81iYjmt3ZDH0nHh2gGHDmKsj0NyFLmkcHeyBMpkguaxqfFxRyl6yw>
    <xmx:x81iYvogD7FI8nsm4rp9w1d6OF3Q4ec1IkUKtrBjDL-vqTz7EcWrVA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 11:46:15 -0400 (EDT)
Message-ID: <d1955ffb-77ce-97a6-fcf2-b25960d389aa@fastmail.fm>
Date:   Fri, 22 Apr 2022 17:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: RFC fuse waitq latency
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dharmendra Singh <dsingh@ddn.com>
References: <6ba14287-336d-cdcd-0d39-680f288ca776@ddn.com>
 <CAJfpegt=KZJKExpxPgGXoBEzWpzepL9cyaqS=dwW5AN6y2up_Q@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegt=KZJKExpxPgGXoBEzWpzepL9cyaqS=dwW5AN6y2up_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[I removed the failing netapp/zufs CCs]

On 4/22/22 14:25, Miklos Szeredi wrote:
> On Mon, 28 Mar 2022 at 15:21, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> I would like to discuss the user thread wake up latency in
>> fuse_dev_do_read(). Profiling fuse shows there is room for improvement
>> regarding memory copies and splice. The basic profiling with flame graphs
>> didn't reveal, though, why fuse is so much
>> slower (with an overlay file system) than just accessing the underlying
>> file system directly and also didn't reveal why a single threaded fuse
>> uses less than 100% cpu, with the application on top of use also using
>> less than 100% cpu (simple bonnie++ runs with 1B files).
>> So I started to suspect the wait queues and indeed, keeping the thread
>> that reads the fuse device for work running for some time gives quite
>> some improvements.
> 
> Might be related: I experimented with wake_up_sync() that didn't meet
> my expectations.  See this thread:
> 
> https://lore.kernel.org/all/1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com/#r
> 
> Possibly fuse needs some wake up tweaks due to its special scheduling
> requirements.

Thanks I will look at that as well. I have a patch with spinning and 
avoid of thread wake  that is almost complete and in my (still limited) 
testing almost does not take more CPU and improves meta data / bonnie 
performance in between factor ~1.9 and 3, depending on in which 
performance mode the cpu is.

https://github.com/aakefbs/linux/commits/v5.17-fuse-scheduling3

Missing is just another option for wake-queue-size trigger and handling 
of signals. Should be ready once I'm done with my other work.

That being said, in the mean time I do believe a better approach would 
be SQ/CQ like, similar to NVME or io_uring. In principle exactly as 
io_uring, just the other way around - kernel fills in SQ, user space 
consumes it and fills CQ. We also looked into zufs and your fuse2 branch 
and were almost ready to start to port it to a recent kernel, but it is 
still all systemcall based and has waitq's - probably much slower than 
what could be achieved through queue pairs. Assuming userspace would not 
want a polling thread, but would want a notification similar to 
io_uring_enter(), there would be still a thread needed to be woken up, 
may that is where wake_up_sync() would help.

Btw, the optional kernel polling thread in io_uring also has spinning...


Bernd
