Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DAB73EBC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjFZUXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjFZUXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:23:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25BE54
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 13:22:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-be49e41a3d6so2328688276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687810973; x=1690402973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fI8fnnmiPoJmQFuh4c2Nrpo4R9wQpHx0us5ixQXCUds=;
        b=KdBZhNK9qKnNXPXVMCshewDhGg7Rjwd00iMAcpAkvFEiyOvKyUUDf6Gj70sMcJhvdS
         CieDao3SRFumLtCmixoELkXHvRA6DUUWT8JUb+Vi/M/7X0WnqZDPT0LWulcyS+MygSRQ
         nv99lLDbXfVzUxV+bYHmOGxwgbjbP2jEP8z9XDxm4w8/a/FYEtWhvokGMMALfBK6H9Q6
         YZurWzWi1WZh+i/THmo2fCoDpS3PVW29UNdnE9NThl8XqaC/11oB30qV36crKCYvVpqn
         EhKqCAsLl+Ag7Ve8wRos/U9nAXHMuJI2H8MKIArcRC982hha4blm07ZelKTCfR8w4MXr
         hIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687810973; x=1690402973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fI8fnnmiPoJmQFuh4c2Nrpo4R9wQpHx0us5ixQXCUds=;
        b=LkOxGybrNQB8lP/FSSo0AnXpn1ql78xVlcI4tcSPocLWfwFxwCFmTp0gMjYEkLrENA
         Bb+y81WLtDLrREwMGUvCaOsFPd3NVzOrJsjNZGA6xuBdbwpb3OS12OjYNtqxVNmJAs7a
         WQy/XxBfBiTrvNLj8ojqELz2lGw+CvpiRo8eOrhe0GmU1eOe/DhTBdpdW4kVWgTPSJe0
         Kh47XaIWMmIEOtdw4elEYoMVcVGB5fM14Gcy7rVRD5OHWCGNM0RXGVKAsLI5a/w3I514
         fOsOnTYJVg+mY5tYJKPwmIO3KmdjHraPKSBQKd9p+iRwiiDpErfgU8ygo3qIVHLXtIwg
         9oVA==
X-Gm-Message-State: AC+VfDxCoMkRaN4S16g07icY7NiwoWTP+rO5gTK3tYhTZdxUPz2gDh/0
        w6aUaKVFqvoDt2IARKwk8rPnMP3tOxKjbDvzDvOqKQ==
X-Google-Smtp-Source: ACHHUZ7Ed4wZ49HuxYDQ3qXmmOOilO950U2f0OcU5SGc9yN1t8TzDkatSyHczFr7yMGGEkAaw1tnIehtTf5xkQaOnxg=
X-Received: by 2002:a25:abf3:0:b0:bab:ef61:8b31 with SMTP id
 v106-20020a25abf3000000b00babef618b31mr19830542ybi.53.1687810973428; Mon, 26
 Jun 2023 13:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230614070733.113068-1-lujialin4@huawei.com> <20230614174004.GC1146@sol.localdomain>
 <CAJuCfpFROxDn-Yv48zKw5PuiLd_LQ5+b1Nt4+jEw8wHMWcRDWw@mail.gmail.com>
 <CAJuCfpGA4Zy-NAsoFrs7R6MJDO0rW1R2gXCzoVkkcsUzfeXbzA@mail.gmail.com>
 <c83f2076-8dfa-7650-f3c6-bb6884a6729a@huawei.com> <CAJuCfpE2w5e8eCC1exQFDQa_t2F5bzkD1_J8QoJddTrL8nMT6A@mail.gmail.com>
 <CAJuCfpFmvMU9K3JkHsR6RrUYaGFsQ9BVapt2mK=_d7O-tcNa2g@mail.gmail.com>
