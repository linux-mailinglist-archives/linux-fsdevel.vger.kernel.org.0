Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB726F4887
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjEBQlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 12:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjEBQlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 12:41:36 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B23173C
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 09:41:35 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9d87dffadfso3337260276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683045695; x=1685637695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou1t/3BczDtOieZxUC6qnCvlEYzlS6VkX0oYBp6focA=;
        b=kiNjbvA116UNqx8OjpQ1Hem0hGkHTZgweFN06QYaIXcoeNvgaJ63hBH0LjlrRtq4re
         uRqbaUPa3Vb7G3a+rTY0KQXlUkQykLGOfY16TDALfzeCSg7Q+4ZJqfLAWVtmfkyCn7gC
         WT09jljF3cKoqnyVZzMe9BznyD3+UqIvsZNvFP3YtXAQcVSW5mvvvftJaFNNuOSjVt08
         Z5REVO6qKBeghWNWvWHhv2Is/+ykGWRlfIun/pzX2AEyGLc4w6dQj42ibHQ5RoUvml8T
         FwtLKi+aeL9F13e2GV8lDSZPEnwf05CEqfDV6SvUk7Xtuxps5jg+WRmD9fcGRD5j2lC+
         RcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683045695; x=1685637695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou1t/3BczDtOieZxUC6qnCvlEYzlS6VkX0oYBp6focA=;
        b=Imnd3heuDJmJV1yu3g2D06lRz3WF7n72/tPGrQBN2XzLFWt2+8efIZa7csTEGhaJpb
         oXVzF+15VGQjqwD8N5H2veh4u4RS7vgixfetFBd7TOHTF5+Su5SnmEUUNOpFi2x+cBJi
         9euAXxKWuz1R9HMjm8hRlEY3sisG3AEQjTjqSklBNln7jxXOrlUX0pV4mMKrA0bxasWJ
         MY7D+odLmTM7zk68DcceSR3RORHBnzrIRWFm6zaSY0JzNM9XHhYxXmfjp9aS5DR4Ym+A
         iETSfXaPO6u+0PIHmN0KDnCoyB7i/+6PvN8tHdxD/bDkjNSeWC+40WmbD1/k2Ig4vq2K
         lPUQ==
X-Gm-Message-State: AC+VfDygcknAU6aw/lptALhR7WzxQNVESclnmFQfxGU2I/fDGu18WQFw
        QggF7pqSYPn8mkrpyNSMwTJYa6F1OSf0xMkquwIV6g==
X-Google-Smtp-Source: ACHHUZ7pFgxpbEMoTmNRS1Qv8xPHDXRoO9l5+qMsCfPIWdI0vytp3y54ZJrtI+jqIanJWyVsQMBjkvkLNl+sTJjv5kY=
X-Received: by 2002:a25:688f:0:b0:b9e:7ef1:2bfb with SMTP id
 d137-20020a25688f000000b00b9e7ef12bfbmr2056028ybc.9.1683045695001; Tue, 02
 May 2023 09:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <20230501175025.36233-2-surenb@google.com>
 <ZFEeHqzBJ6iOsRN+@casper.infradead.org>
In-Reply-To: <ZFEeHqzBJ6iOsRN+@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 09:41:23 -0700
Message-ID: <CAJuCfpGhVLvSj8v5CyRskm1XiWL9_xEoKt2AtfbJDHmpdtUGCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: drop VMA lock before waiting for migration
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 2, 2023 at 7:28=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, May 01, 2023 at 10:50:24AM -0700, Suren Baghdasaryan wrote:
> > migration_entry_wait does not need VMA lock, therefore it can be droppe=
d
> > before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
> > lock was dropped while in handle_mm_fault().
> > Note that once VMA lock is dropped, the VMA reference can't be used as
> > there are no guarantees it was not freed.
>
> How about we introduce:
>
> void vmf_end_read(struct vm_fault *vmf)
> {
>         if (!vmf->vma)
>                 return;
>         vma_end_read(vmf->vma);
>         vmf->vma =3D NULL;
> }
>
> Now we don't need a new flag, and calling vmf_end_read() is idempotent.
>
> Oh, argh, we create the vmf too late.  We really need to hoist the
> creation of vm_fault to the callers of handle_mm_fault().

Yeah, unfortunately vmf does not propagate all the way up to
do_user_addr_fault which needs to know that we dropped the lock.

>
