Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C3152A06C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbiEQLbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 07:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiEQLbR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 07:31:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7726ACC;
        Tue, 17 May 2022 04:31:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id u35so14026416qtc.13;
        Tue, 17 May 2022 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkT6sjdKQ4EcOctcNvzAX+AKkerDWu5LLVQt4wUPvkk=;
        b=HwF7PmsW84Bx6hf9aV2SI5DvhdCSJjsgMaSLTQCv8Vj5gSa7Bs74kwOCpLmBikMjx/
         LR6ra/UqNk8+8hx4XoaHc3ftCM4gdPo4DgIhAi1eIkEkuYqgNiD5kbGo6UbjlxqER0kq
         4FGkGanHsYCLCGv6yrFPI33bo558kB1KfHsp4coLIBdBn7vDR59w+7Hh84Cv406OXGMF
         RJkCOM1uDOZvmVSYd2hWhruHqeEOVpnhVxTK4K+uZR0S9llASMDBc3o2+lualYL7KQi0
         SzO+YJSwWj8u3GxqOYWCUdo+eSX3eS7TBr3/6tlJho3guFa31GVQfFjx+nxTMsK7O77O
         elag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkT6sjdKQ4EcOctcNvzAX+AKkerDWu5LLVQt4wUPvkk=;
        b=F9ZR/oBcD6kYaGcpI+PWAhJPknMBWIA6ZcLdTE2FU2HJZTs/X992jZoZFAYqkHvtNR
         TXw/CggOBhdhuQCwgPQtlIp3wl/CY+4Gmk8EZ8AGqmnerMQcEIgv2X8s9no0dOCyy3xu
         WibRaM5dx5kOSdflJ97MmtsyZFVbe+8hk3I0kb+sPJhzu6PVZcPSLjnHZ8FUm/YzfIcy
         Lq5FF4sxMoYAlmyOCpErn1gC2NbaQb4tez/xYVT8uV5NZ/SYBxQnk8s6qJBifqTgjyN7
         xXhoF2yIbV7VT15uPK8JiYS8VsVQCIQILsBTUWQpt14/4qCV0yQPqiERD1jDbfD9s0z0
         PSKA==
X-Gm-Message-State: AOAM530Flp3RqROl5G7126I8kkZ4qEX244wvSPLzR0+WjMdnFrfn/vb5
        20RqnKUSPn2QhJkF/WV7JCG+G8DFwrhfR+oQqNs=
X-Google-Smtp-Source: ABdhPJxGde08Dr24KPdJkb021fHXk+Ytng0RuldUpyBWBpCzIQUnJok1bs+nr9kLdYy+jSdDobH2zo0LcdnlBpcigNM=
X-Received: by 2002:ac8:4e42:0:b0:2f4:fc3c:b0c8 with SMTP id
 e2-20020ac84e42000000b002f4fc3cb0c8mr19381943qtw.684.1652787074230; Tue, 17
 May 2022 04:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652730821.git.rgb@redhat.com> <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
 <CAOQ4uxjV-eNxJ=O_WFTTzspCxXZqpMdh3Fe-N5aB-h1rDr_1hQ@mail.gmail.com> <20220517103236.i7gtsw7akiikqwam@quack3.lan>
In-Reply-To: <20220517103236.i7gtsw7akiikqwam@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 17 May 2022 14:31:02 +0300
Message-ID: <CAOQ4uxj5HZva82g_ku8uexnqE65K-ThKFJqABNg-A-rc03cVfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fanotify: define struct members to hold response
 decision context
To:     Jan Kara <jack@suse.cz>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>
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

