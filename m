Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5707B8175
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjJDNz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbjJDNz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:55:27 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1ABCC
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 06:55:23 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-45274236ef6so1094667137.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696427722; x=1697032522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnxMde0EiLiD5RMrr/cF2VRBsKVJXuXDWUwSWiGEZS0=;
        b=GrmO1qlAabXhPl/ARyuR/JG+lAfTECm0GfmZEWvZ8aVmptfdiK+rledSQAFf0aGjXN
         +n8l3AoPjG1h+6VQDi9aswGGREp1/bVcFcseknkF98+AabewpKigG2y6/DMJOplWTA1o
         mIaZJsg5HyYgG+HMRxuMyzJxusIi4qnREYIDbt7+Cj0jcBCX5shpawepnJ6OrOEi/8ii
         XHrX5ZbrGr/EsfxkL11yobQleeXxCGod5eRyufqC2VKqYRciTiwzFUdFhQJ2ZcQ4sGqV
         T2TG3JAIo1TKhBT8D68Mif5twNh41oL68c4zqJsjHCpdNLH88ZSd8ffu3PZ2yxP82ZJa
         Sa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696427722; x=1697032522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnxMde0EiLiD5RMrr/cF2VRBsKVJXuXDWUwSWiGEZS0=;
        b=tT0Hw1DjhJEtTdIUQcSGZwbx8KDHk28l45O/yZEmRXUteBpIFn4jOiEwOG735cyZbG
         qFoWC1aWbgJ4emmDu9fepqUHrhLxKPXA+NvU4ZfObNX2VYMQFkv9zYLbD7zWflgOnzNT
         1aTF4MM7+B8ZGeWa7+FoGtAjfNVqvi1MPJy5T5oVzV2hQckxqQEvvjNg7A1WXUdZZq1u
         GipsjkKgmjvplHFOdWHKXjny2mExw5gyTRvsF6v+gwPu1nQ6XbR6//0rNeJbC/ozHgly
         mgqQWGfg4eWh5Q0T12LXLc3zKAiW1tabar7ebZT0gnJ6IzCRwdyKbpHCl0gNYC6ZQR+0
         h+Ug==
X-Gm-Message-State: AOJu0YyaeOw/DNW5jIMokUWzeFMHbHcFyjBrO2l4DW3n7pZMiqKJS/lB
        wRmzAjMaF7th8EWiYC1USlM6xaPpwneX8eEnU1E=
X-Google-Smtp-Source: AGHT+IG3yXBpD7ZPYx/nzv2oVaR4xk6rIJBJ8YCR08y7FHi5d/vF4Q2E2k+igkKa8WWd8YMJrpeVTqYkcsTRv5kS1zg=
X-Received: by 2002:a67:fdd0:0:b0:454:2d1e:6ced with SMTP id
 l16-20020a67fdd0000000b004542d1e6cedmr2234023vsq.27.1696427722565; Wed, 04
 Oct 2023 06:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231004124712.3833-1-chrubis@suse.cz> <20231004124712.3833-3-chrubis@suse.cz>
In-Reply-To: <20231004124712.3833-3-chrubis@suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Oct 2023 16:55:11 +0300
Message-ID: <CAOQ4uxg8Z1sQJ35fdXnct3BJoCaahHoQ9ek3rmPs3Ly8cVCz=A@mail.gmail.com>
Subject: Re: [PATCH 2/3] syscalls/readahead01: Make use of tst_fd_iterate()
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, Matthew Wilcox <willy@infradead.org>,
        mszeredi@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Reuben Hawkins <reubenhwk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 4, 2023 at 3:46=E2=80=AFPM Cyril Hrubis <chrubis@suse.cz> wrote=
:
>

Hi Cyril,

Thanks for following up on this!

> TODO: readahead() on /proc/self/maps seems to succeed is that to be
>       expected?

Not sure.
How does llseek() work on the same fd?
Matthew suggested that we align the behavior of both readahead(2)
and posix_fadvise(2) to that of llseek(2)

>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../kernel/syscalls/readahead/readahead01.c   | 46 ++++++++-----------
>  1 file changed, 20 insertions(+), 26 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcase=
s/kernel/syscalls/readahead/readahead01.c
> index bdef7945d..28134d416 100644
> --- a/testcases/kernel/syscalls/readahead/readahead01.c
> +++ b/testcases/kernel/syscalls/readahead/readahead01.c
> @@ -29,44 +29,38 @@
>  #if defined(__NR_readahead)
>
>  static void test_bad_fd(void)
> -{
> -       char tempname[PATH_MAX] =3D "readahead01_XXXXXX";
> -       int fd;
> -
> -       tst_res(TINFO, "%s -1", __func__);
> -       TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF);
> -
> -       tst_res(TINFO, "%s O_WRONLY", __func__);
> -       fd =3D mkstemp(tempname);
> -       if (fd =3D=3D -1)
> -               tst_res(TFAIL | TERRNO, "mkstemp failed");
> -       SAFE_CLOSE(fd);
> -       fd =3D SAFE_OPEN(tempname, O_WRONLY);
> -       TST_EXP_FAIL(readahead(fd, 0, getpagesize()), EBADF);
> -       SAFE_CLOSE(fd);
> -       unlink(tempname);
> -}
> -
> -static void test_invalid_fd(void)
>  {
>         int fd[2];
>
> -       tst_res(TINFO, "%s pipe", __func__);
> +       TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF,
> +                    "readahead() with fd =3D -1");
> +

Any reason not to include a bad and a closed fd in the iterator?

>         SAFE_PIPE(fd);
> -       TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
>         SAFE_CLOSE(fd[0]);
>         SAFE_CLOSE(fd[1]);
>
> -       tst_res(TINFO, "%s socket", __func__);
> -       fd[0] =3D SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> -       TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> -       SAFE_CLOSE(fd[0]);
> +       TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EBADF,
> +                    "readahead() with invalid fd");
> +}
> +
> +static void test_invalid_fd(struct tst_fd *fd)
> +{
> +       switch (fd->type) {
> +       case TST_FD_FILE:
> +       case TST_FD_PIPE_OUT:
> +               return;
> +       default:
> +               break;
> +       }
> +
> +       TST_EXP_FAIL(readahead(fd->fd, 0, getpagesize()), EINVAL,
> +                    "readahead() on %s", tst_fd_desc(fd));

Thinking forward and we would like to change this error code to ESPIPE
is there already a helper to expect one of a few error codes?

Thanks,
Amir.

>  }
>
>  static void test_readahead(void)
>  {
>         test_bad_fd();
> -       test_invalid_fd();
> +       tst_fd_iterate(test_invalid_fd);
>  }
>
>  static void setup(void)
> --
> 2.41.0
>
