Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3F740121
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjF0Q2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjF0Q2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:28:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2A35BF
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:27:39 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b5d57d7db9so3716140a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687883238; x=1690475238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJFRdvLZEJUWCkL2EK4nO+CExAHFvCuxR6yO/np/Csg=;
        b=itTKOTQ86SntEjnwzI4JoX0BexZJ1pu/XpytRxK4zPckna0jMVyksw9xu+EJszLZeP
         8uFIG0vTobqWN5ctzM/QeA/zhhBpfP8gK7w4NzNLu21ddFYzQd5uCJdZLIkHRhDjsPEt
         cS6icMdVzW99rSPmL/p3rwoFz4jR+q2+SnMdZVLC6e712lumkhlu36B+3aINvRmEV8H3
         iPdVy1BUeFBDfdR/QZozT86M6pj52wygB6XXH+6+jFI2kelNI3P10IjmAvJtMlLstYA+
         90GTZKwcFW30u72Q7hXfvi0YvmHa6e7Ovz5y4CwphiczY10m7mo2NMV22k3w/QjhePPk
         1H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883238; x=1690475238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJFRdvLZEJUWCkL2EK4nO+CExAHFvCuxR6yO/np/Csg=;
        b=C2UZ3I/aKzr7B+bkJXDbq/0JUyJt8rnPr3m/CpPFPQrfazo5uwydP1+oUh33NJrPXU
         WZZWPVL2TInvTnprI2V6Sa5z2wzsWPkgWcc4h0+ir98xOZgCXAf3Y4Tdtcrp3Z7+URZZ
         AfYLv1V6Jigo/e/6fe0PjA7SzCXJAMHyyj7O25yMNWjBvAIv01oRSg1fPqkRbaI2QMr3
         SuAWJYgHmL9v54d8JFzASoy0egEvfJhSv1Up5jF2/xCVA++mDyYP/4Ht2zz8gJV4v5yG
         YM9Vh5F99cyB8O6H3s7fKne56z7Sw8StUY58e4xrgr3vXmK0jRRbX1ep6yzpF1/L1rON
         XJUw==
X-Gm-Message-State: AC+VfDzlbBgTYlb2uuPujzjkdfqJJRJoxYr/Ke1Z47bhlk6/0byXG/Vt
        FaUlOOFJUfPeCH5seg5GNTrhbW4OoMMquxZ4XX4eMg==
X-Google-Smtp-Source: ACHHUZ57VoQ12kfJ5zjAGQLFgpBtvhsvnVdfU8lZ1iezcQnh18vfcwTjU+DhFqTazNLmGcrrtgw2UT9xzFgboNl4Akw=
X-Received: by 2002:a9d:7510:0:b0:6b7:397a:6342 with SMTP id
 r16-20020a9d7510000000b006b7397a6342mr7691290otk.16.1687883237932; Tue, 27
 Jun 2023 09:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com> <20230627042321.1763765-5-surenb@google.com>
 <ZJr+vlkIpaHWj1xg@x1n>
In-Reply-To: <ZJr+vlkIpaHWj1xg@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 09:27:07 -0700
Message-ID: <CAJuCfpFFVvdwJUzZHrBZYS7YgQkphudCNKB6m55XigFXfJGRCg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mm: replace folio_lock_or_retry with folio_lock_fault
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 8:22=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 26, 2023 at 09:23:17PM -0700, Suren Baghdasaryan wrote:
> > Change folio_lock_or_retry to accept vm_fault struct and return the
> > vm_fault_t directly. This will be used later to return additional
> > information about the state of the mmap_lock upon return from this
> > function.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> The patch looks all fine to me except on the renaming..
>
> *_fault() makes me think of a fault handler, while *_lock_or_retry() was
> there for years and it still sounds better than the new one to me.
>
> Can we still come up with a better renaming, or just keep the name?

I thought about alternatives but could not find anything better. I can
keep the old name if that is preferred.

>
> Thanks,
>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
