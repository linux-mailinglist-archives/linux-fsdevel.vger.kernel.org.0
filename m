Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5742517B39
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 02:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiECAUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 20:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiECAT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 20:19:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782F636302
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 17:16:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so433494wmn.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 May 2022 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0cipxav7yr/bv2IJy2ZOQReZig3srdhUuQ6YCnxftM=;
        b=qfvQuaByWngwSvULQUGB3X3a9QtV0lxuqWR7m2oGcWOcP92ZAgvDIsfLX5MniUogt6
         o8M0KvhUSJjv9GFT8r/dudQMjA+Mo/9JEj0QJEL0HAfaz76YUMEfdSdMF5QeODrhm1zo
         rxmhHr3E6XxLAhCx4I2paQTAFM0mnfmjyDBtzZuspMJQbjvHLbn/UoM3p9Rkz5GtHcCc
         HAwO8+qf5V0Jn8f+Dz732lBsYHQiT0URQKhB+B0KW8QULFRESxE7ihZJXIzU1UtRt7yC
         MHSQCcEmx4fSUlLId3d2a0aqAg49LYPiUg+kJEGCT0LOZLwzVvq/S7Zu38MVQ8DcCTqu
         XVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0cipxav7yr/bv2IJy2ZOQReZig3srdhUuQ6YCnxftM=;
        b=haX5ZbbiVZOfAsyQg6EQROyCRYEB3TO47AwyPN7PoBG8cqS7LdNl6kq8NeH9UklU3g
         esfIAABfHnkLB836q3oK4ZZ7MoSefGSjZK7ZwYkHhEkZjcFMzSJwDxzdk4wb1IakRdP8
         er5rDNuEmvE7RMzfUeqxqG1P2aGLOotbCNBl+QOCl1TsUbiSH/9jiA0U/LKmY5+SefZt
         WGB1qbMr2O3jWUpqbABavoB7DKaHH4eILchoHeL+n2uG7g/25/QMFaT2ZAEBOfO16kzh
         UZ3ecJaRk/s4io5n+QrqyjjR3jjjnFHxe/1ypgzh/rOfZ624YdClMirwkc5VVYYyc7HL
         tlRg==
X-Gm-Message-State: AOAM533e1c84nmew3qbjbEx3MPesHpNKcqg/6OYVK16YB7ALU/Q/9UTG
        6us6Mj18mGR2pOkpmp/sBbcMm4Y9U7aRgSY1fMlh
X-Google-Smtp-Source: ABdhPJy/MZRnZDwpZEwHhqU8jZT64exxaAhlChz4HqWmd+FW5MWNPadPedEH/r6NreN9y2HTKPXDKCt16niqKa/qc48=
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id
 n2-20020a7bcbc2000000b00388faec2036mr1139134wmi.190.1651536983684; Mon, 02
 May 2022 17:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651174324.git.rgb@redhat.com> <17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com>
In-Reply-To: <17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 May 2022 20:16:13 -0400
Message-ID: <CAHC9VhQ3Qtpwhj6TeMR7rmdbUe_6VRHU9OymmDoDdsazeGuNKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fanotify: define struct members to hold response
 decision context
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> This patch adds 2 structure members to the response returned from user
> space on a permission event. The first field is 16 bits for the context
> type.  The context type will describe what the meaning is of the second
> field. The default is none. The patch defines one additional context
> type which means that the second field is a 32-bit rule number. This
> will allow for the creation of other context types in the future if
> other users of the API identify different needs.  The second field size
> is defined by the context type and can be used to pass along the data
> described by the context.
>
> To support this, there is a macro for user space to check that the data
> being sent is valid. Of course, without this check, anything that
> overflows the bit field will trigger an EINVAL based on the use of
> FAN_INVALID_RESPONSE_MASK in process_access_response().
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Link: https://lore.kernel.org/r/17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com
> ---
>  fs/notify/fanotify/fanotify.c      |  1 -
>  fs/notify/fanotify/fanotify.h      |  4 +-
>  fs/notify/fanotify/fanotify_user.c | 59 ++++++++++++++++++++----------
>  include/linux/fanotify.h           |  3 ++
>  include/uapi/linux/fanotify.h      | 27 +++++++++++++-
>  5 files changed, 72 insertions(+), 22 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 985e995d2a39..00aff6e29bf8 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -266,7 +266,6 @@ static int fanotify_get_response(struct fsnotify_group *group,
>         case FAN_ALLOW:
>                 ret = 0;
>                 break;
> -       case FAN_DENY:

I personally would drop this from the patch if it was me, it doesn't
change the behavior so it falls under the "noise" category, which
could be a problem considering the lack of response on the original
posting and this one.  Small, focused patches have a better shot of
review/merging.

>         default:
>                 ret = -EPERM;
>         }

