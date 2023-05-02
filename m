Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6786F3C2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 04:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjEBCa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 22:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjEBCa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 22:30:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114C30EA
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 19:30:25 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9d87dffadfso2617413276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682994625; x=1685586625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G6dPJv34apkkUTZOn/wXRi+nDTY2i5t7eXogLIROvc=;
        b=uWiS1nLy/7di3XLvs7g/PIVpYA4NLnVMFXzQkM05HfhMgL890YSzMRf9gVwTZ9/UFM
         XqEBUD4m6FRbQOZlqECOgToFXOS13si0hFY8Tzy4OEojmsgeoCfYt2g7N7NGsEWxQsqa
         hjebEldHmvrQ3AuNVQN/tAuq6Y1iFdnM9Bp2H3WUtY4sNubtmRMddyRHhYFnDgEkIqfi
         DH03iG4PoDAv1n+rdOnrXjcWOx0/J6NZtQYTOj6KIXCfe+NrIU1miTSiN/PmDLfVqQ96
         GGCHPYajgMHrzMDDs7xs+Ocb6oe5bK4egrBqFLMK7B78q5WDZykCTR3IiHR8dlPVG8Wm
         kzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682994625; x=1685586625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/G6dPJv34apkkUTZOn/wXRi+nDTY2i5t7eXogLIROvc=;
        b=N9r4ZfTeaZJyp3Re8iUw/WZYaJa4qUVTKlZhNC5eyv7byxW9d59MJZ0arprIuLtpb8
         eRRCjQ+mgHK+sPOGSAXrQ7+OYRgKuiJxgDFyoT0zO10misKOs34ZTTatviiypX7096Xa
         QZg+6V+nGkZYiRL2QSxoL5gWtvDwKna4ApZwULlUAS/KTce63femUx04Pc80ZTkNET1p
         q1fAiYTqY+1oxDMHink15/pf8xgRZGrCXeqjhkpDIyIevO+RQHMB6x2Byee+a8Ni9KSX
         yotQIJLC3RSe/CLrwt+K9sw8zbT9sAaoyjCwZOkdoJjENVVyTv7g9QMDm+jiyHAWHI6R
         1hrQ==
X-Gm-Message-State: AC+VfDxDv2zWEGe58HW3xkS/0lHIezwfTqvcHHOrL7kdujQsr5Dz0DxS
        Vun1bWecxCVbrNVUNzqdY7OcieFVLdQKfvDx0P+ohQ==
X-Google-Smtp-Source: ACHHUZ7HfUm6L/opqOlLbSXr07QkfSrvDHFsxNVFu0JUgLgCA2mLQAuYNCefLkyXDbJlwIsn54Zch3GqkVvuqv0Lv7M=
X-Received: by 2002:a25:4010:0:b0:b95:941a:86c4 with SMTP id
 n16-20020a254010000000b00b95941a86c4mr15594810yba.26.1682994624671; Mon, 01
 May 2023 19:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <ZFBvOh8r5WbTVyA8@casper.infradead.org>
In-Reply-To: <ZFBvOh8r5WbTVyA8@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 1 May 2023 19:30:13 -0700
Message-ID: <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page is uncontended
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdasaryan wrote:
> > +++ b/mm/memory.c
> > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!pte_unmap_same(vmf))
> >               goto out;
> >
> > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > -             ret =3D VM_FAULT_RETRY;
> > -             goto out;
> > -     }
> > -
> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> >       if (unlikely(non_swap_entry(entry))) {
> >               if (is_migration_entry(entry)) {
>
> You're missing the necessary fallback in the (!folio) case.
> swap_readpage() is synchronous and will sleep.

True, but is it unsafe to do that under VMA lock and has to be done
under mmap_lock?
