Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12A5594EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 04:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiHPCgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 22:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiHPCgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:36:20 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCC27F114
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 15:55:04 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10e615a36b0so9813982fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 15:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HZakkHJVKNFI6jZ4hLAfbglCUW8iVAHkvu3aaDjohhA=;
        b=a/kkTQ6WcPEzTEIDNnBto4w370I3Qlmmcd8z0+g4PeyzIgVBajjzLtU7q4HC2hFSvB
         TvhrdfS/hWSfmqUpEMdfvZ7iRSZwDAUwKwgZmr7EaWqygBED0CAcu78LVbHEYgSwBAo6
         g/Gb5BZyCKEyOM2CELp1GFmVDul1ojw7hg4gFMag/orK+q9QpOv4Vfj7mARGiXNi/P5G
         KJCLahAGn0bvVzNeXUL6gLKaEf2f8o82jSjS6/zhALbRov95ZtiA+3bA+c/naQIo221L
         /NvlOtAXYtxI6nw4FMn24StR0YAqx3MQE9yMPMQ+M0ySvi9FmGiyPM9mIiagooKKHu3I
         0fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HZakkHJVKNFI6jZ4hLAfbglCUW8iVAHkvu3aaDjohhA=;
        b=bV6T1OTbfw58NBfa06Pihh21lgGFxlWnOweDtdfqQa2xjzrvcuQOKG/dmBO+kTFEhX
         WF/faZdJ1EH7Z1iluz36Xieo1fIpO2SNz0e4N9+BPdTXnc8Ut8lvZtlm1KlFiLk4OjEd
         WcoTpNMeYM5R9aJq0uBhbxdB0RtPnD7CRYVK1YntTx/FmUXH9uBb+tpscQhkd0nyPJxJ
         Cny4m18kFao41QeaIFbsxzj3ZZr/TZ0v/HNc55CjBZn1vi/mNG7Jo+H7KUozcqgLv1dn
         zT8z39TCxIrezqmIYvQM/QCD+H+i5o0tfJH2tr7EvFsmBa2UHNcFI0W5vfODebzZO3lF
         wg7A==
X-Gm-Message-State: ACgBeo1FSyDEVa1gpsJcrS3ciNPZcUaeDblL6Da3tGYWw5Hs+c71ivmm
        GvGvhdWkHFLIZN/m+A0z+xYGPW9I/FqJ8NKOkmUlRF4Y
X-Google-Smtp-Source: AA6agR6Wbbo3FOzM13Nq583KWcoOM+gQjLLU9n89feiUsQqKiCB0amaHEKkkpyqe4sxAB2xUQMY/P8k4CnitSNR2Oww=
X-Received: by 2002:a05:6870:310:b0:f1:f473:a53f with SMTP id
 m16-20020a056870031000b000f1f473a53fmr11976043oaf.34.1660604103870; Mon, 15
 Aug 2022 15:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200728234513.1956039-1-ytht.net@gmail.com>
In-Reply-To: <20200728234513.1956039-1-ytht.net@gmail.com>
From:   lepton <ytht.net@gmail.com>
Date:   Mon, 15 Aug 2022 15:54:53 -0700
Message-ID: <CALqoU4xbA5GbLxZOtGJO5Vv6z_XL9jhjWMTPbqEzS8-4mb8z+Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add filesystem attribute in sysfs control dir.
To:     linux-fsdevel@vger.kernel.org
Cc:     miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:45 PM Lepton Wu <ytht.net@gmail.com> wrote:
>
> With this, user space can have more control to just abort some kind of
> fuse connections. Currently, in Android, it will write to abort file
> to abort all fuse connections while in some cases, we'd like to keep
> some fuse connections. This can help that.
>
> Signed-off-by: Lepton Wu <ytht.net@gmail.com>
> ---
>  fs/fuse/control.c | 31 ++++++++++++++++++++++++++++++-
>  fs/fuse/fuse_i.h  |  2 +-
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index c23f6f243ad42..85a56d2de50d5 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -64,6 +64,27 @@ static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
>         return simple_read_from_buffer(buf, len, ppos, tmp, size);
>  }
>
> +static ssize_t fuse_conn_file_system_read(struct file *file, char __user *buf,
> +                                         size_t len, loff_t *ppos)
> +{
> +       char tmp[32];
> +       size_t size;
> +
> +       if (!*ppos) {
> +               struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
> +
> +               if (!fc)
> +                       return 0;
> +               if (fc->sb && fc->sb->s_type)
> +                       file->private_data = (void *)fc->sb->s_type->name;
> +               else
> +                       file->private_data = "(NULL)";
> +               fuse_conn_put(fc);
> +       }
> +       size = sprintf(tmp, "%.30s\n", (char *)file->private_data);
> +       return simple_read_from_buffer(buf, len, ppos, tmp, size);
> +}
> +
>  static ssize_t fuse_conn_limit_read(struct file *file, char __user *buf,
>                                     size_t len, loff_t *ppos, unsigned val)
>  {
> @@ -217,6 +238,12 @@ static const struct file_operations fuse_conn_congestion_threshold_ops = {
>         .llseek = no_llseek,
>  };
>
> +static const struct file_operations fuse_conn_file_system_ops = {
> +       .open = nonseekable_open,
> +       .read = fuse_conn_file_system_read,
> +       .llseek = no_llseek,
> +};
> +
>  static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
>                                           struct fuse_conn *fc,
>                                           const char *name,
> @@ -285,7 +312,9 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
>                                  1, NULL, &fuse_conn_max_background_ops) ||
>             !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
>                                  S_IFREG | 0600, 1, NULL,
> -                                &fuse_conn_congestion_threshold_ops))
> +                                &fuse_conn_congestion_threshold_ops) ||
> +           !fuse_ctl_add_dentry(parent, fc, "filesystem", S_IFREG | 0400, 1,
> +                                NULL, &fuse_conn_file_system_ops))
>                 goto err;
>
>         return 0;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 740a8a7d7ae6f..59390ed37bbad 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -45,7 +45,7 @@
>  #define FUSE_NAME_MAX 1024
>
>  /** Number of dentries for each connection in the control filesystem */
> -#define FUSE_CTL_NUM_DENTRIES 5
> +#define FUSE_CTL_NUM_DENTRIES 6
>
>  /** List of active connections */
>  extern struct list_head fuse_conn_list;
> --
> 2.28.0.163.g6104cc2f0b6-goog
>

Ping this old patch. I just checked and it still applies cleanly to HEAD.
Can we have this merged?

Thanks!
