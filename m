Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A71D4EE60D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 04:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbiDACbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 22:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbiDACbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:31:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAF3255AA9
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 19:30:03 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id t11so2644511ybi.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8cwDlYjnxCV3IxzT3v3QEWgrMQiVq0GE+zAs4nW3SA=;
        b=rikRS/GxwOHHVJquulYr9sEM7JfhAU8lhASRbchygaEUbfO7bShrfIZ6xZCSTFMtEw
         BLu3HJKZYlqMLoI/b3V+GiWUV+i2s2XEIkaJpiCLww0rNWnEcQixmZKMBjB1hGJeg4YQ
         ZEuUKigI11Bpnqwl/MarLJpenSrxlQSDM57lG2QmYc62fsbsIY8W9AKyY3JMkyG+TEIF
         QOPxk6ruqlNyOMqRjFC0HdzkD7ApjZ/iOT0Uv39n8GyNgw4TWpSgUXhSylpXyu5MsZcl
         aUuzKo0mcQJmE0s+oVKcjND1adWDIu3tPv5qyuJEGquxFT2taDugRt1cD4ofBSngJwI+
         aR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8cwDlYjnxCV3IxzT3v3QEWgrMQiVq0GE+zAs4nW3SA=;
        b=CQs6xmL8VCpyvStpkAvRSbAadAK2wXoaNp9M9eu6BH+crjTw5WkUkwfLwEOIs2esjj
         cColjm2gHjWquhyhqYh08kgeL1skz4os9TBjLY0FuIHCdyrwVOYCMQfJ+Qi2uFGoc/49
         UYD+fr28JfHjVG3DaHOVByBI35VcvwrXubkfHCYpehRusmHDIdFBmk5xNJgi9cH7WyO1
         Ac3XT0oddCGmqWYDltpivLPeRy8zpnQTw0ndj5es+H4tS+8FDKc6f0eYTxfjBl33XaaD
         L6/E7CSy9ITg11jl+IP8IP90IVevSM/81eRnyPHO5P+pFB4Zq5QzsfKeP2fCbcCRA8Xc
         VK2A==
X-Gm-Message-State: AOAM53207IE00oppx3epwuOo5XMlZOSQtQp9uyRrJQbQvUVM0oVg4/IU
        eP1bRGsmG+4UhST6RYFWKRT3z8Ov4EM7JTGj2OMbGg==
X-Google-Smtp-Source: ABdhPJxXWN2EeImfs4Xf8QoUFCxpUijqGlRatJFfKNDTVsQyfVCNS5IVCFQPfVXarhLay5xdzlHUWNlAGqUh6kC8ec8=
X-Received: by 2002:a25:24d:0:b0:633:6b37:bea1 with SMTP id
 74-20020a25024d000000b006336b37bea1mr6516276ybc.427.1648780203076; Thu, 31
 Mar 2022 19:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220228122126.37293-1-songmuchun@bytedance.com>
 <20220228122126.37293-13-songmuchun@bytedance.com> <164869718565.25542.15818719940772238394@noble.neil.brown.name>
 <CAMZfGtUSA9f3k9jF5U-y+NVt8cpmB9_mk1F9-vmm4JOuWFF_Bw@mail.gmail.com>
 <164870069595.25542.17292003658915487357@noble.neil.brown.name>
 <CAMZfGtX9pkWYf40RwDALZLKGDc+Dt2UJA7wZFjTagf0AyWyCiw@mail.gmail.com> <164876616694.25542.14010655277238655246@noble.neil.brown.name>
In-Reply-To: <164876616694.25542.14010655277238655246@noble.neil.brown.name>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 1 Apr 2022 10:29:26 +0800
Message-ID: <CAMZfGtUMyag7MHxmg7E1_xmyZ7NDPt62e-qXbqa8nJHFC72=3w@mail.gmail.com>
Subject: Re: [PATCH v6 12/16] mm: list_lru: replace linear array with xarray
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 1, 2022 at 6:36 AM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 31 Mar 2022, Muchun Song wrote:
> >
> > Thanks for your report.  I knew the reason. It is because the following
> > patch in this series was missed upstream.  Could you help me test if it
> > works properly?
> >
> > [v6,06/16] nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
> >
>
> Thanks for the quick response!  That patch helps, but has a bug.  My
> testing resulted in refcount underflow errors.
>
> Problem is that kref_init() is called in nfs4_xattr_entry_init_once().
> This means that it is initialised to '1' the first time an entry is
> allocated, but it is left as zero the second time.
> I applied:
> --- a/fs/nfs/nfs42xattr.c
> +++ b/fs/nfs/nfs42xattr.c
> @@ -191,6 +191,7 @@ nfs4_xattr_alloc_entry(const char *name, const void *value,
>         entry = kmem_cache_alloc_lru(nfs4_xattr_entry_cachep, lru, gfp);
>         if (!entry)
>                 return NULL;
> +       kref_init(&entry->ref);
>         namep = kstrdup_const(name, gfp);
>         if (!namep && name)
>                 goto free_buf;
> @@ -974,7 +975,6 @@ static void nfs4_xattr_entry_init_once(void *p)
>  {
>         struct nfs4_xattr_entry *entry = p;
>
> -       kref_init(&entry->ref);
>         entry->bucket = NULL;
>         INIT_LIST_HEAD(&entry->lru);
>         INIT_LIST_HEAD(&entry->dispose);
>
> and now it seems to work.
>
> The complete patch that I applied is below.  I haven't reviewed it, just
> tested it.
>   Tested-by: NeilBrown <neilb@suse.de>
>

Thanks for your test.  I have looked at the latest code.
I found the following patch has removed GFP_ACCOUNT
on allocation.

5c60e89e71f8 ("NFSv4.2: Fix up an invalid combination of memory
allocation flags")

But this commit forgot to remove SLAB_ACCOUNT when creating
nfs4_xattr_cache_cachep (I think it is a bug).  So I think the following
patch could work.

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index ad3405c64b9e..e7b34f7e0614 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -997,7 +997,7 @@ int __init nfs4_xattr_cache_init(void)

        nfs4_xattr_cache_cachep = kmem_cache_create("nfs4_xattr_cache_cache",
            sizeof(struct nfs4_xattr_cache), 0,
-           (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+           (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD),
            nfs4_xattr_cache_init_once);
        if (nfs4_xattr_cache_cachep == NULL)
                return -ENOMEM;
