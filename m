Return-Path: <linux-fsdevel+bounces-4952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35698069BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 09:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912A7281B7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46500199D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzDn1x+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E19D6C;
	Wed,  6 Dec 2023 00:10:19 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d8481094f9so4048259a34.3;
        Wed, 06 Dec 2023 00:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701850219; x=1702455019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4zRPqTOkB7jDP1E8GI9v9TGvn/esl06SjlrpyyjjKU=;
        b=WzDn1x+Xh/nnO2UKaklKKO1FIsgVomynSBitySmd7EnPpvaPS5+CmcHDzo9NHSROHd
         zr2S+IoHscplX41Vlf3UA5x73YcRuQc1TV9RjQemhIyPF17BAMremmtzfGevvX2AYknQ
         htBmMITY4rm7/toySf6c6b0vOX1afe2SyCIGNEf651mde5M64xylhxWz5T0LCG2vwWRP
         50Qvm+FaZ2did2LdTFUrr1xIER+Z2IHUdx0gUCbhFrQpObp0HFZ+gapcUCQKNOc4qVW2
         pUvTEwC2U1uC/JVP4pFlwdUXlRVNo3mF7jtQmZpL8Ox+bb5zVIaDFMG1XVRePiz43GMS
         /Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850219; x=1702455019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4zRPqTOkB7jDP1E8GI9v9TGvn/esl06SjlrpyyjjKU=;
        b=I7O55mlVvG7QxShsBf0O8z0yp78le9YkVCxwXNz8eg+WpwaNo+vaUww/D0BVKDrWsx
         ldqRdXqcFty1W2PEltQanGZJe00GcJh6GFj0Qg5nobitSwxG74XSpNqB/BZ07Zdf/E5r
         K+Z749tX2+vQJLdr8cIwzpDvZLHFbA1K8sWuxV/07dZMw1/cH6xnLIkCao99RvxVgsW1
         wlCFlHk5BIrgxkJD+h0k9hwvByJ1ReWYDx1pXLxpOGw5ntmdCEK39QrLWWUQUBSlZ7e0
         C1t5F/hG7Qcq1wQ81c0q6BNouh0Mqc6P5DV1kO9vlLzKU/YUQOFfGyxDdWUjy+2q32m8
         M6VA==
X-Gm-Message-State: AOJu0YyGVq8JjkufmVX53LQnbsUqyGPFKREFTIqKyKLcgAR/LvjbI5SE
	wNHmGOd5soJGpVYdTaiKR/oA0MhuHMx7kDimSJg=
X-Google-Smtp-Source: AGHT+IHYzRi5P2jhRZ/cpQOAt6iuZH+UBx/TP+7cObEbZYVtiS4uyqmMjQWcpOlXLBmov5H62Xo8uvzbfv54aVTm00o=
X-Received: by 2002:a05:6358:280e:b0:170:17eb:14c2 with SMTP id
 k14-20020a056358280e00b0017017eb14c2mr661954rwb.50.1701850218695; Wed, 06 Dec
 2023 00:10:18 -0800 (PST)
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
Date: Wed, 6 Dec 2023 16:10:06 +0800
Message-ID: <CAJhGHyAX4UDvm3euvBZ=ksQuWwq3tL=bmNRJwCht=bKjr021wQ@mail.gmail.com>
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

Oh, I miss the code here.

Thanks
Lai


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

