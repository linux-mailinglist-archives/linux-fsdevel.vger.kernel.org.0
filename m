Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F067634D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 04:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjAUDTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 22:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjAUDTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:19:02 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A8A6AF45;
        Fri, 20 Jan 2023 19:19:01 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d10so3667184ilc.12;
        Fri, 20 Jan 2023 19:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNEPDeyZy+520jJ70Z8ubzdZCaFZrMQI2bVBkEs12kU=;
        b=E48zNa4BqUeY8ZRL/jlShcttii3p3GAN2DpMYV/mGhDlphOEpMmhtBcSxCnNGZDCtU
         7auLdY5G1YL8mWCUFAjimglHJgz0JVzFrPQZJj0MFMa0lpUk/uZqKPWZvS0UfVXhhQ2y
         mUwbYkc0PFd51QMQEUwBA8wsFCydxIVENehJb3J+Qrq7+GVZtAV6jYyKWrvKMVVEO1ts
         inD8lqciLPw3ayITq6+jpY/N/n1UGrraSqfrSZxBjFimze1ZUhQt1lOL5opVl+6AfwbO
         MpmzzqXLABam6kEYw95Lm3eytOYr4M3HzqGTS2vg9DNN4Q22H1QfAn20PsKY4cN8cFo/
         FK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNEPDeyZy+520jJ70Z8ubzdZCaFZrMQI2bVBkEs12kU=;
        b=AbiC7/J+Fb2JEAuv3cSmTbu+gchaKF5B2YYAz8taok8zLLFjCV9SiGPqA2wei7yTyp
         i50oX1j/HTI/DtIecH0kTrw1+03hjMDrIx3Xsqheqixaof/IU4npdsE1Pamxh4+Sy8II
         aUtWLym8nXSjprxnMPyCBn2nJQ55DWaO7PvoHGVypSFqDB/NtndHnMftKlYWZ9Tl5pgc
         VAQNl+8+E0V0e3Cxa0E7j2EYAe9oZPIjCc9RUuJiXhw17XKg0fRKAzg/GUW9f7sJnN6u
         kaR8fEdmRSgatgvhQKGSzGeLiIskSqXfuNmYZw5/JIB1LoFQuGradlovoh6/kYJUQJjd
         FgxQ==
X-Gm-Message-State: AFqh2koZSiF+zGzNkU1bXWZHMeMbi83dxqhxyYEby+LAra9Nb3IF+jy8
        n7tyuGZa+K4m0+P1DqZDaNEZ7xkrLA0XbJUQSy8J6GdytRQ=
X-Google-Smtp-Source: AMrXdXvfaALIHcVRYgfGgc9wNixFqvLW7HL6rErcMJV7rqwRwYXquOQcZheG2b0Z5jvuuiSMNnLIanOnFTRAgmav1nQ=
X-Received: by 2002:a92:c70e:0:b0:30e:a789:f0f7 with SMTP id
 a14-20020a92c70e000000b0030ea789f0f7mr1652606ilp.155.1674271140596; Fri, 20
 Jan 2023 19:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20230120144356.40717-1-gregory.price@memverge.com> <20230120144356.40717-4-gregory.price@memverge.com>
In-Reply-To: <20230120144356.40717-4-gregory.price@memverge.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 20 Jan 2023 19:18:49 -0800
Message-ID: <CANaxB-zet4+S4saBHgYPP6feppBVHkCRJxTkL8R-OyXa_gXG3Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 7:05 AM Gregory Price <gourry.memverge@gmail.com> wrote:
>
> Implement ptrace getter/setter interface for syscall user dispatch.
>
> Presently, these settings are write-only via prctl, making it impossible
> to implement transparent checkpoint (coordination with the software is
> required).
>
> This is modeled after a similar interface for SECCOMP, which can have
> its configuration dumped by ptrace for software like CRIU.
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  .../admin-guide/syscall-user-dispatch.rst     |  5 +-
>  include/linux/syscall_user_dispatch.h         | 19 +++++++
>  include/uapi/linux/ptrace.h                   | 10 ++++
>  kernel/entry/syscall_user_dispatch.c          | 49 +++++++++++++++++++
>  kernel/ptrace.c                               |  9 ++++
>  5 files changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
> index 60314953c728..a23ae21a1d5b 100644
> --- a/Documentation/admin-guide/syscall-user-dispatch.rst
> +++ b/Documentation/admin-guide/syscall-user-dispatch.rst

<snip>

> +
> +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> +               void __user *data)
> +{
> +       struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> +       struct syscall_user_dispatch_config config;
> +
> +       if (size != sizeof(struct syscall_user_dispatch_config))
> +               return -EINVAL;
> +
> +       if (sd->selector) {
> +               config.mode = PR_SYS_DISPATCH_ON;
> +               config.offset = sd->offset;
> +               config.len = sd->len;
> +               config.selector = sd->selector;
> +               config.on_dispatch = sd->on_dispatch;
> +       } else {

This doesn't look right for me. selector is optional and if it is 0,
it doesn't mean that
mode is PR_SYS_DISPATCH_OFF, does it?

> +               config.mode = PR_SYS_DISPATCH_OFF;
> +               config.offset = 0;
> +               config.len = 0;
> +               config.selector = NULL;
> +               config.on_dispatch = false;
> +       }
> +       if (copy_to_user(data, &config, sizeof(config)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
