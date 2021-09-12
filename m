Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C604407D48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Sep 2021 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhILMil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 08:38:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40157 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhILMik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 08:38:40 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 826AB5C00B9;
        Sun, 12 Sep 2021 08:37:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 12 Sep 2021 08:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        content-type:mime-version:subject:from:in-reply-to:date:cc
        :content-transfer-encoding:message-id:references:to; s=fm2; bh=X
        wz5Vf+A/daiSKAVptpMwSmJS3Zi3DYefeKFignzdas=; b=aNvxkJvk0X4k+chHW
        YhwaEKtCvKMNIN96mHHXrEivxpS4WkE7yTscmzNB4sAuCu14P6b7UMOLVAFx/aeF
        nUs19uKkowsP+tvL4DRYEt+7HEu4+hcjsboGEDluSGGbgTEqLJjfGbLOgd/zIokJ
        ngLwG+H6qzcNEYDrzeks1PZQVy37RqBnLKWlGmPpAmfR94/pD/8aESeNcZPQTywo
        w3EqCiGvY8XCQQStocW3+FF/zvtkYEimhB5PSj6U8wuzL+aJvgZZb3gucurrhgzI
        13DC3VDlYWIk6uc23wqn/hqnHkTjeauDqIlODswhNLLNbd4d+ML5gzwU6lIoAMJX
        WzwAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Xwz5Vf+A/daiSKAVptpMwSmJS3Zi3DYefeKFignzd
        as=; b=u1a9vhZXyNLW4mTMO3RSobx3FBrHMFQGmXhjbnCpBTcR8mKQUQuwKHzOY
        JdCPg6quVxXtM7Xuoc54gB2CnBsDBW1/vPbIBiPqY7esvXQePVFsPXNxS5k6PC43
        BS162eYmoX0xyXBIBG7Q0ve5dVGEqoZf4ydtmANEgHfv3dH7lCwKbks83GcltCZK
        6yxm7rRDBYj89967YZbtG5Zo+8dzt7EEVLqZf0WysOYMX+YIy48rQaHvLe4q5yaU
        8nn40srRnXvdh7Wl8fIRASPCC8m7IrMv71r8yOPVrBpAV9tJvDmcURC7xy0rcLwy
        yFjdusdccK1IUmZBcDcpLd5GkBHrQ==
X-ME-Sender: <xms:hvQ9YX6dV_NsaZHVJTEHCs98rbaIoWu7rWdHao6RdkArTJL8PPtmXQ>
    <xme:hvQ9Yc5e6w9peXKkO4QIkvDQUFLO7yufGK9D_E8XnGIRTjMwwiN4HbBBbRhogeQNJ
    O1TZNAe3NpqqoYoEl0>
X-ME-Received: <xmr:hvQ9YefJrD9VYUIW2HdQt1QiqaLS9Cwia9hhSOlbG1k4gVdnYaS2mtvFj5eME5s9gTPqp1EjaLq7KAjclpWKd_3SBl5bO1KxRNyZcCrZPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeghedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthejmhdthhdtvdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpefhteffvdelgedtleevgfeivdetieeitdevhfekgeehfeetffejveefkeeviedv
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:hvQ9YYLtzhGbKYlDad-8dgk9Js5f68UO0mFcjs_xvvwcfUf5q82bsg>
    <xmx:hvQ9YbKwmWrhUT28VIQSH2XdfRNpEc0f0gTW5-tTo20iRx4Bgg_3JQ>
    <xmx:hvQ9YRzELjnGe9ihiPYg9_BpGUONkkS2v8LAHC3v9_USL1LBLIC_1g>
    <xmx:hvQ9YT0RiQxJrjAD7_PQztZo4XxXCZel0-s7V7-TExIV0sy_FuobeQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Sep 2021 08:37:24 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/7] proc/stat: Maintain monotonicity of "intr" and
 "softirq"
From:   Alexei Lozovsky <me@ilammy.net>
In-Reply-To: <YT3In8SWc2eYZ/09@localhost.localdomain>
Date:   Sun, 12 Sep 2021 21:37:20 +0900
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <44F84890-521F-4BCA-9F48-B49D2C8A9E32@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
 <YT3In8SWc2eYZ/09@localhost.localdomain>
To:     Alexey Dobriyan <adobriyan@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 12, 2021, at 18:30, Alexey Dobriyan wrote:
> How about making everything "unsigned long" or even "u64" like NIC
> drivers do?

I see some possible hurdles ahead:

- Not all architectures have atomic operations for 64-bit values

  All those "unsigned int" counters are incremented with __this_cpu_inc()
  which tries to use atomics if possible. Though, I'm not quite sure
  how this works for read side which does not seem to use atomic reads
  at all. I guess, just by the virtue of properly aligned 32-bit reads
  being atomic everywhere? If that's so, I think widening counters to
  64 bits will come with an asterisk.

- We'll need to update all counters to be 64-bit.

  Like, *everyone*. Every field that gets summed up needs to be 64-bit
  (or else wrap-arounds will be incorrect). Basically every counter in
  every irq_cpustat_t will need to become twice as wide. If that's
  a fine price to pay for accurate, full-width counters...

  Previously I thought that some of these counters even come from
  hardware, but now that I'm reviewing them, that does not seem to be
  the case. Thankfully.

So right now I don't see why it shouldn't be doable in theory.
I'll give it a shot, I guess, and see how it works in practice,
at least as far as the patches go (since I can't really test on all
architectures).
