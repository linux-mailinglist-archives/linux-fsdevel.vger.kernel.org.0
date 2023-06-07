Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C72725711
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbjFGINO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 04:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbjFGINM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:13:12 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F73210D7;
        Wed,  7 Jun 2023 01:13:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D38A5C007D;
        Wed,  7 Jun 2023 04:11:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Jun 2023 04:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686125512; x=1686211912; bh=oehWi2mcNypSHEDOl07F4vFqlJbimL9Vc+E
        tsRILVQI=; b=3tBEpoLaA/r3IvvvcW/Ed2Ro+VtkUlWTC3HJbGojPOqGYunM0JS
        fBli8vZY8hdf+N7bcLFL8uDqD7dLkN50xvcw9lTLhIROeslktAco3SpOjqk8ijah
        m2zsSotjAGXl/a7qbnCmZP8YrrbBPHeBkBWZ/hKJJlm31mR6QWG6fwhUgxokwjXm
        C8b2GW0YLAeEAWez7P+jYL84+J82ZPYhz0GraGjJ2S8X7TJqX1d/TwKu6P3rr5TA
        HIcjy0NVVi2ECCpuwDydofkwcK0Df6vYgABblaamoaTB5nqlkrh83HSw/XPkYLDn
        2MvOFC7hlCQiJIwRtXYnaWDQKcCxHwq6gXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686125512; x=1686211912; bh=oehWi2mcNypSHEDOl07F4vFqlJbimL9Vc+E
        tsRILVQI=; b=Fk3bJIbP/+nkkg/GJiocAqU1LnFGAzIkf94CX5g4uRIc/xbzz8d
        /RJ05hrPkcCkPtvUC2tVjmBMrcWsfq65YNMk4vofncc1Y1vFKjZ5T8s6k34XhwPW
        nY6pHbseKWtbmsbAF8Td3/L8//y7Yl0XgAwKatO7wzloJu4P2QeVF6SOqRZ0Tsvo
        pRi0LVypSgVhOinnqvdcH3xC/JkY/HjJpMzghqinr1jiuOdZCB+xIXgen6bOeK6V
        3j0UWNSPRPJJbQrlpUB91M7vzd8PZ8r6eVZ8hJpMUBrVcNwXp+Euk2m+jyQqXwTh
        B4+W6LmRz4XuyHAQ+VnDimFiVCc4HoASuUg==
X-ME-Sender: <xms:yDuAZAx33D9gHHgAbE5EHnbc9rm-PgkP1QIg7W8kEfjekSXbRJxTOA>
    <xme:yDuAZESU2bKlWqdG9grNBUokueCtDDQs3DLcadYinmBNhfuqj20VDfblYDS_XLAQq
    L4rnBFVF6pYDtiY>
X-ME-Received: <xmr:yDuAZCWR6T_2EeU0iI9nEWDcCguaH-YSwyf5Al8LQdKOm0uA_jKB_MC45BocSi26OWuYAhohbhM0YCOBee7emNkAn96Vlg-7_gEdcStR-KgnETAWtabR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtfedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnheptdeujeffueehtdefjedtfeeltedvhffhteeh
    ffevudelhfegiedtuddvteekgffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:yDuAZOh22Tdjn1YdTNr0bxkTYpfIZikOAB7_CuX_IYojnXbUHeC8JQ>
    <xmx:yDuAZCDVjzIHQy1nQQ2YdTQzgnEIJL8eOjyW1JNvBypbPibeTo0h6g>
    <xmx:yDuAZPIaH3s3ssetJPgzm6W7uDuwFMfTRU2EqNTc6tsMRycLXpqGZA>
    <xmx:yDuAZJ6zkx3gs4STOM1wLl0a5PeKaz2hIYlxCZS_u7Quh_h-o_M7tA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 04:11:51 -0400 (EDT)
Message-ID: <9f79a2b7-c3f4-9c42-e6f3-f3c77f75afa2@fastmail.fm>
Date:   Wed, 7 Jun 2023 10:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Askar Safin <safinaskar@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
 <5d69a11e-c64e-25dd-a982-fd4c935f2bf3@fastmail.fm>
 <CAJfpeguQ87Vxdn-+c4yYy7=hKnSYwWJNe22f-6dG8FNAwjWBXA@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpeguQ87Vxdn-+c4yYy7=hKnSYwWJNe22f-6dG8FNAwjWBXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/7/23 09:21, Miklos Szeredi wrote:
> On Tue, 6 Jun 2023 at 22:18, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 6/6/23 16:37, Miklos Szeredi wrote:
>>> On Sun, 14 May 2023 at 00:04, Askar Safin <safinaskar@gmail.com> wrote:
>>>>
>>>> Will this patch fix a long-standing fuse vs suspend bug? (
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=34932 )
>>>
>>> No.
>>>
>>> The solution to the fuse issue is to freeze processes that initiate
>>> fuse requests *before* freezing processes that serve fuse requests.
>>>
>>> The problem is finding out which is which.  This can be complicated by
>>> the fact that a process could be both serving requests *and*
>>> initiating them (even without knowing).
>>>
>>> The best idea so far is to let fuse servers set a process flag
>>> (PF_FREEZE_LATE) that is inherited across fork/clone.  For example the
>>> sshfs server would do the following before starting request processing
>>> or starting ssh:
>>>
>>>     echo 1 > /proc/self/freeze_late
>>>
>>> This would make the sshfs and ssh processes be frozen after processes
>>> that call into the sshfs mount.
>>
>> Hmm, why would this need to be done manually on the server (daemon)
>> side? It could be automated on the fuse kernel side, for example in
>> process_init_reply() using current task context?
> 
> Setting the flag for the current task wouldn't be sufficient, it would
> need to set it for all threads of a process.  Even that wouldn't work
> for e.g. sshfs, which forks off ssh before starting request
> processing.

Assuming a fuse server process is not handing over requests to other 
threads/forked-processes, isn't the main issue that all fuse server 
tasks are frozen and none is left to take requests? A single non-frozen 
thread should be sufficient for that?


> 
> So I'd prefer setting this explicitly.   This could be done from
> libfuse, before starting threads.  Or, as in the case of sshfs, it
> could be done by the filesystem itself.

With a flag that should work, with my score proposal it would be difficult.

> 
>>
>> A slightly better version would give scores, the later the daemon/server
>> is created the higher its freezing score - would help a bit with stacked
>> fuse file systems, although not perfectly. For that struct task would
>> need to be extended, though.
> 
> If we can quiesce the top of the stack, then hopefully all the lower
> ones will also have no activity.   There could be special cases, but
> that would need to be dealt with in the fuse server itself.


Ah, when all non flagged processes are frozen first no IO should come 
in. Yeah, it mostly works, but I wonder if init/systemd is not going to 
set that flag as well. And then you have an issue when fuse is on a file 
system used by systemd. My long time ago initial interest on fuse is to 
use fuse as root file system and I still do that for some cases - not 
sure if a flag would be sufficient here. I think a freezing score would 
solve more issues.
Although probably better to do step by step - flag first and score can 
be added later.



Thanks,
Bernd
