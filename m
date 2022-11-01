Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FADF614246
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 01:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiKAAcn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 20:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKAAck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:32:40 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8657613F20;
        Mon, 31 Oct 2022 17:32:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EDE315C00E7;
        Mon, 31 Oct 2022 20:32:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 31 Oct 2022 20:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1667262758; x=
        1667349158; bh=8ame5+g1vFTZe19N8YY2ZI8AVM29rYwFCCLbDt28C5A=; b=s
        Nt7Raaa2nvEuJiaHpK5EDg2caNAw2rCwhiwY8pSwiZ6/JqGwefUnHVJrHxBpXtnr
        ha24sCLiblvl8c6Fp0UMvvYKCEugHPAfaUHB9tbJ5JIK7YRzwQwhdXNWR0IJwkWE
        so0sHApClPmf18LMDPIkZ1p1l3BEjN9oi76HGloV4csNXd1ron50JtzndRbJ35sf
        B2V31pkFNSDFCLsroIO2gRlONJZMcPIugAcIxwANgZN3IK219SfloPE8SD3ztCCM
        933bdOFZKo20Iw4tuZbCOgB4yi7/h0pZ7e/XIUoK0ZAalBBRiO/DpV9Ae5UOK+Cd
        eikAKcy8KM/3L/dvVmjoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667262758; x=
        1667349158; bh=8ame5+g1vFTZe19N8YY2ZI8AVM29rYwFCCLbDt28C5A=; b=b
        lNoUguwSMu5+Ns9poN2qAapNeBHdubOjHA+B5nbnQW9IxKHwCagyMHE3Z1PnAe28
        nnpq6hinuwhCKtIpO7EhM3rBSnjAhSzc9CkTT+L79zqssqx5yhzq1gZ6RVqENMEE
        lUABdeYTZBk0xg4BetLi5j/rNbWB/UQjOM4Alj1alATOdmcA1fRE15gW1ok0bKL1
        UDDxEfWUhOc3b2Yi40a7AGoxbNbQRRiDlXDemnHtqZm/qgRW73c+2gKJOHhZBx8D
        7Dznykfx1mRyDxwOMd30yBk5fIDO5R6PB7AVkGVtb3uHrqxLrXcnUtai2nYasg9E
        AFxWkeKp1Pdkntp/AU/Og==
X-ME-Sender: <xms:JWlgYwCIwAcNWw3YXRUv511jrdNCgQGikN72CPunO13MknpYCDzxKw>
    <xme:JWlgYygEIO_muzHxuiQk3TPsXUdyzZJFU1dszvCaPvEPHgvt8v83gIYxHLdBLuSpq
    otA_jM_z6Wx>
X-ME-Received: <xmr:JWlgYzkNnhB60ZDbCsY9TewXobQLdIwUP5jv34RCJzG68T0cRnb7hgyiwyXnnRcD8zZ2x4uWPcT9xjErLSII0sWOpKJEvNueXcc4NEkMzRG3lSceXN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudeggddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtke
    ertddtfeejnecuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidr
    nhgvtheqnecuggftrfgrthhtvghrnhepgedvteevvdefiedvueeujeegtedvheelhfehte
    fhkefgjeeuffeguefgkeduhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:JWlgY2xDnPanSANpvR2s91j_WwlOsO1iDK1dm5Z5i-Ne0oRnbtEybw>
    <xmx:JWlgY1SB73B6jyXojI1R1Z3N2KUhI9RJjsE1C-o79Eo8-15X2CEWBw>
    <xmx:JWlgYxYlgtaq9gtYtihtJt2TJ5mjm51MwYoWRwngoQM0UOedDrXCoQ>
    <xmx:JmlgY2K07sbDbBMCWZrQQtUU0Py3MOgsVXkUhVoNVyTn59VBCX_mlQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Oct 2022 20:32:30 -0400 (EDT)
Message-ID: <f81f0ddc-cff3-b327-f4b2-57102bdf0ecf@themaw.net>
Date:   Tue, 1 Nov 2022 08:32:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH -next 0/5] fs: fix possible null-ptr-deref when parsing
 param
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Hawkins Jiawei <yin31149@gmail.com>, viro@zeniv.linux.org.uk
Cc:     18801353760@163.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        cmaiolino@redhat.com, dhowells@redhat.com, hughd@google.com,
        miklos@szeredi.hu, oliver.sang@intel.com, siddhesh@gotplt.org,
        syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, smfrench@gmail.com,
        pc@cjr.nz, lsahlber@redhat.com, sprasad@microsoft.com,
        tom@talpey.com
References: <Y1VwdUYGvDE4yUoI@ZenIV>
 <20221024004257.18689-1-yin31149@gmail.com>
 <7ba9257e-0285-117c-eada-04716230d5af@themaw.net>
 <af24da42-02cb-e60e-d1df-365801aa686b@I-love.SAKURA.ne.jp>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <af24da42-02cb-e60e-d1df-365801aa686b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 31/10/22 19:28, Tetsuo Handa wrote:
> On 2022/10/24 12:34, Ian Kent wrote:
>> On 24/10/22 08:42, Hawkins Jiawei wrote:
>>> On Mon, 24 Oct 2022 at 00:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>> On Mon, Oct 24, 2022 at 12:39:41AM +0800, Hawkins Jiawei wrote:
>>>>> According to commit "vfs: parse: deal with zero length string value",
>>>>> kernel will set the param->string to null pointer in vfs_parse_fs_string()
>>>>> if fs string has zero length.
>>>>>
>>>>> Yet the problem is that, when fs parses its mount parameters, it will
>>>>> dereferences the param->string, without checking whether it is a
>>>>> null pointer, which may trigger a null-ptr-deref bug.
>>>>>
>>>>> So this patchset reviews all functions for fs to parse parameters,
>>>>> by using `git grep -n "\.parse_param" fs/*`, and adds sanity check
>>>>> on param->string if its function will dereference param->string
>>>>> without check.
>>>> How about reverting the commit in question instead?  Or dropping it
>>>> from patch series, depending upon the way akpm handles the pile
>>>> these days...
>>> I think both are OK.
>>>
>>> On one hand, commit "vfs: parse: deal with zero length string value"
>>> seems just want to make output more informattive, which probably is not
>>> the one which must be applied immediately to fix the
>>> panic.
>>>
>>> On the other hand, commit "vfs: parse: deal with zero length string value"
>>> affects so many file systems, so there are probably some deeper
>>> null-ptr-deref bugs I ignore, which may take time to review.
>> Yeah, it would be good to make the file system handling consistent
>> but I think there's been a bit too much breakage and it appears not
>> everyone thinks the approach is the right way to do it.
>>
>> I'm thinking of abandoning this and restricting it to the "source"
>> parameter only to solve the user space mount table parser problem but
>> still doing it in the mount context code to keep it general (at least
>> for this case).
> No progress on this problem, and syzbot is reporting one after the other...
>
> I think that reverting is the better choice.

Yes, I agree/


Ian

