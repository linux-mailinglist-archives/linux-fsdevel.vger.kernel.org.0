Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5999E743288
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 04:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjF3CIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 22:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjF3CIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:08:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35D235A0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:08:11 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bff0beb2d82so1253719276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688090891; x=1690682891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh9IVshRgKbatuJLHHRKBuSrhlgLbtUglR9X5QKFVAU=;
        b=gwBmbPurzkfYes2MIljJwdoCAcB+If6Ml+DMB5DLexuSd0XcB8hBYwx+v5h4cF3hnQ
         HG4+3YBFyz/37nNw7ib3I4+3kxDQZi3QiERxlSkP/0doMfFOHo911JPrF5XTr133Rnht
         zBuXrJaxnjL3sxAw8kmPwu57qFZHMNkwL0ja8n0txeTR6tA1sKjnUieu+yNutkVSjcbk
         ffjXGKgTQisJz2ui3CL/8D0O7xAKIf16vX6tSPA/Kc9MMweV0CsWv9xXeYMswGsWkwIJ
         L8ZMFeJD9AgqqRh7w6hX4pL54FgJb1wGuRXbunzzRGfzgDlPAVWfo9HlJuPNLEhBhsIE
         Ay3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688090891; x=1690682891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kh9IVshRgKbatuJLHHRKBuSrhlgLbtUglR9X5QKFVAU=;
        b=M3yo8lJLimm3oCNCSrYCxs2gKHfO87/V0HxB+IJ9WkwdEXtcQqNNgdsyNyO5Uxqqlj
         iELkzDf3eWimitqWHKFM6Ib/jM81TgTQwg/7BzEHBpLveHxDdKkAcZkPLJD9gKfsEI9l
         2pE3gb56VmjemtuvPW4fnawriRLmRp6w5CVZNXOjtkAAlcH4eicmj+x5THVXmu5mmTJe
         ugsiqBNV7AoxKxhjzO2L9r0JZhMXM8IF/h0VlAgoxRb0osTZynlhgxFwQ7K8ZLuim6Ew
         nvMBug+VoMcciVnIdlYk7V+IFsvpaAA1FTgfQAX3/X9tpQzrghskVSYt9hujHMKT8aaZ
         EnMA==
X-Gm-Message-State: ABy/qLbSuzJ5rYVvmFVUVXa/bNGiFgXwUxJCrZW0FrI3X9VsymYf3rfJ
        wYKbd6YVqJcd5HsUKpa1yPG7k9z+9rXpr9a38PE95A==
X-Google-Smtp-Source: APBJJlHGkt0t9d4kMIkTr5ZsvGG4e7Epya0TCKGzmPViHhBAkeKAn71oAque5IgOgZWTHT+L1N9H59qQMlaw92G/lD0=
X-Received: by 2002:a25:d112:0:b0:c02:7c99:629 with SMTP id
 i18-20020a25d112000000b00c027c990629mr1519896ybg.34.1688090890831; Thu, 29
 Jun 2023 19:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com> <20230628172529.744839-7-surenb@google.com>
 <ZJxulItq9iHi2Uew@x1n> <CAJuCfpEPpdEScAG_UOiNfOTpue9ro0AP6414C4tBaK1rbVK7Hw@mail.gmail.com>
 <ZJ2yOACwp7B2poIw@x1n> <CAJuCfpER=0GzcR3sWETYJAPK9SKAaRYtNfVXa-sXZu8MiL67NA@mail.gmail.com>
In-Reply-To: <CAJuCfpER=0GzcR3sWETYJAPK9SKAaRYtNfVXa-sXZu8MiL67NA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 29 Jun 2023 19:07:59 -0700
Message-ID: <CAJuCfpHLMYM0BvTP9pXBMpQLEYend7+p_xXsnd+PeyruiGngsg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: handle userfaults under VMA lock
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
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

On Thu, Jun 29, 2023 at 9:39=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jun 29, 2023 at 9:33=E2=80=AFAM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Wed, Jun 28, 2023 at 05:19:31PM -0700, Suren Baghdasaryan wrote:
> > > On Wed, Jun 28, 2023 at 10:32=E2=80=AFAM Peter Xu <peterx@redhat.com>=
 wrote:
> > > >
> > > > On Wed, Jun 28, 2023 at 10:25:29AM -0700, Suren Baghdasaryan wrote:
> > > > > Enable handle_userfault to operate under VMA lock by releasing VM=
A lock
> > > > > instead of mmap_lock and retrying. Note that FAULT_FLAG_RETRY_NOW=
AIT
> > > > > should never be used when handling faults under per-VMA lock prot=
ection
> > > > > because that would break the assumption that lock is dropped on r=
etry.
> > > > >
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > >
> > > > Maybe the sanitize_fault_flags() changes suite more in patch 3, but=
 not a
> > > > big deal I guess.
> > >
> > > IIUC FAULT_FLAG_RETRY_NOWAIT comes into play in this patchset only in
> > > the context of uffds, therefore that check seems to be needed when we
> > > enable per-VMA lock uffd support, which is this patch. Does that make
> > > sense?
> >
> > I don't see why uffd is special in this regard, as e.g. swap also check=
s
> > NOWAIT when folio_lock_or_retry() so I assume it's also used there.
> >
> > IMHO the "NOWAIT should never apply with VMA_LOCK so far" assumption st=
arts
> > from patch 3 where it conditionally releases the vma lock when
> > !(RETRY|COMPLETE); that is the real place where it can start to go wron=
g if
> > anyone breaks the assumption.
>
> Um, yes, you are right as usual. It was clear to me from the code that
> NOWAIT is not used with swap under VMA_LOCK, that's why I didn't
> consider this check earlier. Yeah, patch 3 seems like a more
> appropriate place for it. I'll move it and post a new patchset later
> today or tomorrow morning with your Acks.

Posted v6 at https://lore.kernel.org/all/20230630020436.1066016-1-surenb@go=
ogle.com/

> Thanks,
> Suren.
>
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
