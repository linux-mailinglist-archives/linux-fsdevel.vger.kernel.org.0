Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47BE51B69A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 05:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241431AbiEEDgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 23:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiEEDgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 23:36:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F31849F95
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 20:33:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u3so4372999wrg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 20:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqfZfQpmXVHETuF1B0xNE9EmPpUhhrjqT9Nbme9K0BI=;
        b=oE/mLb9s7n5byBWoAzgTvwR7m4Ag4TuYbKdpZGwy317zKrDgD/ijP+QcPOvbnGKfFZ
         HgA/N6I5JCAnSqpCNdPAtqx4tF72aOkDa8c6PiBJ/0S9o1WQtO9XtYrtY2DPL+FAhMr9
         Fwwn6sapCh9U+2Cobw4FhaJ+gt/NHS7u75uNtiLOpBBSwKCK1kzYOpkDmkTLuFXZiMyV
         Z58Bczyl93yd2t1JKeeZPWw5TCvgMbRQrzL0bbf4FRhkyJG1jX6TEle6qkULxq9j5z8y
         Ix9VOjP40Y3RXKgykDrJlOuYobWA+1KfxQV43D0PLu3Be+xmeAGTR9xl8l2F/EoG9WOM
         ifMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqfZfQpmXVHETuF1B0xNE9EmPpUhhrjqT9Nbme9K0BI=;
        b=YqBZVFSBng04Mw3ZN8YS+G/Zen7LRkKHcTP4X3ClspJBJmIObL5cMuShic2j4IreyQ
         e6do0nuB2BkVKTD2D2uFjnoIfT8lLFi4ci8cSooVXlNw3lONZ5e9/Ao0xJ8uLTO5f8Xu
         GGLIe1dRIABQehQbV4fXc5joi72XUKBt1VKphQPHAPDDAW8tx6j0IB7SWOcxBfIHg7Pz
         LBMqamUKrPyhZr8ddnUp1lvcNfNufaprFUmdiy3++stFAzHiF4iVIDUmeP8S1PLagtSG
         UlSfadOUT8lWshORtoAEzXfoOQOZ0rnVXKO0Wr1P7+qHb6XjB4H6tHskA9g8C6DHYjHI
         KJvA==
X-Gm-Message-State: AOAM531FI1Lc4yuxQP/Fqla5mqGh2oY3kSA4Gc09tEXfJxeGxrdJfmzO
        dTtUIMi2JYQSKE1PoKPnGtQIXssgs+K/xxWzXuyq
X-Google-Smtp-Source: ABdhPJwWYpcnPUCH3PNkFBMqlRujbkaS6Bc/qHhso4xOhHj4K4edZv8Cb6cHarVPyslAEAAvUUKW0DR1qpT4+/9ckHs=
X-Received: by 2002:a05:6000:10cc:b0:20a:de6f:3c48 with SMTP id
 b12-20020a05600010cc00b0020ade6f3c48mr18325890wrx.650.1651721590030; Wed, 04
 May 2022 20:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651174324.git.rgb@redhat.com> <17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com>
 <CAHC9VhQ3Qtpwhj6TeMR7rmdbUe_6VRHU9OymmDoDdsazeGuNKA@mail.gmail.com> <YnHX74E+COTp7AgY@madcap2.tricolour.ca>
In-Reply-To: <YnHX74E+COTp7AgY@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 May 2022 23:32:59 -0400
Message-ID: <CAHC9VhR-3xNFgSdK7LUKmhfw5uGHo9gnmKb7K62=3TVBONJ2nQ@mail.gmail.com>
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

On Tue, May 3, 2022 at 9:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2022-05-02 20:16, Paul Moore wrote:
> > On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > This patch adds 2 structure members to the response returned from user
> > > space on a permission event. The first field is 16 bits for the context
> > > type.  The context type will describe what the meaning is of the second
> > > field. The default is none. The patch defines one additional context
> > > type which means that the second field is a 32-bit rule number. This
> > > will allow for the creation of other context types in the future if
> > > other users of the API identify different needs.  The second field size
> > > is defined by the context type and can be used to pass along the data
> > > described by the context.
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
> > > Link: https://lore.kernel.org/r/17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com
> > > ---
> > >  fs/notify/fanotify/fanotify.c      |  1 -
> > >  fs/notify/fanotify/fanotify.h      |  4 +-
> > >  fs/notify/fanotify/fanotify_user.c | 59 ++++++++++++++++++++----------
> > >  include/linux/fanotify.h           |  3 ++
> > >  include/uapi/linux/fanotify.h      | 27 +++++++++++++-
> > >  5 files changed, 72 insertions(+), 22 deletions(-)

...

> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index 694516470660..f1ff4cf683fb 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -289,13 +289,19 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
> > >   */
> > >  static void finish_permission_event(struct fsnotify_group *group,
> > >                                     struct fanotify_perm_event *event,
> > > -                                   __u32 response)
> > > +                                   struct fanotify_response *response)
> > >                                     __releases(&group->notification_lock)
> > >  {
> > >         bool destroy = false;
> > >
> > >         assert_spin_locked(&group->notification_lock);
> > > -       event->response = response;
> > > +       event->response = response->response;
> > > +       event->extra_info_type = response->extra_info_type;
> > > +       switch (event->extra_info_type) {
> > > +       case FAN_RESPONSE_INFO_AUDIT_RULE:
> > > +               memcpy(event->extra_info_buf, response->extra_info_buf,
> > > +                      sizeof(struct fanotify_response_audit_rule));
> >
> > Since the fanotify_perm_event:extra_info_buf and
> > fanotify_response:extra_info_buf are the same type/length, and they
> > will be the same regardless of the extra_info_type field, why not
> > simply get rid of the above switch statement and do something like
> > this:
> >
> >   memcpy(event->extra_info_buf, response->extra_info_buf,
> >          sizeof(response->extra_info_buf));
>
> I've been wrestling with the possibility of doing a split between what
> is presented to userspace and what's used in the kernel for struct
> fanotify_response, while attempting to future-proof it.

You really only need to worry about what is presented to userspace,
the kernel internals can always change if needed.  Right now I would
focus on making sure the userspace visible data structures are done
properly: preserve the existing data offsets/lengths, and ensure that
the new additions do not make it harder to extend the structure again
in the future.

> > > @@ -827,26 +845,25 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
> > >
> > >  static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
> > >  {
> > > -       struct fanotify_response response = { .fd = -1, .response = -1 };
> > > +       struct fanotify_response response;
> > >         struct fsnotify_group *group;
> > >         int ret;
> > > +       size_t size = min(count, sizeof(struct fanotify_response));
> > >
> > >         if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> > >                 return -EINVAL;
> > >
> > >         group = file->private_data;
> > >
> > > -       if (count < sizeof(response))
> > > +       if (count < offsetof(struct fanotify_response, extra_info_buf))
> > >                 return -EINVAL;
> >
> > Is this why you decided to shrink the fanotify_response:response field
> > from 32-bits to 16-bits?  I hope not.  I would suggest both keeping
> > the existing response field as 32-bits and explicitly checking for
> > writes that are either the existing/compat length as well as the
> > newer, longer length.
>
> No.  I shrank it at Jan's suggestion.  I think I agree with you that
> the response field should be kept at u32 as it is defined in userspace
> and purge the doubt about what would happen with a new userspace with
> an old kernel.

I'm struggling to think of why shrinking an existing field is a good
idea.  Unfortunately, there is a possibility that any problems this
would cause might not be caught until it has been in a couple of
kernel releases and some applications have been written/updated to use
the new struct definition, at which point restoring the field to a u32
value will break all of these new applications.

I think changing the fanotify_response:response field is an
unnecessary risk, and I'll leave it at that.

> > > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> > > index e8ac38cc2fd6..efb5a3a6f814 100644
> > > --- a/include/uapi/linux/fanotify.h
> > > +++ b/include/uapi/linux/fanotify.h
> > > @@ -179,9 +179,34 @@ struct fanotify_event_info_error {
> > >         __u32 error_count;
> > >  };
> > >
> > > +/*
> > > + * User space may need to record additional information about its decision.
> > > + * The extra information type records what kind of information is included.
> > > + * The default is none. We also define an extra informaion buffer whose
> > > + * size is determined by the extra information type.
> > > + *
> > > + * If the context type is Rule, then the context following is the rule number
> > > + * that triggered the user space decision.
> > > + */
> > > +
> > > +#define FAN_RESPONSE_INFO_AUDIT_NONE   0
> > > +#define FAN_RESPONSE_INFO_AUDIT_RULE   1
> > > +
> > > +struct fanotify_response_audit_rule {
> > > +       __u32 rule;
> > > +};
> > > +
> > > +#define FANOTIFY_RESPONSE_EXTRA_LEN_MAX        \
> > > +       (sizeof(union { \
> > > +               struct fanotify_response_audit_rule r; \
> > > +               /* add other extra info structures here */ \
> > > +       }))
> > > +
> > >  struct fanotify_response {
> > >         __s32 fd;
> > > -       __u32 response;
> > > +       __u16 response;
> > > +       __u16 extra_info_type;
> > > +       char extra_info_buf[FANOTIFY_RESPONSE_EXTRA_LEN_MAX];
> > >  };
> >
> > Since both the kernel and userspace are going to need to agree on the
> > content and formatting of the fanotify_response:extra_info_buf field,
> > why is it hidden behind a char array?  You might as well get rid of
> > that abstraction and put the union directly in the fanotify_response
> > struct.  It is possible you could also get rid of the
> > fanotify_response_audit_rule struct this way too and just access the
> > rule scalar directly.
>
> This does make sense and my only concern would be a variable-length
> type.  There isn't any reason to hide it.  If userspace chooses to use
> the old interface and omit the type field then it defaults to NONE.

There is no reason you couldn't put flexible-array field in a union if
that is what was needed.  Of you could have the flexible-array field
outside of the union and use a union field as the length value.
There's probably other clever solutions to this too.

-- 
paul-moore.com
