Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844C53D08F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhGUFyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 01:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhGUFyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:54:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBCFC061574;
        Tue, 20 Jul 2021 23:34:57 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k16so1157548ios.10;
        Tue, 20 Jul 2021 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WX5jC3uVh8Xnn2cHsQhaDzjBDV/LCNyXvKRPWGeiPls=;
        b=WLHW7YWDypnte5Vt3/r92xdI4EAlqi7AkizT5e4/MDDN3U6s2KL0OqfWOW0jkRjBpo
         tGeOsr/7G4O/sO+ojqLpFvKsM/kw5ejqK1wJ0mTcdANKxPzLwOxrfX42cA8ZPlgY3gYV
         h9brKlsRxsCWl7shOfQ23/blcWwD0ZUijdEyVqqNUL87gTgqR8M7NnxT8o+Oq1mdCyI+
         C3n1zLXLzoZkQAB+3KLDptNyDjbYDBhlox7Ihg55jm50yG6zIl40t5nGrts8ONTvmn/3
         eBAhV3enAZH47jZrFCEOeP81sXKfg/hQbtmmWCyMicjvEK22e1R71eaONYaVIBf2/ZYq
         EBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WX5jC3uVh8Xnn2cHsQhaDzjBDV/LCNyXvKRPWGeiPls=;
        b=jXlbXiQBQQzY+F6ro8orsJx40QGAjYAh49k2wqR2WnKoNKykOIa5Y0e3SsNqOhmVq3
         jzKk+E2OIoiaVr0SW9DhP6oChD2pQXDi8lz3fP9x+I5CiHSm3qfkmI3SGFkVyobEGYv7
         LcpoRpSuFNtyheK8cFruCEM9hmfBdJdhEYs76KlpBE59iPcGyP1cahf7eE25AkDMe2BG
         qea0JwHiucujnTluNnatSfgjvPdiD66CzMMgYiPpfz0pOUTDe6O0kinEZ4y1mMZf+laq
         ACqGSYbPI6SH+RwkwDIr/qrdToKLkEfz1tRkESnincO85FPYNYZ6+CURsfAaBzDJQB5x
         SVAg==
X-Gm-Message-State: AOAM530/NNzgV2kXrHCQXF93QD4OSMRF0QbScPqqHt+ZcjVClyQkdVex
        0jxs1m3DVnZZcpkrfz3z1tHeJmDMi7Qne0MStpU=
X-Google-Smtp-Source: ABdhPJwmqdRftMUOve4YraTHad7QsLw4c1i+RFXhk/RYREnBjKA/5X6EPB/U9+sA9gT9J3l+jZmGbOEV9thzyapdVBM=
X-Received: by 2002:a05:6638:58e:: with SMTP id a14mr24926541jar.81.1626849297239;
 Tue, 20 Jul 2021 23:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <8aa9b05ae5901f14a7d3043dbf81473bfc811fdf.1626845288.git.repnop@google.com>
In-Reply-To: <8aa9b05ae5901f14a7d3043dbf81473bfc811fdf.1626845288.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Jul 2021 09:34:46 +0300
Message-ID: <CAOQ4uxjbsdsf8AG3z+60+5YoRHk5H7hPc6gRS2XMGO2c-1nxZA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] fanotify/fanotify_user.c: minor cosmetic
 adjustments to fid labels
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 9:18 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> With the idea to support additional info record types in the future
> i.e. fanotify_event_info_pidfd, it's a good idea to rename some of the
> labels assigned to some of the existing fid related functions,
> parameters, etc which more accurately represent the intent behind
> their usage.
>
> For example, copy_info_to_user() was defined with a generic function
> label, which arguably reads as being supportive of different info
> record types, however the parameter list for this function is
> explicitly tailored towards the creation and copying of the
> fanotify_event_info_fid records. This same point applies to the macro
> defined as FANOTIFY_INFO_HDR_LEN.
>
> With fanotify_event_info_len(), we change the parameter label so that
> the function implies that it can be extended to calculate the length
> for additional info record types.
>
> Signed-off-by: Matthew Bobrowski <repnop@google.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 64864fb40b40..182fea255376 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -104,7 +104,7 @@ struct kmem_cache *fanotify_path_event_cachep __read_mostly;
>  struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>
>  #define FANOTIFY_EVENT_ALIGN 4
> -#define FANOTIFY_INFO_HDR_LEN \
> +#define FANOTIFY_FID_INFO_HDR_LEN \
>         (sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
>
>  static int fanotify_fid_info_len(int fh_len, int name_len)
> @@ -114,10 +114,11 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
>         if (name_len)
>                 info_len += name_len + 1;
>
> -       return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
> +       return roundup(FANOTIFY_FID_INFO_HDR_LEN + info_len,
> +                      FANOTIFY_EVENT_ALIGN);
>  }
>
> -static int fanotify_event_info_len(unsigned int fid_mode,
> +static int fanotify_event_info_len(unsigned int info_mode,
>                                    struct fanotify_event *event)
>  {
>         struct fanotify_info *info = fanotify_event_info(event);
> @@ -128,7 +129,8 @@ static int fanotify_event_info_len(unsigned int fid_mode,
>
>         if (dir_fh_len) {
>                 info_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
> -       } else if ((fid_mode & FAN_REPORT_NAME) && (event->mask & FAN_ONDIR)) {
> +       } else if ((info_mode & FAN_REPORT_NAME) &&
> +                  (event->mask & FAN_ONDIR)) {
>                 /*
>                  * With group flag FAN_REPORT_NAME, if name was not recorded in
>                  * event on a directory, we will report the name ".".
> @@ -303,9 +305,10 @@ static int process_access_response(struct fsnotify_group *group,
>         return -ENOENT;
>  }
>
> -static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> -                            int info_type, const char *name, size_t name_len,
> -                            char __user *buf, size_t count)
> +static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> +                                int info_type, const char *name,
> +                                size_t name_len,
> +                                char __user *buf, size_t count)
>  {
>         struct fanotify_event_info_fid info = { };
>         struct file_handle handle = { };
> @@ -466,10 +469,11 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         if (fanotify_event_dir_fh_len(event)) {
>                 info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
>                                              FAN_EVENT_INFO_TYPE_DFID;
> -               ret = copy_info_to_user(fanotify_event_fsid(event),
> -                                       fanotify_info_dir_fh(info),
> -                                       info_type, fanotify_info_name(info),
> -                                       info->name_len, buf, count);
> +               ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> +                                           fanotify_info_dir_fh(info),
> +                                           info_type,
> +                                           fanotify_info_name(info),
> +                                           info->name_len, buf, count);
>                 if (ret < 0)
>                         goto out_close_fd;
>
> @@ -515,9 +519,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>                         info_type = FAN_EVENT_INFO_TYPE_FID;
>                 }
>
> -               ret = copy_info_to_user(fanotify_event_fsid(event),
> -                                       fanotify_event_object_fh(event),
> -                                       info_type, dot, dot_len, buf, count);
> +               ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> +                                           fanotify_event_object_fh(event),
> +                                           info_type, dot, dot_len,
> +                                           buf, count);
>                 if (ret < 0)
>                         goto out_close_fd;
>
> --
> 2.32.0.432.gabb21c7263-goog
>
> /M
