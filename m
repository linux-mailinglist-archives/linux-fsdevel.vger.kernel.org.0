Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327047A14BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 06:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjIOEP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 00:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjIOEPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:15:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B67A2710
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 21:15:46 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d7b91422da8so1653909276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 21:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694751346; x=1695356146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FamDpRRxOJ58SltchwNZF7P11BnxlXwApaRPCg7sEgs=;
        b=GTze/FHqzukfn7AScJn8BMG2yWF1Xw8G63BUAZ/Q4be0K4cde+lfKRyg2PTQCIRx7s
         WDr6+rlwAMCsi9GBEEpMb93yQb+Y/pZw79j2F66ZNnNcyV0eqiOBo1bfHIz69RYaB0hV
         n4B92N/u1hH+tp3lyQrLCSQV/XH8O4bX9/CDLdMWdRuUOihPDtLDrf9ZXV5NtxWTCIoZ
         xlCw6/8yr8+XEoti5UurASxT0dfLH9mM7vKW/drQ9vX5vq/wOpZZ1kMfGHkMPMnnPK2m
         seJNNNytyED/2Xr0fhPRXHBXuEQQmosIsBqwFeNRh6oGCfEUfRFihElwTHJYd6pKgANm
         hrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694751346; x=1695356146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FamDpRRxOJ58SltchwNZF7P11BnxlXwApaRPCg7sEgs=;
        b=N+bvKVX4n/VJkPiO5qJTpIpFcLRXun3wkUFQiQ4bNRA3zhIYEXdXR7V3k+iOxjTW3G
         WIjJ/zetH5sQZ77KcHY/HRkGb39dm7geU2vOz3g+bcqlaoQmBcDkSIa7XLSMMtxPEL6+
         BHc76MESLLnCQIjn0pSr7kOKsWzOgMWFQxfKwe/oiFCZ5t0lkzCjI1kf2XIbsLaCjnCY
         FeH8BaUR/k2DzJR+Q0ck8wdwqku1jVQNK1oKP5610fANLMc8LjAG74CO6CftvzoK+G8X
         ZR9QNJ9zsO3p2SEwkdow4dl2zHoIQgfo0Jr4t8HrZ3/JeHNfBE6WJktKJWb/k8DVWaSn
         mrtA==
X-Gm-Message-State: AOJu0YzjiPwy6OuLGvN9jrpbcOKmOa5FHbrUjyPrRwaz0HURrDmvj548
        g6Q2aZGURtQzhWQm09lqDY5FLNBPBOgRTGp+JjpdBQ==
X-Google-Smtp-Source: AGHT+IFnqWx0uXRyMpqiHFFl7wXq7TmCLUPNB45WfzsSh3Iwf38WnhwAFRVFx/qVUqXsUALqr8w0a8O7MgSyOCVK4No=
X-Received: by 2002:a25:ae1c:0:b0:d4d:f157:9673 with SMTP id
 a28-20020a25ae1c000000b00d4df1579673mr418753ybj.26.1694751345603; Thu, 14 Sep
 2023 21:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <4F9BBE45-22D0-4F8D-BA56-CA3459998DC4@gmail.com> <CAJuCfpGWkzDUL4+9evD-Kx5uGoc+=g808CXtc1hrSUdCRMtRgA@mail.gmail.com>
 <C04B3D0F-A757-49A5-9CF4-3387EED41562@gmail.com>
In-Reply-To: <C04B3D0F-A757-49A5-9CF4-3387EED41562@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 21:15:31 -0700
Message-ID: <CAJuCfpESQFWPuGS0_8swoM3iGEUbpeOH7Z9dvsPJZ5dJ1ENDDg@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>, lokeshgidra@google.com,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, mhocko@suse.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Liam.Howlett@oracle.com,
        Jann Horn <jannh@google.com>, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:04=E2=80=AFAM Nadav Amit <nadav.amit@gmail.com> w=
rote:
>
>
>
> > On Sep 14, 2023, at 8:28 PM, Suren Baghdasaryan <surenb@google.com> wro=
te:
> >
> > On Thu, Sep 14, 2023 at 2:57=E2=80=AFPM Nadav Amit <nadav.amit@gmail.co=
m> wrote:
> >>
> >>
> >>> On Sep 14, 2023, at 8:26 AM, Suren Baghdasaryan <surenb@google.com> w=
rote:
> >>>
> >>> +     if (!pte_same(ptep_clear_flush(src_vma, src_addr, src_pte),
> >>> +             orig_src_pte))
> >>> +             BUG_ON(1);
> >>
> >> Just a minor detail regarding these few lines:
> >>
> >> Besides the less-than-ideal use of BUG_ON() here, I think that this co=
de
> >> assumes that the PTE cannot change at this point. However, as the PTE =
was
> >> still mapped at this point, I think the access and dirty bits can be s=
et.
> >
> > At this point we are holding PTLs for both PTEs (see
> > double_pt_lock()).  Can a PTE be modified from under us in this
> > situation?
>
> PTEs has several parts: access-control bits (e.g., writable), physical
> frame number, software-only bits and log-bits. The log-bits, which are
> =E2=80=9Caccess=E2=80=9D and =E2=80=9Cdirty=E2=80=9D on x86, track whethe=
r the PTE has ever been used
> for translation or write correspondingly.
>
> Without getting into all the subtleties (e.g., =E2=80=9Caccess" can be se=
t
> speculatively even if no actual access take place), as long as the PTE
> is present, it might be used for access (and write if it is writable)
> by other cores. The page-table locks are irrelevant here, because the
> PTE is not updated by software, but it is updated by the CPU itself
> during the page-walk/write.

Ah, I see. I believe Jann also pointed this out in one of his comments
and I didn't realize that. Thanks for the note! I'll see how I can
rework this.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
