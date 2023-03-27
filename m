Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16BC6CA52D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjC0NGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 09:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjC0NGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:06:49 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8268A9;
        Mon, 27 Mar 2023 06:06:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A9145C00B0;
        Mon, 27 Mar 2023 09:06:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 Mar 2023 09:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679922406; x=1680008806; bh=CX
        Zqjw6DO5AjfIiN36DH9kZPxN2/wzuNoGnQ8fzH+PE=; b=X0//ka+UUFa9e+F/AF
        ySHE0i1QCYTEEP6x8t6nEFxMHJVjQ9GQYKkGxjng95WavJb58MFtoqVOAy6dHjQ8
        aN8BsoQY/ZYZFhfu5/Iu0Wxuu/YeBwoS+FEyXbaiuvtUbpJNUoBA9IeXu2MKRJ2q
        tE5EiV6rewGYXUs10ZKRF/jCmVsQ/JyhlbCleYDGDpxBlwlxty1wCf4EJws+rG/U
        MlXKJUSmyMRJDvLsuyjP9VCiYn4vQjOXB2UnW/l2Uurl6XVoWroU/V7CRP0trzUR
        ZOXa7gK2DQA+MDSdP7ubTxftTzAUtHYZ4aaoI74CPZO+PGKau9ahamZln2uAzSKq
        9FiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679922406; x=1680008806; bh=CXZqjw6DO5Ajf
        IiN36DH9kZPxN2/wzuNoGnQ8fzH+PE=; b=GwrM/3jfGfQZ0cHOjBirDJ6tGm5IW
        T/N0b/3pfjpl+qrGY5X+2Qz5MWdSou9aVxzvOStqFIXt7orI8SOkaxmRKmIwDI1T
        8eOApRJOunn4tAQ5TNZ7rvJ9cGjdw6evrJIs2OcHYQit5ttTbv7GFkHW4/fUECQ7
        wvxsWkFJpFbauEX0FnSXKl/6D2VWxw85UA/Cq1fq978TM2v9ULmX0YBAb7Djs/bl
        aOyxZPFYWM/nT81JbQaWOsoyY2LAHMWLW2RYAG04WUn1H+VSuYQ3GELOZrDYsGK4
        x2QLbKK4HC1efBwUZ9qfnadCGPWP4oDM0anSu0EF3Hwht8FxKL288/0gw==
X-ME-Sender: <xms:5ZQhZL8wTFbsF0pqQHz0nSaZ9Q990A1pY6Eh3r7beAPeRxzIw-IWUw>
    <xme:5ZQhZHt3Rgz6dCsRz9YHux4zJgRD2h-nsweMAgsFkqaVs0__EQNLcJk6RLV_-DOiA
    X9kNV8lcawdTrvNvL0>
X-ME-Received: <xmr:5ZQhZJC5HVBcdesKvD6WVN08Yzkv5IeNo5UWHJk_dusbLlBIsRWf3fM37NYWa_8a90cEeKaxgwGAfSkHwLlcarIacA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:5ZQhZHfOAge0fPdGj2t6Jv2Q9kLiZfBoIzFGfDZzXmuozdVPVcv4Dw>
    <xmx:5ZQhZAOXqEVBVSzratKy_Uw-iMbW9w1OJlsqI4Gi6o9LjgWU3g4xvQ>
    <xmx:5ZQhZJmaH3I2bQuFxrDbbxRzXhMI2b5HtmE9JG1cP0cdg3wwBKserQ>
    <xmx:5pQhZHfW-OB6wBVjJdkGh3pfQLrJVUPyvjsyoXcffpi56A3xbvCc6g>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 09:06:44 -0400 (EDT)
Date:   Mon, 27 Mar 2023 07:06:44 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <brauner@kernel.org>
Cc:     aloktiagi <aloktiagi@gmail.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David.Laight@aculab.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, hch@infradead.org
Subject: Re: [RFC v4 2/2] file, epoll: Implement do_replace() and
 eventpoll_replace()
Message-ID: <ZCGU5JBg02+DU6JN@tycho.pizza>
References: <20230324063422.1031181-2-aloktiagi@gmail.com>
 <ZBzRfDnHaEycE72s@ip-172-31-38-16.us-west-2.compute.internal>
 <20230324082344.xgze2vu3ds2kubcz@wittgenstein>
 <ZB2o8cs+VTQlz5GA@tycho.pizza>
 <20230327090106.zylztuk77vble7ye@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327090106.zylztuk77vble7ye@wittgenstein>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:01:06AM +0200, Christian Brauner wrote:
> On Fri, Mar 24, 2023 at 07:43:13AM -0600, Tycho Andersen wrote:
> > Perhaps we could add a flag that people could set from SECCOMP_ADDFD
> > asking for this extra behavior?
> 
>         +       if (fd > 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_EPOLL) {
>         +               /*
>         +                * - retrieve old struct file that addfd->fd refered to if any.
>         +                * - call your epoll seccomp api to update the references in the epoll instance
>         +                */
> 			epoll_seccomp_notify()
>         +       }
>         +
>         +       if (fd > 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_IO_URING) {
>         +               /*
>         +                * - call your io_uring seccomp api to update the references in the io_uring instance
>         +                */
> 			io_uring_seccomp_notify()
>         +       }

Looks reasonable to me, thanks.

Tycho
