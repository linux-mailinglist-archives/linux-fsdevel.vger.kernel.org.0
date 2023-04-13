Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9B6E0C68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 13:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDML0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDML0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:26:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D429893ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:26:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f26so30441500ejb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681385178; x=1683977178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/msDqown+gsJEVmOfzlTbyMpOATpYD/kAuVh4jdSmEQ=;
        b=5X4Hzoh0yu7xqdwwMJzwItqZb349+O2XmbtGc4wZmScFAqWvlR41kAHd/G5vSmTdDF
         TwSmjXYnk9aPqmBudu5HRQ7zA/ir998f3C3tqlhsSrkLHO55EPx0PfVVmMpqYWWkOJpb
         imDolCRSJyxiT9KHMkA7gTmjWXGiEGjBwi8klJF2gTlMsBjFY/21FgAgdWU8XajThuUA
         lwN8zY2rSBiCbMYkGiBVOd5ryjonht9HXZclfR96nSJog5pVB2LQaE8JGIpPAk6Z/xS8
         f0qjtt+zifDG3ra3wpDJdgipm+7YwCPJqZAbXKu2sAgEpn5ndWNmktL/wZgIKOUXGXaU
         CRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681385178; x=1683977178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/msDqown+gsJEVmOfzlTbyMpOATpYD/kAuVh4jdSmEQ=;
        b=lBUUT35iE3TGA63pQVVUPLCHkHFCE0N46Dc7pEnbbIrCW4XZ4VTiVqQ5fXey9NB/k+
         98Z5RTp7Pylh0cqNfLPUMtvanSI/Uidar4ZLJov/QWSGSTqjbBDt/HNZc9pd0p7O6/zn
         U/WPy734kOXZNTECyRbnhPYQi9bVVFFTNqLc7uoeBKASz0bRGpw+Js1tW3p+q67Jgx3p
         brE30N+A3+dF8gniDKsblCh/uWJDjwEMUpbcPhHyn8rQYUj8OKAlbRH2HE/htvNB4C94
         zXf6EaOB+1fGZI/Z1Wkz3DlnZdvpDfwrIjihxyb2S1Fequ2q9ZOmlI9+nEw66x0jHUv9
         HDZw==
X-Gm-Message-State: AAQBX9fN9V+2iePUQhJsXNwdkqt3HbVuQcowuNnbrip9SnLBgBG7vNvj
        NtVBDXmYH380QVcQktgEb4F2stg4J4lB7dZwKfoPSA==
X-Google-Smtp-Source: AKy350YRtD2zTQ9+KiMShjAtzx5fwXvp2NVZX/rprSwV/8Ili7SCqCDXg2Nd5gR33WR1gOzoPiUyEAxmvMQmLGcaIa8=
X-Received: by 2002:a17:906:2c1a:b0:94e:8e6f:4f1c with SMTP id
 e26-20020a1709062c1a00b0094e8e6f4f1cmr1086817ejh.15.1681385178080; Thu, 13
 Apr 2023 04:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230413104034.1086717-1-yosryahmed@google.com>
 <20230413104034.1086717-2-yosryahmed@google.com> <0340c57b-dcec-42ba-eb6e-dd5599722ea4@redhat.com>
In-Reply-To: <0340c57b-dcec-42ba-eb6e-dd5599722ea4@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Apr 2023 04:25:41 -0700
Message-ID: <CAJD7tkZ-6oJewNfPrz+cdd304kr_LKWTHSKeaHUyOQ-8HAw-MA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 13, 2023 at 4:16=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.04.23 12:40, Yosry Ahmed wrote:
> > We keep track of different types of reclaimed pages through
> > reclaim_state->reclaimed_slab, and we add them to the reported number
> > of reclaimed pages.  For non-memcg reclaim, this makes sense. For memcg
> > reclaim, we have no clue if those pages are charged to the memcg under
> > reclaim.
> >
> > Slab pages are shared by different memcgs, so a freed slab page may hav=
e
> > only been partially charged to the memcg under reclaim.  The same goes =
for
> > clean file pages from pruned inodes (on highmem systems) or xfs buffer
> > pages, there is no simple way to currently link them to the memcg under
> > reclaim.
> >
> > Stop reporting those freed pages as reclaimed pages during memcg reclai=
m.
> > This should make the return value of writing to memory.reclaim, and may
> > help reduce unnecessary reclaim retries during memcg charging.  Writing=
 to
> > memory.reclaim on the root memcg is considered as cgroup_reclaim(), but
> > for this case we want to include any freed pages, so use the
> > global_reclaim() check instead of !cgroup_reclaim().
> >
> > Generally, this should make the return value of
> > try_to_free_mem_cgroup_pages() more accurate. In some limited cases (e.=
g.
> > freed a slab page that was mostly charged to the memcg under reclaim),
> > the return value of try_to_free_mem_cgroup_pages() can be underestimate=
d,
> > but this should be fine. The freed pages will be uncharged anyway, and =
we
> > can charge the memcg the next time around as we usually do memcg reclai=
m
> > in a retry loop.
> >
> > Fixes: f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> > instead of pages")
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
>
> LGTM, hopefully the underestimation won't result in a real issue.
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Thanks,
>
> David / dhildenb
>
