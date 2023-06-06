Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51199724DDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 22:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbjFFUSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 16:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbjFFUSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:18:31 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC241A7;
        Tue,  6 Jun 2023 13:18:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C91B5C0189;
        Tue,  6 Jun 2023 16:18:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 16:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686082707; x=1686169107; bh=/7YL0I/wdpR1Dyl/whVOKKeGk3Kq8M8MxbU
        JFQZ6VKA=; b=3RTJflr+Jr/ONLWddDwxwFKO98Mg53p2jZEW/c+lCMYnOA1YjDJ
        o2CWUmyc5gs3vBQLTNQnl7hKEFX6gmtHof7EoxFxeXVw91ua6hQnyNeQHEpiaUus
        YuyaAp/tYVq8PuXLhsBJGliRqEDOt9gm+A2Ssqgw/Ek1tF3YMgy43f/cOD+uRsG6
        0/oQpbjK1EyjHiXJGzEKLMe8SCk0sp8yUzfFqX/0i4hwEZNn7hMmwa22Z2HreLto
        o26zhtaj1/15Gs2CA+cJZXfJ+a/NKfJVFXShjmLE/QEAcF/NyVWP8K92zgVL324Z
        +tb+j9G0ShWOKvp3WAfkEaKOUxiPnRRir9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686082707; x=1686169107; bh=/7YL0I/wdpR1Dyl/whVOKKeGk3Kq8M8MxbU
        JFQZ6VKA=; b=UrHmkgFO7902chnScDG+wfosItXrw46HGp5V/ecfTHQv/eGutyG
        b7uW1QhMFanTqncPAlQu/Nq0tfv9lnSJmhHzv9pml9XDgk+1/XTyCw493fxOYKdV
        TPZs/qdoDmws82lAiv5P+XvtKIChCtA2/4kY/4Xja+MurwF/ehz+7YBo7FnGIm33
        oH5d833ukWKCrP/lPd/LEd4ojlLFpoQVde5NB66O0F4zmdYuYn/j5DnRbvQKB1XU
        Wu1DStCfwzNEXCZaFks6oD2AZrNk8GFGVz4bit8pUJEt1YwtgKLOVtqYBwhfdKv0
        G+8WYqRyc413wBCF640XHfB5lrtp/nYx1+g==
X-ME-Sender: <xms:k5R_ZOPY4fbT2CG2pPWiu5LnK4DWKPr9aDKj9MHuDtztVqWYraH2Fg>
    <xme:k5R_ZM9mPxrSPN3B2XAnwue-RRKFQSsJPvp6dhWNkigINEFBsUj6jK0xG8Zhu8mpm
    G7kMELJ9PptCDv6>
X-ME-Received: <xmr:k5R_ZFQYkWPvWvr9NYvFU5rDE6o771XdN36zxWElooyZiryc_B8U1ZlwdEJpPIcAmYz28jc6ei1aD1bmYswl04s_QJgqS7K8mUBZYvNoj5MOlEE-mLFz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpedtueejffeuhedtfeejtdefleetvdfhhfet
    heffvedulefhgeeitdduvdetkefghfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:k5R_ZOs_9kr7lbZF9qt0rG1deCSz5W3orW86YxLlHZcv-4VSRyN6wA>
    <xmx:k5R_ZGcdLht1RpaRq4x8WE-pVIFK6X_7a3EVAUzgaQ3Ys4gx9nwstA>
    <xmx:k5R_ZC2r5-5wuTNEdYxV0q43ube7_jbyrQZGUv24FD0ptrAL2Gvbbw>
    <xmx:k5R_ZDGdEMocbr2Vtf3WrOQElo4zvCPh_c3y_Cebgf7Jm25fxd7chA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 16:18:26 -0400 (EDT)
Message-ID: <5d69a11e-c64e-25dd-a982-fd4c935f2bf3@fastmail.fm>
Date:   Tue, 6 Jun 2023 22:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Askar Safin <safinaskar@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
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



On 6/6/23 16:37, Miklos Szeredi wrote:
> On Sun, 14 May 2023 at 00:04, Askar Safin <safinaskar@gmail.com> wrote:
>>
>> Will this patch fix a long-standing fuse vs suspend bug? (
>> https://bugzilla.kernel.org/show_bug.cgi?id=34932 )
> 
> No.
> 
> The solution to the fuse issue is to freeze processes that initiate
> fuse requests *before* freezing processes that serve fuse requests.
> 
> The problem is finding out which is which.  This can be complicated by
> the fact that a process could be both serving requests *and*
> initiating them (even without knowing).
> 
> The best idea so far is to let fuse servers set a process flag
> (PF_FREEZE_LATE) that is inherited across fork/clone.  For example the
> sshfs server would do the following before starting request processing
> or starting ssh:
> 
>    echo 1 > /proc/self/freeze_late
> 
> This would make the sshfs and ssh processes be frozen after processes
> that call into the sshfs mount.

Hmm, why would this need to be done manually on the server (daemon) 
side? It could be automated on the fuse kernel side, for example in 
process_init_reply() using current task context?

A slightly better version would give scores, the later the daemon/server 
is created the higher its freezing score - would help a bit with stacked 
fuse file systems, although not perfectly. For that struct task would 
need to be extended, though.

> 
> After normal (non-server) processes are frozen, server processes
> should not be getting new requests and can be frozen.
> 
> Issues remaining:
> 
>   - if requests are stuck (e.g. network is down) then the requester
> process can't be frozen and suspend will still fail.
> 
>   - if server process is generating filesystem activity (new fuse
> requests) spontaneously, then there's nothing to differentiate between
> server processes and we are back to the original problem
> 
> Solution to both these are probably non-kernel: impacted servers need
> to receive notification from systemd when suspend is starting and act
> accordingly.
> 
> Attaching work-in-progress patch.  This needs to be improved to freeze
> server processes in a separate phase from kernel threads, but it
> should be able to demonstrate the idea.


Thanks,
Bernd
