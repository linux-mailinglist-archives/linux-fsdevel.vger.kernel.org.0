Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7300470A72B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 12:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjETK23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 06:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETK22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 06:28:28 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDE189
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 03:28:26 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-456f1cc1791so768255e0c.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 03:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684578506; x=1687170506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0mLfNRWNdPsGvR2m/OoROzZS/PWIq2DMzR8bi/cJHQ=;
        b=e9P8kFxyqenahtcfFKBaI5/fZRuYfFTRkc9C/vGeZr1HIhxfCMR7gBELOpR/0F35wc
         CyYu+jKGbIdtGDd4WoW9wGChOxgwllcbIhe505pGvT48jTDDYZSSo+77xIfdS99hH7aC
         SImloCNTndNRVgT9BmBFn05IVDgxLNvbFfzRCOo7TnK49ZuRywEO20t3RPavg2zGPwqE
         udBk+w9OkdD/lbDTCgCeGN2o5JKVrtRGtB858A8c0ODeg5Nx33w2mzVvxMe4BOvWDZvS
         p1IGRmRb2a/rIo8oEUib7PjGFWTYCqgc9bpj1zzbziwh0gWwOmRx/9egBBUUbHRA8TMk
         VI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684578506; x=1687170506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0mLfNRWNdPsGvR2m/OoROzZS/PWIq2DMzR8bi/cJHQ=;
        b=VZAHrQCXLk4eyJZMKOSvz5rH4kQVsI/+B1b1zcwBJmMb75N5SflGF9gNnOUQsBIL2v
         KBkY7tbWTRfjtCZzx7HEC0JaPvv/rV0mKNeRJK1T38tIIEI0ZtCnJoNwFUPqLGJpodgS
         P2ozeoiD6xE2bksnNq8SBddrZtYAI5EZnmKTSKafujeJbRQgZ6uaVCUynXL+68/AI5gT
         NpJ9kdvUr1Mv9MLd3IwczIGofHQtWbzOY/5K5a0NLtaKoCpFBLlyCx3jqhYswC85lkP7
         dtkAmZNE2cckkmIglsqLN9rbtMJr6yH6HwWgtVMbV52tdZeNsjb3c8+rgxZfYBI/v9vc
         TeCw==
X-Gm-Message-State: AC+VfDw3aPsj9p2SXlS+0XEJ4av6opTVr2wEK/07sN0q0z/n/PtVsmPj
        h3MIV62HqO0S5yg084zbWx/4B0+D3YoJV7qwUuE=
X-Google-Smtp-Source: ACHHUZ4N5Z7+DZ9S2sT9PgwGhDLuRCfszm8//KyuoLPuV7vqBlfkE/wbHhIW9kJ/u20J2EI6+GkkOGdVYcD04nsHYAM=
X-Received: by 2002:a1f:450b:0:b0:456:f5c4:a3e4 with SMTP id
 s11-20020a1f450b000000b00456f5c4a3e4mr1530026vka.6.1684578505754; Sat, 20 May
 2023 03:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com>
In-Reply-To: <20230519125705.598234-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 20 May 2023 13:28:14 +0300
Message-ID: <CAOQ4uxhRY1L0=KJ_iwq+Qey83Fpa+jnQ87w9OeYJqh8z_4664w@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 3:57=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Miklos,
>
> This patch set addresses your review feedback on Alesio's V12 patch set
> from 2021 [1] as well as other bugs that I have found since.
> This patch set uses refcounted backing files as we discussed recently [2]=
.
>
> I am posting this for several possible outcomes:
>
> 1. Either FUSE-BPF develpers can use this as a reference implementation
>    for their 1st phase of "backing file passthrough"
> 2. Or they can tell me which API changes need to made to this patch set
>    so the API is flexible enough to extend to "backing inode passthrough"
>    and to "BPF filters" later on
> 3. We find there is little overlap in the APIs and merge this as is
>
> These patches are available on github [3] along with libfuse patches [4].
> I tested them by running xfstests (./check -fuse -g quick.rw) with latest
> libfuse xfstest support.
>
> Without FOPEN_PASSTHROUGH, one test in this group fails (generic/451)
> which tests mixed buffered/aio writes.
> With FOPEN_PASSTHROUGH, this test also passes.
>
> This revision does not set any limitations on the number of backing files
> that can be mapped by the server.  I considered several ways to address
> this and decided to try a different approach.
>
> Patch 10 (with matching libfuse patch) is an RFC patch for an alternative
> API approach. Please see my comments on that patch.
>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-fsdevel/20210125153057.3623715-1-balsin=
i@android.com/
> [2] https://lore.kernel.org/linux-fsdevel/CAJfpegvbMKadnsBZmEvZpCxeWaMEGD=
RiDBqEZqaBSXcWyPZnpA@mail.gmail.com/
> [3] https://github.com/amir73il/linux/commits/fuse-passthrough-fd
> [4] https://github.com/amir73il/libfuse/commits/fuse-passthrough-fd
>
> Changes since v12:
> - Rebase to v6.4-rc2
> - Reword 'lower file' language to 'backing file'
> - Add explicit FOPEN_PASSTHROUGH open flags
> - Remove fuse_passthrough_out container
> - Add FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl
> - Add experimental FUSE_DEV_IOC_PASSTHROUGH_SETUP ioctl
> - Distinguished errors for failures to create passthrough id
>   (EBADF, EOPNOTSUPP, ELOOP)
> - idr and fuse_file point to refcounted passthrough object
> - Use rcu_read_lock() to get passthrough object by id
> - Handle errors to setup passthrough in atomic_open()
> - Invalidate mtime/size after passthrough write
> - Invalidate atime after passthrough read/mmap
> - Bump FUSE protocol minor version

> Alessio Balsini (2):
>   fs: Generic function to convert iocb to rw flags
>   fuse: Definitions and ioctl for passthrough
>
> Amir Goldstein (8):
>   fuse: Passthrough initialization and release
>   fuse: Introduce synchronous read and write for passthrough
>   fuse: Handle asynchronous read and write in passthrough
>   fuse: Use daemon creds in passthrough mode
>   fuse: Introduce passthrough for mmap
>   fuse: update inode size/mtime after passthrough write
>   fuse: invalidate atime after passthrough read/mmap
>   fuse: setup a passthrough fd without a permanent backing id
>

Hi Alessio et al.

FYI, the authorship of the patches in this set have been randomly
reset by git rebase.

I've restored Alessio's authorship on my branch for patches 4-7
which I have changed only mildly.

OTOH, I have taken over authorship on patches 2-3 which I had
made more significant changes to (i.e. refcounted backing files).

Also, please note my comment on patch 2 for copyright notice
on the new passthrough.c file.

Thanks,
Amir.
