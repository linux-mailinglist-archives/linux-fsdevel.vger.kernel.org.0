Return-Path: <linux-fsdevel+bounces-532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FAB7CC5EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 16:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011DA2819CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6585143AB9;
	Tue, 17 Oct 2023 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4MXkNHxo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFE43AB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 14:28:23 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B723D92
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 07:28:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso186265ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697552902; x=1698157702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSy6qZ9NIRb/OtvKvJDZwAfsawTVlD/Icx0zZ3iDl5M=;
        b=4MXkNHxoh+cfwq61IRicWyudZd9oDFPH351MRtwdFKcz7U/cFQgwi+pkXvvG3FdYW5
         NmQHjWcU8OE9xaEShL71aq+D9TRnWon7PioHTOCgJ09L9nP0i/39LdOFdhkLtYrwkUnd
         76f+pnQXDwQuzz0ptp4HiqBPKs0SULimKYuOYBzH5Ff8XU80ecwDERTD851kttiEjXqY
         bmDwMdsu6Zyk1Zm3fvvxod4RCZS5NrF88kKdC+b0RIP08OeZ+9LVvytg6W83fqbQhxpo
         x1QGwDkcMFJYek+yX0O1foKqlhBz1esqehL92Ae3iZx4XqjvhMTp8Pu/VDquqRSUfQV0
         I/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552902; x=1698157702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSy6qZ9NIRb/OtvKvJDZwAfsawTVlD/Icx0zZ3iDl5M=;
        b=SeV4Ljv9VFG+g4jnLeZFbNovj7nw9NkO5DCFOqJx9jKONimc2chpwf1bMqOXSXuvPZ
         Czy+c3RoqIRodp2bLWPzrP/rks31PoEu/zPLs+WIp4oM2yzZe8l66kZPqfcmspgZacKc
         esX3XQ0xj0bPc6v6oO1kxUmoPp2hdJl2zqV94rm1WMcObRfzeAl6oObj7fAxTC9l+Yoe
         9DnesOv9gqVxPzOI3aTTOlt/vBsYA1PsF/qe2CNzlwh2T+2rBytpztyeKl4zXNHPfKlm
         2B7h/mTrS+ifyjuAY4N4h0UgioAzpSXsr3sml00PGJS2ZnjtS4FYJ++OUvtfVJRTaGYs
         985w==
X-Gm-Message-State: AOJu0YxLdTDeaPrtKWJW+pnQeOj3+YXewkIYpUlYHEII1px7XXQkecCG
	WjDAcZ2YrxwZ2/xlmD+uFR52MHuEvLTy69HxXqjHag==
X-Google-Smtp-Source: AGHT+IFV7iyG/eTlVkxEDinAqhjIRCYTKsczaKYOTW9lPz8RVBI7jHgg2Qn33RXgL6Y8+Q8kiGfcQonBxCsC2JHbx0c=
X-Received: by 2002:a17:903:2003:b0:1c9:bdc9:7f97 with SMTP id
 s3-20020a170903200300b001c9bdc97f97mr8134pla.6.1697552901939; Tue, 17 Oct
 2023 07:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e40a2906072e9567@google.com> <000000000000bc00ea0607e9359d@google.com>
 <20231017141650.GC1599@noisy.programming.kicks-ass.net>
In-Reply-To: <20231017141650.GC1599@noisy.programming.kicks-ass.net>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 17 Oct 2023 16:28:09 +0200
Message-ID: <CANp29Y5B1VvKbe9Z3Bh-7_3jUSok=q9LO=ibjf9R5iDqEZUBVg@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in console_flush_all (2)
To: Peter Zijlstra <peterz@infradead.org>
Cc: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>, 
	adilger.kernel@dilger.ca, bsegall@google.com, dvyukov@google.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you for the information!

I've looked closer -- syzbot is currently fuzzing a somewhat old -next
version now (20231005), it could not upgrade after that because of a
-next boot error
(https://syzkaller.appspot.com/bug?extid=3D6867a9777f4b8dc4e256, already
has a patch). It can explain why we're still seeing these crashes.

Once the fix commit for "linux-next boot error: KASAN:
slab-out-of-bounds Write in vhci_setup" reaches next, it should all be
fine.

And it looks like we should just automatically stop -next fuzzing if
we cannot upgrade the kernel for more than several days in a row..

On Tue, Oct 17, 2023 at 4:16=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Oct 17, 2023 at 06:07:50AM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    213f891525c2 Merge tag 'probes-fixes-v6.6-rc6' of git:/=
/gi..
>
> > list_add corruption. next->prev should be prev (ffff8880b993d228), but =
was caff904900000000. (next=3Dffff8880783659f8).
>
> Urgh, I've not seen that happen before. How reliable does this trigger?
>
> >  __list_add_valid_or_report+0xa2/0x100 lib/list_debug.c:29
> >  __list_add_valid include/linux/list.h:88 [inline]
> >  __list_add include/linux/list.h:150 [inline]
> >  list_add include/linux/list.h:169 [inline]
> >  account_entity_enqueue kernel/sched/fair.c:3534 [inline]
> >  enqueue_entity+0x97b/0x1490 kernel/sched/fair.c:5117
> >  enqueue_task_fair+0x15b/0xbc0 kernel/sched/fair.c:6536
> >  enqueue_task kernel/sched/core.c:2102 [inline]
> >  activate_task kernel/sched/core.c:2132 [inline]
> >  ttwu_do_activate+0x214/0xd90 kernel/sched/core.c:3787
> >  ttwu_queue kernel/sched/core.c:4029 [inline]
> >  try_to_wake_up+0x8e7/0x15b0 kernel/sched/core.c:4346
> >  autoremove_wake_function+0x16/0x150 kernel/sched/wait.c:424
> >  __wake_up_common+0x140/0x5a0 kernel/sched/wait.c:107
> >  __wake_up_common_lock+0xd6/0x140 kernel/sched/wait.c:138
> >  wake_up_klogd_work_func kernel/printk/printk.c:3840 [inline]
> >  wake_up_klogd_work_func+0x90/0xa0 kernel/printk/printk.c:3829
> >  irq_work_single+0x1b5/0x260 kernel/irq_work.c:221
> >  irq_work_run_list kernel/irq_work.c:252 [inline]
> >  irq_work_run_list+0x92/0xc0 kernel/irq_work.c:235
> >  update_process_times+0x1d5/0x220 kernel/time/timer.c:2074
> >  tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:254
> >  tick_sched_timer+0xe9/0x110 kernel/time/tick-sched.c:1492
> >  __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
> >  __hrtimer_run_queues+0x647/0xc10 kernel/time/hrtimer.c:1752
> >  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
> >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1063 [inline]
> >  __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:=
1080
> >  sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1074
> >  </IRQ>

