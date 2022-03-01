Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000234C97EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 22:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiCAVuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 16:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiCAVuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:50:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6751E344E6;
        Tue,  1 Mar 2022 13:49:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p15so34211940ejc.7;
        Tue, 01 Mar 2022 13:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdlzCwyPb0LKAsdsGZLfJlZjUMsAn2owiB/9oX5i75A=;
        b=qEuYBhepionLwIoGiaa9Ulp44ZeIAan84Vhc/O/Y6o6cp8Zgql95Q6rABAoxAdobZj
         qQeN/ZTM7qbSTofEST/YutPsc9WDpRLj3l84/yd+1p2JbiHxLjBXXniDthmBLrCExdN/
         hLyJmEdmjaXGscNd1Yun2TtagX/rVn+g/uiAAbrE9f4X/zMR1s+JgnEowiKxNaqVn9PV
         Pek7b6OU1s1E2VhnRWYlLdkJ+FDcDWuF1T9WzLb3wqrEXeBR1s/7fkwoGz55JVYAAe8g
         gH+3LOX9BdkqcrCTiHU28TFZjXh6+mdZPvUcCYNG80jvbK1oujAWLrD6mUpvEC1I7DLR
         2jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdlzCwyPb0LKAsdsGZLfJlZjUMsAn2owiB/9oX5i75A=;
        b=EkiQ5w5rz5aoXXKxu5fKXWmt35OL45G2JmV+OU2ZWTd+tIADIa1V2quEP1flkZnx/0
         Uz690txdLA84VqSmsMP/TJHMhyWJVzO6b2qShVT95ZsgwkqYIMfGDyG8D/0hMWam3fNM
         HBj1mennTV9xoGZFhLsfN0yORTup4hYKi02ZHbMnGU3HZ13mQs6IFaAeHunp3VytLoyv
         l8fj/cGuquqhFcdCTz4ERQ9e4zOTQAnQqzgjXTXZD2f5iZQFxr5LpryCUirZC108k0om
         4dousfUY1xb8kaO6ngvPo95++jCW1MzNw+ORbaOW0NAdswnPpXCsOEKmSyIbx/B2AWqr
         8xoQ==
X-Gm-Message-State: AOAM531TB96LNK3dOJkhK2GsN5al45NCWCXvQO0sSgRmqo1c7v80dGh4
        sVhQV/LoSkNhF9Y60TRVPSZ6wVizVSDrsw51K8c=
X-Google-Smtp-Source: ABdhPJwGpmDe1OSxAdDHA7AdYxADhyeiRyRx1A6rkz+OGFpxWqmchI7rXwhx1y2oXfad8rFcIase6SAsTWE4z2cHyOs=
X-Received: by 2002:a17:907:6006:b0:6ce:46f:fe4b with SMTP id
 fs6-20020a170907600600b006ce046ffe4bmr19818724ejc.7.1646171371927; Tue, 01
 Mar 2022 13:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20220228235741.102941-1-shy828301@gmail.com> <20220228235741.102941-2-shy828301@gmail.com>
 <cfaefe6f-dd51-1595-a23c-1aa5dc8350ff@huawei.com>
In-Reply-To: <cfaefe6f-dd51-1595-a23c-1aa5dc8350ff@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Mar 2022 13:49:19 -0800
Message-ID: <CAHbLzkqP36q+exOy3wqa84ziRE6E=ThccGH9rpYC6f8H7RXwWw@mail.gmail.com>
Subject: Re: [PATCH 1/8] sched: coredump.h: clarify the use of MMF_VM_HUGEPAGE
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        darrick.wong@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 1, 2022 at 12:45 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/1 7:57, Yang Shi wrote:
> > MMF_VM_HUGEPAGE is set as long as the mm is available for khugepaged by
> > khugepaged_enter(), not only when VM_HUGEPAGE is set on vma.  Correct
> > the comment to avoid confusion.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/sched/coredump.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> > index 4d9e3a656875..4d0a5be28b70 100644
> > --- a/include/linux/sched/coredump.h
> > +++ b/include/linux/sched/coredump.h
> > @@ -57,7 +57,8 @@ static inline int get_dumpable(struct mm_struct *mm)
> >  #endif
> >                                       /* leave room for more dump flags */
> >  #define MMF_VM_MERGEABLE     16      /* KSM may merge identical pages */
> > -#define MMF_VM_HUGEPAGE              17      /* set when VM_HUGEPAGE is set on vma */
> > +#define MMF_VM_HUGEPAGE              17      /* set when mm is available for
> > +                                        khugepaged */
>
> I think this comment could be written in one line. Anyway, this patch looks good to me.
> Thanks.

Yes, as long as we don't care about the 80 characters limit. I know
the limit was bumped to 100 by checkpatch, but I have seen 80 was
still preferred by a lot of people.

>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.

>
> >  /*
> >   * This one-shot flag is dropped due to necessity of changing exe once again
> >   * on NFS restore
> >
>
