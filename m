Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9941782CD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjHUPCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjHUPCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:02:38 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35567D1;
        Mon, 21 Aug 2023 08:02:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ADC735C271A;
        Mon, 21 Aug 2023 11:02:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 21 Aug 2023 11:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692630152; x=1692716552; bh=x2
        EH9nuzIR6/KmV+lj5VKIPa3WH4/i9ku2KHuJ7oITI=; b=Nf9FOwOfe2cCb8XyUt
        21tO1n6zZTEtIii0VXN4x1J9tcXcJ95Acfye6y0miwYlB9aCnUybl7NRC/vj5sBI
        ZLy8MocYyp3BfsGvCC9DAy5hzk0Xj4xz7FfVPsgAlxpAX+5uFzmqg/8QKZ/AtcdJ
        6MOnzvOHajBx0i0+W023qtW1NPTgcYAvyAVDuclW8uhePtqOt/uSVLtBZJj13lZ3
        1xxY7MhpbbFWZ2KTcjGt3AJDdaQ5uoqB1Kn1Ja8gxab6L10YRGL5psYJgltiViCT
        ZzIgfEUkTwV7pd+YO1xqyFbSce1pgY8E72EHzr/mTWz6xHW20bHhOudk8WihEmr5
        hxsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692630152; x=1692716552; bh=x2EH9nuzIR6/K
        mV+lj5VKIPa3WH4/i9ku2KHuJ7oITI=; b=iYQjkY7NDx7/ChspJRGz9NdNcwqXc
        5V0MutJCh2tlHwMDDsJVhsgZefOTM/Sjk8C8r8Rc0rRvs5HAEvq2/HxSO5kLLbQG
        nYXJpiIjrdQthhtoDgb7Qgm9/37UCc8uzB90TJnw6QM6HBqHNg8OxzQqLjw06tfD
        Hkcg4m5XjjwehpIZyfEgxSV+XSggXxrewnnAhK490wPPpMMOaWSw/mUxDbYctuOF
        JGIRcvYmJxZSObFF7T/F4yEeQGbiQXsvoTM7nBHVHn4oo+DGAlzMp5zLaYUFF4/F
        nTYBNWyLdoypIqxudmXY0IwuyQt/dEjvaHBY2je73/eMk9wk6OiIAXykQ==
X-ME-Sender: <xms:h3zjZCMaXgMh6VmdIqLz5vRU_MCeZONykNh8SpX1QSb9didnzPPa1A>
    <xme:h3zjZA-vxrRjLoTRmoLGtTUXq-vr8iUZKEYiI8KqhYBbwYMb53mP3lS3VcrkJpwfc
    78JLGRKmmrYNid7TCE>
X-ME-Received: <xmr:h3zjZJRbFNUz9LTnFyZ7qUygw9KD8zRRd3nDWFNv2qVqVXG9vXrmCD_EACc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepjeeiiedtkeegvefhfeehgfdvheejgedugeduledtvdejveeijefhvedv
    kefftdehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:iHzjZCtiRQ2pmBVJtjY-xY3_srDNgtpRuxBwgnq3i2Qin1P35E4EqA>
    <xmx:iHzjZKcypQKlrgAVRF3HIP64vWZxu3kOdCLb4qzSgz7zcOGhULR45g>
    <xmx:iHzjZG03s5CBDSK7Xr9yQ_z8EnIDPEgpC7PCgS6lfGJ9MhyrT2ghhQ>
    <xmx:iHzjZJ42sJNmGuPqTFnSMQvxt1m4TAT4M4-xl6ikOrSR2VdfhwHt2A>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Aug 2023 11:02:30 -0400 (EDT)
Date:   Mon, 21 Aug 2023 09:02:28 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async
 fuse_flush
Message-ID: <ZON8hKOAGRvTn83a@tycho.pizza>
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
 <ZNozdrtKgTeTaMpX@tycho.pizza>
 <CAJfpegt6x_=F=mD8LEL4AZPbfCLGQrpurhtbDN4Ew50fd2ngqQ@mail.gmail.com>
 <ZNqseD4hqHWmeF2w@tycho.pizza>
 <CAJfpegtzj7=f99=m49DShDTgLpGAzx8gpHSakgPn0qe+dNjHdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtzj7=f99=m49DShDTgLpGAzx8gpHSakgPn0qe+dNjHdw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:24:00PM +0200, Miklos Szeredi wrote:
> On Tue, 15 Aug 2023 at 00:36, Tycho Andersen <tycho@tycho.pizza> wrote:
> >
> > On Mon, Aug 14, 2023 at 04:35:56PM +0200, Miklos Szeredi wrote:
> > > On Mon, 14 Aug 2023 at 16:00, Tycho Andersen <tycho@tycho.pizza> wrote:
> > >
> > > > It seems like we really do need to wait here. I guess that means we
> > > > need some kind of exit-proof wait?
> > >
> > > Could you please recap the original problem?
> >
> > Sure, the symptom is a deadlock, something like:
> >
> > # cat /proc/1528591/stack
> > [<0>] do_wait+0x156/0x2f0
> > [<0>] kernel_wait4+0x8d/0x140
> > [<0>] zap_pid_ns_processes+0x104/0x180
> > [<0>] do_exit+0xa41/0xb80
> > [<0>] do_group_exit+0x3a/0xa0
> > [<0>] __x64_sys_exit_group+0x14/0x20
> > [<0>] do_syscall_64+0x37/0xb0
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > which is stuck waiting for:
> >
> > # cat /proc/1544574/stack
> > [<0>] request_wait_answer+0x12f/0x210
> > [<0>] fuse_simple_request+0x109/0x2c0
> > [<0>] fuse_flush+0x16f/0x1b0
> > [<0>] filp_close+0x27/0x70
> > [<0>] put_files_struct+0x6b/0xc0
> > [<0>] do_exit+0x360/0xb80
> > [<0>] do_group_exit+0x3a/0xa0
> > [<0>] get_signal+0x140/0x870
> > [<0>] arch_do_signal_or_restart+0xae/0x7c0
> > [<0>] exit_to_user_mode_prepare+0x10f/0x1c0
> > [<0>] syscall_exit_to_user_mode+0x26/0x40
> > [<0>] do_syscall_64+0x46/0xb0
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > I have a reproducer here:
> > https://github.com/tych0/kernel-utils/blob/master/fuse2/Makefile#L7
> 
> The issue seems to be that the server process is recursing into the
> filesystem it is serving (nested_fsync()).  It's quite easy to
> deadlock fuse this way, and I'm not sure why this would be needed for
> any server implementation.   Can you explain?

I think the idea is that they're saving snapshots of their own threads
to the fs for debugging purposes.

Whether this is a sane thing to do or not, it doesn't seem like it
should deadlock pid ns destruction.

Tycho
