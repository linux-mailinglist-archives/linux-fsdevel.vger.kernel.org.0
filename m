Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD936098EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 05:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJXDfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 23:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJXDfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:35:19 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC62314E;
        Sun, 23 Oct 2022 20:35:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DD93C320029B;
        Sun, 23 Oct 2022 23:35:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 23 Oct 2022 23:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1666582503; x=
        1666668903; bh=uxLRE/v3Di2b7qXjA9BnI1XX0S9/AG7n7y1jsVX+klY=; b=q
        AZ4IPnBeGHI3kE74FJKvsqd+gmbVX5wPGhEXVt+g5hKQZMMKCyRlrmBSfd22DwfR
        l3dSV8G63d9EVWPZfHmBfnxpuFvKWhCBV7dNjuK8zGrT7WITGeICyKRnuk9xVyuR
        wu9kyfgyRGCrRi9fPhBDdG1LNax7mTchyzA1qgmWDTcCpcXHFibQfntMKgHT2wo/
        Dmc1+BuzA/QPLSEsAEfwAbGXMfGwMRvL0QcNmh35XXDR/LInHBD/cGo8jl7IDzgZ
        41ZYjPj/jvFPWpeqPJD60DDm3nIakr2rkAfa7ORda/HaUQIGOLr9Hmi+/BnvqMz3
        ycyWfhwxX0PRVELdoGVQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666582503; x=
        1666668903; bh=uxLRE/v3Di2b7qXjA9BnI1XX0S9/AG7n7y1jsVX+klY=; b=G
        qdMnutGGpMvzm4/Y2nNw/98AdItf96ITKUNAwIKAgJhXZaSuv/x2OUsZzeMYhpPG
        vFkKGjDCt+lu1pdsUJkhKaLYMOAu+dwkM7q73yMyQLoKwGhZKWPW6LnDofzRcQQX
        EebWoJp5wGVC2LlAzBos2bbtLyO1KgdloludgLxnn7vUU/E1ooYxFJNWiBeQIK4l
        rl+aFu2qb6BcjsHUC7C3sNFfftL9Jw6cs74fZjq8lQygbgZ5aNf+Mn+u9cLDYV+O
        J3MPpwmwTOzL6R7I3ud8x20obzUOAQW2JVudVoT6Wwjo2sSnJPwGsm3HKg5Uk3eQ
        /pm0rSZ0TCc4+WaYYgdUg==
X-ME-Sender: <xms:5gdWYzBgGNVp7CbROm7t7f9yPqiaFjajjjEYZXAgK6B6rOEjs42ouw>
    <xme:5gdWY5gwAjYjy2fr8-e7UNCV2EgKKu6rxxSHdgsFe3NGfMZ2kYKDkH2FNVelNEXrE
    lvql2BlgNmU>
X-ME-Received: <xmr:5gdWY-mYF4qSh3x8pP1ZW6f_8w79_XhPK87MZfUvIPJ_neG_HKL326nENl3JnVWe2FIKqVurzY3pZGmGuOTsFTxotG8_sduVZrlrB3gDfTH8FHzjA_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtfedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttdefjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgif
    rdhnvghtqeenucggtffrrghtthgvrhhnpeeuhfeuieeijeeuveekgfeitdethefguddtle
    ffhfelfeelhfduuedvfefhgefhheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:5gdWY1zdHEkzNPrvxA-LaBbZ-m0qubfOZVzn9KXaftj4sHmEtFGL3Q>
    <xmx:5gdWY4SsPiVhDiQHKOSCW7IrSJ8Q-MEl_fiLsQamuPsCCFsa7YgmWw>
    <xmx:5gdWY4aoRC0E4t44pM0UCxLsHh7-S0soNDF3nQVpfsYOptVNzfok8A>
    <xmx:5wdWY5LBQDUxz4Im6iOVzR7Bm9qvNME0YcEqECDzxmM6QdgBtMAwXQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Oct 2022 23:34:54 -0400 (EDT)
Message-ID: <7ba9257e-0285-117c-eada-04716230d5af@themaw.net>
Date:   Mon, 24 Oct 2022 11:34:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH -next 0/5] fs: fix possible null-ptr-deref when parsing
 param
Content-Language: en-US
To:     Hawkins Jiawei <yin31149@gmail.com>, viro@zeniv.linux.org.uk
Cc:     18801353760@163.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        cmaiolino@redhat.com, dhowells@redhat.com, hughd@google.com,
        miklos@szeredi.hu, oliver.sang@intel.com,
        penguin-kernel@i-love.sakura.ne.jp, siddhesh@gotplt.org,
        syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, smfrench@gmail.com,
        pc@cjr.nz, lsahlber@redhat.com, sprasad@microsoft.com,
        tom@talpey.com
References: <Y1VwdUYGvDE4yUoI@ZenIV>
 <20221024004257.18689-1-yin31149@gmail.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20221024004257.18689-1-yin31149@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 24/10/22 08:42, Hawkins Jiawei wrote:
> On Mon, 24 Oct 2022 at 00:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Mon, Oct 24, 2022 at 12:39:41AM +0800, Hawkins Jiawei wrote:
>>> According to commit "vfs: parse: deal with zero length string value",
>>> kernel will set the param->string to null pointer in vfs_parse_fs_string()
>>> if fs string has zero length.
>>>
>>> Yet the problem is that, when fs parses its mount parameters, it will
>>> dereferences the param->string, without checking whether it is a
>>> null pointer, which may trigger a null-ptr-deref bug.
>>>
>>> So this patchset reviews all functions for fs to parse parameters,
>>> by using `git grep -n "\.parse_param" fs/*`, and adds sanity check
>>> on param->string if its function will dereference param->string
>>> without check.
>> How about reverting the commit in question instead?  Or dropping it
>> from patch series, depending upon the way akpm handles the pile
>> these days...
> I think both are OK.
>
> On one hand, commit "vfs: parse: deal with zero length string value"
> seems just want to make output more informattive, which probably is not
> the one which must be applied immediately to fix the
> panic.
>
> On the other hand, commit "vfs: parse: deal with zero length string value"
> affects so many file systems, so there are probably some deeper
> null-ptr-deref bugs I ignore, which may take time to review.

Yeah, it would be good to make the file system handling consistent

but I think there's been a bit too much breakage and it appears not

everyone thinks the approach is the right way to do it.


I'm thinking of abandoning this and restricting it to the "source"

parameter only to solve the user space mount table parser problem but

still doing it in the mount context code to keep it general (at least

for this case).


Ian

