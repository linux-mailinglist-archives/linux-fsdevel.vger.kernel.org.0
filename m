Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55899732322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 01:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbjFOXNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 19:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjFOXNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:13:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A92952
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 16:13:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bb167972cffso45940276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686870814; x=1689462814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0BL9jQqU/XGVw4elhsSufWdE9l6+qPNuoKqN07c2CM=;
        b=6GrOQdgkP0IPTkvB/7dDt++fQpu/DLFhFLM7vG/VsboxPl9l0Yf4fGQlgp7uejo1AJ
         X28m8krYfJh7vK05bnsEtu8Yz3gAJXr9QBDXKEOQSWae8Fn2FHSK0TPmKJVy+GLU5Ujk
         MgxovJQXXkU3j6CjPANl+dYxhAVvXKwzlFQQpzwoWs6+eSn8q5IFZ2C+Qwm8Dm2NAoMu
         iJ0XxfahlhrHU4GUWiHtT22vyYf0wB3oLMs/ClAY7ICtqSqE9+d/6hJERE1Xx1v99Hnr
         /DjEH50dEsIRnvYzETOm6/j/RE4EaxS9MIvMeYLtg3YX4ghuEcT84zz96css2fsAKc7U
         fJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686870814; x=1689462814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0BL9jQqU/XGVw4elhsSufWdE9l6+qPNuoKqN07c2CM=;
        b=kSNT/SX68Il/A2CfDojvpUkrkXz+sKSD87h3O3AHjBJCLiVrSP/hRweO2taIWhvVQ5
         Tp2hy0STb8EkwHJnaz0dH4qFNfLl4A78VuGa5tF2JLxCyRaNFNIltLTRq0ntqqo+hMxR
         IiEhakh2sI8XhWUOe8t4FJOgAOEa6Kdvtf4kiRy2gGuIFo4PF9m5DKxintNBMilVYvzX
         24TAWvnvcDzB2QpXkB7Uo8dQaxyAiTvEi5kccszGZwKFDtelGGWHLVZkyLP9hkGJoH4R
         2ateyQnX3QsDGRdkJZfiKsm4DpvXAa8yPPVpCPp1IE9o6t0fB8wZSE5/P/o4oRp1lZCX
         XNLQ==
X-Gm-Message-State: AC+VfDzAWwNyYzkN/Qmnce3uvYD9ctXB7h4O5dfcwJ63ABeU48GufIWy
        mDtv3yOEr041E0DGXqiadIzzbKeps9WB9Oho/fWeQ9YWsGFgY5jxWbU9ZA==
X-Google-Smtp-Source: ACHHUZ7RgzHcT5lrNenGdFvG9m8qBOlLlC9DuSGcESQns0OHuzlcAfDLicdAp/VebvsNRIOATZSJoGhoybADKmVcy/o=
X-Received: by 2002:a25:be8e:0:b0:bc9:cbe:99dc with SMTP id
 i14-20020a25be8e000000b00bc90cbe99dcmr5297617ybk.60.1686870813634; Thu, 15
 Jun 2023 16:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230614070733.113068-1-lujialin4@huawei.com> <20230614174004.GC1146@sol.localdomain>
 <CAJuCfpFROxDn-Yv48zKw5PuiLd_LQ5+b1Nt4+jEw8wHMWcRDWw@mail.gmail.com>
