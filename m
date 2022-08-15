Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F1359305F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiHON7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiHON70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:59:26 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D60521279;
        Mon, 15 Aug 2022 06:59:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4020C3200951;
        Mon, 15 Aug 2022 09:59:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Aug 2022 09:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660571952; x=1660658352; bh=avieeFTqme
        6FMbKv6uuCDr9epn/YVsXKNuu4CsdX0I0=; b=WUUOOC3ERVb3rDC/N4vhPVAOFQ
        JoBgdT+mVU5oLxnWLgugeXoQR3bngQAuPs1c4aeHulGZQ2944ZzAZnvqPuwTT7oj
        ifhKWzbCPQCNFHm0j8fnm4vhYiDg1oiT04wptulI2KEpU9ZqXSD740BSNI7KoEAG
        curhDqI+U2fyeN+TDEq4WDH7LFO8Q8oH8WXMI7R9+DT2GZqVpXrdMgcpdyqErXkX
        3QBfVQeflZsB2cx/ZylB5j7U9oH/DMhm6T1yf6wu9hMFiTvEpeN2F2DMrvUZwiRb
        imxb8jsKzIkSJpxCddQliIOGojwp8kqHG3t9w6CMq5gCQl2AqW9UELXPmgzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660571952; x=1660658352; bh=avieeFTqme6FMbKv6uuCDr9epn/Y
        VsXKNuu4CsdX0I0=; b=nUHumxp3CSzchlE6Swleeer1J8MgsY28S7IlNrSSA8uI
        HMRh4dCPu5qXCwFd4YsBhaofiWDqJ+yfGmxofYyAd4dDrjiXjyCwvLWLhXFM9THq
        r4waN3gR/QHT/CyNezTiYLzGlZXqSQQ/J2t0PPz8AW4SpHGp3zSU8mcQBx6QB/nw
        QHMIZ+vT8NRpeRGcJD6oOGw4yFKtwgGJcZM7sNmbFApXt4b7fo0BvcSEDHi7si6d
        jW+l9bdMXSa87dEoUawMxSgVmC93zKfWRQvMmcIoKLy3icDo3BHhuCZ8uYKlyCRd
        0y+9CSYlU3CNslyAIMop1E+RkC+PzLRvw5nr1/A19g==
X-ME-Sender: <xms:L1H6YpOM2fUq-Ziok4oI4Xhh9gxYeH4nYDPyW6lL4jpy9n8GzJPTrg>
    <xme:L1H6Yr8IZ3t2vU_F5Y1PKkMEQQ35VMosDTa9Kxc8Qs1jI_F3lK0CcYjdGDOXcsw6M
    megntRXUOdQESk8ork>
X-ME-Received: <xmr:L1H6YoSrLsbbV9Vgh2bx7lGAYjpJKg7N3XQW6Tfo79-StWeH2rF4DVDS56fXrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:L1H6YlsLiyoEN-vGW9ECOAZjK0nWE4tchFaF1a_ejqAzSVnMnA0L-w>
    <xmx:L1H6Yhdcj6eSQNLNqTEQw1llYSnIdao-JDtiPG8xGhEPTEJPllVb0w>
    <xmx:L1H6Yh184Xxw897AACpnERHgb6kNtBGm_psUlTQGTURWpzq-RAixpw>
    <xmx:MFH6YqGNVnt3ArbsyZ-f7MrbiziWk5z5IzDUYdYPc_kecMG_C7gUaQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 09:59:10 -0400 (EDT)
Date:   Mon, 15 Aug 2022 07:59:08 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v2] fuse: In fuse_flush only wait if someone wants
 the return code
Message-ID: <YvpRLJ79GRWYjLdf@tycho.pizza>
References: <20220728091220.GA11207@redhat.com>
 <YuL9uc8WfiYlb2Hw@tycho.pizza>
 <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
 <YuPlqp0jSvVu4WBK@tycho.pizza>
 <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
 <YuQPc51yXhnBHjIx@tycho.pizza>
 <87h72zes14.fsf_-_@email.froward.int.ebiederm.org>
 <20220729204730.GA3625@redhat.com>
 <YuR4MRL8WxA88il+@ZenIV>
 <875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Sat, Jul 30, 2022 at 12:10:33AM -0500, Eric W. Biederman wrote:
> Al, vfs folks? (igrab/iput sorted so as not to be distractions).

Any movement on this? Can you resend (or I can) the patch with the
fixes for fuse at the very least?

Thanks,
