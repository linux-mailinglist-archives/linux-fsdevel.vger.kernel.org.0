Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C31E752FAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjGNDDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGNDD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:03:29 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEAC2698
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:03:28 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-576a9507a9bso39177267b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689303808; x=1691895808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxN91l7lJLjM7NpLet8IL3ScV61vQ1hMth4QWxYqNrg=;
        b=A0/RP+8APT4/kBg7ktj/jqxRG5MOv3WH1MB2NKbU1pOA+l4QmvFOIYaQRxgSvBBi2i
         6oHCj53LhYnwSQdDtBgWZrQKi09+5eqxwUvNEJ8zmhcnsSwiHzXPqT6f/T9fjIv+RVfc
         E6MsiEZ5aPEd3agNcBwAcX2IVxAwcp24hZ3/GKOK/WVvjGCkfaozFQvpYlEX+HI3nm3R
         emcu76/2LXoYiTkCTevSwVrfxivF01Y5/194KzvkeeDMaNnRRu1lNsQl1+6MTNIXgkHy
         /Ol0xpSENABPYdlPRoQsuDjPvm/MjEUTE22qen2HfSnnTCzDryW/2LoGiMCI8NnbjHO6
         7+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689303808; x=1691895808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxN91l7lJLjM7NpLet8IL3ScV61vQ1hMth4QWxYqNrg=;
        b=KBZLhdL/pWgl3o5Pd6/AFM7HbbdYGaqWiqzbUysvchRBBZbSK1xSyyN7YOVHC++3ib
         qrpx3VULe5SRu/xiR84537vKRVMdMjiCMCb2aOBMUmcRNd/xFIQotLpyraSoQpKTfy0A
         X3Tsu5hxGXIve1vhY2LSncg79+Fg9opuiWeyu/FhYOsSnQ0Hs76p04+ewSOGMKV/04Tc
         fQlmMiyPb5+VgQFSydIFWfQuXQpNQBl61ZT89st28DrUcIdKXPaq+9VSfETEEs31XPR8
         Mwg57kMg5p2Eb+NFgFm3c/kYsV9/rSuNH8BM+FC1nuH6yeIAsEg5vePUpAHqFGIXROK2
         DiMg==
X-Gm-Message-State: ABy/qLafzfNzZdu8KUCSDpfoozoB97VFtgxkom+bNLlG5cFQNJpPnOjD
        DcyyaWNK0s6otJyEZOMRmnqTo5Vo+SgNawz7IJ9w1Jr9YUVbcfHLUPP16A==
X-Google-Smtp-Source: APBJJlHzwxFLMxwMg7Tv6a7IZN2HUePraXebHJUYVxUVRdnEunNPkRhFem6/v8cF++psr+xoHxOPQWxH5LC/O8wXBDg=
X-Received: by 2002:a81:4fc6:0:b0:57a:8de8:6eef with SMTP id
 d189-20020a814fc6000000b0057a8de86eefmr1648481ywb.24.1689303807652; Thu, 13
 Jul 2023 20:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-3-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-3-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 20:03:16 -0700
Message-ID: <CAJuCfpEL0OH+SASV_fxuZrLmqwRB2wbV4zdTjiFQqSSzQDMXHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] mm: Allow per-VMA locks on file-backed VMAs
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 1:21=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> The fault path will immediately fail in handle_mm_fault(), so this
> is the minimal step which allows the per-VMA lock to be taken on
> file-backed VMAs.  There may be a small performance reduction as a
> little unnecessary work will be done on each page fault.  See later
> patches for the improvement.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/memory.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 2c7967632866..f2dcc695f54e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5247,6 +5247,11 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *=
vma, unsigned long address,
>                 goto out;
>         }
>
> +       if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
> +               vma_end_read(vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         /*
>          * Enable the memcg OOM handling for faults triggered in user
>          * space.  Kernel faults are handled more gracefully.
> @@ -5418,12 +5423,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
>         if (!vma)
>                 goto inval;
>
> -       /* Only anonymous vmas are supported for now */
> -       if (!vma_is_anonymous(vma))
> -               goto inval;
> -
>         /* find_mergeable_anon_vma uses adjacent vmas which are not locke=
d */
> -       if (!vma->anon_vma)
> +       if (vma_is_anonymous(vma) && !vma->anon_vma)
>                 goto inval;
>
>         if (!vma_start_read(vma))
> --
> 2.39.2
>
