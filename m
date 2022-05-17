Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE052A126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 14:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbiEQMHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 08:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiEQMHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 08:07:04 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8290444746;
        Tue, 17 May 2022 05:07:03 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id k2so14125433qtp.1;
        Tue, 17 May 2022 05:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHCPn/5+IVbOfCi9iuEGhFmI1sfcIXa1/Qs52bDuAk0=;
        b=SOh6EcMWhqj1rRTK+fVaTib5Wo+a7e/L9Fs8VOuS9uF1/qtWusul3kpCrScepzF0wP
         6u8IaM+JgyJNaF4JOnrKqjNPudVUU8bzHESYxMNGKef9q+ECsd+AIcyTtNDjIsDZLIQb
         RP7LLWwYVugwykCD8aIqaMsP0CR8xHLb45qGeVYvfTVDhcItNfr96GDxKCoM8RjyTSJm
         l6ym8XXJxqfr68fKvDn7yxJWm/NrTO7XcRq93griWlVnMV3QnQvhSSQLeWSFI8AbSyfW
         YbRKy9/2tmwySLVlmeIK36sY0yEQmWfGkMkLi5Re2g4hdKdx8yXY9lUrqWTdFJuwb3L/
         hhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHCPn/5+IVbOfCi9iuEGhFmI1sfcIXa1/Qs52bDuAk0=;
        b=3urMK9tpfciF5ZD7kcw4PW+Ar1mljXioRPn3z0xjIMaMg6JVSG0xiyqbkXL4ViNl0O
         O94z8Nweb18YvJv3BsQu6FlMedOPExmumcqHkyA/TQaTZpw15QltgUjPicgST2Cp9QTk
         4ZD6DfJKv3MX/4XreP+UkmLUFfuCLXX1LLR5aDX9Rx2iuAYl9fNyN1S+YCjiAx4cSdnu
         M9C7IfDQ/64R40J+QtJzbQ4Io2S736XCzoQ8Enj9X9VofeJMHPWanzo1eDj5ZSR/9amQ
         czQPMxBPabsq041Of4Zj8snpjkqIQBXw2Wp5j0WnWvSP6Oc3//4h8FyUYq7S4oOoA1Rp
         ie6Q==
X-Gm-Message-State: AOAM533qi068TI/B/MyGRNMYjN37MpvAEAAHn2KiqznhK3LZ8xPLgSFU
        ruSDUhCiYPxx+Nmp6nnO9hPUkF1ULpSjWUTPmdA=
X-Google-Smtp-Source: ABdhPJx6dQalt69lWc63M4e+8wGXLuOE1/eDQYeJ+SA5ExGvxJJtlQN/wjbt+8RYCUNNbbswNb0CJ1q8DRFBP/Zvdgg=
X-Received: by 2002:ac8:4e42:0:b0:2f4:fc3c:b0c8 with SMTP id
 e2-20020ac84e42000000b002f4fc3cb0c8mr19509798qtw.684.1652789222633; Tue, 17
 May 2022 05:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652730821.git.rgb@redhat.com> <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
 <CAOQ4uxjV-eNxJ=O_WFTTzspCxXZqpMdh3Fe-N5aB-h1rDr_1hQ@mail.gmail.com>
 <20220517103236.i7gtsw7akiikqwam@quack3.lan> <CAOQ4uxj5HZva82g_ku8uexnqE65K-ThKFJqABNg-A-rc03cVfg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj5HZva82g_ku8uexnqE65K-ThKFJqABNg-A-rc03cVfg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 17 May 2022 15:06:51 +0300
Message-ID: <CAOQ4uxg2Kq_+cwn+7SxvE_8vpObpBHvuXpMLnu29FJWQwR2CFA@mail.gmail.com>
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

