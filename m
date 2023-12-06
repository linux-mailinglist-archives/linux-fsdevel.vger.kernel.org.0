Return-Path: <linux-fsdevel+bounces-4953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FE58069BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 09:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4B4B20793
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E26C1A711
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk0GZpJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F1398;
	Wed,  6 Dec 2023 00:23:36 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2963274a12.0;
        Wed, 06 Dec 2023 00:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701851016; x=1702455816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0LwbusvQAa95t36P39uX2HIsyGAgVBDxOy6DS+pmFA=;
        b=Uk0GZpJTF4VYNEupxl6WCsr1xnAtYn4z7UqH1My3K4zN0DLgz9VgNXC5nJtZJ8n/+P
         ZeXJG9Q0R1lU9m8mOvFlzdajwTWfIcnXjOiSJ/7k9BbIZdH1fbTaKacpKnCcTdtC6KFl
         CFSU1nIMLzgqEMnVmYYEAgSyFDAncXi2Xp1scgIKLHi/vY16308T94QKypVOhraytuox
         IU+PTYubCgVYsJ190AjVlBMmc1/gQ87haKd/wkAu+ybp5/7lLW/Uk5U1hIAi2A3UTDi4
         ut8wbFmPsKn8KQasZ8MFGSaz06VQ0UM83i04nVpgRlDYfI3vhzjTsBECWJv/t7iq7v0F
         wM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701851016; x=1702455816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0LwbusvQAa95t36P39uX2HIsyGAgVBDxOy6DS+pmFA=;
        b=DhpqmXbZCdVS3LtArZFM2GGilstLal8O/uGmm/eIbvH+jdMgAsiZAcoLMExOn0k/JO
         IkHyGfa2rk+zVcT9o90ww2QJQ3F5MEKVq02LfVySM9DJoyFMMsHHf0DN6NpdSzNM8Gix
         BCygXwMsqDKZ3IWzOYMYTh4mheG3bLCzszmmpLZzvKade+OwzsYD0ehA1cJefztikoct
         /hDQq5UtRJIw4pGYS6mKrq26u05jBxP+2pAp9NIE1t7SzNucds73336fqfqj2DgyqLv6
         I5DTqB6k7VKWdJf+/sT9AynDNVqHVXM1lv/A+tPaOL015VVEBWwYlvvhfKN60+nrkblQ
         0V1Q==
X-Gm-Message-State: AOJu0Yx2Vq6VZGxjadSuXQVtX5FunHKAm9R0bkHoJGLF0DrOveg88qYZ
	FcV+gE69itFB/fiU9ArwNgxr0yV2jV+w1OLYTfo=
X-Google-Smtp-Source: AGHT+IE4z0Aa2OY/6DqAi1bRkpmctNsQdq0WVGZJdvn+5aQuJ96nNPiPbpC9KIh/XV+LCvwJ5NQP72QYvowHgnzPLzA=
X-Received: by 2002:a05:6a21:6d9c:b0:18f:df4f:893 with SMTP id
 wl28-20020a056a216d9c00b0018fdf4f0893mr130520pzb.49.1701851015724; Wed, 06
 Dec 2023 00:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-43-zhengqi.arch@bytedance.com> <CAJhGHyBdk++L+DhZoZfHUac3ci14QdTM7qqUSQ_fO2iY1iHKKA@mail.gmail.com>
 <93c36097-5266-4fc5-84a8-d770ab344361@bytedance.com>
In-Reply-To: <93c36097-5266-4fc5-84a8-d770ab344361@bytedance.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 6 Dec 2023 16:23:24 +0800
Message-ID: <CAJhGHyBJiYOQGY3t=Lpe4A-rmJML8Mn8GC35GkrQ6Us082ZTAQ@mail.gmail.com>
Subject: Re: [PATCH v6 42/45] mm: shrinker: make global slab shrink lockless
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, paulmck@kernel.org, david@fromorbit.com, 
	tkhai@ya.ru, vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org, 
	brauner@kernel.org, tytso@mit.edu, steven.price@arm.com, cel@kernel.org, 
	senozhatsky@chromium.org, yujie.liu@intel.com, gregkh@linuxfoundation.org, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:55=E2=80=AFPM Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
