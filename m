Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B978A58E747
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 08:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiHJGXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 02:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiHJGXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:23:03 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B516D565;
        Tue,  9 Aug 2022 23:23:02 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id c3so14142657vsc.6;
        Tue, 09 Aug 2022 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oNiC7YhrEAbKIwyKLm8c/Y9sTLqUK8SsszUBwIfVgM8=;
        b=MRPCMSAF1FryYoO2fOLapZLWV8Ucrru60/11qZSKspfT9BvN7vpSgrfr76oj8JxKwq
         d/JIhuUg8wGDWnk3r6Cw3JEmDwkrDd2LUCxGNGhtAFYqYS6fDS3L16ndvo+pgW+7XuUC
         J0WIKPDkCJJsiWnJiRX5lS0/KwhctB3Wjcuv7VDSsDHrZQ8cSnMBKk64511/wP+RuX1b
         rN9IN/tP+vQkb085OGitBZq9AYR4IQCbndb9sHGqksZm0R3WgTi7crli6dDBpgXZSy6G
         gNwnzYfgCjsIRuvH2SJqdClkbciGBA/U2zfaxngGUBXen9+lplf7TO8qql2UBq0Ed1jL
         AMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oNiC7YhrEAbKIwyKLm8c/Y9sTLqUK8SsszUBwIfVgM8=;
        b=Jo+U3KrbYokWfAzUPV2pU6+hqLF+S5+sa4mSHktD2SAnN5gDVB4rxRHnWAqUbQGyGz
         8AgBUzrwJiXJlWTsevL/ZtJNQi2HPXDHh0mwVm96cNta0xZ2vSs98UlFVL2vIlnx41iJ
         v4t8ZaKUwLUqxzXHZRSo/0XmwkWHnRxyYPVbmgxmUfEKoP0tWeIRDEwRYR7FPvDeAfI+
         Mt+v/BDIrgEwda+vAR60GzpjtDUUuWVW1zVC9DMpEBYFwafGIccTwPqjGkVxuludmK8Q
         GvxrzUGiD13IpVnoZ+SkETmFhHkJtXSsZGW/vGJK/XzaeDT/J37tPiYEeHF5XZOhvGGU
         f4VA==
X-Gm-Message-State: ACgBeo12z9jXj+STY3E9I/UH8uU24SQbrpqmE1TIafrlYwgPZr4jD+LY
        TkRUgsDf5CeegZNnAcZt1DuUR+f2qNR7ncH3DPQ=
X-Google-Smtp-Source: AA6agR6b7grznDyI/cGaAw9yZ/j9OSykag+1lJaDT+7hW4UHVEI//Tm29t457HgwkwWI8iMFouh9mI3+hV57eQJx3g8=
X-Received: by 2002:a05:6102:3ecd:b0:358:57a1:d8a with SMTP id
 n13-20020a0561023ecd00b0035857a10d8amr10897213vsv.2.1660112581268; Tue, 09
 Aug 2022 23:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659996830.git.rgb@redhat.com> <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
In-Reply-To: <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 10 Aug 2022 08:22:49 +0200
Message-ID: <CAOQ4uxjWCyFNATVmAcgOa8HNk6Upj+PPrJF7DA9V-4LjOGAALA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: define struct members to hold response
 decision context
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux API <linux-api@vger.kernel.org>
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

[+linux-api]

On Tue, Aug 9, 2022 at 7:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> This patch adds a flag, FAN_INFO and an extensible buffer to provide
> additional information about response decisions.  The buffer contains
> one or more headers defining the information type and the length of the
> following information.  The patch defines one additional information
> type, FAN_RESPONSE_INFO_AUDIT_RULE, an audit rule number.  This will
> allow for the creation of other information types in the future if other
> users of the API identify different needs.
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---

Looks mostly fine.
A few small bugs and style suggestions
and one UAPI improvement suggestion.

