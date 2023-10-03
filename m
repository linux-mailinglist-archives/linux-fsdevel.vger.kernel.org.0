Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDE07B7456
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 00:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjJCWy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 18:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjJCWy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:54:58 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80EDB4;
        Tue,  3 Oct 2023 15:54:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 185A63200B49;
        Tue,  3 Oct 2023 18:54:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 18:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696373692; x=1696460092; bh=2jVHXmEhNGnLoThDwRPTaiXQ4VgtqdFS0mA
        cLW+bbUo=; b=IFhkv836Ujjzz4C2Te8jaNK4yy5yagWg1P/KMPmBtP+4n2IQXBa
        BmL3DpoJYO2BiYOvgijAusiv/52+c83Q921gn4qrPC/03dVyvKOUUqIu4Azidibo
        sRA3I06mXeBlA1GANIpHRvDl94FVtkQOjEEwL43OlqysU43s3v8k9godLZQhXk6d
        mwx6s7htmDB8P3+tienqK8LriGaCCTllrpfJ3GojqbnJGCLRNsWjSj7EVJ3gYEFN
        m/Td9YaTngsxXGj4+tLli/NArQ09DPboAH7C7oMSB1NLnma1u/OYB7qHtlhaVtDW
        K/a1Ec2RmdC+NPWnZDjncviLe3SpooAnrig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696373692; x=1696460092; bh=2jVHXmEhNGnLoThDwRPTaiXQ4VgtqdFS0mA
        cLW+bbUo=; b=egPLEMD8Ni268aQlNmn/ScE2MzX3hNgSvoVz75KIExlNmuMPNxw
        g60ujvzGsPgMQSmY7K5b3KPbors8ma0tP29W0gdl1/wLrsN3NZfje2IItjQlyTZV
        +oIG0Syv7SNFl2yomimmjRnw2bkqH+r+NoBda8F7y/c25t4N2IvkYJR6PGrNs1AR
        sT12oLzNTRXj3SMhZj6RbWDdGFo9EGO7CpEkrpFI9YNO8jVp1sSpHvCniAmZIuGS
        ymIPtBsL8rx/HVvdG33J7X4tYNUc2Xk4GqfmWOqbX9ekpBlicQLZG9T8b6gSuEXj
        RCELFVTHbzZglTF93G6wfihWJ1biZPxqL2A==
X-ME-Sender: <xms:vJscZUSv2fYXzRGw20oUnwcZ3Q4T0imITWJuVM_Aqr2pViCqkKb1yg>
    <xme:vJscZRzUzIAIWHGvi2mM9mPj0F0zw_Y8Lf9qNc79IyvWqS-84A0k_pWP1xRjsxS19
    XQMYnlKWRl_kTWz>
X-ME-Received: <xmr:vJscZR3Q96bH2QPgsQU1g7-P0Onbw9TLZ4CquMq9fsm2hXE1fcjAiWIjSiEZHbSjTeXUqhy6WBwpZ9nW3mBe5x0lHesb0g1qja6JHwm2umo0Mkj5Rd60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeekgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeffjeevfeefjefghfefhfeiueffffetledtgffh
    hfdttdefueevledvleetfeevtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:vJscZYAWHQLGn3S0qDd8h39sj5HpVNq5cvNmdZZPu5uwOLy9DXrkFw>
    <xmx:vJscZdhY3QLrNT9VtLzU57kWMW0-96_yPQDtP-AbZOxp-F4ve6-CQw>
    <xmx:vJscZUqAF84SyIre1hTcxXKwUtjp69QbAYfkreL8jpbTyp1OU01Qeg>
    <xmx:vJscZYVt4fZ9Ysdx_vOh_23eASNJgdxCdfugvdpM27I-jN27FTWauQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 18:54:51 -0400 (EDT)
Message-ID: <18552fc7-184c-4bc7-9154-c885fae06d31@fastmail.fm>
Date:   Wed, 4 Oct 2023 00:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH v2 0/2] virtiofs submounts that are still in use
 forgotten by shrinker
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <97163cdf-ab2c-4fb8-abf2-738a4680c47f@fastmail.fm>
 <20231003164823.GA1995@templeofstupid.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20231003164823.GA1995@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/3/23 18:48, Krister Johansen wrote:
> On Tue, Oct 03, 2023 at 12:18:42AM +0200, Bernd Schubert wrote:
>>
>>
>> On 10/2/23 17:24, Krister Johansen wrote:
>>> Hi,
>>> I recently ran into a situation where a virtiofs client began
>>> encountering EBADF after the client / guest system had an OOM.  After
>>> reproducing the issue and debugging, the problem is caused by a
>>> virtiofsd submount having the nodeid of its root dentry fogotten.  This
>>> occurs because it borrows the reference for this dentry from the parent
>>> that is passed into the function.
>>
>>
>> Sorry, I didn't forget you, just didn't manage to review the 2nd version
>> yet. Will definitely do this week.
> 
> Thanks; I appreciate the feedback you've provided so far.
> 
>> Please also note that there will be merge conflicts with atomic open patches
>> from Dharmendra/me. Although probably not too difficult to resolve.
> 
> Sure. I'm happy to reparent, resolve those conflicts, re-test, and send
> another revision when we're ready.  I suspect there are going to be
> additional changes requested on the v2.  With that in mind, I'll hold
> off for the moment unless it is going to cause headaches for you.

I certainly also didn't mean that you should check for merge conflicts, 
it was more an annotation that it might come up - depending on the merge 
order. Please don't stop to do improvements, resolving merge conflicts 
shouldn't be difficult.
I'm going to add you to the atomic open patch series to keep you 
updated, if you don't mind.


> 
> For the atomic-open-revalidate changes: should I be working from what's
> on the list?  This is the most recent patchset I see:
> 
> https://lore.kernel.org/linux-fsdevel/20230920173445.3943581-1-bschubert@ddn.com/
> 
> I found a 6.5 relative tree of yours on GitHub by following the libfuse
> pull request, but nothing that seemed in sync with fuse/for-next.

I don't think there are conflicts with fuse-next right now, but I can 
check.


Thanks,
Bernd
