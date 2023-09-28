Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6867B2625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 21:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjI1Tus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 15:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjI1Tur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:50:47 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628C319F
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 12:50:45 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a21ea6baccso18530367b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695930644; x=1696535444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP4BbdJTdcgYDV7Qx/mEWw5rQtFKtKyVqI/O28O5mPs=;
        b=qCklHZGThcv0o4pW/DfbuF4e+E+zbDeZaAzVTwed5XuQQr1BNvp8X16nQWZ80TySrl
         V/djSMyFV2glY2wrBUNkffcxNWtBK46APiVCHGwHMH7KayBXCV42sBIoKs9ozxDbnG72
         Sp2Jhgyl/iKdt5+WtBUBmdJarcdn8p2XTuO6ItVcOrR3jCX3ElW6n/cwgXN2MXswGEFx
         8AEASsrbEftrrnrzqB/EKVcxOc8JEE1wMVYqRrvhP3KgjzHtDiIs9k/oWqS+jO99FqNk
         D/Ak/sMmrh4Qj/QRqO/zvFXOvNmr4nATY5HPl45FVt+/38RUeuGohbAC2L22+bDSBBwo
         GAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695930644; x=1696535444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gP4BbdJTdcgYDV7Qx/mEWw5rQtFKtKyVqI/O28O5mPs=;
        b=bo9OqDMlKmZcUayJvjqtu+eVXQYIuzBxwX7/7fqldolxa/S7uQezYr7OFhMLkuvlaV
         c9XDSmtyjdECX7htljAjoJ7cxmXmf7R0lsHScDSn/sseMaOsLvRupW+tElVyLL2p4WGf
         AcScGJ2wPw9mEtUq13buyFG3X4uHj3QDqcb7jL0V6YnD71QYz3evfvDF3hl4DEQYfY5y
         HlBl3ZATkNPS/CvD04ZeiLaLcBcWp0gbw+lWzmWNZ6uutR8shZGG+gxt/BlonoCAddcZ
         Svew6qCJO15xIdP0hZENDRGg5RaaNmTNbi0z2fProhQAuFzr05kToKd50USv6hcvUxPv
         JOrw==
X-Gm-Message-State: AOJu0YyvJyBn8VxxVsAXFlXXTSreagtswSa5TMqBE/xQbO0Jtz/0SL3y
        y79i8XgY7VfIcYpigDcIGH7Iz+tgEVAuJuOrKTRKqQ==
X-Google-Smtp-Source: AGHT+IG3Rb7Z0h/ROaA3hCrSRrRuw/6HH5fqObICNocBlKuL+ih7nn5iO35GIC3JuJEF8FbPK8kIVC0dF9VSiIqv+Jo=
X-Received: by 2002:a81:848f:0:b0:584:61df:45e8 with SMTP id
 u137-20020a81848f000000b0058461df45e8mr2449845ywf.13.1695930644215; Thu, 28
 Sep 2023 12:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <ZRXJZyPMdVsQNt4h@x1n>
In-Reply-To: <ZRXJZyPMdVsQNt4h@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Sep 2023 12:50:33 -0700
Message-ID: <CAJuCfpFttknDCAOaiR25Nw4_MS=YSpQNqzFPeEh41gtCVgCs0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:43=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> One more thing..
>
> On Fri, Sep 22, 2023 at 06:31:45PM -0700, Suren Baghdasaryan wrote:
> > +static int remap_pages_pte(struct mm_struct *dst_mm,
>
> [...]
>
> > +retry:
> > +     dst_pte =3D pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, &dst=
_ptl);
> > +
> > +     /* If an huge pmd materialized from under us fail */
> > +     if (unlikely(!dst_pte)) {
> > +             err =3D -EFAULT;
> > +             goto out;
> > +     }
> > +
> > +     src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, src_addr, &src=
_ptl);
> > +
> > +     /*
> > +      * We held the mmap_lock for reading so MADV_DONTNEED
> > +      * can zap transparent huge pages under us, or the
> > +      * transparent huge page fault can establish new
> > +      * transparent huge pages under us.
> > +      */
> > +     if (unlikely(!src_pte)) {
> > +             err =3D -EFAULT;
> > +             goto out;
> > +     }
>
> For these two places: I know that thp collapse with mmap read lock hasn't
> yet spread to anon (so I assume none of above could trigger yet on the
> failure paths), but shall we constantly return -EAGAIN here just in case =
we
> forget that in the future?
>
> For example, for UFFDIO_COPY over shmem which we can already hit similar
> case, mfill_atomic_install_pte() has:
>
>         ret =3D -EAGAIN;
>         dst_pte =3D pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
>         if (!dst_pte)
>                 goto out;
>
> Thanks,

Retrying in this case makes sense to me. Will change.

>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