In-Reply-To: <CAJuCfpFmvMU9K3JkHsR6RrUYaGFsQ9BVapt2mK=_d7O-tcNa2g@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 26 Jun 2023 13:22:42 -0700
Message-ID: <CAJuCfpEx4HsO48+PNR7C5rS0gXdDUQ2UmPEpixPqTaLdB3wANA@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 23, 2023 at 6:58=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Jun 20, 2023 at 5:09=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Sun, Jun 18, 2023 at 6:28=E2=80=AFAM lujialin (A) <lujialin4@huawei.=
com> wrote:
> > >
> > > Hi Suren:
> > >
> > > kernel config:
> > > x86_64_defconfig
> > > CONFIG_PSI=3Dy
> > > CONFIG_SLUB_DEBUG=3Dy
> > > CONFIG_SLUB_DEBUG_ON=3Dy
> > > CONFIG_KASAN=3Dy
> > > CONFIG_KASAN_INLINE=3Dy
> > >
> > > I make some change in code, in order to increase the recurrence proba=
bility.
> > > diff --git a/fs/select.c b/fs/select.c
> > > index 5edffee1162c..5ee5b74a8386 100644
> > > --- a/fs/select.c
> > > +++ b/fs/select.c
> > > @@ -139,6 +139,7 @@ void poll_freewait(struct poll_wqueues *pwq)
> > >   {
> > >          struct poll_table_page * p =3D pwq->table;
> > >          int i;
> > > +       mdelay(50);
> > >          for (i =3D 0; i < pwq->inline_index; i++)
> > >                  free_poll_entry(pwq->inline_entries + i);
> > >          while (p) {
> > >
> > > Here is the simple repo test.sh:
> > > #!/bin/bash
> > >
> > > RESOURCE_TYPES=3D("cpu" "memory" "io" "irq")
> > > #RESOURCE_TYPES=3D("cpu")
> > > cgroup_num=3D50
> > > test_dir=3D/sys/fs/cgroup/test
> > >
> > > function restart_cgroup() {
> > >          num=3D$(expr $RANDOM % $cgroup_num + 1)
> > >          rmdir $test_dir/test_$num
> > >          mkdir $test_dir/test_$num
> > > }
> > >
> > > function create_triggers() {
> > >          num=3D$(expr $RANDOM % $cgroup_num + 1)
> > >          random=3D$(expr $RANDOM % "${#RESOURCE_TYPES[@]}")
> > >          psi_type=3D"${RESOURCE_TYPES[${random}]}"
> > >          ./psi_monitor $test_dir/test_$num $psi_type &
> > > }
> > >
> > > mkdir $test_dir
> > > for i in $(seq 1 $cgroup_num)
> > > do
> > >          mkdir $test_dir/test_$i
> > > done
> > > for j in $(seq 1 100)
> > > do
> > >          restart_cgroup &
> > >          create_triggers &
> > > done
> > >
> > > psi_monitor.c:
> > > #include <errno.h>
> > > #include <fcntl.h>
> > > #include <stdio.h>
> > > #include <poll.h>
> > > #include <string.h>
> > > #include <unistd.h>
> > >
> > > int main(int argc, char *argv[]) {
> > >          const char trig[] =3D "full 1000000 1000000";
> > >          struct pollfd fds;
> > >          char filename[100];
> > >
> > >          sprintf(filename, "%s/%s.pressure", argv[1], argv[2]);
> > >
> > >          fds.fd =3D open(filename, O_RDWR | O_NONBLOCK);
> > >          if (fds.fd < 0) {
> > >                  printf("%s open error: %s\n", filename,strerror(errn=
o));
> > >                  return 1;
> > >          }
> > >          fds.events =3D POLLPRI;
> > >          if (write(fds.fd, trig, strlen(trig) + 1) < 0) {
> > >                  printf("%s write error: %s\n",filename,strerror(errn=
o));
> > >                  return 1;
> > >          }
> > >          while (1) {
> > >                  poll(&fds, 1, -1);
> > >          }
> > >          close(fds.fd);
> > >          return 0;
> > > }
> >
> > Thanks a lot!
> > I'll try to get this reproduced and fixed by the end of this week.
>
> Ok, I was able to reproduce the issue and I think the ultimate problem
> here is that kernfs_release_file() can be called from both
> kernfs_fop_release() and kernfs_drain_open_files(). While
> kernfs_fop_release() is called when the FD's refcount is 0 and there
> are no users, kernfs_drain_open_files() can be called while there are
> still other users. In our scenario, kn->attr.ops->release points to
> cgroup_pressure_release() which destroys the psi trigger thinking that
> (since the file is "released") there could be no other users. So,
> shell process which issues the rmdir command will destroy the trigger
> once cgroup_pressure_release() is called and the reproducer will step
> on the freed wait_queue_head. The way kernfs_release_file() is
> implemented, it ensures that kn->attr.ops->release(of) is called only
> once (the first time), therefore cgroup_pressure_release() is never
> called in reproducer's context. That prevents me from implementing
> some kind of refcounting schema for psi triggers because we are never
> notified when the last user is gone.
> I think to fix this I would need to modify kernfs_release_file() and
> maybe add another operation in kernfs_ops to indicate that the last
> user is gone (smth like final_release()). It's not pretty but so far I
> did not find a better way. I'll think some more over the weekend and
> will try to post a patch implementing the fix on Monday.

Posted 2 patches to fix this at:
https://lore.kernel.org/all/20230626201713.1204982-1-surenb@google.com/
Thanks,
Suren.

> Thanks,
> Suren.
>
>
> > Suren.
> >
> > > Thanks,
> > > Lu
> > > =E5=9C=A8 2023/6/16 7:13, Suren Baghdasaryan =E5=86=99=E9=81=93:
> > > > On Wed, Jun 14, 2023 at 11:19=E2=80=AFAM Suren Baghdasaryan <surenb=
@google.com> wrote:
> > > >>
> > > >> On Wed, Jun 14, 2023 at 10:40=E2=80=AFAM Eric Biggers <ebiggers@ke=
rnel.org> wrote:
> > > >>>
> > > >>> On Wed, Jun 14, 2023 at 03:07:33PM +0800, Lu Jialin wrote:
> > > >>>> We found a UAF bug in remove_wait_queue as follows:
> > > >>>>
> > > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>>> BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x71/0xe0
> > > >>>> Write of size 4 at addr ffff8881150d7b28 by task psi_trigger/153=
06
> > > >>>> Call Trace:
> > > >>>>   dump_stack+0x9c/0xd3
> > > >>>>   print_address_description.constprop.0+0x19/0x170
> > > >>>>   __kasan_report.cold+0x6c/0x84
> > > >>>>   kasan_report+0x3a/0x50
> > > >>>>   check_memory_region+0xfd/0x1f0
> > > >>>>   _raw_spin_lock_irqsave+0x71/0xe0
> > > >>>>   remove_wait_queue+0x26/0xc0
> > > >>>>   poll_freewait+0x6b/0x120
> > > >>>>   do_sys_poll+0x305/0x400
> > > >>>>   do_syscall_64+0x33/0x40
> > > >>>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > > >>>>
> > > >>>> Allocated by task 15306:
> > > >>>>   kasan_save_stack+0x1b/0x40
> > > >>>>   __kasan_kmalloc.constprop.0+0xb5/0xe0
> > > >>>>   psi_trigger_create.part.0+0xfc/0x450
> > > >>>>   cgroup_pressure_write+0xfc/0x3b0
> > > >>>>   cgroup_file_write+0x1b3/0x390
> > > >>>>   kernfs_fop_write_iter+0x224/0x2e0
> > > >>>>   new_sync_write+0x2ac/0x3a0
> > > >>>>   vfs_write+0x365/0x430
> > > >>>>   ksys_write+0xd5/0x1b0
> > > >>>>   do_syscall_64+0x33/0x40
> > > >>>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > > >>>>
> > > >>>> Freed by task 15850:
> > > >>>>   kasan_save_stack+0x1b/0x40
> > > >>>>   kasan_set_track+0x1c/0x30
> > > >>>>   kasan_set_free_info+0x20/0x40
> > > >>>>   __kasan_slab_free+0x151/0x180
> > > >>>>   kfree+0xba/0x680
> > > >>>>   cgroup_file_release+0x5c/0xe0
> > > >>>>   kernfs_drain_open_files+0x122/0x1e0
> > > >>>>   kernfs_drain+0xff/0x1e0
> > > >>>>   __kernfs_remove.part.0+0x1d1/0x3b0
> > > >>>>   kernfs_remove_by_name_ns+0x89/0xf0
> > > >>>>   cgroup_addrm_files+0x393/0x3d0
> > > >>>>   css_clear_dir+0x8f/0x120
> > > >>>>   kill_css+0x41/0xd0
> > > >>>>   cgroup_destroy_locked+0x166/0x300
> > > >>>>   cgroup_rmdir+0x37/0x140
> > > >>>>   kernfs_iop_rmdir+0xbb/0xf0
> > > >>>>   vfs_rmdir.part.0+0xa5/0x230
> > > >>>>   do_rmdir+0x2e0/0x320
> > > >>>>   __x64_sys_unlinkat+0x99/0xc0
> > > >>>>   do_syscall_64+0x33/0x40
> > > >>>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>>>
> > > >>>> If using epoll(), wake_up_pollfree will empty waitqueue and set
> > > >>>> wait_queue_head is NULL before free waitqueue of psi trigger. Bu=
t is
> > > >>>> doesn't work when using poll(), which will lead a UAF problem in
> > > >>>> poll_freewait coms as following:
> > > >>>>
> > > >>>> (cgroup_rmdir)                      |
> > > >>>> psi_trigger_destroy                 |
> > > >>>>    wake_up_pollfree(&t->event_wait)  |
> > > >>>>     synchronize_rcu();               |
> > > >>>>      kfree(t)                        |
> > > >>>>                                    |   (poll_freewait)
> > > >>>>                                    |     free_poll_entry(pwq->in=
line_entries + i)
> > > >>>>                                    |       remove_wait_queue(ent=
ry->wait_address)
> > > >>>>                                    |         spin_lock_irqsave(&=
wq_head->lock)
> > > >>>>
> > > >>>> entry->wait_address in poll_freewait() is t->event_wait in cgrou=
p_rmdir().
> > > >>>> t->event_wait is free in psi_trigger_destroy before call poll_fr=
eewait(),
> > > >>>> therefore wq_head in poll_freewait() has been already freed, whi=
ch would
> > > >>>> lead to a UAF.
> > > >
> > > > Hi Lu,
> > > > Could you please share your reproducer along with the kernel config
> > > > you used? I'm trying to reproduce this UAF but every time I delete =
the
> > > > cgroup being polled, poll() simply returns POLLERR.
> > > > Thanks,
> > > > Suren.
> > > >
> > > >>>>
> > > >>>> similar problem for epoll() has been fixed commit c2dbe32d5db5
> > > >>>> ("sched/psi: Fix use-after-free in ep_remove_wait_queue()").
> > > >>>> epoll wakeup function ep_poll_callback() will empty waitqueue an=
d set
> > > >>>> wait_queue_head is NULL when pollflags is POLLFREE and judge pwq=
->whead
> > > >>>> is NULL or not before remove_wait_queue in ep_remove_wait_queue(=
),
> > > >>>> which will fix the UAF bug in ep_remove_wait_queue.
> > > >>>>
> > > >>>> But poll wakeup function pollwake() doesn't do that. To fix the
> > > >>>> problem, we empty waitqueue and set wait_address is NULL in poll=
wake() when
> > > >>>> key is POLLFREE. otherwise in remove_wait_queue, which is simila=
r to
> > > >>>> epoll().
> > > >>>>
> > > >>>> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> > > >>>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > > >>>> Link: https://lore.kernel.org/all/CAJuCfpEoCRHkJF-=3D1Go9E94wchB=
4BzwQ1E3vHGWxNe+tEmSJoA@mail.gmail.com/#t
> > > >>>> Signed-off-by: Lu Jialin <lujialin4@huawei.com>
> > > >>>> ---
> > > >>>> v2: correct commit msg and title suggested by Suren Baghdasaryan
> > > >>>> ---
> > > >>>>   fs/select.c | 20 +++++++++++++++++++-
> > > >>>>   1 file changed, 19 insertions(+), 1 deletion(-)
> > > >>>>
> > > >>>> diff --git a/fs/select.c b/fs/select.c
> > > >>>> index 0ee55af1a55c..e64c7b4e9959 100644
> > > >>>> --- a/fs/select.c
> > > >>>> +++ b/fs/select.c
> > > >>>> @@ -132,7 +132,17 @@ EXPORT_SYMBOL(poll_initwait);
> > > >>>>
> > > >>>>   static void free_poll_entry(struct poll_table_entry *entry)
> > > >>>>   {
> > > >>>> -     remove_wait_queue(entry->wait_address, &entry->wait);
> > > >>>> +     wait_queue_head_t *whead;
> > > >>>> +
> > > >>>> +     rcu_read_lock();
> > > >>>> +     /* If it is cleared by POLLFREE, it should be rcu-safe.
> > > >>>> +      * If we read NULL we need a barrier paired with smp_store=
_release()
> > > >>>> +      * in pollwake().
> > > >>>> +      */
> > > >>>> +     whead =3D smp_load_acquire(&entry->wait_address);
> > > >>>> +     if (whead)
> > > >>>> +             remove_wait_queue(whead, &entry->wait);
> > > >>>> +     rcu_read_unlock();
> > > >>>>        fput(entry->filp);
> > > >>>>   }
> > > >>>>
> > > >>>> @@ -215,6 +225,14 @@ static int pollwake(wait_queue_entry_t *wai=
t, unsigned mode, int sync, void *key
> > > >>>>        entry =3D container_of(wait, struct poll_table_entry, wai=
t);
> > > >>>>        if (key && !(key_to_poll(key) & entry->key))
> > > >>>>                return 0;
> > > >>>> +     if (key_to_poll(key) & POLLFREE) {
> > > >>>> +             list_del_init(&wait->entry);
> > > >>>> +             /* wait_address !=3DNULL protects us from the race=
 with
> > > >>>> +              * poll_freewait().
> > > >>>> +              */
> > > >>>> +             smp_store_release(&entry->wait_address, NULL);
> > > >>>> +             return 0;
> > > >>>> +     }
> > > >>>>        return __pollwake(wait, mode, sync, key);
> > > >>>
> > > >>> I don't understand why this patch is needed.
> > > >>>
> > > >>> The last time I looked at POLLFREE, it is only needed because of =
asynchronous
> > > >>> polls.  See my explanation in the commit message of commit 50252e=
4b5e989ce6.
> > > >>
> > > >> Ah, I missed that. Thanks for the correction.
> > > >>
> > > >>>
> > > >>> In summary, POLLFREE solves the problem of polled waitqueues whos=
e lifetime is
> > > >>> tied to the current task rather than to the file being polled.  A=
lso refer to
> > > >>> the comment above wake_up_pollfree(), which mentions this.
> > > >>>
> > > >>> fs/select.c is synchronous polling, not asynchronous.  Therefore,=
 it should not
> > > >>> need to handle POLLFREE.
> > > >>>
> > > >>> If there's actually a bug here, most likely it's a bug in psi_tri=
gger_poll()
> > > >>> where it is using a waitqueue whose lifetime is tied to neither t=
he current task
> > > >>> nor the file being polled.  That needs to be fixed.
> > > >>
> > > >> Yeah. We discussed this issue in
> > > >> https://lore.kernel.org/all/CAJuCfpFb0J5ZwO6kncjRG0_4jQLXUy-_dicpH=
5uGiWP8aKYEJQ@mail.gmail.com
> > > >> and the root cause is that cgroup_file_release() where
> > > >> psi_trigger_destroy() is called is not tied to the cgroup file's r=
eal
> > > >> lifetime (see my analysis here:
> > > >> https://lore.kernel.org/all/CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewK=
ReJru=3D=3DMdEHQg@mail.gmail.com/#t).
> > > >> I guess it's time to do a deeper surgery and figure out a way to c=
all
> > > >> psi_trigger_destroy() when the polled cgroup file is actually bein=
g
> > > >> destroyed. I'll take a closer look into this later today.
> > > >> A fix will likely require some cgroup or kernfs code changes, so
> > > >> CC'ing Tejun for visibility.
> > > >> Thanks,
> > > >> Suren.
> > > >>
> > > >>>
> > > >>> - Eric
> > > > .
> > > >