In-Reply-To: <CAJuCfpFROxDn-Yv48zKw5PuiLd_LQ5+b1Nt4+jEw8wHMWcRDWw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 15 Jun 2023 16:13:22 -0700
Message-ID: <CAJuCfpGA4Zy-NAsoFrs7R6MJDO0rW1R2gXCzoVkkcsUzfeXbzA@mail.gmail.com>
Subject: Re: [PATCH v2] poll: Fix use-after-free in poll_freewait()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Lu Jialin <lujialin4@huawei.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:19=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Wed, Jun 14, 2023 at 10:40=E2=80=AFAM Eric Biggers <ebiggers@kernel.or=
g> wrote:
> >
> > On Wed, Jun 14, 2023 at 03:07:33PM +0800, Lu Jialin wrote:
> > > We found a UAF bug in remove_wait_queue as follows:
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x71/0xe0
> > > Write of size 4 at addr ffff8881150d7b28 by task psi_trigger/15306
> > > Call Trace:
> > >  dump_stack+0x9c/0xd3
> > >  print_address_description.constprop.0+0x19/0x170
> > >  __kasan_report.cold+0x6c/0x84
> > >  kasan_report+0x3a/0x50
> > >  check_memory_region+0xfd/0x1f0
> > >  _raw_spin_lock_irqsave+0x71/0xe0
> > >  remove_wait_queue+0x26/0xc0
> > >  poll_freewait+0x6b/0x120
> > >  do_sys_poll+0x305/0x400
> > >  do_syscall_64+0x33/0x40
> > >  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > >
> > > Allocated by task 15306:
> > >  kasan_save_stack+0x1b/0x40
> > >  __kasan_kmalloc.constprop.0+0xb5/0xe0
> > >  psi_trigger_create.part.0+0xfc/0x450
> > >  cgroup_pressure_write+0xfc/0x3b0
> > >  cgroup_file_write+0x1b3/0x390
> > >  kernfs_fop_write_iter+0x224/0x2e0
> > >  new_sync_write+0x2ac/0x3a0
> > >  vfs_write+0x365/0x430
> > >  ksys_write+0xd5/0x1b0
> > >  do_syscall_64+0x33/0x40
> > >  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > >
> > > Freed by task 15850:
> > >  kasan_save_stack+0x1b/0x40
> > >  kasan_set_track+0x1c/0x30
> > >  kasan_set_free_info+0x20/0x40
> > >  __kasan_slab_free+0x151/0x180
> > >  kfree+0xba/0x680
> > >  cgroup_file_release+0x5c/0xe0
> > >  kernfs_drain_open_files+0x122/0x1e0
> > >  kernfs_drain+0xff/0x1e0
> > >  __kernfs_remove.part.0+0x1d1/0x3b0
> > >  kernfs_remove_by_name_ns+0x89/0xf0
> > >  cgroup_addrm_files+0x393/0x3d0
> > >  css_clear_dir+0x8f/0x120
> > >  kill_css+0x41/0xd0
> > >  cgroup_destroy_locked+0x166/0x300
> > >  cgroup_rmdir+0x37/0x140
> > >  kernfs_iop_rmdir+0xbb/0xf0
> > >  vfs_rmdir.part.0+0xa5/0x230
> > >  do_rmdir+0x2e0/0x320
> > >  __x64_sys_unlinkat+0x99/0xc0
> > >  do_syscall_64+0x33/0x40
> > >  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > If using epoll(), wake_up_pollfree will empty waitqueue and set
> > > wait_queue_head is NULL before free waitqueue of psi trigger. But is
> > > doesn't work when using poll(), which will lead a UAF problem in
> > > poll_freewait coms as following:
> > >
> > > (cgroup_rmdir)                      |
> > > psi_trigger_destroy                 |
> > >   wake_up_pollfree(&t->event_wait)  |
> > >    synchronize_rcu();               |
> > >     kfree(t)                        |
> > >                                   |   (poll_freewait)
> > >                                   |     free_poll_entry(pwq->inline_e=
ntries + i)
> > >                                   |       remove_wait_queue(entry->wa=
it_address)
> > >                                   |         spin_lock_irqsave(&wq_hea=
d->lock)
> > >
> > > entry->wait_address in poll_freewait() is t->event_wait in cgroup_rmd=
ir().
> > > t->event_wait is free in psi_trigger_destroy before call poll_freewai=
t(),
> > > therefore wq_head in poll_freewait() has been already freed, which wo=
uld
> > > lead to a UAF.

Hi Lu,
Could you please share your reproducer along with the kernel config
you used? I'm trying to reproduce this UAF but every time I delete the
cgroup being polled, poll() simply returns POLLERR.
Thanks,
Suren.

