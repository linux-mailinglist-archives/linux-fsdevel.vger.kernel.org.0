Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6768F64F757
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 04:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLQD0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 22:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiLQD0F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 22:26:05 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B30312AFC;
        Fri, 16 Dec 2022 19:26:03 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j16so4296808qtv.4;
        Fri, 16 Dec 2022 19:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZFufwQyYg181fCKHBWeJHeaNMtdR5JvLzbiBi4xcY8=;
        b=HBrt7nlJLCsonXENX37G0vpixSjSLJxo54OG6IrQm8+aQ461wPnA4H0Sn3pGS6tnTt
         pgt/ay/DImbvyEPjv7+4HWjxMowWXROfwORrumOoO77xXj85YxjdWWEyAqNah4zr+ZEC
         kcCwNXFjDUgioE98jio+K+CklBLhT1Vvieecb5Ohr0mNkqs/YN5nPiw4+5DIEHzuclOZ
         AaAeWtaSerDHHXdOiUifYGGZFy4XJmZ00tfB4NFcJpOqrc6xhH5oHfuwRQf+KXM5uchQ
         X5wPx4eITeZmt0q6IHy39PpXwQBUJlcWMBTDHxDUp1xROzdGi+ku2rN2qSGqROZgbVju
         3tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZFufwQyYg181fCKHBWeJHeaNMtdR5JvLzbiBi4xcY8=;
        b=bG2ImMMIdYhE2XZ0JtR/eszK4cfypPXy9RTPoGADD0t3OEW381gbzyGw6kx7HnWW6X
         XoiwGM6BxfZZp6Yds+ZMmEUDxMH98Vx+ghx2IJsvELXezvY88K1bog/5bsOz2VGQnINb
         2JZSe2VRG9aru/OeZeYvHH/yn3e3nWDzWCsU9F9qsyIg+EdoKi+QwqhHv+iAJX8tHl1m
         iPsl9CwjntlMYNH7DdldFg9u0b7MqYFiWOAenwBu1PYzjw+tsU9RYo8tPkkXpP7Oicr/
         Xhu6R1+j6bjp588fuJiELHyspTRoNRbZlAWYjiy8WPyRJJ98LGNdOzqBHQbrvlHxbJqA
         K9bg==
X-Gm-Message-State: ANoB5pm47uwG40oZSTamDz/tOAxAKjIFS2mza2VedQJxvHTUMmeQHT+/
        keXB4fqmf+3JFN+pmzJGo9c=
X-Google-Smtp-Source: AA0mqf4VVHLxOkc75VU6QfVTfu8KbY3QpnF+kvGmEZs3B/Jx9w7ve3nFpbFunS53UadyIx4vMmuigQ==
X-Received: by 2002:ac8:71cf:0:b0:3a8:104c:11cd with SMTP id i15-20020ac871cf000000b003a8104c11cdmr38290183qtp.35.1671247562434;
        Fri, 16 Dec 2022 19:26:02 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id i22-20020a05620a075600b006ffb452b10asm2741594qki.13.2022.12.16.19.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 19:26:01 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7E95927C0054;
        Fri, 16 Dec 2022 22:26:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 16 Dec 2022 22:26:01 -0500
X-ME-Sender: <xms:yDadYxY5MN1U7R9PXTtpcIaPBWSG6XPC1GS5YFyKhvXIZ3UuxyJpng>
    <xme:yDadY4YuEH3sX2GM41rPpO87GHuh9o5QJry3kcmSK1VwnVvaqEGrAhWffUvPTSQ11
    S6XwuQp7C1hNE1UqA>
X-ME-Received: <xmr:yDadYz-LmNgZk5fLD2TLrIC8TVTYGsricHvBEukDM4Evl1ZVqD6OqKhCmckvCUXxRoX-UZBHwKBheyql9BYI3GYKMLhih8qKtPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddv
    hedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:yDadY_pPBYs7NsTa18UzIdsC75QJwN0o89Ska9mAs1tEKAcvVsit0g>
    <xmx:yDadY8pt2bl0nneWn93sjcnTMfJAdZH7_8ZOJhtWIi_EJ8v5-gVUjg>
    <xmx:yDadY1TXVV3UeGYdy1tXYJPVoDho2XF3MYWjT4LVzY4P1s2pFrOH5A>
    <xmx:yTadYxRnIK-pFJOPVl84fIXl5U90fU-qEhvKp-kVLOrGYFNXicdAPA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Dec 2022 22:26:00 -0500 (EST)
Date:   Fri, 16 Dec 2022 19:25:59 -0800
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
Message-ID: <Y502x/oubigQGIrr@Boquns-Mac-mini.local>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
 <Y5vo00v2F4zVKeug@ZenIV>
 <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
 <Y50BqT3nSF7+JEzt@ZenIV>
 <Y50FIckzrV9sWlid@boqun-archlinux>
 <Y50ihHKFbderCqH1@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y50ihHKFbderCqH1@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 17, 2022 at 01:59:32AM +0000, Al Viro wrote:
