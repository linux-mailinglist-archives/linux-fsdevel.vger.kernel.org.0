Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C913513D79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352264AbiD1V1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352246AbiD1V1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:27:07 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18CABF94D;
        Thu, 28 Apr 2022 14:23:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EAB6E320095D;
        Thu, 28 Apr 2022 17:23:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 28 Apr 2022 17:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1651181025; x=
        1651267425; bh=3vLTaVkEZ3b8A4ELUXpDmgBz1iAHWXqN83BSs1RDik8=; b=P
        7MWA4sFQF/eL1CM/F+x0g08frs8CGg9aFBosPt3zTJkXWkvPZTWJt2PP0QBIBVKU
        tm4szCoDCymCMtgixB+8iLaz4Y2Mvr4jPIHVU68YQDk4JD9LPAPPkvbLIRwvISxJ
        dRUBeB01CPWajxEAuKMsKaQp5R7Te1dXmjqAvp+A73+Sxk+9uh1qtU4G+6J0rbTg
        1y3Q1btmdMcs2dnL6Dgv/mZ1dnb7elXSFPNfszONLCKheecoUDTlNR9VcxYILoZf
        wxc209MxbJZ/xShSUwDWUsKY5rYiPTIw8DEgjsQTwdKco7Jws1oD+e2z0h7GtJ9S
        J2pU426KPxGhgo03yk+EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1651181025; x=1651267425; bh=3vLTaVkEZ3b8A
        4ELUXpDmgBz1iAHWXqN83BSs1RDik8=; b=gyIRtKAZX3ennp4NYDYyZAEpyljzi
        cvAazoPkS8ss8NUznSe7btuhLAjFh8i1Nu0XTkNSGpCa900BSqJ8VmHzlJGrJtYe
        PNsCd6b3P6fJIMxBUzMlwCubfldBE5xqn/LuS3JkC1ZXZYJinEXPf26BR/UIoyHB
        3d51tI9lfSz/wMxgX6Dxlvkq0+avsGL1A6zuay0//aY7kdF+2bQjIRixvPzVJB9s
        KfViqI9lmxsici3zvn+OsC8h86YOxPZyyI2/Sc4s1NPpDtox+vJXCQJamXWeeuSE
        w3yaRntXShqAi2IXjWA/2To6iA4kROCYEphvXw5iqWEUw3whWWoxLWV7Q==
X-ME-Sender: <xms:4AVrYgtlIFYeyUNHsydvFJsvjrOy50nhGAIfZUtQ88DIcO9PlEUE8w>
    <xme:4AVrYtcDrb62AasLD4DvInXdzn-EVDU-XzatWQ4ORPPOPZvFcx8i5zktSIXmCO40F
    lK0AcduwYPASVo1>
X-ME-Received: <xmr:4AVrYrwkspRMnRTAJMzJTT3LhWBHIsiTQIuwPLF9okm8o0jY7FcpNk0ARrNu_Lif6MRwYByeH74WKCyiTDQWktz90MYUz4d0i3vWeWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejgdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkefgkeeihfeljeefteffiefgteeluedtkeff
    hfevfefgveetieekveejteelvdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:4QVrYjP4DYdfaGEf0g45xiNDcQt2_u4Kv12W6Yjp1IPaNTEBijTN8w>
    <xmx:4QVrYg9EOFNgIzh9tYRmyH9CGlKufRjGSayCFkm6kISR1Uf2FI_kyQ>
    <xmx:4QVrYrUQ1TzUwQJic4-faAgRAElIPMCIXdne-UXRZn7O5FK457goFw>
    <xmx:4QVrYvb3qOcgdpZnB0NmiSsD4OwhqRb1bQVDrBv9O71mucVCinCTUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Apr 2022 17:23:44 -0400 (EDT)
Message-ID: <9326bb76-680f-05f6-6f78-df6170afaa2c@fastmail.fm>
Date:   Thu, 28 Apr 2022 23:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: RFC fuse waitq latency
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dharmendra Singh <dsingh@ddn.com>
References: <6ba14287-336d-cdcd-0d39-680f288ca776@ddn.com>
 <CAJfpegt=KZJKExpxPgGXoBEzWpzepL9cyaqS=dwW5AN6y2up_Q@mail.gmail.com>
 <d1955ffb-77ce-97a6-fcf2-b25960d389aa@fastmail.fm>
 <CAJfpegsr3fqcFuNekLwf69v3mpNJyze741=L5KUJjvH758eE6g@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegsr3fqcFuNekLwf69v3mpNJyze741=L5KUJjvH758eE6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for my late reply, I'm on vacation and family visit this week.

