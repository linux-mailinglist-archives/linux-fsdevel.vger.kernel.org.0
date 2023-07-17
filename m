Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B7E7568C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjGQQNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 12:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjGQQNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:13:12 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8618EE4F
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 09:13:09 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5700b15c12fso47047747b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689610389; x=1692202389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CqPKH8zLjxPG0T2aNpKAIqJzacVH6EbJBb3LjExpjw=;
        b=cQpEj7wQVECv/U9cTpn+RN55ujAIWvks3MU4IX4Wr/hwnFIe0F/qx5YUKjSMpnx703
         CHzs0WWQ7uBihIAx5z5eiCKmCaltnArXhlaNRgavYeytVm5vSw/gQiRT1py2AerifbO6
         AiJnYOTJCz0R2HkNoD7T9Yf9t3z2uTFa83xyLrtRemXVRe2lrXcVvM5qyrJMMViUNE7U
         6aLZBv3MPfrrvSHz+w10LReOyQijeOLBQAf/Jl5WjQxapxktKezBDH2erUpWfo+TfrZS
         RnuZ/YnESkQ6HSr7gO5+BgLJh/oDlySt0yQzLcBh/BGfPb0h9TdwTyAHNWQPywULEg7z
         BUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610389; x=1692202389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CqPKH8zLjxPG0T2aNpKAIqJzacVH6EbJBb3LjExpjw=;
        b=AymGAD5kKvEvUTZ+1qPh6dAx+iwDWFrA1qYaY0Bt/do8whmYXh1iTMurIV2e5yKgSm
         R6u7C7mRYulwOcDr3FshedXF46XOfm6/glBwXuS8oSJJKs7Y3YKkx8aIkT98eMrWyOVX
         Y75zL5B6vjdZhZJ2eCOHlT1CgihiAnviqcngA1r0i49pvCZTdU6B8z8hsDA2PZeagDTz
         QjRuAe4KYp9rVshYxwjgoxo9674h7yR5x4RtQ7qVOngpb2xxS2RJt38+ZkyUYNqUdI+j
         pSIJ6lZmMr494+ky2Rku/sjBdw45RE6QPGGKE4jpvjrxXxzKkPGEX3Lpvbd98zP77YNT
         0HLg==
X-Gm-Message-State: ABy/qLZ0EkFR2hTqLgNT1q5IaQUwkw7r5ttbnozggITvgkXKMFS6Rz5k
        AgxQeyF4gn5EXQjAeBgZEkVZO2gHzIQzysPyjd1M
X-Google-Smtp-Source: APBJJlGog4dyfGlwFIS3iBtcrvJFLeH/ogm5YcXS+semC1utnZAcGzlBZgUKou2DvMgGuYXX4nNPAERtXRDz/TQJF88=
X-Received: by 2002:a81:67c1:0:b0:577:2fda:f181 with SMTP id
 b184-20020a8167c1000000b005772fdaf181mr12551811ywc.44.1689610388723; Mon, 17
 Jul 2023 09:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com> <20230712143831.120701-5-wangkefeng.wang@huawei.com>
In-Reply-To: <20230712143831.120701-5-wangkefeng.wang@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 12:12:58 -0400
Message-ID: <CAHC9VhSU=T5FEP=sZyNukykE-xRzWsqyddS2-+sEsy2bmfGHKQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: use vma_is_stack() and vma_is_heap()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:25=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawe=
i.com> wrote:
>
> Use the helpers to simplify code.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  security/selinux/hooks.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4e46cf3d67b6..289ef2d6a427 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3775,13 +3775,10 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>         if (default_noexec &&
>             (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
>                 int rc =3D 0;
> -               if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> -                   vma->vm_end <=3D vma->vm_mm->brk) {
> +               if (vma_is_heap(vma)) {
>                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECHEAP, NULL);
> -               } else if (!vma->vm_file &&
> -                          ((vma->vm_start <=3D vma->vm_mm->start_stack &=
&
> -                            vma->vm_end >=3D vma->vm_mm->start_stack) ||
> +               } else if (!vma->vm_file && vma_is_stack(vma) ||
>                             vma_is_stack_for_current(vma))) {

With the parens fix that Andrew already provided.

Acked-by: Paul Moore <paul@paul-moore.com>

>                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECSTACK, NULL);
> --
> 2.41.0

--=20
paul-moore.com
