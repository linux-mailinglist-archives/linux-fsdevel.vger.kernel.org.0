Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0459522DB52
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 04:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgGZCL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 22:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgGZCLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:11:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A65C0619D2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2020 19:11:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so11562999wrh.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2020 19:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BY5Poqr2fA3RRuOzlPlb22Tg24jxGxBQVUUxrbzh/M=;
        b=KWW7XRvnNCgZsnxgTX9/6O5WphsFCiJ5rLsriaFFCjo0w89hIZa98KECDv1RbTuJsB
         OwKi4lc2CXeYWMG/TPbEpfad9Wc9R2wKh3+FpYWffG0Vj2ymqxzWsqtD2oe6xw1lPfPU
         wY0u30YQLtGsFu3Ld/o0DcVKmZaLrdeMWiG2h4ItCsaC8aTXj/vbt6L39CVpNkLxuo2i
         l2AI4Ddif5Z4Nm3HM5K6pJUACvOMOX3lTuVi4NvMtjLOr5UYjtUy+fiRH2e1+hykOBxi
         H5RKk/F7BWjL+NkminG2g9cQeJ10xBI5HZ/CuDaCqKhKGTNVfotpQNpwHjMKXkne3blx
         N9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BY5Poqr2fA3RRuOzlPlb22Tg24jxGxBQVUUxrbzh/M=;
        b=pbDBF/0H87clPtIY5+1APrSo5IhfI9M/yb1KtSoG3yB4hKgv9J3wR2UjVhvj7AJurg
         3rzYfsXbd+CghPEAohQ7fqGV4VB+kkelzlcp5j5u0ihFAvDrlVPoHblXfgpYZ0zFHMj1
         mddt1Kl4Sp2dxEFXWogFlI/KvjylXm80OSHSnIdSyBxaRmU0ijejABlkXGaIBtm2eVAx
         Lpl8ilSNAHoCx79QReCP82K9PVdpw0FRAHyMxZY+rLzak43iPudyb7CViY8yYmFkReZi
         NX9L0jUOpHOxukaHOjkDnpqY/gODpSdptWWOIvcECdwDuEWBa39i0I9Ql5HvEZi1NIYF
         5tvw==
X-Gm-Message-State: AOAM530s/+OjEzBMp+y2pqjg2rSMIF8ZTDqkIe6M3+TUZsuWZE5bE8dA
        LtT44nDI5RpUIztXDOXl0Y55od6X6n1+BVWCKG6V9Q==
X-Google-Smtp-Source: ABdhPJzYjq53hix8vYV6O/NEWrQvf44oV97N5I8qZhQjdzG/xJ+YJAaus2rch7JC6PFRpE1E4F7UxrZeV8/91/vPRjk=
X-Received: by 2002:a05:6000:141:: with SMTP id r1mr10897990wrx.69.1595729514257;
 Sat, 25 Jul 2020 19:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200725045921.2723-1-kalou@tfz.net> <20200725051547.3718-1-kalou@tfz.net>
In-Reply-To: <20200725051547.3718-1-kalou@tfz.net>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Sat, 25 Jul 2020 19:11:43 -0700
Message-ID: <CAGbU3_nNeeZn8Sk28t_fqOEjBi81JXp67L7-2E+9J=8LHtcE7Q@mail.gmail.com>
Subject: Re: [PATCH v3] This command attaches a description to a file
 descriptor for troubleshooting purposes. The free string is displayed in the
 process fdinfo file for that fd /proc/pid/fdinfo/fd.
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry about all the noise, please disregard this one.


On Sat, Jul 25, 2020 at 7:04 PM Pascal Bouchareine <kalou@tfz.net> wrote:
>
> One intended usage is to allow processes to self-document sockets
> for netstat and friends to report
>
> Signed-off-by: Pascal Bouchareine <kalou@tfz.net>
> ---
>  Documentation/filesystems/proc.rst |  3 +++
>  fs/fcntl.c                         | 19 +++++++++++++++++++
>  fs/file_table.c                    |  2 ++
>  fs/proc/fd.c                       |  5 +++++
>  include/linux/fs.h                 |  3 +++
>  include/uapi/linux/fcntl.h         |  5 +++++
>  6 files changed, 37 insertions(+)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 996f3cfe7030..ae8045650836 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1918,6 +1918,9 @@ A typical output is::
>         flags:  0100002
>         mnt_id: 19
>
> +An optional 'desc' is set if the process documented its usage of
> +the file via the fcntl command F_SET_DESCRIPTION.
> +
>  All locks associated with a file descriptor are shown in its fdinfo too::
>
>      lock:       1: FLOCK  ADVISORY  WRITE 359 00:13:11691 0 EOF
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 2e4c0fa2074b..c1ef724a906e 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -319,6 +319,22 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
>         }
>  }
>
> +static long fcntl_set_description(struct file *file, char __user *desc)
> +{
> +       char *d;
> +
> +       d = strndup_user(desc, MAX_FILE_DESC_SIZE);
> +       if (IS_ERR(d))
> +               return PTR_ERR(d);
> +
> +       spin_lock(&file->f_lock);
> +       kfree(file->f_description);
> +       file->f_description = d;
> +       spin_unlock(&file->f_lock);
> +
> +       return 0;
> +}
> +
>  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>                 struct file *filp)
>  {
> @@ -426,6 +442,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>         case F_SET_FILE_RW_HINT:
>                 err = fcntl_rw_hint(filp, cmd, arg);
>                 break;
> +       case F_SET_DESCRIPTION:
> +               err = fcntl_set_description(filp, argp);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 656647f9575a..6673a48d2ea1 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -272,6 +272,8 @@ static void __fput(struct file *file)
>         eventpoll_release(file);
>         locks_remove_file(file);
>
> +       kfree(file->f_description);
> +
>         ima_file_free(file);
>         if (unlikely(file->f_flags & FASYNC)) {
>                 if (file->f_op->fasync)
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 81882a13212d..60b3ff971b2b 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -57,6 +57,11 @@ static int seq_show(struct seq_file *m, void *v)
>                    (long long)file->f_pos, f_flags,
>                    real_mount(file->f_path.mnt)->mnt_id);
>
> +       spin_lock(&file->f_lock);
> +       if (file->f_description)
> +               seq_printf(m, "desc:\t%s\n", file->f_description);
> +       spin_unlock(&file->f_lock);
> +
>         show_fd_locks(m, file, files);
>         if (seq_has_overflowed(m))
>                 goto out;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f5abba86107d..09717bfa4e3b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -980,6 +980,9 @@ struct file {
>         struct address_space    *f_mapping;
>         errseq_t                f_wb_err;
>         errseq_t                f_sb_err; /* for syncfs */
> +
> +#define MAX_FILE_DESC_SIZE 256
> +       char                    *f_description;
>  } __randomize_layout
>    __attribute__((aligned(4))); /* lest something weird decides that 2 is OK */
>
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 2f86b2ad6d7e..f86ff6dc45c7 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -55,6 +55,11 @@
>  #define F_GET_FILE_RW_HINT     (F_LINUX_SPECIFIC_BASE + 13)
>  #define F_SET_FILE_RW_HINT     (F_LINUX_SPECIFIC_BASE + 14)
>
> +/*
> + * Set file description
> + */
> +#define F_SET_DESCRIPTION      (F_LINUX_SPECIFIC_BASE + 15)
> +
>  /*
>   * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
>   * used to clear any hints previously set.
> --
> 2.25.1
>