On Tue, May 17, 2022 at 1:32 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 17-05-22 08:37:28, Amir Goldstein wrote:
> > On Mon, May 16, 2022 at 11:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > This patch adds 2 structure members to the response returned from user
> > > space on a permission event. The first field is 32 bits for the context
> > > type.  The context type will describe what the meaning is of the second
> > > field. The default is none. The patch defines one additional context
> > > type which means that the second field is a union containing a 32-bit
> > > rule number. This will allow for the creation of other context types in
> > > the future if other users of the API identify different needs.  The
> > > second field size is defined by the context type and can be used to pass
> > > along the data described by the context.
> > >
> > > To support this, there is a macro for user space to check that the data
> > > being sent is valid. Of course, without this check, anything that
> > > overflows the bit field will trigger an EINVAL based on the use of
> > > FAN_INVALID_RESPONSE_MASK in process_access_response().
> > >
> > > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > > Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>
> ...
> > >  static int process_access_response(struct fsnotify_group *group,
> > > -                                  struct fanotify_response *response_struct)
> > > +                                  struct fanotify_response *response_struct,
> > > +                                  size_t count)
> > >  {
> > >         struct fanotify_perm_event *event;
> > >         int fd = response_struct->fd;
> > >         u32 response = response_struct->response;
> > >
> > > -       pr_debug("%s: group=%p fd=%d response=%u\n", __func__, group,
> > > -                fd, response);
> > > +       pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
> > > +                group, fd, response, response_struct->extra_info_type, count);
> > > +       if (fd < 0)
> > > +               return -EINVAL;
> > >         /*
> > >          * make sure the response is valid, if invalid we do nothing and either
> > >          * userspace can send a valid response or we will clean it up after the
> > >          * timeout
> > >          */
> > > -       switch (response & ~FAN_AUDIT) {
> > > -       case FAN_ALLOW:
> > > -       case FAN_DENY:
> > > -               break;
> > > -       default:
> > > -               return -EINVAL;
> > > -       }
> > > -
> > > -       if (fd < 0)
> > > +       if (FAN_INVALID_RESPONSE_MASK(response))
> >
> > That is a logic change, because now the response value of 0 becomes valid.
> >
> > Since you did not document this change in the commit message I assume this was
> > non intentional?
> > However, this behavior change is something that I did ask for, but it should be
> > done is a separate commit:
> >
> >  /* These are NOT bitwise flags.  Both bits can be used together.  */
> > #define FAN_TEST          0x00
> > #define FAN_ALLOW       0x01
> > #define FAN_DENY        0x02
> > #define FANOTIFY_RESPONSE_ACCESS \
> >             (FAN_TEST|FAN_ALLOW | FAN_DENY)
> >
> > ...
> > int access = response & FANOTIFY_RESPONSE_ACCESS;
> >
> > 1. Do return EINVAL for access == 0
> > 2. Let all the rest of the EINVAL checks run (including extra type)
> > 3. Move if (fd < 0) to last check
> > 4. Add if (!access) return 0 before if (fd < 0)
> >
> > That will provide a mechanism for userspace to probe the
> > kernel support for extra types in general and specific types
> > that it may respond with.
>
> I have to admit I didn't quite grok your suggestion here although I
> understand (and agree with) the general direction of the proposal :). Maybe
> code would explain it better what you have in mind?
>

+/* These are NOT bitwise flags.  Both bits can be used together.  */
+#define FAN_TEST          0x00
#define FAN_ALLOW       0x01
#define FAN_DENY        0x02
#define FAN_AUDIT       0x10    /* Bit mask to create audit record for result */
+#define FANOTIFY_RESPONSE_ACCESS \
+            (FAN_TEST|FAN_ALLOW | FAN_DENY)

...

@@ -311,6 +314,7 @@ static int process_access_response(struct
fsnotify_group *group,
        struct fanotify_perm_event *event;
        int fd = response_struct->fd;
        int response = response_struct->response;
+       int access = response & FANOTIFY_RESPONSE_ACCESS;

        pr_debug("%s: group=%p fd=%d response=%d\n", __func__, group,
                 fd, response);
@@ -319,18 +323,33 @@ static int process_access_response(struct
fsnotify_group *group,
         * userspace can send a valid response or we will clean it up after the
         * timeout
         */
-       switch (response & ~FAN_AUDIT) {
+       if (!response)
+               return -EINVAL;
+
+       switch (access) {
        case FAN_ALLOW:
        case FAN_DENY:
+       case FAN_TEST:
                break;
        default:
                return -EINVAL;
        }

-       if (fd < 0)
-                return -EINVAL;
-
       if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
                return -EINVAL;

+       /*
+        * FAN_TEST|FAN_AUDIT response can be written during setup time to probe
+        * if the kernel has support for FAN_AUDIT.
+        * For FAN_TEST, fd must not be valid.
+        */
+       if (access == FAN_TEST) {
+               if (fd >= 0)
+                       return -EINVAL;
+               return 0;
+       }
+
+       if (fd < 0)
+                return -EINVAL;

Thanks,
Amir.
