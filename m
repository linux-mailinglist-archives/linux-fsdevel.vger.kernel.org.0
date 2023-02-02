Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC868897E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 23:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjBBWCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 17:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjBBWC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:02:28 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1869488CE0;
        Thu,  2 Feb 2023 14:02:00 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B193A5C0114;
        Thu,  2 Feb 2023 17:01:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Feb 2023 17:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675375299; x=
        1675461699; bh=YCW7GaAtPaVZlrRCbu29XnWiMCmrl3ppTRURidgtXOY=; b=F
        wc6nhXMDAmuFGL0TUU8QnKM2LD4H6JRBlwK9lG6zl8OjtKPm5c4SwLr6STgAeIzz
        hIWugzL2X5B0P0wguXU/0S+HYq9FpUL/VmswIG2pFPM2WVywgSCeHFuwh4hJrD1L
        JDuK3TX5jEyBhSpmUsZ4TSG1GbZSFMllfUG02zaG2sc+DSEyyhzwRM26tia+D6lX
        QhSFemjuT4Gop482kCirNGgSozOzFfzhZ1Aj9l3/6umyU0arFgqUbvzSmcUarXO7
        ocAoCcZyMsej7MwJbvJa4VSnrDGv2Wa9nuQ9qZ/fU4/IKJetK6bclRG+n5tz6piU
        f9260Ohkvmqka/YCLcYSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675375299; x=
        1675461699; bh=YCW7GaAtPaVZlrRCbu29XnWiMCmrl3ppTRURidgtXOY=; b=k
        hWTk6kt4+dyIcwJkPWW2IwwH3GBn4laJh5KXGCo0LckiJFHG+9/XMIzARIIBbYXO
        sAgkBibXMX9TYr/ATLiqaJ4idc26o9MV2gluEHsirR0avE6eYjN04roA0tAsrtJ3
        9G23q6D93lMD1triUh6M2yP1jP3m2Lf5RqIVt9uYNwNqwvsOYhDsWV/tYmTI+Rty
        W82SfORbCWVtGNhrmVeY3vbGaubMfo1t55L2v/0aSOkFCzxSrHQD8AdMT1Elhrt6
        rlpJp4Y90NWPamdgdePjnLbjWxwJ4rKlpGvnfCQ/ninSu1ahcxWcE20M/0QA8Zp/
        zWaaN9R1PfOQ3IBe6AoHg==
X-ME-Sender: <xms:wjLcY6nfeO526MV7BTKpwDAfuD747TdEzwbg-s8_cMAogooVeiSdfg>
    <xme:wjLcYx0tKyjL19DhByStlVm3L-k18lILIKnoLF-wiWzhAdm6vo0Iu2QgDhO8E9WEO
    n7rnWqLpmPlEn82>
X-ME-Received: <xmr:wjLcY4qbBplRk0OTvHgFiZV23WoZB_E05kwvWoDu5RzUzv17IREjarId5hCGmWLSn9y0n-OFGyGADsqRWdkHqnnFDN3uh8XWTczENy1wzPMdd63isU8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpedtueduieefteefheeutdefheehteekuedu
    teeukeegveektdfhtddthfdujeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmpd
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:wjLcY-mhqWtThg_P1R9B7fEwTdvAxglEiEGtSGPa-qMs8Al4lg4X6w>
    <xmx:wjLcY40Kwcu9l8c6mHOz1io61YtVu3voIyBMYcDrdLGXZoN-yqDoWQ>
    <xmx:wjLcY1vIjrGnngOCkAx0GrV9ZHcaA1IHJP13GDw5-hFMr250DGtY3w>
    <xmx:wzLcY5k43sx9X8NYcj4tcOCC6nHlCmo6mNXqUMRq3bJtG_gPNKMBig>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 17:01:37 -0500 (EST)
Message-ID: <283b5344-3ef5-7799-e243-13c707388cd8@fastmail.fm>
Date:   Thu, 2 Feb 2023 23:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for
 FUSE
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Vivek Goyal <vgoyal@redhat.com>,
        Nikolaus Rath <Nikolaus@rath.org>
References: <20221122021536.1629178-1-drosen@google.com>
 <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
 <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm>
 <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/2/23 09:47, Amir Goldstein wrote:
> On Tue, Nov 22, 2022 at 11:23 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 11/22/22 21:56, Daniel Rosenberg wrote:
>>> I've been running the generic xfstests against it, with some
>>> modifications to do things like mount/unmount the lower and upper fs
>>> at once. Most of the failures I see there are related to missing
>>> opcodes, like FUSE_SETLK, FUSE_GETLK, and FUSE_IOCTL. The main failure
>>> I have been seeing is generic/126, which is happening due to some
>>> additional checks we're doing in fuse_open_backing. I figured at some
>>> point we'd add some tests into libfuse, and that sounds like a good
>>> place to start.
>>
>>
>> Here is a branch of xfstests that should work with fuse and should not
>> run "rm -fr /" (we are going to give it more testing this week).
>>
>> https://github.com/hbirth/xfstests
>>
>>
> 
> Bernd, Daniel, Vivek,
> 
> Did you see LSFMMBPF 2023 CFP [1]?
> 
> Did you consider requesting an invitation?
> I think it could be a good opportunity to sit in a room and discuss the
> roadmap of "FUSE2" with all the developers involved.
> 
> I am on the program committee for the Filesystem track, and I encourage
> you to request an invite if you are interested to attend and/or nominate
> other developers that you think will be valuable for this discussion.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/Y9qBs82f94aV4%2F78@localhost.localdomain/


Thanks a lot Amir, I'm going to send out an invitation tomorrow. Maybe 
Nikolaus as libfuse maintainer could also attend?


Thanks,
Bernd
