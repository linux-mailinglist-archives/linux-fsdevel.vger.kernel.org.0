Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EFD263E52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 09:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgIJHPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbgIJHPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:15:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4B7C061756;
        Thu, 10 Sep 2020 00:15:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a12so5179552eds.13;
        Thu, 10 Sep 2020 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PYvTFQ+A4YAM71gMLAYrqttsL6XopiHaMQSLIkfSeg4=;
        b=DnyeY9UGXLvPTKeSDifoA6oF4MNddPwFaNFMl0e2Ho/3E4mF4P0PqXha3/a9y9Pk72
         0kDqwVGY/CDlIiX9UNGldYk7910AlO6hO+/cdqc/W8RXpNbKLYFE5HKz5Ymb3ITUE1Ri
         p3Ai5slTSnrHin5AcVLAh/0DOus3oFfeDyJ8TJhLGHDfi0DuOkd5Xk32oHZwCXHPeYS/
         PTS/DoYjFfBzXuJ+fl8/LFgBl5Tq/aAsZdpIRjUWWrCBB2foObtGFC1Av2FViywtPenn
         sMYekFGtMuUwNIKVDRM52g/4lhxuLAv+qVLbZnkTw829F+FaIXawvkPYV1IHpMICnyN0
         d+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PYvTFQ+A4YAM71gMLAYrqttsL6XopiHaMQSLIkfSeg4=;
        b=hfg9kDjKJHozJjEokwsxja91bDj1AeqmncII/2TYhKmMnH0/iVefNWEPQsnhWR6ghB
         lvK8C6IIekXNPkVOhTpLzwi4DKAHtXtNOHAiIA4SYFzby7dQhLu0UVZMYIiM/L76flXD
         3Ug4mfkm2GJ3CHXWsZgzKcx02TRNtaxPAAqcGSRuX8vYWSLXSw4obrD1nyPo6pByLV+y
         lSC2Cs6VlbHEGM1CrIpUSy91z3dNZx+vuVhIcGKONxEaEVvh6IHreEEFRlQQEmQXkq/s
         VEX1KbJieZ3wmMAzsldJ9GvE4nbGStL8lIXvQO4oiDcgwi8IqKLNmtyP8p7NGi/ifRda
         yxBA==
X-Gm-Message-State: AOAM531YjpZ6hhlIDGxu8naeDV5X8dOR+7FmxdzF+aoayQwbAY/NHWRN
        QUpfpx6lSR6C35JsxC8EcSs=
X-Google-Smtp-Source: ABdhPJwbvDZtK8W1otGDzENhdSL1h60FEZD2dOhpsPJUh1cDSFU2HIklW10wnGEZT9gHtEHoBXI1oQ==
X-Received: by 2002:a50:f28b:: with SMTP id f11mr7718109edm.44.1599722129674;
        Thu, 10 Sep 2020 00:15:29 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q27sm5507955ejd.74.2020.09.10.00.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 00:15:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 65CF727C0054;
        Thu, 10 Sep 2020 03:15:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 10 Sep 2020 03:15:26 -0400
X-ME-Sender: <xms:jdJZX989laUuIhoIK8JFdPxLc4Pt4b-MGHDcqK02BU9qoI4Wn4W-dQ>
    <xme:jdJZXxvOq0mAhVVZAnqiZ7yJpP6hvKJtGxRdZvkrm3sYxJXwRsYZqHC1elO7MZ1Jo
    Knf7ICx5GqzkLwuXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegueetveeigefhgedvleeutdejjeefhfelfeeuteeigefhgeegteeuieev
    gfeuffenucffohhmrghinheprghpphhsphhothdrtghomhdpghhoohdrghhlnecukfhppe
    ehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhm
    rghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:jdJZX7BblxuUq5gBnJWjAoPc1tjJ3UZkRyXzjURwHuRZf1bSdom1lQ>
    <xmx:jdJZXxeW9SZXFh35If40IHA_yX-P4zAP9rjNEGNdyKmFRl5WoBtpQA>
    <xmx:jdJZXyNW4cYOm9aPugjoYjLz7dUmy-hFwonK2RALde0M7M3lWAMYpw>
    <xmx:jtJZXziQlPPHsb_CB6xlbDtjuKsZWmaC1DFzSnH5SklBdCr5kON650mDiZE>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 520973064683;
        Thu, 10 Sep 2020 03:15:25 -0400 (EDT)
Date:   Thu, 10 Sep 2020 15:15:23 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     syzbot <syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com>
Cc:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: Re: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected (2)
Message-ID: <20200910071523.GF7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <0000000000002cdf7305aedd838d@google.com>
 <000000000000d7136005aee14bf9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d7136005aee14bf9@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks!

On Wed, Sep 09, 2020 at 06:19:06AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit f08e3888574d490b31481eef6d84c61bedba7a47
> Author: Boqun Feng <boqun.feng@gmail.com>
> Date:   Fri Aug 7 07:42:30 2020 +0000
> 
>     lockdep: Fix recursive read lock related safe->unsafe detection
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13034be1900000
> start commit:   dff9f829 Add linux-next specific files for 20200908
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=10834be1900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17034be1900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
> dashboard link: https://syzkaller.appspot.com/bug?extid=22e87cdf94021b984aa6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108b740d900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12daa9ed900000
> 
> Reported-by: syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com
> Fixes: f08e3888574d ("lockdep: Fix recursive read lock related safe->unsafe detection")
> 

This is another deadlock possibility detected by lockdep's new detection
algorithm.

The deadlock happens as follow:

	CPU 0				CPU 1			CPU 2
	read_lock(&fown->lock);
					spin_lock_irqsave(&dev->event_lock, ...)
								write_lock_irq(&filp->f_owner.lock); // wait for the lock
					read_lock(&fown-lock); // have to wait until the writer release
							       // due to the fairness
	<interrupted>
	spin_lock_irqsave(&dev->event_lock); // wait for the lock

The lock dependency on CPU 1 happens if there exists a call sequence:

	input_inject_event():
	  spin_lock_irqsave(&dev->event_lock,...);
	  input_handle_event():
	    input_pass_values():
	      input_to_handler():
	        handler->event(): // evdev_event()
	          evdev_pass_values():
	            spin_lock(&client->buffer_lock);
	            __pass_event():
	              kill_fasync():
	                kill_fasync_rcu():
	                  read_lock(&fa->fa_lock);
	                  send_sigio():
	                    read_lock(&fown->lock);

A possible fix would be replacing the read_lock() with read_lock_irq()
or read_lock_irqsave().

Regards,
Boqun

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