> > >
> > > similar problem for epoll() has been fixed commit c2dbe32d5db5
> > > ("sched/psi: Fix use-after-free in ep_remove_wait_queue()").
> > > epoll wakeup function ep_poll_callback() will empty waitqueue and set
> > > wait_queue_head is NULL when pollflags is POLLFREE and judge pwq->whe=
ad
> > > is NULL or not before remove_wait_queue in ep_remove_wait_queue(),
> > > which will fix the UAF bug in ep_remove_wait_queue.
> > >
> > > But poll wakeup function pollwake() doesn't do that. To fix the
> > > problem, we empty waitqueue and set wait_address is NULL in pollwake(=
) when
> > > key is POLLFREE. otherwise in remove_wait_queue, which is similar to
> > > epoll().
> > >
> > > Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> > > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > > Link: https://lore.kernel.org/all/CAJuCfpEoCRHkJF-=3D1Go9E94wchB4BzwQ=
1E3vHGWxNe+tEmSJoA@mail.gmail.com/#t
> > > Signed-off-by: Lu Jialin <lujialin4@huawei.com>
> > > ---
> > > v2: correct commit msg and title suggested by Suren Baghdasaryan
> > > ---
> > >  fs/select.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/select.c b/fs/select.c
> > > index 0ee55af1a55c..e64c7b4e9959 100644
> > > --- a/fs/select.c
> > > +++ b/fs/select.c
> > > @@ -132,7 +132,17 @@ EXPORT_SYMBOL(poll_initwait);
> > >
> > >  static void free_poll_entry(struct poll_table_entry *entry)
> > >  {
> > > -     remove_wait_queue(entry->wait_address, &entry->wait);
> > > +     wait_queue_head_t *whead;
> > > +
> > > +     rcu_read_lock();
> > > +     /* If it is cleared by POLLFREE, it should be rcu-safe.
> > > +      * If we read NULL we need a barrier paired with smp_store_rele=
ase()
> > > +      * in pollwake().
> > > +      */
> > > +     whead =3D smp_load_acquire(&entry->wait_address);
> > > +     if (whead)
> > > +             remove_wait_queue(whead, &entry->wait);
> > > +     rcu_read_unlock();
> > >       fput(entry->filp);
> > >  }
> > >
> > > @@ -215,6 +225,14 @@ static int pollwake(wait_queue_entry_t *wait, un=
signed mode, int sync, void *key
> > >       entry =3D container_of(wait, struct poll_table_entry, wait);
> > >       if (key && !(key_to_poll(key) & entry->key))
> > >               return 0;
> > > +     if (key_to_poll(key) & POLLFREE) {
> > > +             list_del_init(&wait->entry);
> > > +             /* wait_address !=3DNULL protects us from the race with
> > > +              * poll_freewait().
> > > +              */
> > > +             smp_store_release(&entry->wait_address, NULL);
> > > +             return 0;
> > > +     }
> > >       return __pollwake(wait, mode, sync, key);
> >
> > I don't understand why this patch is needed.
> >
> > The last time I looked at POLLFREE, it is only needed because of asynch=
ronous
> > polls.  See my explanation in the commit message of commit 50252e4b5e98=
9ce6.
>
> Ah, I missed that. Thanks for the correction.
>
> >
> > In summary, POLLFREE solves the problem of polled waitqueues whose life=
time is
> > tied to the current task rather than to the file being polled.  Also re=
fer to
> > the comment above wake_up_pollfree(), which mentions this.
> >
> > fs/select.c is synchronous polling, not asynchronous.  Therefore, it sh=
ould not
> > need to handle POLLFREE.
> >
> > If there's actually a bug here, most likely it's a bug in psi_trigger_p=
oll()
> > where it is using a waitqueue whose lifetime is tied to neither the cur=
rent task
> > nor the file being polled.  That needs to be fixed.
>
> Yeah. We discussed this issue in
> https://lore.kernel.org/all/CAJuCfpFb0J5ZwO6kncjRG0_4jQLXUy-_dicpH5uGiWP8=
aKYEJQ@mail.gmail.com
> and the root cause is that cgroup_file_release() where
> psi_trigger_destroy() is called is not tied to the cgroup file's real
> lifetime (see my analysis here:
> https://lore.kernel.org/all/CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru=
=3D=3DMdEHQg@mail.gmail.com/#t).
> I guess it's time to do a deeper surgery and figure out a way to call
> psi_trigger_destroy() when the polled cgroup file is actually being
> destroyed. I'll take a closer look into this later today.
> A fix will likely require some cgroup or kernfs code changes, so
> CC'ing Tejun for visibility.
> Thanks,
> Suren.
>
> >
> > - Eric