> On Fri, Dec 16, 2022 at 03:54:09PM -0800, Boqun Feng wrote:
> > On Fri, Dec 16, 2022 at 11:39:21PM +0000, Al Viro wrote:
> > > [Boqun Feng Cc'd]
> > > 
> > > On Fri, Dec 16, 2022 at 03:26:21AM -0800, Linus Torvalds wrote:
> > > > On Thu, Dec 15, 2022 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > >
> > > > > CPU1: ptrace(2)
> > > > >         ptrace_check_attach()
> > > > >                 read_lock(&tasklist_lock);
> > > > >
> > > > > CPU2: setpgid(2)
> > > > >         write_lock_irq(&tasklist_lock);
> > > > >         spins
> > > > >
> > > > > CPU1: takes an interrupt that would call kill_fasync().  grep and the
> > > > > first instance of kill_fasync() is in hpet_interrupt() - it's not
> > > > > something exotic.  IRQs disabled on CPU2 won't stop it.
> > > > >         kill_fasync(..., SIGIO, ...)
> > > > >                 kill_fasync_rcu()
> > > > >                         read_lock_irqsave(&fa->fa_lock, flags);
> > > > >                         send_sigio()
> > > > >                                 read_lock_irqsave(&fown->lock, flags);
> > > > >                                 read_lock(&tasklist_lock);
> > > > >
> > > > > ... and CPU1 spins as well.
> > > > 
> > > > Nope. See kernel/locking/qrwlock.c:
> > > 
> > > [snip rwlocks are inherently unfair, queued ones are somewhat milder, but
> > > all implementations have writers-starving behaviour for read_lock() at least
> > > when in_interrupt()]
> > > 
> > > D'oh...  Consider requested "Al, you are a moron" duly delivered...  I plead
> > > having been on way too low caffeine and too little sleep ;-/
> > > 
> > > Looking at the original report, looks like the scenario there is meant to be
> > > the following:
> > > 
> > > CPU1: read_lock(&tasklist_lock)
> > > 	tasklist_lock grabbed
> > > 
> > > CPU2: get an sg write(2) feeding request to libata; host->lock is taken,
> > > 	request is immediately completed and scsi_done() is about to be called.
> > > 	host->lock grabbed
> > > 
> > > CPU3: write_lock_irq(&tasklist_lock)
> > > 	spins on tasklist_lock until CPU1 gets through.
> > > 
> > > CPU2: get around to kill_fasync() called by sg_rq_end_io() and to grabbing
> > > 	tasklist_lock inside send_sigio()
> > > 	spins, since it's not in an interrupt and there's a pending writer
> > > 	host->lock is held, spin until CPU3 gets through.
> > 
> > Right, for a reader not in_interrupt(), it may be blocked by a random
> > waiting writer because of the fairness, even the lock is currently held
> > by a reader:
> > 
> > 	CPU 1			CPU 2		CPU 3
> > 	read_lock(&tasklist_lock); // get the lock
> > 
> > 						write_lock_irq(&tasklist_lock); // wait for the lock
> > 
> > 				read_lock(&tasklist_lock); // cannot get the lock because of the fairness
> 
> IOW, any caller of scsi_done() from non-interrupt context while
> holding a spinlock that is also taken in an interrupt...
> 
> And we have drivers/scsi/scsi_error.c:scsi_send_eh_cmnd(), which calls
> ->queuecommand() under a mutex, with
> #define DEF_SCSI_QCMD(func_name) \
>         int func_name(struct Scsi_Host *shost, struct scsi_cmnd *cmd)   \
>         {                                                               \
>                 unsigned long irq_flags;                                \
>                 int rc;                                                 \
>                 spin_lock_irqsave(shost->host_lock, irq_flags);         \
>                 rc = func_name##_lck(cmd);                              \
>                 spin_unlock_irqrestore(shost->host_lock, irq_flags);    \
>                 return rc;                                              \
>         }
> 
> being commonly used for ->queuecommand() instances.  So any scsi_done()
> in foo_lck() (quite a few of such) + use of ->host_lock in interrupt
> for the same driver (also common)...
> 
> I wonder why that hadn't triggered the same warning a long time
> ago - these warnings had been around for at least two years.
> 

FWIW, the complete dependency chain is:

	&host->lock --> &new->fa_lock --> &f->f_owner.lock --> tasklist_lock

for the "&f->f_owner.lock" part to get into lockdep's radar, the
following call trace needs to appear once:

	kill_fasync():
	  kill_fasync_rcu():
	    send_sigio()

not sure whether it's rare or not though. And ->fa_lock also had its own
issue:

	https://lore.kernel.org/lkml/20210702091831.615042-1-desmondcheongzx@gmail.com/

which may have covered &host->lock for a while ;-)

Regards,
Boqun

> Am I missing something here?
