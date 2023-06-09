Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29EE72A643
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 00:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjFIWaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 18:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjFIWaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:30:24 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0334135BE
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 15:30:23 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-568f9caff33so21083537b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686349822; x=1688941822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zT6sV+fvzmgBBI81QXgaF+Btrnt6GH7aWTnX6MCUB4=;
        b=mXAcURqk+1SjmifAbWS+rzdBg3sJG/XNRZ8y8ysR8INkOv4gWnF+xs+y+SYfhtf6N/
         RUzqMQwHktqLGXnFqUtsvhF5L9vLpFUwvm2N9epG17Y0Vp2wpI7ZrzX8JDonWRmiow43
         mX+mucGCdEZRZwBSCuNbliPjS+zKIFFWb9/ic7yJM7pykYyKn+2kH4loCcZKtPEoA1iE
         lVZoLXJDhsiAM0IcrGBlFgWLUzxo4jWTIDQDnDuTB/9r0dEv+ey0PgmSn+GZP+iXEtW9
         SOuHwnTb87WF5tfCuyWfCUydVDBd/5vbNI4gxJKZAzwgeQAoWA573b3Zpk+zJz2L5oom
         Ryow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686349822; x=1688941822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zT6sV+fvzmgBBI81QXgaF+Btrnt6GH7aWTnX6MCUB4=;
        b=fo/yz6++K2ttl+7Xjl8jz/wo2niEIGU17sPJ9wtO3rWnhChCM0Rx3N19mvHgShvgqj
         34x+Ek3iBU3BjJk72rwIU28BcGGSt5/dEEX0ZM3VEOf6aIk1AuuleSdOdEZY+2CL40Cg
         hKMca7sFGrzw6aXzLG55bJGsDYiouBRtRUeggyrUENHT2cXWWLlqtWUwe02BVNJTNZ11
         XUMP8jtC/NyhzMdTw8n+2tADBgeNZl8yywZJcAf+zCRIRw9HKf9YChVkj4NmvIghNanJ
         HOcCwv7Mf0e6UrKqCPAsxPnNT4u4/oItkqMcRoeDYWY/iZcuNbxn1bWg6nmviuwMzq4p
         BVGA==
X-Gm-Message-State: AC+VfDy6SYnryV6fHb68kjhhmdRnMmAaWeSiTQzrbsq9/bg7S30Qg0Uz
        FP/QXqkRw13KLNvGk5Ucv8MU//LPqzY3HiLI6bFPww==
X-Google-Smtp-Source: ACHHUZ5TZvpX4UfdCUpjEiPqY6QZGnmNogZwNLVZjipLgMlKuWApKPOOPeExrL9FO8ZqBOPgG6jGQ762Win+1tZG15A=
X-Received: by 2002:a0d:d8cb:0:b0:559:e1b2:70c6 with SMTP id
 a194-20020a0dd8cb000000b00559e1b270c6mr2210211ywe.34.1686349821843; Fri, 09
 Jun 2023 15:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-5-surenb@google.com>
 <ZIOOmC26qh4EXUEX@x1n>
In-Reply-To: <ZIOOmC26qh4EXUEX@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jun 2023 15:30:10 -0700
Message-ID: <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
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

On Fri, Jun 9, 2023 at 1:42=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wrote:
> > migration_entry_wait does not need VMA lock, therefore it can be droppe=
d
> > before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
> > lock was dropped while in handle_mm_fault().
> > Note that once VMA lock is dropped, the VMA reference can't be used as
> > there are no guarantees it was not freed.
>
> Then vma lock behaves differently from mmap read lock, am I right?  Can w=
e
> still make them match on behaviors, or there's reason not to do so?

I think we could match their behavior by also dropping mmap_lock here
when fault is handled under mmap_lock (!(fault->flags &
FAULT_FLAG_VMA_LOCK)).
I missed the fact that VM_FAULT_COMPLETED can be used to skip dropping
mmap_lock in do_page_fault(), so indeed, I might be able to use
VM_FAULT_COMPLETED to skip vma_end_read(vma) for per-vma locks as well
instead of introducing FAULT_FLAG_VMA_LOCK. I think that was your idea
of reusing existing flags?

>
> One reason is if they match they can reuse existing flags and there'll be
> less confusing, e.g. this:
>
>   (fault->flags & FAULT_FLAG_VMA_LOCK) &&
>     (vm_fault_ret && (VM_FAULT_RETRY || VM_FAULT_COMPLETE))
>
> can replace the new flag, iiuc.
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
