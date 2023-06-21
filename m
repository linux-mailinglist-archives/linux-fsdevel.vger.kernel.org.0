Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E08737816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 02:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjFUAKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 20:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFUAKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:10:13 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9710F1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 17:10:11 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so5142040276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687306210; x=1689898210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snxSOAFD2ShvzVzuihyn6AGdpfK5lmnKVj2Wmvy34Ac=;
        b=rSyk4ORe5m+JV2W7BrGnl225+GSluhKn7tLVDDxC5jk3zgjjL+elyS3Kfss93MsdL8
         WnJKKAvRQQTMBq/W66X1JUE4YVoGlxHviGsRXDr8qR57TkGoQx0aJv28rhWpRFzZdTjf
         ewGR/aqVnvpQPIz1sf3yLT+zNq3ayDiEfhJHZhzRI3kSsn2qthPisE7xSzmNrnBYmGm7
         YRz5Ynxzs2CmgP1ETLsNd3sRZLqzvc+1xoDwjSx8rph82iv3+/UgJGw9d/wWsaLKkKFH
         QiGm4EVZsbwAHtJD6oAIT+P/C4j5LUFu7wCbsaGonXuPgfaB/X5qio5SlVpX/zRMqxMI
         D9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687306210; x=1689898210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snxSOAFD2ShvzVzuihyn6AGdpfK5lmnKVj2Wmvy34Ac=;
        b=IttrAa1vA6jP/vOC9ZOifUCv4NW9jMNEyzeSNhFLHRJSTz8GqC1Cxwn6oYKneDO+/U
         WIdCrL9+mJXiQKQXRFyKEJXxF+4pa8i+HrAoIlwl58rKnGXyhxsaK47gfVDMrEdB7XSS
         bRzpmEfWYx3hV43/GPqZSP5jz9700luRf4YYDbTB+MVmVb3eD0N8bOYVzc404btXFI1R
         SiinYbarYIhghbgjdaYS+Hwd7Ip1xMuhg8DDcYQNMONv+vhkikd5IviNAUqPoz1V5gpk
         c5yRnV3qwmbN9NNX1GofS+NKK3xc9GpzPUs71secksqNZ2zLDrtpvYXnLxvKzzcpdNcD
         NvJw==
X-Gm-Message-State: AC+VfDwlaI+cKXkREMiptdveQrIxqEQxSkhFDi2vWCkiyU5FOG0d+TIK
        nt9zXf/62jNtFwLHXVgYxv91gFnq2bgKN1FJ+WTfwQ==
X-Google-Smtp-Source: ACHHUZ6L2pdPuxAa9H3NucwF4ih9dViSIpoDsRzh3cwOiL0hGw6bpM5yKlOyXlRZCSOI7/Uc/R25c9eMh3P35w1B/UM=
X-Received: by 2002:a25:ae06:0:b0:ba8:5fd6:e657 with SMTP id
 a6-20020a25ae06000000b00ba85fd6e657mr9613065ybj.49.1687306210329; Tue, 20 Jun
 2023 17:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230614070733.113068-1-lujialin4@huawei.com> <20230614174004.GC1146@sol.localdomain>
 <CAJuCfpFROxDn-Yv48zKw5PuiLd_LQ5+b1Nt4+jEw8wHMWcRDWw@mail.gmail.com>
 <CAJuCfpGA4Zy-NAsoFrs7R6MJDO0rW1R2gXCzoVkkcsUzfeXbzA@mail.gmail.com> <c83f2076-8dfa-7650-f3c6-bb6884a6729a@huawei.com>
In-Reply-To: <c83f2076-8dfa-7650-f3c6-bb6884a6729a@huawei.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 20 Jun 2023 17:09:59 -0700
Message-ID: <CAJuCfpE2w5e8eCC1exQFDQa_t2F5bzkD1_J8QoJddTrL8nMT6A@mail.gmail.com>
Subject: Re: [PATCH v2] poll: Fix use-after-free in poll_freewait()
To:     "lujialin (A)" <lujialin4@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 18, 2023 at 6:28=E2=80=AFAM lujialin (A) <lujialin4@huawei.com>=
 wrote:
