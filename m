Return-Path: <linux-fsdevel+bounces-4950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCD18069C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 09:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B921C20BB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437581A593
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f010h2RL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F88D46;
	Tue,  5 Dec 2023 23:47:55 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce52d796d2so2805586b3a.3;
        Tue, 05 Dec 2023 23:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701848875; x=1702453675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9tOeG5lSH9f7dyJI5an/jIJpQd2p6O7LHJWWGhvBKQ=;
        b=f010h2RLkpP4mMlQ2vjO0YUnQpmSBsa8TUzzoAurMNoGN6J2wq91OLIVboWVRFC7zL
         Hzcuz3iWkF0RyM152qKqDiGdvQJ4uwRWy9pGGIs69ythV4TDELRWGBYM7I14y2BA0IL/
         9MGldtU7CpPZDYEgNf26+XOtrFf6/o43h0jUPyrxeDlYfkbacirQAUVUYxkRZ8sTK/mh
         e1EsXVvSxu4R0zoycVbtTmSqztGYqSj49AV3PAh/4gNl/PVjiKgkMvsmPE/5yhb2PfNz
         TxW/e6/mXALzjF564RTMN1q8ck2RaRvaEIN2XoSJPmp7JfCBnZaYqgKVZG1OlrU+H0Ws
         8COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848875; x=1702453675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9tOeG5lSH9f7dyJI5an/jIJpQd2p6O7LHJWWGhvBKQ=;
        b=P1ni8wFqou3XFJkERtXPDRklocIgbw3RBvBTI91K40aBXH6nJcxqCaz54k4lfiTzBF
         8fPBFS6LBcmjE9uNWn8Sc+FaABaaB0wNaYDjXgCXwyTqayOLJZIti7Q+rvXpcywdeHB8
         DuPT3Jf6LT6suOv2QZ220kbnTzB5QXLaCW3engH3Utgc+1Kk4APxpKBA8w+7mpf+8wMV
         bw3D261bQ40cyxQRkfEp2spauvVWxoPQPtLRNyP7SOm0U7DMMWvPH56H8JbwX9AGfenO
         o4++OZr3TrhbpYOTkoOutkr44A+c1GViod/Lq5FWDOSz0f9pWbeU6YMmKl9GqQuutb5q
         953w==
X-Gm-Message-State: AOJu0YwGb7dCE5j6iN/WU68rP2CiJ249DZbL0ce70WCcfj9VRbGRPG1y
	7gJYrU7f+KkMOU8TNjQot12s0D3gqIUI+iuJt30=
X-Google-Smtp-Source: AGHT+IFwSbhTLDlvnf5+oxYDdBIhm4qGO2bZ81JWMwosaCevSDcqxlcxB/Vy2nAY8jK/0IA4t818DT8m3AIBZaVNV9Y=
X-Received: by 2002:a05:6a20:12c8:b0:18f:97c:9776 with SMTP id
 v8-20020a056a2012c800b0018f097c9776mr528838pzg.94.1701848874699; Tue, 05 Dec
 2023 23:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com> <20230911094444.68966-43-zhengqi.arch@bytedance.com>
In-Reply-To: <20230911094444.68966-43-zhengqi.arch@bytedance.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 6 Dec 2023 15:47:43 +0800
Message-ID: <CAJhGHyBdk++L+DhZoZfHUac3ci14QdTM7qqUSQ_fO2iY1iHKKA@mail.gmail.com>
Subject: Re: [PATCH v6 42/45] mm: shrinker: make global slab shrink lockless
To: Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org, 
	paulmck@kernel.org
Cc: david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz, roman.gushchin@linux.dev, 
	djwong@kernel.org, brauner@kernel.org, tytso@mit.edu, steven.price@arm.com, 
	cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com, 
	gregkh@linuxfoundation.org, muchun.song@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 9:57=E2=80=AFPM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:

> -       if (!down_read_trylock(&shrinker_rwsem))
> -               goto out;
> -
> -       list_for_each_entry(shrinker, &shrinker_list, list) {
> +       /*
> +        * lockless algorithm of global shrink.
> +        *
> +        * In the unregistration setp, the shrinker will be freed asynchr=
onously
> +        * via RCU after its refcount reaches 0. So both rcu_read_lock() =
and
> +        * shrinker_try_get() can be used to ensure the existence of the =
shrinker.
> +        *
> +        * So in the global shrink:
> +        *  step 1: use rcu_read_lock() to guarantee existence of the shr=
inker
> +        *          and the validity of the shrinker_list walk.
> +        *  step 2: use shrinker_try_get() to try get the refcount, if su=
ccessful,
> +        *          then the existence of the shrinker can also be guaran=
teed,
> +        *          so we can release the RCU lock to do do_shrink_slab()=
 that
> +        *          may sleep.
> +        *  step 3: *MUST* to reacquire the RCU lock before calling shrin=
ker_put(),
> +        *          which ensures that neither this shrinker nor the next=
 shrinker
> +        *          will be freed in the next traversal operation.

Hello, Qi, Andrew, Paul,

I wonder know how RCU can ensure the lifespan of the next shrinker.
it seems it is diverged from the common pattern usage of RCU+reference.

cpu1:
rcu_read_lock();
shrinker_try_get(this_shrinker);
rcu_read_unlock();
    cpu2: shrinker_free(this_shrinker);
    cpu2: shrinker_free(next_shrinker); and free the memory of next_shrinke=
r
    cpu2: when shrinker_free(next_shrinker), no one updates this_shrinker's=
 next
    cpu2: since this_shrinker has been removed first.
rcu_read_lock();
shrinker_put(this_shrinker);
travel to the freed next_shrinker.

a quick simple fix:

// called with other references other than RCU (i.e. refcount)
static inline rcu_list_deleted(struct list_head *entry)
{
   // something like this:
   return entry->prev =3D=3D LIST_POISON2;
}

// in the loop
if (rcu_list_deleted(&shrinker->list)) {
   shrinker_put(shrinker);
   goto restart;
}
rcu_read_lock();
shrinker_put(shrinker);

Thanks
Lai

> +        *  step 4: do shrinker_put() paired with step 2 to put the refco=
unt,
> +        *          if the refcount reaches 0, then wake up the waiter in
> +        *          shrinker_free() by calling complete().
> +        */
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
>                 struct shrink_control sc =3D {
>                         .gfp_mask =3D gfp_mask,
>                         .nid =3D nid,
>                         .memcg =3D memcg,
>                 };
>
> +               if (!shrinker_try_get(shrinker))
> +                       continue;
> +
> +               rcu_read_unlock();
> +
>                 ret =3D do_shrink_slab(&sc, shrinker, priority);
>                 if (ret =3D=3D SHRINK_EMPTY)
>                         ret =3D 0;
>                 freed +=3D ret;
> -               /*
> -                * Bail out if someone want to register a new shrinker to
> -                * prevent the registration from being stalled for long p=
eriods
> -                * by parallel ongoing shrinking.
> -                */
> -               if (rwsem_is_contended(&shrinker_rwsem)) {
> -                       freed =3D freed ? : 1;
> -                       break;
> -               }
> +
> +               rcu_read_lock();
> +               shrinker_put(shrinker);
>         }
>

