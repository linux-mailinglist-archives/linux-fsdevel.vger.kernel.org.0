Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4374334D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 05:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjF3Dpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjF3Dpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:45:53 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27852681
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 20:45:51 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so1257424276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688096751; x=1690688751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saWqnlpdUmfPljs/UpQGOApe3EmxkRHLGJwyoGjzPLY=;
        b=vKGf/e8CYYHf22UlEIy31yyfFyCWm+jNSc5QJu24ZDGspNg2t4H9STq/j20Z78eOb8
         7aUb2Z4nm12laHEwVV2d4/ulK9Or9JbgrxBBmh6KPh/M5xaKq1MGKZfLm6RDh7VMLZSZ
         ZM/ulEyM6kxGpModQfttYZ0SbvgsxRtDkBXJ9cn8jBjU1FQO0ECWwX39aIgnzU5HClwP
         xluj5aIgwM7qRojWnvxpXNn3DqwfWuy8Xzw4ldQFF6kSLFCjC/xHXJSWN06hnuyG7zxL
         WsrNUlVON4X7iE1LikGIfMXvCaiHx9U+J27MwQ0/fUqfg2bh80Tns3Zqb6rSHJbSNGib
         gy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688096751; x=1690688751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saWqnlpdUmfPljs/UpQGOApe3EmxkRHLGJwyoGjzPLY=;
        b=cPEW7ID6CPqTq7t4g5uqkh7FpzMtFub3nUyTSmSkX+MPaBmriNZFZaUd2OhEPhSs/U
         5TWQnDzFABIJ9mmXuWuqJt5PYNAFUUahwDBiihS+o/ZTM+03eO7UIiaFkjisfkV1ZXX4
         fI/RKvtm/rfThq3rkUlC7G8tD0xUIrNyjZjafWLNsXjhODvdx7JPV2CrXXr+YO1MgIzP
         ERUcT4sSxcpaPBt71c8XXdxllX85Hjj0zvP+bWw4qKH6DHXqFxRuxssx33KJYr+D91xu
         IfZpUuKFySDTaS0pADM3NB3fClVKP7dVjny/ewDZN8xwBnqAYdrKSuQviF4u37y0jR19
         kRLg==
X-Gm-Message-State: ABy/qLaGCB1AUttcTX4UnwVQiIV2/XJhj5/QVulxy4n1th0Llr1+vbcu
        CQh8Okj86f733oNAVHqsKQMzP2AXSYSK8nKWpiodgw==
X-Google-Smtp-Source: APBJJlH+dIP5PgMY5tOg//5V8CnyI3pnCQ09g8uaYXw4J4RYR63H5b5ed6UR5bTPn+W5aIhs9KcZIfK4g3mtEsP9K4g=
X-Received: by 2002:a25:94c:0:b0:c18:4f16:aaf6 with SMTP id
 u12-20020a25094c000000b00c184f16aaf6mr1550054ybm.58.1688096750694; Thu, 29
 Jun 2023 20:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230630020436.1066016-1-surenb@google.com> <20230630020436.1066016-5-surenb@google.com>
 <ZJ5NzJDY0XPt8ui1@casper.infradead.org>
In-Reply-To: <ZJ5NzJDY0XPt8ui1@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 29 Jun 2023 20:45:39 -0700
Message-ID: <CAJuCfpH7uBPS4v24MEh_4XTfJ1bz3oUhHGvtNY=XwoicXc8_XA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] mm: change folio_lock_or_retry to use vm_fault directly
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jun 29, 2023 at 07:04:33PM -0700, Suren Baghdasaryan wrote:
> > Change folio_lock_or_retry to accept vm_fault struct and return the
> > vm_fault_t directly.
>
> I thought we decided to call this folio_lock_fault()?
>
> > +static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
> > +                                          struct vm_fault *vmf)
> >  {
> >       might_sleep();
> > -     return folio_trylock(folio) || __folio_lock_or_retry(folio, mm, f=
lags);
> > +     return folio_trylock(folio) ? 0 : __folio_lock_or_retry(folio, vm=
f);
>
> No, don't use the awful ternary operator.  The || form is used
> everywhere else.

Ok, but folio_trylock() returns a boolean while folio_lock_or_retry
should return vm_fault_t. How exactly do you suggest changing this?
Something like this perhaps:

static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
                                          struct vm_fault *vmf)
{
     might_sleep();
     if (folio_trylock(folio))
         return 0;
     return __folio_lock_or_retry(folio, mm, flags);
}

?


>
> >  /*
> >   * Return values:
> > - * true - folio is locked; mmap_lock is still held.
> > - * false - folio is not locked.
> > + * 0 - folio is locked.
> > + * VM_FAULT_RETRY - folio is not locked.
>
> I don't think we want to be so prescriptive here.  It returns non-zero
> if the folio is not locked.  The precise value is not something that
> callers should depend on.

Ok, I'll change it to "non-zero" here.

>