>
> Hi Suren:
>
> kernel config:
> x86_64_defconfig
> CONFIG_PSI=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> CONFIG_SLUB_DEBUG_ON=3Dy
> CONFIG_KASAN=3Dy
> CONFIG_KASAN_INLINE=3Dy
>
> I make some change in code, in order to increase the recurrence probabili=
ty.
> diff --git a/fs/select.c b/fs/select.c
> index 5edffee1162c..5ee5b74a8386 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -139,6 +139,7 @@ void poll_freewait(struct poll_wqueues *pwq)
>   {
>          struct poll_table_page * p =3D pwq->table;
>          int i;
> +       mdelay(50);
>          for (i =3D 0; i < pwq->inline_index; i++)
>                  free_poll_entry(pwq->inline_entries + i);
>          while (p) {
>
> Here is the simple repo test.sh:
> #!/bin/bash
>
> RESOURCE_TYPES=3D("cpu" "memory" "io" "irq")
> #RESOURCE_TYPES=3D("cpu")
> cgroup_num=3D50
> test_dir=3D/sys/fs/cgroup/test
>
> function restart_cgroup() {
>          num=3D$(expr $RANDOM % $cgroup_num + 1)
>          rmdir $test_dir/test_$num
>          mkdir $test_dir/test_$num
> }
>
> function create_triggers() {
>          num=3D$(expr $RANDOM % $cgroup_num + 1)
>          random=3D$(expr $RANDOM % "${#RESOURCE_TYPES[@]}")
>          psi_type=3D"${RESOURCE_TYPES[${random}]}"
>          ./psi_monitor $test_dir/test_$num $psi_type &
> }
>
> mkdir $test_dir
> for i in $(seq 1 $cgroup_num)
> do
>          mkdir $test_dir/test_$i
> done
> for j in $(seq 1 100)
> do
>          restart_cgroup &
>          create_triggers &
> done
>
> psi_monitor.c:
> #include <errno.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <poll.h>
> #include <string.h>
> #include <unistd.h>
>
> int main(int argc, char *argv[]) {
>          const char trig[] =3D "full 1000000 1000000";
>          struct pollfd fds;
>          char filename[100];
>
>          sprintf(filename, "%s/%s.pressure", argv[1], argv[2]);
>
>          fds.fd =3D open(filename, O_RDWR | O_NONBLOCK);
>          if (fds.fd < 0) {
>                  printf("%s open error: %s\n", filename,strerror(errno));
>                  return 1;
>          }
>          fds.events =3D POLLPRI;
>          if (write(fds.fd, trig, strlen(trig) + 1) < 0) {
>                  printf("%s write error: %s\n",filename,strerror(errno));
>                  return 1;
>          }
>          while (1) {
>                  poll(&fds, 1, -1);
>          }
>          close(fds.fd);
>          return 0;
> }

Thanks a lot!
I'll try to get this reproduced and fixed by the end of this week.
Suren.

> Thanks,
> Lu
> =E5=9C=A8 2023/6/16 7:13, Suren Baghdasaryan =E5=86=99=E9=81=93:
> > On Wed, Jun 14, 2023 at 11:19=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> >>
> >> On Wed, Jun 14, 2023 at 10:40=E2=80=AFAM Eric Biggers <ebiggers@kernel=
.org> wrote:
> >>>
> >>> On Wed, Jun 14, 2023 at 03:07:33PM +0800, Lu Jialin wrote:
> >>>> We found a UAF bug in remove_wait_queue as follows:
> >>>>
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x71/0xe0
> >>>> Write of size 4 at addr ffff8881150d7b28 by task psi_trigger/15306
> >>>> Call Trace:
> >>>>   dump_stack+0x9c/0xd3
> >>>>   print_address_description.constprop.0+0x19/0x170
> >>>>   __kasan_report.cold+0x6c/0x84
> >>>>   kasan_report+0x3a/0x50
> >>>>   check_memory_region+0xfd/0x1f0
> >>>>   _raw_spin_lock_irqsave+0x71/0xe0
> >>>>   remove_wait_queue+0x26/0xc0
> >>>>   poll_freewait+0x6b/0x120
> >>>>   do_sys_poll+0x305/0x400
> >>>>   do_syscall_64+0x33/0x40
> >>>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >>>>
> >>>> Allocated by task 15306:
> >>>>   kasan_save_stack+0x1b/0x40
> >>>>   __kasan_kmalloc.constprop.0+0xb5/0xe0
> >>>>   psi_trigger_create.part.0+0xfc/0x450
> >>>>   cgroup_pressure_write+0xfc/0x3b0
> >>>>   cgroup_file_write+0x1b3/0x390
> >>>>   kernfs_fop_write_iter+0x224/0x2e0
> >>>>   new_sync_write+0x2ac/0x3a0
> >>>>   vfs_write+0x365/0x430
> >>>>   ksys_write+0xd5/0x1b0
> >>>>   do_syscall_64+0x33/0x40
> >>>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >>>>
> >>>> Freed by task 15850:
> >>>>   kasan_save_stack+0x1b/0x40
> >>>>   kasan_set_track+0x1c/0x30
> >>>>   kasan_set_free_info+0x20/0x40
> >>>>   __kasan_slab_free+0x151/0x180
> >>>>   kfree+0xba/0x680
> >>>>   cgroup_file_release+0x5c/0xe0
> >>>>   kernfs_drain_open_files+0x122/0x1e0
> >>>>   kernfs_drain+0xff/0x1e0
> >>>>   __kernfs_remove.part.0+0x1d1/0x3b0
> >>>>   kernfs_remove_by_name_ns+0x89/0xf0
> >>>>   cgroup_addrm_files+0x393/0x3d0
> >>>>   css_clear_dir+0x8f/0x120
> >>>>   kill_css+0x41/0xd0
> >>>>   cgroup_destroy_locked+0x166/0x300
> >>>>   cgroup_rmdir+0x37/0x140
> >>>>   kernfs_iop_rmdir+0xbb/0xf0
> >>>>   vfs_rmdir.part.0+0xa5/0x230
> >>>>   do_rmdir+0x2e0/0x320
> >>>>   __x64_sys_unlinkat+0x99/0xc0
> >>>>   do_syscall_64+0x33/0x40
> >>>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> If using epoll(), wake_up_pollfree will empty waitqueue and set
> >>>> wait_queue_head is NULL before free waitqueue of psi trigger. But is
> >>>> doesn't work when using poll(), which will lead a UAF problem in
> >>>> poll_freewait coms as following:
> >>>>
> >>>> (cgroup_rmdir)                      |
> >>>> psi_trigger_destroy                 |
> >>>>    wake_up_pollfree(&t->event_wait)  |
> >>>>     synchronize_rcu();               |
> >>>>      kfree(t)                        |
> >>>>                                    |   (poll_freewait)
> >>>>                                    |     free_poll_entry(pwq->inline=
_entries + i)
> >>>>                                    |       remove_wait_queue(entry->=
wait_address)
> >>>>                                    |         spin_lock_irqsave(&wq_h=
ead->lock)
> >>>>
> >>>> entry->wait_address in poll_freewait() is t->event_wait in cgroup_rm=
dir().
> >>>> t->event_wait is free in psi_trigger_destroy before call poll_freewa=
it(),
> >>>> therefore wq_head in poll_freewait() has been already freed, which w=
ould
> >>>> lead to a UAF.
> >
> > Hi Lu,
> > Could you please share your reproducer along with the kernel config
> > you used? I'm trying to reproduce this UAF but every time I delete the
> > cgroup being polled, poll() simply returns POLLERR.
> > Thanks,
> > Suren.
> >
> >>>>
> >>>> similar problem for epoll() has been fixed commit c2dbe32d5db5
> >>>> ("sched/psi: Fix use-after-free in ep_remove_wait_queue()").
> >>>> epoll wakeup function ep_poll_callback() will empty waitqueue and se=
t
> >>>> wait_queue_head is NULL when pollflags is POLLFREE and judge pwq->wh=
ead
> >>>> is NULL or not before remove_wait_queue in ep_remove_wait_queue(),
> >>>> which will fix the UAF bug in ep_remove_wait_queue.
> >>>>
> >>>> But poll wakeup function pollwake() doesn't do that. To fix the
> >>>> problem, we empty waitqueue and set wait_address is NULL in pollwake=
() when
> >>>> key is POLLFREE. otherwise in remove_wait_queue, which is similar to
> >>>> epoll().
> >>>>
> >>>> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> >>>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> >>>> Link: https://lore.kernel.org/all/CAJuCfpEoCRHkJF-=3D1Go9E94wchB4Bzw=
Q1E3vHGWxNe+tEmSJoA@mail.gmail.com/#t
> >>>> Signed-off-by: Lu Jialin <lujialin4@huawei.com>
> >>>> ---
> >>>> v2: correct commit msg and title suggested by Suren Baghdasaryan
> >>>> ---
> >>>>   fs/select.c | 20 +++++++++++++++++++-
> >>>>   1 file changed, 19 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/select.c b/fs/select.c
> >>>> index 0ee55af1a55c..e64c7b4e9959 100644
> >>>> --- a/fs/select.c
> >>>> +++ b/fs/select.c
> >>>> @@ -132,7 +132,17 @@ EXPORT_SYMBOL(poll_initwait);
> >>>>
> >>>>   static void free_poll_entry(struct poll_table_entry *entry)
> >>>>   {
> >>>> -     remove_wait_queue(entry->wait_address, &entry->wait);
> >>>> +     wait_queue_head_t *whead;
> >>>> +
> >>>> +     rcu_read_lock();
> >>>> +     /* If it is cleared by POLLFREE, it should be rcu-safe.
> >>>> +      * If we read NULL we need a barrier paired with smp_store_rel=
ease()
> >>>> +      * in pollwake().
> >>>> +      */
> >>>> +     whead =3D smp_load_acquire(&entry->wait_address);
> >>>> +     if (whead)
> >>>> +             remove_wait_queue(whead, &entry->wait);
> >>>> +     rcu_read_unlock();
> >>>>        fput(entry->filp);
> >>>>   }
> >>>>
> >>>> @@ -215,6 +225,14 @@ static int pollwake(wait_queue_entry_t *wait, u=
nsigned mode, int sync, void *key
> >>>>        entry =3D container_of(wait, struct poll_table_entry, wait);
> >>>>        if (key && !(key_to_poll(key) & entry->key))
> >>>>                return 0;
> >>>> +     if (key_to_poll(key) & POLLFREE) {
> >>>> +             list_del_init(&wait->entry);
> >>>> +             /* wait_address !=3DNULL protects us from the race wit=
h
> >>>> +              * poll_freewait().
> >>>> +              */
> >>>> +             smp_store_release(&entry->wait_address, NULL);
> >>>> +             return 0;
> >>>> +     }
> >>>>        return __pollwake(wait, mode, sync, key);
> >>>
> >>> I don't understand why this patch is needed.
> >>>
> >>> The last time I looked at POLLFREE, it is only needed because of asyn=
chronous
> >>> polls.  See my explanation in the commit message of commit 50252e4b5e=
989ce6.
> >>
> >> Ah, I missed that. Thanks for the correction.
> >>
> >>>
> >>> In summary, POLLFREE solves the problem of polled waitqueues whose li=
fetime is
> >>> tied to the current task rather than to the file being polled.  Also =
refer to
> >>> the comment above wake_up_pollfree(), which mentions this.
> >>>
> >>> fs/select.c is synchronous polling, not asynchronous.  Therefore, it =
should not
> >>> need to handle POLLFREE.
> >>>
> >>> If there's actually a bug here, most likely it's a bug in psi_trigger=
_poll()
> >>> where it is using a waitqueue whose lifetime is tied to neither the c=
urrent task
> >>> nor the file being polled.  That needs to be fixed.
> >>
> >> Yeah. We discussed this issue in
> >> https://lore.kernel.org/all/CAJuCfpFb0J5ZwO6kncjRG0_4jQLXUy-_dicpH5uGi=
WP8aKYEJQ@mail.gmail.com
> >> and the root cause is that cgroup_file_release() where
> >> psi_trigger_destroy() is called is not tied to the cgroup file's real
> >> lifetime (see my analysis here:
> >> https://lore.kernel.org/all/CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJr=
u=3D=3DMdEHQg@mail.gmail.com/#t).
> >> I guess it's time to do a deeper surgery and figure out a way to call
> >> psi_trigger_destroy() when the polled cgroup file is actually being
> >> destroyed. I'll take a closer look into this later today.
> >> A fix will likely require some cgroup or kernfs code changes, so
> >> CC'ing Tejun for visibility.
> >> Thanks,
> >> Suren.
> >>
> >>>
> >>> - Eric
> > .
> >