>
> Hi,
>
> On 2023/12/6 15:47, Lai Jiangshan wrote:
> > On Tue, Sep 12, 2023 at 9:57=E2=80=AFPM Qi Zheng <zhengqi.arch@bytedanc=
e.com> wrote:
> >
> >> -       if (!down_read_trylock(&shrinker_rwsem))
> >> -               goto out;
> >> -
> >> -       list_for_each_entry(shrinker, &shrinker_list, list) {
> >> +       /*
> >> +        * lockless algorithm of global shrink.
> >> +        *
> >> +        * In the unregistration setp, the shrinker will be freed asyn=
chronously
> >> +        * via RCU after its refcount reaches 0. So both rcu_read_lock=
() and
> >> +        * shrinker_try_get() can be used to ensure the existence of t=
he shrinker.
> >> +        *
> >> +        * So in the global shrink:
> >> +        *  step 1: use rcu_read_lock() to guarantee existence of the =
shrinker
> >> +        *          and the validity of the shrinker_list walk.
> >> +        *  step 2: use shrinker_try_get() to try get the refcount, if=
 successful,
> >> +        *          then the existence of the shrinker can also be gua=
ranteed,
> >> +        *          so we can release the RCU lock to do do_shrink_sla=
b() that
> >> +        *          may sleep.
> >> +        *  step 3: *MUST* to reacquire the RCU lock before calling sh=
rinker_put(),
> >> +        *          which ensures that neither this shrinker nor the n=
ext shrinker
> >> +        *          will be freed in the next traversal operation.
> >
> > Hello, Qi, Andrew, Paul,
> >
> > I wonder know how RCU can ensure the lifespan of the next shrinker.
> > it seems it is diverged from the common pattern usage of RCU+reference.
> >
> > cpu1:
> > rcu_read_lock();
> > shrinker_try_get(this_shrinker);
> > rcu_read_unlock();
> >      cpu2: shrinker_free(this_shrinker);
> >      cpu2: shrinker_free(next_shrinker); and free the memory of next_sh=
rinker
> >      cpu2: when shrinker_free(next_shrinker), no one updates this_shrin=
ker's next
> >      cpu2: since this_shrinker has been removed first.
>
> No, this_shrinker will not be removed from the shrinker_list until the
> last refcount is released. See below:
>
> > rcu_read_lock();
> > shrinker_put(this_shrinker);
>
>         CPU 1                                      CPU 2
>
>    --> if (refcount_dec_and_test(&shrinker->refcount))
>                 complete(&shrinker->done);
>
>                                 wait_for_completion(&shrinker->done);
>                                  list_del_rcu(&shrinker->list);

since shrinker will not be removed from the shrinker_list until the
last refcount is released.

Is it possible that shrinker_free() can be starved by continuous
scanners getting and putting the refcount?

Thanks
Lai


>
> > travel to the freed next_shrinker.
> >
> > a quick simple fix:
> >
> > // called with other references other than RCU (i.e. refcount)
> > static inline rcu_list_deleted(struct list_head *entry)
> > {
> >     // something like this:
> >     return entry->prev =3D=3D LIST_POISON2;
> > }
> >
> > // in the loop
> > if (rcu_list_deleted(&shrinker->list)) {
> >     shrinker_put(shrinker);
> >     goto restart;
> > }
> > rcu_read_lock();
> > shrinker_put(shrinker);
> >
> > Thanks
> > Lai
> >
> >> +        *  step 4: do shrinker_put() paired with step 2 to put the re=
fcount,
> >> +        *          if the refcount reaches 0, then wake up the waiter=
 in
> >> +        *          shrinker_free() by calling complete().
> >> +        */
> >> +       rcu_read_lock();
> >> +       list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
> >>                  struct shrink_control sc =3D {
> >>                          .gfp_mask =3D gfp_mask,
> >>                          .nid =3D nid,
> >>                          .memcg =3D memcg,
> >>                  };
> >>
> >> +               if (!shrinker_try_get(shrinker))
> >> +                       continue;
> >> +
> >> +               rcu_read_unlock();
> >> +
> >>                  ret =3D do_shrink_slab(&sc, shrinker, priority);
> >>                  if (ret =3D=3D SHRINK_EMPTY)
> >>                          ret =3D 0;
> >>                  freed +=3D ret;
> >> -               /*
> >> -                * Bail out if someone want to register a new shrinker=
 to
> >> -                * prevent the registration from being stalled for lon=
g periods
> >> -                * by parallel ongoing shrinking.
> >> -                */
> >> -               if (rwsem_is_contended(&shrinker_rwsem)) {
> >> -                       freed =3D freed ? : 1;
> >> -                       break;
> >> -               }
> >> +
> >> +               rcu_read_lock();
> >> +               shrinker_put(shrinker);
> >>          }
> >>

