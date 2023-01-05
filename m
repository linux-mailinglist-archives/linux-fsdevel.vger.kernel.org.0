Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757B65E143
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 01:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjAEAGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 19:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAEAGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:06:40 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAA543A07
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 16:06:39 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-43ea87d0797so497924577b3.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jan 2023 16:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ugktJCe/HSjFId4CkvvJ5v4nvujpVuUxkVJVsSWOUE4=;
        b=TKQFqzcmuwTVyi3fjqE0c6JtCZpLG69JEMvwQ6VAsL1vYaWS8jl8Ysb6ZsxhwK4DMG
         DLtJmfrmqSb+cdaJSbcFxZB58lhBSf6ZDJcM4rhBHpZPZRNy6jPxx9LM28XFK590uVgS
         VxOgvPfEVks3f11jgxvLz0zfljElFhSVgMbiawbY0+oetVr77HuynqiIDa2OJ8m49HJy
         yR1PrjDL9tlL84h6s14i7dTGbiI23YdKK3m/ezLpMwmRerur7GGw13WD1pMz/TcNCCjx
         Nmmdw1vWw+he73L7aPwbQqDb9gP+pba9Ydir8bWW/K7aodV3UnOz/RokArKRRp3JexgF
         E8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugktJCe/HSjFId4CkvvJ5v4nvujpVuUxkVJVsSWOUE4=;
        b=SckzzdiHo//rfkf7fyT1o447sZiXlqkfG2kVDpLUiBgh8WDvmauZI6FKwxe8ABgybU
         i81M/mutZOMAEZHXLXf3sZGLw45p2KIumhSDQx5Gltgv+wb97U4uucNsRZc6nR09hZYO
         ycL67STnA6E8Ynnec4VcEtZMUIzn7Z64xaBi2fYHueL82Rb6OUEY4l4t/RQM3nTFtCtx
         4KoMgncXn2Ky2l85XBxXfor49iicaXbo2PxDBjuACtL9jkD0oI51OyqWgshtZKIv3f+T
         OQjRmfLP3NfTa0GH7BCohjHBPlSYGDqwplStRnO/AJ+k6IWmlf3UPDkjtBBM47GF11Nb
         BrMw==
X-Gm-Message-State: AFqh2krulGXRCm5iObFatH8lkUjB7jUqVfRTWwCy7M0YLp3GUER5CQPz
        MW24vNjM2aQgjjv+Y4HbknofHPvcLNu0WmlazBTMBg==
X-Google-Smtp-Source: AMrXdXv+nX87Qe/hYWQukdNnIqreUBCRunYKkfj5vDDQx2RKVFT5PrGFmLA/MfY9YJN1/ZjG81CVeT/yDqJFSHSUz+g=
X-Received: by 2002:a81:9210:0:b0:3dc:fd91:ef89 with SMTP id
 j16-20020a819210000000b003dcfd91ef89mr5295477ywg.347.1672877198588; Wed, 04
 Jan 2023 16:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20221228194249.170354-1-surenb@google.com> <6ddb468a-3771-92a1-deb1-b07a954293a3@redhat.com>
 <CAJuCfpGUpPPoKjAAmV7UK2H2o2NqsSa+-_M6JwesCfc+VRY2vw@mail.gmail.com>
 <b3aec4d4-737d-255a-d25e-451222fc9bb9@redhat.com> <CAJuCfpGBrAjjX9Otyn1vRKSVGL5uh=VOsEtM7-B6V4oT4ufSxw@mail.gmail.com>
In-Reply-To: <CAJuCfpGBrAjjX9Otyn1vRKSVGL5uh=VOsEtM7-B6V4oT4ufSxw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 4 Jan 2023 16:06:27 -0800
Message-ID: <CAJuCfpHp_rMUf6hjBH+aXjHbkBUhPLO9VFL+o8tfmHfRNPrzJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 4, 2023 at 10:24 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Jan 4, 2023 at 1:04 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 03.01.23 20:53, Suren Baghdasaryan wrote:
> > > On Mon, Jan 2, 2023 at 4:00 AM David Hildenbrand <david@redhat.com> wrote:
> > >>
> > >> On 28.12.22 20:42, Suren Baghdasaryan wrote:
> > >>> free_anon_vma_name() is missing a check for anonymous shmem VMA which
> > >>> leads to a memory leak due to refcount not being dropped. Fix this by
> > >>> adding the missing check.
> > >>>
> > >>> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
> > >>> Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
> > >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>> ---
> > >>>    include/linux/mm_inline.h | 2 +-
> > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > >>> index e8ed225d8f7c..d650ca2c5d29 100644
> > >>> --- a/include/linux/mm_inline.h
> > >>> +++ b/include/linux/mm_inline.h
> > >>> @@ -413,7 +413,7 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
> > >>>         * Not using anon_vma_name because it generates a warning if mmap_lock
> > >>>         * is not held, which might be the case here.
> > >>>         */
> > >>> -     if (!vma->vm_file)
> > >>> +     if (!vma->vm_file || vma_is_anon_shmem(vma))
> > >>>                anon_vma_name_put(vma->anon_name);
> > >>
> > >> Wouldn't it be me more consistent to check for "vma->anon_name"?
> > >>
> > >> That's what dup_anon_vma_name() checks. And it's safe now because
> > >> anon_name is no longer overloaded in vm_area_struct.
> > >
> > > Thanks for the suggestion, David. Yes, with the recent change that
> > > does not overload anon_name, checking for "vma->anon_name" would be
> > > simpler. I think we can also drop anon_vma_name() function now
> > > (https://elixir.bootlin.com/linux/v6.2-rc2/source/mm/madvise.c#L94)
> > > since vma->anon_name does not depend on vma->vm_file anymore, remove
> > > the last part of this comment:
> > > https://elixir.bootlin.com/linux/v6.2-rc2/source/include/linux/mm_types.h#L584
> > > and use vma->anon_name directly going forward. If all that sounds
> > > good, I'll post a separate patch implementing all these changes.
> > > So, for this patch I would suggest keeping it as is because
> > > functionally it is correct and will change this check along with other
> > > corrections I mentioned above in a separate patch. Does that sound
> > > good?
> >
> > Works for me.
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
>
> Thank you! Will post the followup cleanup patch shorly.

Andrew, I posted v2 of this patch at
https://lore.kernel.org/all/20230105000241.1450843-1-surenb@google.com/.
Please replace the original one in your tree. I had to follow David's
original suggestion instead of my planned cleanup because removing
anon_vma_name() would require us to add #ifdef CONFIG_ANON_VMA_NAME
everywhere we use vma->anon_name, which is quite ugly.
Thanks,
Suren.

>
> >
> > for this one, as it fixes the issue.
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
