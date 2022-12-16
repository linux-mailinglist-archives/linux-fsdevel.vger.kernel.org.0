Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4079E64F55C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 00:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLPXyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 18:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLPXyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:54:21 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B64D27CFC;
        Fri, 16 Dec 2022 15:54:20 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id ay32so4014279qtb.11;
        Fri, 16 Dec 2022 15:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNWvhNkvHdAkxkOlPBeECbMH6IGETqYR0jkIh2pLD9U=;
        b=JFVLPMOGKeQ6YL0ru7V0Nnd8JyloRgwYo1r/AF+3WtiQhaulOI0HuzRTMXVFkuJXJJ
         A6zHTWihKYOlcvPmmc5W2bKUteG/bDsBJ9VJ5txvTr+x+T9AxhkZH0pHYAYHiYDDAaGW
         PX2GJz54V1sYGMDuBMopMALVxXBcdf3+Jo9125p48N8DZlVsNa1gaZApATwekrA28xBg
         XAZ7o/0vUXOaAhWgggXCrVr4xrCVVEtAH5GxgFBoDTeke83dTmSpnqbz0IbaVbq6LxZq
         3rx4hWPwg8SZKP02a0u5mos7L0jNqoMEV7mkWMJDW+NrNLeIAXvNWozmXH0MQJM+k8F2
         tSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNWvhNkvHdAkxkOlPBeECbMH6IGETqYR0jkIh2pLD9U=;
        b=VYhkj3HgZwVgTPzSzBgywLPishjms0IKxQR5R7fJ1OlVwRMS9kUpmEXTOldWI4Le3Q
         8hvr8DHk/MghrF9FpoTnrPP9eg+Zm/o9yka/9SkiTM0dP1vU0KQT9V0rBdNHcscrZ7X2
         +DSOdhsispTyZlqsc2ZXMi+TuC6P4mLiPagZAIS4vCJPQjde7+l3pAvO3V4GQW7DwuaF
         4uzXRoDmJJGqxUYN3nhEgWOqmmBmBcFJOoI73hSAOeQw2YhcaAcjJMtl8RBMwrBeHecP
         643PjrPC70/2OKcGihPBx7ihuVrGnbg0LI33in6Bf4/D1NY6Ep52hK9EbRZFVwQxisNX
         6iYg==
X-Gm-Message-State: ANoB5pnH20r8/ZWCsCebZyTFNZzBEjYuAi/Gh+WhQTYX1A1hkKQBii57
        NtY1wWZFfwdxOBo5OUl7h8Y=
X-Google-Smtp-Source: AA0mqf4M0UP+x/kb/+VLMWT+lBrboQrLd2nDFBzmrjXCwyR3FMHzh0Hd4uhv60gjassMOWRwDHQgZQ==
X-Received: by 2002:ac8:72d6:0:b0:3a7:ee15:d94c with SMTP id o22-20020ac872d6000000b003a7ee15d94cmr44950182qtp.47.1671234859177;
        Fri, 16 Dec 2022 15:54:19 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m1-20020ac86881000000b0039a55f78792sm2055750qtq.89.2022.12.16.15.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:54:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1A08D27C0054;
        Fri, 16 Dec 2022 18:54:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 16 Dec 2022 18:54:18 -0500
X-ME-Sender: <xms:KQWdY3rChPDrM1_MWUjw8V_-yj8_I5Bar_PNrTNEIoeSDtREwu7pFQ>
    <xme:KQWdYxqGrguRn5l3zqqSsvXPD_50PnJkcVFtLaQrij1HoRdqFt57e6sdrwo3d3Ylb
    YNGE4zxiy3SXcLTwQ>
X-ME-Received: <xmr:KQWdY0PNIumE0moXXcVI7iGhBvn-nyEtzp8Ahq7BsYnasuSSjm8xCZGdQLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:KQWdY64D4yAf1G-19pEMeJaE79V1JLsV3cZLymVKGo7196VX4qeZzg>
    <xmx:KQWdY26ponr1ggD2eMSFMfjUf0gBNXD6Lr9H9mBIF6eB-a07UAItYQ>
    <xmx:KQWdYyiUyXFeG1stv-YXlds4RaKFhBhhgDmqjmNrYtMqKWhh6w7rXA>
    <xmx:KQWdY-gADdhfLjvHSdiPb47dI7jhES9rX91OskrsP2UaKMugndnD0w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Dec 2022 18:54:16 -0500 (EST)
Date:   Fri, 16 Dec 2022 15:54:09 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible deadlock in __ata_sff_interrupt
Message-ID: <Y50FIckzrV9sWlid@boqun-archlinux>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
 <Y5vo00v2F4zVKeug@ZenIV>
 <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
 <Y50BqT3nSF7+JEzt@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y50BqT3nSF7+JEzt@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:39:21PM +0000, Al Viro wrote:
> [Boqun Feng Cc'd]
> 
> On Fri, Dec 16, 2022 at 03:26:21AM -0800, Linus Torvalds wrote:
> > On Thu, Dec 15, 2022 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > CPU1: ptrace(2)
> > >         ptrace_check_attach()
> > >                 read_lock(&tasklist_lock);
> > >
> > > CPU2: setpgid(2)
> > >         write_lock_irq(&tasklist_lock);
> > >         spins
> > >
> > > CPU1: takes an interrupt that would call kill_fasync().  grep and the
> > > first instance of kill_fasync() is in hpet_interrupt() - it's not
> > > something exotic.  IRQs disabled on CPU2 won't stop it.
> > >         kill_fasync(..., SIGIO, ...)
> > >                 kill_fasync_rcu()
> > >                         read_lock_irqsave(&fa->fa_lock, flags);
> > >                         send_sigio()
> > >                                 read_lock_irqsave(&fown->lock, flags);
> > >                                 read_lock(&tasklist_lock);
> > >
> > > ... and CPU1 spins as well.
> > 
> > Nope. See kernel/locking/qrwlock.c:
> 
> [snip rwlocks are inherently unfair, queued ones are somewhat milder, but
> all implementations have writers-starving behaviour for read_lock() at least
> when in_interrupt()]
> 
> D'oh...  Consider requested "Al, you are a moron" duly delivered...  I plead
> having been on way too low caffeine and too little sleep ;-/
> 
> Looking at the original report, looks like the scenario there is meant to be
> the following:
> 
> CPU1: read_lock(&tasklist_lock)
> 	tasklist_lock grabbed
> 
> CPU2: get an sg write(2) feeding request to libata; host->lock is taken,
> 	request is immediately completed and scsi_done() is about to be called.
> 	host->lock grabbed
> 
> CPU3: write_lock_irq(&tasklist_lock)
> 	spins on tasklist_lock until CPU1 gets through.
> 
> CPU2: get around to kill_fasync() called by sg_rq_end_io() and to grabbing
> 	tasklist_lock inside send_sigio()
> 	spins, since it's not in an interrupt and there's a pending writer
> 	host->lock is held, spin until CPU3 gets through.

Right, for a reader not in_interrupt(), it may be blocked by a random
waiting writer because of the fairness, even the lock is currently held
by a reader:

	CPU 1			CPU 2		CPU 3
	read_lock(&tasklist_lock); // get the lock

						write_lock_irq(&tasklist_lock); // wait for the lock

				read_lock(&tasklist_lock); // cannot get the lock because of the fairness

Regards,
Boqun

> 
> CPU1: take an interrupt, which on libata will try to grab host->lock
> 	tasklist_lock is held, spins on host->lock until CPU2 gets through
> 
> Am I reading it correctly?

