Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51EF6547B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 22:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiLVVRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 16:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLVVRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:17:11 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7012ACC
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 13:17:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a14so2067606pfa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 13:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKGYCzvkrRQsG26exGSDsGM12AW8tkADFj8h5RB+A30=;
        b=xA2sAcbvHRLRPTNUcWhOU2eTVgIGKrEnm3k5rs25we3/mQswqEnKJE0BAFGpg2kPLM
         Dn+EN3WwOtSdz1LqYVQHtlzMiwaek22Q1ndUd9meDVwMakC3sKgEbMO0Rc8qgFYrbgtk
         4w2iEeXUEjqhaSrsFJcAuejShPMBEUqXlFZ9Kfn/61Me0fPEwNYwlDC6fmLNoUU1VAgz
         aNA638ly+YP1vGWFb1l37EDPbImpC/e4Vi1aHts4gCQHLljJG37sLlLDYxqYZCqJq/w6
         EBu1T8DMU/uOOsK8JeW7wGifHMMCwARYXQq6U9qR4aEosFifxbJqR7YbwEd7Ib/oBOds
         A1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKGYCzvkrRQsG26exGSDsGM12AW8tkADFj8h5RB+A30=;
        b=SGuul5avXdDVpO9PHP720vseKgrSbF28QE8WYL7UkyD7JMMlOPN3zBwNlnqkFBgzcX
         STy36OwzSmuSVsmLwbOjnFMpMp94lPsrRijv/OsvzKA4YbEyfvnDzXYh5v76kSkNF221
         R34cQU96+yJAF4U8KgzfekPkDkz/Lr59EsQjsqLIptNu1yna/A0befRlkIO/K7Fw5lnR
         Z9Is6yVj6DK/uBtz4O3wRF2ItVXGm27ajmeF6ZxHsOP9IiZWUQXXmJHL2UVeyzncqQel
         ljHimVea80fbO5GQjjQQvc481UwqPXwVXakZ+1w57cBqaLOniashxIankc6ipoU7lcGu
         mehQ==
X-Gm-Message-State: AFqh2krETK0qB8q854sYy+w6RbFgu1QnCvFHLI8X3i/+c029aIofqmfv
        Xm68K9iRREPgBg2TfgBVySQkXjFlmv3Wp9tsrSy9
X-Google-Smtp-Source: AMrXdXutQGBOBCQtEo6BWJnU2LinVPQY1YK1lmJoTJgmHaEQzUCCjkTLfrnDcRjCZNzga7g8tnUcuDgqK3DL5+HgtFo=
X-Received: by 2002:aa7:924d:0:b0:577:62a8:f7a1 with SMTP id
 13-20020aa7924d000000b0057762a8f7a1mr454916pfp.2.1671743829956; Thu, 22 Dec
 2022 13:17:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670606054.git.rgb@redhat.com> <79fcf72ea442eeede53ed5e6de567f8df8ef7d83.1670606054.git.rgb@redhat.com>
 <CAHC9VhQont7=S9pvTpLUmxVSj-g-j2ZhVCLiUki69vtp8rf-9A@mail.gmail.com> <Y6TBL7+W7Q1lYc9Q@madcap2.tricolour.ca>
In-Reply-To: <Y6TBL7+W7Q1lYc9Q@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Dec 2022 16:16:58 -0500
Message-ID: <CAHC9VhQ6Nn2DuO-w3OtMj3rrtPp+X5ULYpZW8wLTakK9sMrs0g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] fanotify,audit: Allow audit to use the full
 permission event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-api@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 3:42 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2022-12-20 18:31, Paul Moore wrote:
> > On Mon, Dec 12, 2022 at 9:06 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > This patch passes the full response so that the audit function can use all
> > > of it. The audit function was updated to log the additional information in
> > > the AUDIT_FANOTIFY record.
> > >
> > > Currently the only type of fanotify info that is defined is an audit
> > > rule number, but convert it to hex encoding to future-proof the field.
> > > Hex encoding suggested by Paul Moore <paul@paul-moore.com>.
> > >
> > > Sample records:
> > >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
> > >   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F subj_trust=2 obj_trust=2
> > >
> > > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > > Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  fs/notify/fanotify/fanotify.c |  3 ++-
> > >  include/linux/audit.h         |  9 +++++----
> > >  kernel/auditsc.c              | 25 ++++++++++++++++++++++---
> > >  3 files changed, 29 insertions(+), 8 deletions(-)
> >
> > ...
> >
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index d1fb821de104..8d523066d81f 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -64,6 +64,7 @@
> > >  #include <uapi/linux/limits.h>
> > >  #include <uapi/linux/netfilter/nf_tables.h>
> > >  #include <uapi/linux/openat2.h> // struct open_how
> > > +#include <uapi/linux/fanotify.h>
> > >
> > >  #include "audit.h"
> > >
> > > @@ -2877,10 +2878,28 @@ void __audit_log_kern_module(char *name)
> > >         context->type = AUDIT_KERN_MODULE;
> > >  }
> > >
> > > -void __audit_fanotify(u32 response)
> > > +void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > >  {
> > > -       audit_log(audit_context(), GFP_KERNEL,
> > > -               AUDIT_FANOTIFY, "resp=%u", response);
> > > +       struct audit_context *ctx = audit_context();
> > > +       struct audit_buffer *ab;
> > > +       char numbuf[12];
> > > +
> > > +       if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > > +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > > +                         "resp=%u fan_type=%u fan_info=3F subj_trust=2 obj_trust=2",
> > > +                         response, FAN_RESPONSE_INFO_NONE);
> >
> > The fan_info, subj_trust, and obj_trust constant values used here are
> > awfully magic-numbery and not the usual sentinel values one might
> > expect for a "none" operation, e.g. zeros/INT_MAX/etc. I believe a
> > comment here explaining the values would be a good idea.
>
> Ack.  I'll add a comment.  I would have preferred zero for default of
> unset, but Steve requested 0/1/2 no/yes/unknown.

Yeah, if they were zeros I don't think we would need to comment on
them as zeros for unset/unknown/invalid is rather common, 2 ... not so
much.

-- 
paul-moore.com
