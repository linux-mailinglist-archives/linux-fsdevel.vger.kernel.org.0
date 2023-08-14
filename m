Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3877C38C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 00:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjHNWhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjHNWgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:36:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836E98;
        Mon, 14 Aug 2023 15:36:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6078332004E7;
        Mon, 14 Aug 2023 18:36:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 18:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692052604; x=1692139004; bh=aj
        1uyDV78Du+3ZCPu4kabiwDe7pIihAf2jz8M5tL4JM=; b=h9pUt3siHysgPhnWmQ
        3Z2kfwYatcYuuxJmS5NfO9EAdU1yHHnIqlu1KkSxbeGuDkpCTNVpZ2viD/sYOKci
        S4ABOkGXC2nUBtVOkEEGvn/ymy3lZh6xB5CL0NGQPkUgDw/z1KCMFdv2fxbQy4oT
        e07V7FLc1ZXdvaMYkAyV+pufXJANkP0saH4xquN3iNoamFdxjhGm2TuJPN/Q81Ec
        KTw6FjQu3iENDOIcvKRUXBH4/5pZkr5HEb2LOJ8TqXNBd60uG71gEU1J55nG9xzk
        L/1rz2Tq9vf4qT4nWE6wZNjg1wyQQjuyaR+J/hCxmA0SYj+/S99kBBTP9Sw1S0+X
        sc2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692052604; x=1692139004; bh=aj1uyDV78Du+3
        ZCPu4kabiwDe7pIihAf2jz8M5tL4JM=; b=di3qcdlZz8TAAtJfBuFtPfYXFXOJE
        Q/HObj5Na/Yiq3qw6XmIZMfeidYo47gahzJnWkHKUMcftvZXdqDBrHARd0xL6xIp
        si1j/XThsBTGcet12D/Y8asJFcYPoZmS6fXLd7W/QIni0rUljkf/3FQyKBtNAuvw
        pMeuqYT3wcZxwraEk9Nd36ALzPYY7N+4SvLH7XjvX9hBEQ2hSYlBq5x+Gt5ZYeyI
        L088Lzc3g/FJe3Mo9Nhg/D2Vh0/k5x6iSpkuHo9zaXUcJoAxCZD3Kfcdm4YjtAKA
        MNv2t0/UTaqY5Hcv1gRchp36rZFkk7hFQLZ/ZCV5PYdLROeIZ4nT4FKnQ==
X-ME-Sender: <xms:e6zaZIKrYNdNBF7Nw4XfYbp3Scb4GCblEj0U6uK3e-ikd6frq6dU5w>
    <xme:e6zaZILuDa61fh9kOxf1WWNqGVTFrigMsSDdemwnRkuCSLCACu3tvWkL1pXoc6VHP
    OKQowGi_w9mns2cqNU>
X-ME-Received: <xmr:e6zaZIuxbzPTqYWWuSH1rmHZgLVK0C6-T7zp2Co6G_1UPaI1YnMbNcv4D-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtiedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepjeeiiedtkeegvefhfeehgfdvheejgedugeduledtvdejveeijefhvedv
    kefftdehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:fKzaZFbmGLsHsTyt4xv97KqRwOpcUB6UODAFhe6mbgrSFOucrj6BOg>
    <xmx:fKzaZPYaFzCWPpfyVXhNEZ8PkVXv9LfPVZJ-_knb98IIgdiYUWwZhw>
    <xmx:fKzaZBAbvusAwsQi-EbrG_-f-8n1vyh_IYDFS7XpacZS0OLzOnssnA>
    <xmx:fKzaZOVaDK_wN2xEOHZsoYJmp6XGLr1YeZochmaxGZf66LF5AJ1uEw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 18:36:42 -0400 (EDT)
Date:   Mon, 14 Aug 2023 16:36:40 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async
 fuse_flush
Message-ID: <ZNqseD4hqHWmeF2w@tycho.pizza>
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
 <ZNozdrtKgTeTaMpX@tycho.pizza>
 <CAJfpegt6x_=F=mD8LEL4AZPbfCLGQrpurhtbDN4Ew50fd2ngqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt6x_=F=mD8LEL4AZPbfCLGQrpurhtbDN4Ew50fd2ngqQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 04:35:56PM +0200, Miklos Szeredi wrote:
> On Mon, 14 Aug 2023 at 16:00, Tycho Andersen <tycho@tycho.pizza> wrote:
> 
> > It seems like we really do need to wait here. I guess that means we
> > need some kind of exit-proof wait?
> 
> Could you please recap the original problem?

Sure, the symptom is a deadlock, something like:

# cat /proc/1528591/stack
[<0>] do_wait+0x156/0x2f0
[<0>] kernel_wait4+0x8d/0x140
[<0>] zap_pid_ns_processes+0x104/0x180
[<0>] do_exit+0xa41/0xb80
[<0>] do_group_exit+0x3a/0xa0
[<0>] __x64_sys_exit_group+0x14/0x20
[<0>] do_syscall_64+0x37/0xb0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

which is stuck waiting for:

# cat /proc/1544574/stack
[<0>] request_wait_answer+0x12f/0x210
[<0>] fuse_simple_request+0x109/0x2c0
[<0>] fuse_flush+0x16f/0x1b0
[<0>] filp_close+0x27/0x70
[<0>] put_files_struct+0x6b/0xc0
[<0>] do_exit+0x360/0xb80
[<0>] do_group_exit+0x3a/0xa0
[<0>] get_signal+0x140/0x870
[<0>] arch_do_signal_or_restart+0xae/0x7c0
[<0>] exit_to_user_mode_prepare+0x10f/0x1c0
[<0>] syscall_exit_to_user_mode+0x26/0x40
[<0>] do_syscall_64+0x46/0xb0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

I have a reproducer here:
https://github.com/tych0/kernel-utils/blob/master/fuse2/Makefile#L7

The problem is that the second thread has called do_exit() ->
exit_signals(), but then tries to request_wait_answer() which uses the
core wait primitives that no longer get woken up from signals due to
the code in exit_signals(). So when we try to exit the pid ns, the
whole cleanup hangs.

It seems we really do need to wait in do_exit(), otherwise we get
the behavior described in this regression...

Tycho