>  fs/notify/fanotify/fanotify.c      |  10 ++-
>  fs/notify/fanotify/fanotify.h      |   2 +
>  fs/notify/fanotify/fanotify_user.c | 104 +++++++++++++++++++++++------
>  include/linux/fanotify.h           |   5 ++
>  include/uapi/linux/fanotify.h      |  27 +++++++-
>  5 files changed, 123 insertions(+), 25 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 4f897e109547..0f36062521f4 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -262,13 +262,16 @@ static int fanotify_get_response(struct fsnotify_group *group,
>         }
>
>         /* userspace responded, convert to something usable */
> -       switch (event->response & ~FAN_AUDIT) {
> +       switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
>         case FAN_ALLOW:
>                 ret = 0;
>                 break;
>         case FAN_DENY:
> -       default:
>                 ret = -EPERM;
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               break;

This is very odd.
Why has this changed?
The return value here is going to the process that
is trying to access the file.

>         }
>
>         /* Check if the response should be audited */
> @@ -560,6 +563,8 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
>
>         pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH_PERM;
>         pevent->response = 0;
> +       pevent->info_len = 0;
> +       pevent->info_buf = NULL;
>         pevent->state = FAN_EVENT_INIT;
>         pevent->path = *path;
>         path_get(path);
> @@ -996,6 +1001,7 @@ static void fanotify_free_path_event(struct fanotify_event *event)
>  static void fanotify_free_perm_event(struct fanotify_event *event)
>  {
>         path_put(fanotify_event_path(event));
> +       kfree(FANOTIFY_PERM(event)->info_buf);
>         kmem_cache_free(fanotify_perm_event_cachep, FANOTIFY_PERM(event));
>  }
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index abfa3712c185..14c30e173632 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -428,6 +428,8 @@ struct fanotify_perm_event {
>         u32 response;                   /* userspace answer to the event */
>         unsigned short state;           /* state of the event */
>         int fd;         /* fd we passed to userspace for this event */
> +       size_t info_len;
> +       char *info_buf;
>  };
>
>  static inline struct fanotify_perm_event *
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index ff67ca0d25cc..a4ae953f0e62 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -289,13 +289,18 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
>   */
>  static void finish_permission_event(struct fsnotify_group *group,
>                                     struct fanotify_perm_event *event,
> -                                   u32 response)
> +                                   struct fanotify_response *response,
> +                                   size_t info_len, char *info_buf)
>                                     __releases(&group->notification_lock)
>  {
>         bool destroy = false;
>
>         assert_spin_locked(&group->notification_lock);
> -       event->response = response;
> +       event->response = response->response & ~FAN_INFO;
> +       if (response->response & FAN_INFO) {
> +               event->info_len = info_len;
> +               event->info_buf = info_buf;
> +       }
>         if (event->state == FAN_EVENT_CANCELED)
>                 destroy = true;
>         else
> @@ -306,33 +311,71 @@ static void finish_permission_event(struct fsnotify_group *group,
>  }
>
>  static int process_access_response(struct fsnotify_group *group,
> -                                  struct fanotify_response *response_struct)
> +                                  struct fanotify_response *response_struct,
> +                                  const char __user *buf,
> +                                  size_t count)
>  {
>         struct fanotify_perm_event *event;
>         int fd = response_struct->fd;
>         u32 response = response_struct->response;
> +       struct fanotify_response_info_header info_hdr;
> +       char *info_buf = NULL;
>
> -       pr_debug("%s: group=%p fd=%d response=%u\n", __func__, group,
> -                fd, response);
> +       pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%lu\n", __func__,
> +                group, fd, response, info_buf, count);
>         /*
>          * make sure the response is valid, if invalid we do nothing and either
>          * userspace can send a valid response or we will clean it up after the
>          * timeout
>          */
> -       switch (response & ~FAN_AUDIT) {
> +       if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
> +               return -EINVAL;
> +       switch (response & FANOTIFY_RESPONSE_ACCESS) {
>         case FAN_ALLOW:
>         case FAN_DENY:
>                 break;
>         default:
>                 return -EINVAL;
>         }
> -
> -       if (fd < 0)
> -               return -EINVAL;
> -
>         if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
>                 return -EINVAL;
> +       if (fd < 0)
> +               return -EINVAL;

Since you did not accept my suggestion of FAN_TEST [1],
I am not sure why this check was moved.

However, if you move this check past FAN_INFO processing,
you could change the error value to -ENOENT, same as the return value
for an fd that is >= 0 but does not correspond to any pending
permission event.

The idea was that userspace could write a test
fanotify_response_info_audit_rule payload to fanotify fd with FAN_NOFD
in the response.fd field.
On old kernel, this will return EINVAL.
On new kernel, if the fanotify_response_info_audit_rule payload
passes all the validations, this will do nothing and return ENOENT.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxi+8HUqyGxQBNMqSong92nreOWLKdy9MCrYg8wgW9Dj4g@mail.gmail.com/

> +       if (response & FAN_INFO) {

Please split this out to helper process_response_info() and
optionally also helper process_response_info_audit_rule()

> +               size_t c = count;
> +               const char __user *ib = buf;
>
> +               if (c <= 0)
> +                       return -EINVAL;

This was already checked by the caller.
If you think we need this defence use if (WARN_ON_ONCE())

> +               while (c >= sizeof(info_hdr)) {

This while() is a bit confusing.
It suggests that the parser may process multiple info records,
but the code below uses 'count' and assumed single audit rule
record.

Maybe just change this to:
  if (WARN_ON_ONCE(c < sizeof(info_hdr))
     return -EINVAL

Until the code can really handle multiple records.

> +                       if (copy_from_user(&info_hdr, ib, sizeof(info_hdr)))
> +                               return -EFAULT;
> +                       if (info_hdr.pad != 0)
> +                               return -EINVAL;
> +                       if (c < info_hdr.len)
> +                               return -EINVAL;
> +                       switch (info_hdr.type) {
> +                       case FAN_RESPONSE_INFO_AUDIT_RULE:
> +                               break;
> +                       case FAN_RESPONSE_INFO_NONE:
> +                       default:
> +                               return -EINVAL;
> +                       }
> +                       c -= info_hdr.len;
> +                       ib += info_hdr.len;
> +               }
> +               if (c != 0)
> +                       return -EINVAL;
> +               /* Simplistic check for now */
> +               if (count != sizeof(struct fanotify_response_info_audit_rule))
> +                       return -EINVAL;
> +               info_buf = kmalloc(sizeof(struct fanotify_response_info_audit_rule),
> +                                  GFP_KERNEL);
> +               if (!info_buf)
> +                       return -ENOMEM;
> +               if (copy_from_user(info_buf, buf, count))
> +                       return -EFAULT;

info_buf allocation is leaked here and also in case 'fd' is not found.

> +       }
>         spin_lock(&group->notification_lock);
>         list_for_each_entry(event, &group->fanotify_data.access_list,
>                             fae.fse.list) {
> @@ -340,7 +383,9 @@ static int process_access_response(struct fsnotify_group *group,
>                         continue;
>
>                 list_del_init(&event->fae.fse.list);
> -               finish_permission_event(group, event, response);
> +               /* finish_permission_event() eats info_buf */
> +               finish_permission_event(group, event, response_struct,
> +                                       count, info_buf);
>                 wake_up(&group->fanotify_data.access_waitq);
>                 return 0;
>         }
> @@ -802,9 +847,14 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>                         fsnotify_destroy_event(group, &event->fse);
>                 } else {
>                         if (ret <= 0) {
> +                               struct fanotify_response response = {
> +                                       .fd = FAN_NOFD,
> +                                       .response = FAN_DENY };
> +
>                                 spin_lock(&group->notification_lock);
>                                 finish_permission_event(group,
> -                                       FANOTIFY_PERM(event), FAN_DENY);
> +                                       FANOTIFY_PERM(event), &response,
> +                                       0, NULL);
>                                 wake_up(&group->fanotify_data.access_waitq);
>                         } else {
>                                 spin_lock(&group->notification_lock);
> @@ -827,26 +877,33 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>
>  static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
>  {
> -       struct fanotify_response response = { .fd = -1, .response = -1 };
> +       struct fanotify_response response;
>         struct fsnotify_group *group;
>         int ret;
> +       const char __user *info_buf = buf + sizeof(struct fanotify_response);
> +       size_t c;
>
>         if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
>                 return -EINVAL;
>
>         group = file->private_data;
>
> -       if (count < sizeof(response))
> -               return -EINVAL;
> -
> -       count = sizeof(response);
> -
>         pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
>
> -       if (copy_from_user(&response, buf, count))
> +       if (count < sizeof(response))
> +               return -EINVAL;
> +       if (copy_from_user(&response, buf, sizeof(response)))
>                 return -EFAULT;
>
> -       ret = process_access_response(group, &response);
> +       c = count - sizeof(response);
> +       if (response.response & FAN_INFO) {
> +               if (c < sizeof(struct fanotify_response_info_header))
> +                       return -EINVAL;

Should FAN_INFO require FAN_AUDIT?

> +       } else {
> +               if (c != 0)
> +                       return -EINVAL;
> +       }
> +       ret = process_access_response(group, &response, info_buf, c);
>         if (ret < 0)
>                 count = ret;
>
> @@ -857,6 +914,9 @@ static int fanotify_release(struct inode *ignored, struct file *file)
>  {
>         struct fsnotify_group *group = file->private_data;
>         struct fsnotify_event *fsn_event;
> +       struct fanotify_response response = {
> +               .fd = FAN_NOFD,
> +               .response = FAN_ALLOW };
>
>         /*
>          * Stop new events from arriving in the notification queue. since
> @@ -876,7 +936,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
>                 event = list_first_entry(&group->fanotify_data.access_list,
>                                 struct fanotify_perm_event, fae.fse.list);
>                 list_del_init(&event->fae.fse.list);
> -               finish_permission_event(group, event, FAN_ALLOW);
> +               finish_permission_event(group, event, &response, 0, NULL);
>                 spin_lock(&group->notification_lock);
>         }
>
> @@ -893,7 +953,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
>                         fsnotify_destroy_event(group, fsn_event);
>                 } else {
>                         finish_permission_event(group, FANOTIFY_PERM(event),
> -                                               FAN_ALLOW);
> +                                               &response, 0, NULL);
>                 }
>                 spin_lock(&group->notification_lock);
>         }
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index edc28555814c..ce9f97eb69f2 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -114,6 +114,11 @@
>  #define ALL_FANOTIFY_EVENT_BITS                (FANOTIFY_OUTGOING_EVENTS | \
>                                          FANOTIFY_EVENT_FLAGS)
>
> +/* This mask is to check for invalid bits of a user space permission response */
> +#define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
> +#define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
> +#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS)
> +
>  /* Do not use these old uapi constants internally */
>  #undef FAN_ALL_CLASS_BITS
>  #undef FAN_ALL_INIT_FLAGS
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index f1f89132d60e..4d08823a5698 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -180,15 +180,40 @@ struct fanotify_event_info_error {
>         __u32 error_count;
>  };
>
> +/*
> + * User space may need to record additional information about its decision.
> + * The extra information type records what kind of information is included.
> + * The default is none. We also define an extra information buffer whose
> + * size is determined by the extra information type.
> + *
> + * If the context type is Rule, then the context following is the rule number
> + * that triggered the user space decision.
> + */
> +
> +#define FAN_RESPONSE_INFO_NONE         0
> +#define FAN_RESPONSE_INFO_AUDIT_RULE   1
> +
>  struct fanotify_response {
>         __s32 fd;
>         __u32 response;
>  };
>
> +struct fanotify_response_info_header {
> +       __u8 type;
> +       __u8 pad;
> +       __u16 len;
> +};
> +
> +struct fanotify_response_info_audit_rule {
> +       struct fanotify_response_info_header hdr;
> +       __u32 audit_rule;
> +};
> +
>  /* Legit userspace responses to a _PERM event */
>  #define FAN_ALLOW      0x01
>  #define FAN_DENY       0x02
> -#define FAN_AUDIT      0x10    /* Bit mask to create audit record for result */
> +#define FAN_AUDIT      0x10    /* Bitmask to create audit record for result */
> +#define FAN_INFO       0x20    /* Bitmask to indicate additional information */
>
>  /* No fd set in event */
>  #define FAN_NOFD       -1
> --
> 2.27.0
>