...

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 694516470660..f1ff4cf683fb 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -289,13 +289,19 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
>   */
>  static void finish_permission_event(struct fsnotify_group *group,
>                                     struct fanotify_perm_event *event,
> -                                   __u32 response)
> +                                   struct fanotify_response *response)
>                                     __releases(&group->notification_lock)
>  {
>         bool destroy = false;
>
>         assert_spin_locked(&group->notification_lock);
> -       event->response = response;
> +       event->response = response->response;
> +       event->extra_info_type = response->extra_info_type;
> +       switch (event->extra_info_type) {
> +       case FAN_RESPONSE_INFO_AUDIT_RULE:
> +               memcpy(event->extra_info_buf, response->extra_info_buf,
> +                      sizeof(struct fanotify_response_audit_rule));

Since the fanotify_perm_event:extra_info_buf and
fanotify_response:extra_info_buf are the same type/length, and they
will be the same regardless of the extra_info_type field, why not
simply get rid of the above switch statement and do something like
this:

  memcpy(event->extra_info_buf, response->extra_info_buf,
         sizeof(response->extra_info_buf));

> +       }
>         if (event->state == FAN_EVENT_CANCELED)
>                 destroy = true;
>         else

...

> @@ -827,26 +845,25 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>
>  static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
>  {
> -       struct fanotify_response response = { .fd = -1, .response = -1 };
> +       struct fanotify_response response;
>         struct fsnotify_group *group;
>         int ret;
> +       size_t size = min(count, sizeof(struct fanotify_response));
>
>         if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
>                 return -EINVAL;
>
>         group = file->private_data;
>
> -       if (count < sizeof(response))
> +       if (count < offsetof(struct fanotify_response, extra_info_buf))
>                 return -EINVAL;

Is this why you decided to shrink the fanotify_response:response field
from 32-bits to 16-bits?  I hope not.  I would suggest both keeping
the existing response field as 32-bits and explicitly checking for
writes that are either the existing/compat length as well as the
newer, longer length.

> -       count = sizeof(response);
> -
>         pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
>
> -       if (copy_from_user(&response, buf, count))
> +       if (copy_from_user(&response, buf, size))
>                 return -EFAULT;
>
> -       ret = process_access_response(group, &response);
> +       ret = process_access_response(group, &response, count);
>         if (ret < 0)
>                 count = ret;
>

...

> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index e8ac38cc2fd6..efb5a3a6f814 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -179,9 +179,34 @@ struct fanotify_event_info_error {
>         __u32 error_count;
>  };
>
> +/*
> + * User space may need to record additional information about its decision.
> + * The extra information type records what kind of information is included.
> + * The default is none. We also define an extra informaion buffer whose
> + * size is determined by the extra information type.
> + *
> + * If the context type is Rule, then the context following is the rule number
> + * that triggered the user space decision.
> + */
> +
> +#define FAN_RESPONSE_INFO_AUDIT_NONE   0
> +#define FAN_RESPONSE_INFO_AUDIT_RULE   1
> +
> +struct fanotify_response_audit_rule {
> +       __u32 rule;
> +};
> +
> +#define FANOTIFY_RESPONSE_EXTRA_LEN_MAX        \
> +       (sizeof(union { \
> +               struct fanotify_response_audit_rule r; \
> +               /* add other extra info structures here */ \
> +       }))
> +
>  struct fanotify_response {
>         __s32 fd;
> -       __u32 response;
> +       __u16 response;
> +       __u16 extra_info_type;
> +       char extra_info_buf[FANOTIFY_RESPONSE_EXTRA_LEN_MAX];
>  };

Since both the kernel and userspace are going to need to agree on the
content and formatting of the fanotify_response:extra_info_buf field,
why is it hidden behind a char array?  You might as well get rid of
that abstraction and put the union directly in the fanotify_response
struct.  It is possible you could also get rid of the
fanotify_response_audit_rule struct this way too and just access the
rule scalar directly.


--
paul-moore.com