On Tue, May 17, 2022 at 2:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, May 17, 2022 at 1:32 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 17-05-22 08:37:28, Amir Goldstein wrote:
> > > On Mon, May 16, 2022 at 11:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > >
> > > > This patch adds 2 structure members to the response returned from user
> > > > space on a permission event. The first field is 32 bits for the context
> > > > type.  The context type will describe what the meaning is of the second
> > > > field. The default is none. The patch defines one additional context
> > > > type which means that the second field is a union containing a 32-bit
> > > > rule number. This will allow for the creation of other context types in
> > > > the future if other users of the API identify different needs.  The
> > > > second field size is defined by the context type and can be used to pass
> > > > along the data described by the context.
> > > >
> > > > To support this, there is a macro for user space to check that the data
> > > > being sent is valid. Of course, without this check, anything that
> > > > overflows the bit field will trigger an EINVAL based on the use of
> > > > FAN_INVALID_RESPONSE_MASK in process_access_response().
> > > >
> > > > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > > > Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> > > > Suggested-by: Jan Kara <jack@suse.cz>
> > > > Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >
> > ...
> > > >  static int process_access_response(struct fsnotify_group *group,
> > > > -                                  struct fanotify_response *response_struct)
> > > > +                                  struct fanotify_response *response_struct,
> > > > +                                  size_t count)
> > > >  {
> > > >         struct fanotify_perm_event *event;
> > > >         int fd = response_struct->fd;
> > > >         u32 response = response_struct->response;
> > > >
> > > > -       pr_debug("%s: group=%p fd=%d response=%u\n", __func__, group,
> > > > -                fd, response);
> > > > +       pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
> > > > +                group, fd, response, response_struct->extra_info_type, count);
> > > > +       if (fd < 0)
> > > > +               return -EINVAL;
> > > >         /*
> > > >          * make sure the response is valid, if invalid we do nothing and either
> > > >          * userspace can send a valid response or we will clean it up after the
> > > >          * timeout
> > > >          */
> > > > -       switch (response & ~FAN_AUDIT) {
> > > > -       case FAN_ALLOW:
> > > > -       case FAN_DENY:
> > > > -               break;
> > > > -       default:
> > > > -               return -EINVAL;
> > > > -       }
> > > > -
> > > > -       if (fd < 0)
> > > > +       if (FAN_INVALID_RESPONSE_MASK(response))
> > >
> > > That is a logic change, because now the response value of 0 becomes valid.
> > >
> > > Since you did not document this change in the commit message I assume this was
> > > non intentional?
> > > However, this behavior change is something that I did ask for, but it should be
> > > done is a separate commit:
> > >
> > >  /* These are NOT bitwise flags.  Both bits can be used together.  */
> > > #define FAN_TEST          0x00
> > > #define FAN_ALLOW       0x01
> > > #define FAN_DENY        0x02
> > > #define FANOTIFY_RESPONSE_ACCESS \
> > >             (FAN_TEST|FAN_ALLOW | FAN_DENY)
> > >
> > > ...
> > > int access = response & FANOTIFY_RESPONSE_ACCESS;
> > >
> > > 1. Do return EINVAL for access == 0
> > > 2. Let all the rest of the EINVAL checks run (including extra type)
> > > 3. Move if (fd < 0) to last check
> > > 4. Add if (!access) return 0 before if (fd < 0)
> > >
> > > That will provide a mechanism for userspace to probe the
> > > kernel support for extra types in general and specific types
> > > that it may respond with.
> >
> > I have to admit I didn't quite grok your suggestion here although I
> > understand (and agree with) the general direction of the proposal :). Maybe
> > code would explain it better what you have in mind?
> >
>
> +/* These are NOT bitwise flags.  Both bits can be used together.  */

I realize when reading this that this comment is weird, because
0x01 and 0x02 cannot currently be used together.
The comment was copied from above FAN_MARK_INODE where it
has the same weirdness.

The meaning is that (response & FANOTIFY_RESPONSE_ACCESS)
is an enum. I am sure that a less confusing phrasing for this comment
can be found.

> +#define FAN_TEST          0x00
> #define FAN_ALLOW       0x01
> #define FAN_DENY        0x02
> #define FAN_AUDIT       0x10    /* Bit mask to create audit record for result */
> +#define FANOTIFY_RESPONSE_ACCESS \
> +            (FAN_TEST|FAN_ALLOW | FAN_DENY)

Thanks,
Amir.
