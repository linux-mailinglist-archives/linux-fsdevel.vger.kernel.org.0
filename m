Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91D5571B99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiGLNoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 09:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGLNoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:44:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167311EEC9;
        Tue, 12 Jul 2022 06:43:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CBEEC5C00E9;
        Tue, 12 Jul 2022 09:43:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 12 Jul 2022 09:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1657633433; x=1657719833; bh=U63C9vKYqb
        yyQVXMseKFJL5UTTd7BOn74sOr5EP6CUM=; b=MbNJjCTtD2flfZ2hTQGRAS++5o
        zqXTGq+UznE4x4bwhzAXZjGutckkgY/Ocyyp12HgJvDlzFepqFGYZmF17v/jSOl3
        3y6O8G434Indwh4khZQygy/2vkyJC07tnXSyd/Vx5krsh36o6cvkjEw5bsnkBSjQ
        +WwdrimTWSyVnlolxA8fK+LFP3TG2nJrFLuxZlTf5Ay1i9H9jvAnTsyslut8AEJf
        paKgHwkmqbT722AYzHjvJxOrb06siNqlGBSGtp2XH7q5ga3x7Ar4nqYMksQGs/+z
        utefzIMLPII2JDzvxZMRhyJjy2bRNcpCfdRDzshYGcUcJayFY0QlRHZEzR+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657633433; x=1657719833; bh=U63C9vKYqbyyQVXMseKFJL5UTTd7
        BOn74sOr5EP6CUM=; b=Fcd2Oxczk3F178MxWy3slksKMXCjtS3pStt7VwHyJlh9
        oeOqT1jZd/vDQlkkKX3kAhe83Gg9aYxBjG/axX8utz7bV0TJSeEErpVHQUFi+yap
        XvvBkBDp68N4OL3TJzF3Gyw2gs2fp2o7SfjmPrSp6bUYnvcOuiZYDDqMzkSOOyfV
        YaEj6PzgQsNzziK8LroD4MwD8kyH578cBQt8EnaiL3iXu84fX+uh/LEnd3bYOsw/
        WsN6sXdYKOjiAU4Jz25nXYuzyetSiWNofU0Qa5KNMOJZjCidMwwyMKu9CwyDAdBP
        daNvSTap4BiXnTwOixZpK66RbYhDlHuxmjJt/Nq54A==
X-ME-Sender: <xms:mXrNYnawa89djn2Npoqukaipkba9TJpnh5_1DObFIOwxlNgP2R4W_Q>
    <xme:mXrNYmZCIlp4zfhQVE2_F1ACQgGXjolI1gZGgE9_s-aE0HO9uqWsNqThZreYa5GON
    T5POOwJrJZ966PslIg>
X-ME-Received: <xmr:mXrNYp9BpsmO-T4taMATWNCnFkgmwW1RGIK29VuWHLVAYCa-W4j_Yd92ZpN5jrrFgfuUVfYo7_EhhknZWlTc0_DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejhedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:mXrNYto2NuAWKLukp4n8J847sCqguZI03M9T3nS4jd6uV8Zcf6he8w>
    <xmx:mXrNYir7mAXxN_dPy51uvn9g8MrP6YxZnF2MFHC8hEehvgh59CdxWw>
    <xmx:mXrNYjRJaUv2FswiBsWi51t9h2PmjTujwJSge4EpZYzK59wWp8WfKg>
    <xmx:mXrNYrku7qinzzomh975e7jnSRpwSH0frA_WiwjU7RHDFpJmgPEQgQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 09:43:52 -0400 (EDT)
Date:   Tue, 12 Jul 2022 07:43:51 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: strange interaction between fuse + pidns
Message-ID: <Ys16l6+iotX2JE33@netflix>
References: <YrShFXRLtRt6T/j+@risky>
 <CAJfpegvH1EMS_469yOyUP9f=eCAEqzhyngm7h=YLRExeRdPEaw@mail.gmail.com>
 <CAJfpegurW7==LEp2yXWMYdBYXTZN4HCMMVJPu-f8yvHVbu79xQ@mail.gmail.com>
 <YsyHMVLuT5U6mm+I@netflix>
 <877d4jbabb.fsf@email.froward.int.ebiederm.org>
 <Ysyp8Kbl8FzhApUb@netflix>
 <87zghf6yhe.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zghf6yhe.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 11, 2022 at 06:06:21PM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> It is not different enough to change the semantics.  What I am aiming
> for is having a dedicated flag indicating a task will exit, that
> fatal_signal_pending can check.  And I intend to make that flag one way
> so that once it is set it will never be cleared.

Ok - how far out is that? I'd like to try to convince Miklos to land
the fuse part of this fix now, but without the "look at shared signals
too" patch, that fix is useless. I'm not married to my patch, but I
would like to get this fixed somehow soon.

> The other thing I have played with that might be relevant was removing
> the explicit wait in zap_pid_ns_processes and simply not allowing wait
> to reap the pid namespace init until all it's children had been reaped.
> Essentially how we deal with the thread group leader for ordinary
> processes.  Does that sound like it might help in the fuse case?

No, the problem is that the wait code doesn't know to look in the
right place, so waiting later still won't help.

Tycho