On 4/25/22 10:37, Miklos Szeredi wrote:
> On Fri, 22 Apr 2022 at 17:46, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>> [I removed the failing netapp/zufs CCs]
>>
>> On 4/22/22 14:25, Miklos Szeredi wrote:
>>> On Mon, 28 Mar 2022 at 15:21, Bernd Schubert <bschubert@ddn.com> wrote:
>>>>
>>>> I would like to discuss the user thread wake up latency in
>>>> fuse_dev_do_read(). Profiling fuse shows there is room for improvement
>>>> regarding memory copies and splice. The basic profiling with flame graphs
>>>> didn't reveal, though, why fuse is so much
>>>> slower (with an overlay file system) than just accessing the underlying
>>>> file system directly and also didn't reveal why a single threaded fuse
>>>> uses less than 100% cpu, with the application on top of use also using
>>>> less than 100% cpu (simple bonnie++ runs with 1B files).
>>>> So I started to suspect the wait queues and indeed, keeping the thread
>>>> that reads the fuse device for work running for some time gives quite
>>>> some improvements.
>>>
>>> Might be related: I experimented with wake_up_sync() that didn't meet
>>> my expectations.  See this thread:
>>>
>>> https://lore.kernel.org/all/1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com/#r
>>>
>>> Possibly fuse needs some wake up tweaks due to its special scheduling
>>> requirements.
>>
>> Thanks I will look at that as well. I have a patch with spinning and
>> avoid of thread wake  that is almost complete and in my (still limited)
>> testing almost does not take more CPU and improves meta data / bonnie
>> performance in between factor ~1.9 and 3, depending on in which
>> performance mode the cpu is.
>>
>> https://github.com/aakefbs/linux/commits/v5.17-fuse-scheduling3
>>
>> Missing is just another option for wake-queue-size trigger and handling
>> of signals. Should be ready once I'm done with my other work.
> 
> Trying to understand what is being optimized here...  does the
> following correctly describe your use case?
> 
> - an I/O thread is submitting synchronous requests (direct I/O?)
> 
> - the fuse thread always goes to sleep, because the request queue is
> empty (there's always a single request on the queue)
> 
> - with this change the fuse thread spins for a jiffy before going to
> sleep, and by that time the I/O thread will submit a new sync request.
> 
> - the I/O thread does not spin while the the fuse thread is processing
> the request, so it still goes to sleep.


Yes, this describes it well. We basically noticed weird effects with 
multiple fuse threads when you had asked for benchmarks of the atomic 
create/open patches. In our HPC world the standard for such benchmarks 
is to use mdtest, but for simplicity I personally prefer bonnie++, like 
"bonnie++ -s0 -n10:1:1:10 -d <dest-path>"

Initial results were rather confusing, as reduced number of requests 
could result in lower performance. So I started to investigate and found 
a number of issues

1) passthrough_ll is using a single linked list to store inodes, we 
later switched to passthrough_hp which uses a C++ map to avoid the O(N) 
inode search

2) limiting the number of threads in libfuse using the max_idle_threads 
variable caused additional high cpu usage - there was permanent pthread 
creation/destruction. I have submitted patches for that (additional 
difficulty is to fix the API to avoid uninitialized struct members in 
libfuse3)

3) There is some overhead with splice for small requests like meta data. 
Even though the libfuse already tries to use splice for larger requests 
only. But unless disabled it still does a splice system call for the 
request header - enough to introduce a perf penalty. I have some very 
experimental patches for that as well, although it got much more 
difficult than I had initially hoped for. With these patches applied I 
started to profile the system with flame graphs and noticed that 
performance is much lower than it could be explained by the fuse cpu 
overhead.

4) Figured out about the waitq overhead. In the mean time I'm rather 
surprised about the zufs results - benchmarks had been done with at 
least  n-application thread >= 2 x n-zufs threads? Using thread spinning 
might avoid the issue, but with request queue per core in worst case all 
system cores might go a bit into spinning mode - at least not idea for 
embedded systems. And also not ideal for power consumption on laptops or 
phones and neither for HPC systems where systems are supposed to be busy 
to do calculations.

4.1) A sub problem of the waitq is the sleep condition - it checks if 
there are no pending requests - threads on different cores randomly wake 
up, even with avoided explicit thread wake as in my patches.

Right now I'm at a point where I see that my patches help to improve 
performance, but I'm not totally happy with the solution myself. That is 
basically where I believe that a SQ/CQ approach would give better 
performance and should/might avoid additional complexity.  At a minimum 
the request queue (SQ) spinning could be totally controlled/handled in 
user space.
Just need to find the time to code it...


Bernd
