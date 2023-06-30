Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BEA7443E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 23:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjF3VZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 17:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjF3VZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:25:49 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8DD2680
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:25:48 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bfee66a5db6so2198941276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688160347; x=1690752347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDq+42TG3Ict2mGIXSxzLvITw6tDdgLWNgtDD2KSbtQ=;
        b=p+FcoycAK0LPHezltqUeI1NrBX02NNvg5DenKN0eWW1dccMI32UPW8kFZXi9E1liI7
         DXYS4n5JEx0K8GZNxGg+qprF+yhlh0aoqEyKqaRW/GmIuTumS/1PkBlZI+loDbENmNBX
         Ho7ju7BN9BO7gPdG/IYe8CqRA3A5LJUsyNWk7PlMC++UPN9eBCyXVNb14REAHWCSl6q2
         Je65sJp6xp3ZUvwhMu5GeWyM8Qo+RY+ReIkKr8cTipAt+0MzoT57tkgZye0aad+zr0Q0
         bE/RhNvlJ1QugzovorCN6ITdQVr2mEdnCVPvr9vPU4ew5xC0HaqZ7A2pwu6xaV+0yUr9
         UeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688160347; x=1690752347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDq+42TG3Ict2mGIXSxzLvITw6tDdgLWNgtDD2KSbtQ=;
        b=TMEsHbVQO2bK4eBdPfKpvMMADqA/70OkOT3P+yq/0jZkeimqViCERueNtwvSyy+hHX
         dnEck71K9wiREm215Zh2V3knL87C4GFq8lNyS0fck7572WYlk5cubqrS/v0KXa8djvl4
         4liQyiEgySVGL018hfxJu52DSgkUVJ7UeFwFxighgEFvrHOEEZUBkv6HtTdZ93hW0nz+
         ctZicyu+xPolfzbzzM/6FcNVVAN1msrJNQtyy58Y8dkVqdXzM5pJtKunT2Qk9bWd1rBG
         w2OVL3qAX9fGMZjy0okHK4pFc3H9AcuCLMbequC4JS9EJVV6b2ZjEmvynrb5IpKToUaf
         bZ1w==
X-Gm-Message-State: ABy/qLZPwALhlRVonZR9yNRKp3hUB3U860PHOrUYBkCKQHNUBeurY697
        XXt3pMPWwD0Hdr95o51lkmLfZCfr2MZfeQDO1m6KOw==
X-Google-Smtp-Source: APBJJlG07kZfUqsjjffPRGzbU8Rg8FwBTqDjQrYIYP39R2vse26RFRoYEGSmwzduzus/Oe7YVXAxuSv0y1+UclYTcxU=
X-Received: by 2002:a25:15c1:0:b0:bfe:77f1:f454 with SMTP id
 184-20020a2515c1000000b00bfe77f1f454mr3324853ybv.51.1688160347525; Fri, 30
 Jun 2023 14:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230630020436.1066016-1-surenb@google.com> <20230630020436.1066016-5-surenb@google.com>
 <ZJ5NzJDY0XPt8ui1@casper.infradead.org> <CAJuCfpH7uBPS4v24MEh_4XTfJ1bz3oUhHGvtNY=XwoicXc8_XA@mail.gmail.com>
 <ZJ5QR5q2WtD2z1rd@casper.infradead.org>
In-Reply-To: <ZJ5QR5q2WtD2z1rd@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 30 Jun 2023 14:25:36 -0700
Message-ID: <CAJuCfpE9XCBy3vCv-zKDbB2J7ctgGz1k4Y5265V6vXNX=GTX8A@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 8:47=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jun 29, 2023 at 08:45:39PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Thu, Jun 29, 2023 at 07:04:33PM -0700, Suren Baghdasaryan wrote:
> > > > Change folio_lock_or_retry to accept vm_fault struct and return the
> > > > vm_fault_t directly.
> > >
> > > I thought we decided to call this folio_lock_fault()?
> > >
> > > > +static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
> > > > +                                          struct vm_fault *vmf)
> > > >  {
> > > >       might_sleep();
> > > > -     return folio_trylock(folio) || __folio_lock_or_retry(folio, m=
m, flags);
> > > > +     return folio_trylock(folio) ? 0 : __folio_lock_or_retry(folio=
, vmf);
> > >
> > > No, don't use the awful ternary operator.  The || form is used
> > > everywhere else.
> >
> > Ok, but folio_trylock() returns a boolean while folio_lock_or_retry
> > should return vm_fault_t. How exactly do you suggest changing this?
> > Something like this perhaps:
> >
> > static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
> >                                           struct vm_fault *vmf)
> > {
> >      might_sleep();
> >      if (folio_trylock(folio))
> >          return 0;
> >      return __folio_lock_or_retry(folio, mm, flags);
> > }
> >
> > ?
>
> I think the automatic casting would work, but I prefer what you've
> written here.
>
> > > >  /*
> > > >   * Return values:
> > > > - * true - folio is locked; mmap_lock is still held.
> > > > - * false - folio is not locked.
> > > > + * 0 - folio is locked.
> > > > + * VM_FAULT_RETRY - folio is not locked.
> > >
> > > I don't think we want to be so prescriptive here.  It returns non-zer=
o
> > > if the folio is not locked.  The precise value is not something that
> > > callers should depend on.
> >
> > Ok, I'll change it to "non-zero" here.
>
> Thanks!

Posted v7 at https://lore.kernel.org/all/20230630211957.1341547-1-surenb@go=
ogle.com/
