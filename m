Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310556CA55E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjC0NQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 09:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:16:45 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD281985;
        Mon, 27 Mar 2023 06:16:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7CC275C00F3;
        Mon, 27 Mar 2023 09:16:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 Mar 2023 09:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679923003; x=1680009403; bh=PM
        Ybv6lzMtV9aBsvN9bUd8L45MF7C3r1CJYwE0yaT8c=; b=dObTmFqWuQq4O1QxWL
        axiTetLUSGpUp88T5qYMZOgBlWuyrI3p91pD0WcrZxqJspmncBSXXdIA2RHvQzDo
        legvDcHDa2XA7ivgIJUGIzLyYVHzm92gQAK7nFvy9Xvvc3yCSXMzFrpjAymR7L8D
        cQblmLAFh/SjQcB2trKJnHHiKCWpDjXMfbZpydcg50g4i0qZ7Ehxv2p8PNPhaJrh
        cLKaI25cRC2+7vtK5so8eUy8XOpI35khdTpN9SuPofR+ojhwVOzmaE5FXVaVt+LL
        cNGhHD9GpGvlUMg33HncCt+dPBt0VEWvk+CWUt72E8yf0YyOfmlSTJT4DpaHUwXP
        o6Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679923003; x=1680009403; bh=PMYbv6lzMtV9a
        BsvN9bUd8L45MF7C3r1CJYwE0yaT8c=; b=M4Hh45eJ8jVZqVk+rC75IIspBdWrw
        VXTjZZJXIJMfei/INdp9skdKGBm0Nt8AjQTBWJuiRQnUFCs2hvZ7z/rNhYnu3G1Q
        N5ybBP7gPGr6btaD+U0r0cYJ084kUeVAfaqIJPO8E+ADG+MI/k8hp5XGTVL+1omP
        u0T9EGfNlZh6rSgi4EI2acuop2cJhgRjKPtc8BNqUFGouOV+fD9USxfy+qrWEjcw
        RDNs2/HRtEQLpcW2Zq4zGEbmnaGc5riNJRxU5vTZP4Sx1Tf6uB4H0sjkkB5IWt+D
        JLmlw1XixHPsqq1/qOn+561kJszua4nBou2ECKiVxNtn8WxQqD/MLc2Xw==
X-ME-Sender: <xms:O5chZJWIY09st7tvRJB1Olv8Nxz1dIx-G4T4qS_OeJy_J6-c2FSc-w>
    <xme:O5chZJkhaaH_wsZG5bhBCykjO27FdXuQy9TyV0qxcJEvUPHsJkr-vSq-LSwSyTKbh
    5fNJHydYI9NjV3HzKE>
X-ME-Received: <xmr:O5chZFYcX8xys0oNIrYeg9vDijg0w8r143KJ2VhcdLc7iLOTYB6-Eu6SsqkdlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:O5chZMXAH3DmQEklLFJ0MAQg714IPGcf9z_Y64FfvFKBFSXQo5B7XQ>
    <xmx:O5chZDnWlQz_KVL_lkxtIPxSzjRhEqHUZnGqzwqrFM8cXWzfesrsDA>
    <xmx:O5chZJcItmUmZvr4NR_1f2T7hV2zAHPA0s81uvzi-DhzezYS4kj0vQ>
    <xmx:O5chZBVEslk11RufJp5QNts12fsPkagVrs01kzSi1d6bvDBtMXyvuA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 09:16:41 -0400 (EDT)
Date:   Mon, 27 Mar 2023 07:16:39 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <brauner@kernel.org>
Cc:     aloktiagi <aloktiagi@gmail.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David.Laight@aculab.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, hch@infradead.org
Subject: Re: [RFC v4 2/2] file, epoll: Implement do_replace() and
 eventpoll_replace()
Message-ID: <ZCGXNwvymHVJ7O6K@tycho.pizza>
References: <20230324063422.1031181-2-aloktiagi@gmail.com>
 <ZBzRfDnHaEycE72s@ip-172-31-38-16.us-west-2.compute.internal>
 <20230324082344.xgze2vu3ds2kubcz@wittgenstein>
 <ZB2o8cs+VTQlz5GA@tycho.pizza>
 <20230327090106.zylztuk77vble7ye@wittgenstein>
 <ZCGU5JBg02+DU6JN@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCGU5JBg02+DU6JN@tycho.pizza>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:06:46AM -0600, Tycho Andersen wrote:
> On Mon, Mar 27, 2023 at 11:01:06AM +0200, Christian Brauner wrote:
> > On Fri, Mar 24, 2023 at 07:43:13AM -0600, Tycho Andersen wrote:
> > > Perhaps we could add a flag that people could set from SECCOMP_ADDFD
> > > asking for this extra behavior?
> > 
> >         +       if (fd > 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_EPOLL) {
> >         +               /*
> >         +                * - retrieve old struct file that addfd->fd refered to if any.
> >         +                * - call your epoll seccomp api to update the references in the epoll instance
> >         +                */
> > 			epoll_seccomp_notify()
> >         +       }
> >         +
> >         +       if (fd > 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_IO_URING) {
> >         +               /*
> >         +                * - call your io_uring seccomp api to update the references in the io_uring instance
> >         +                */
> > 			io_uring_seccomp_notify()
> >         +       }
> 
> Looks reasonable to me, thanks.

One change I might suggest is only using a single flag bit -- we don't
need to consume all of seccomp's remaining flag bits with the various
subsystems. If you want to do this logic for epoll, you almost
certainly want it for io_uring, select, and whatever else is out
there.

Tycho
