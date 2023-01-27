Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C2D67EF1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 21:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjA0UE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 15:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjA0UEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:04:08 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D2518B21
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 12:02:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z31so4033618pfw.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 12:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EfpmMAjatY4kOsbY4TrkMHzBXh5/X5BJOB000E4SZn0=;
        b=JhER9st/YUOoa3m7j35TEwpppTbpvyA5HEFCCTJwhfbmmVWtir6XkteBq/XZXDlheX
         WIHJc1WkEhhtuQ8+DwT17ydyxui242CwJUqylU4IzrknYRLLKDBiKD0a4U5How6r6ETR
         A5voWLO9+dPO8Cyyb/3xlm5cowQu1+pDHzxKfXJYfkbvinfqSoOqDCrFk1gKZxq5NGzX
         yXv5+7+L1SlmDrEDyQAEapbp4GXxCxndD/QCk+5HAX3YDA/JKcR1E3CXIckJiBUBFwC3
         EaMxyeJmEIgqDNszgC4k46OpVK2d/hkl+Rr5pDMTKntUuDQ/3pbgGRfgYSf7H/fCkQoV
         1D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfpmMAjatY4kOsbY4TrkMHzBXh5/X5BJOB000E4SZn0=;
        b=XzwGhyclHncVxskEX657S0tFgBhJpzmI7F2GF1fsrNMv8SQIw9zxoJemipuwdFXkhm
         K/3opeQSFp0gWkhTVRrRl4jdcK3ybFfqL+F5JfwwQj5YdBM4CFH6Nk5OdGEiOnOF0t32
         u2zrXRx6G1yAZASts6Lfr1MdR7RZTqAfe+wA4VwDI1iDSUbXMNVQog5eaGz9Km7AsjhZ
         JPXcDDOBvugO4wgXOtJVKleacQUFt6wUeZ5bjftgmtS+zjW4TeuWBrOyR9FvKM4JskzS
         HG7RFUpmkLbubv2pnddYEwetfcJkEV1pc0Puh7NYgW7rL+A+pD4ejU/PWVoHR0Ni0xpr
         r33w==
X-Gm-Message-State: AO0yUKVySHcou7qLPEnk+KpFdBB2nKw2jASjN28bbB9HsW3aiSg0bi44
        RlSNe3/OvLJjHBAay/XYp+mf73QgrDPm/vp3bySR
X-Google-Smtp-Source: AK7set9cHd9eqigM7Z80LSp1WCi5uON322QrXrpvNCrJTc0+ocBLek6mOp1j8JQUOubRBHUx4ngqoNZ2hk173uCj0yQ=
X-Received: by 2002:a62:8e0a:0:b0:592:a8af:4ffc with SMTP id
 k10-20020a628e0a000000b00592a8af4ffcmr487646pfe.52.1674849744106; Fri, 27 Jan
 2023 12:02:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673989212.git.rgb@redhat.com> <82aba376bfbb9927ab7146e8e2dee8d844a31dc2.1673989212.git.rgb@redhat.com>
 <CAHC9VhTgesdmF3-+oP-EYuNZ-8LKXGPYuSffVst_Wca5Oj0EAQ@mail.gmail.com> <Y9GpDpjlwBr+ZTWm@madcap2.tricolour.ca>
In-Reply-To: <Y9GpDpjlwBr+ZTWm@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Jan 2023 15:02:13 -0500
Message-ID: <CAHC9VhQY3zfwh_=6swUN7BWGSQdsLDxw-dbyTh6rayZq7q-x5w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fanotify,audit: Allow audit to use the full
 permission event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 5:11 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2023-01-20 13:58, Paul Moore wrote:
> > On Tue, Jan 17, 2023 at 4:14 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > This patch passes the full response so that the audit function can use all
> > > of it. The audit function was updated to log the additional information in
> > > the AUDIT_FANOTIFY record.
> > >
> > > Currently the only type of fanotify info that is defined is an audit
> > > rule number, but convert it to hex encoding to future-proof the field.
> > > Hex encoding suggested by Paul Moore <paul@paul-moore.com>.
> > >
> > > The {subj,obj}_trust values are {0,1,2}, corresponding to no, yes, unknown.
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
> > >  kernel/auditsc.c              | 16 +++++++++++++---
> > >  3 files changed, 20 insertions(+), 8 deletions(-)
> >
> > ...
> >
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index d1fb821de104..3133c4175c15 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -2877,10 +2878,19 @@ void __audit_log_kern_module(char *name)
> > >         context->type = AUDIT_KERN_MODULE;
> > >  }
> > >
> > > -void __audit_fanotify(u32 response)
> > > +void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > >  {
> > > -       audit_log(audit_context(), GFP_KERNEL,
> > > -               AUDIT_FANOTIFY, "resp=%u", response);
> > > +       /* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
> > > +       if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > > +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > > +                         "resp=%u fan_type=%u fan_info=3F subj_trust=2 obj_trust=2",
> > > +                         response, FAN_RESPONSE_INFO_NONE);
> > > +               return;
> > > +       }
> > > +       audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > > +                 "resp=%u fan_type=%u fan_info=%X subj_trust=%u obj_trust=%u",
> > > +                 response, friar->hdr.type, friar->rule_number,
> > > +                 friar->subj_trust, friar->obj_trust);
> > >  }
> >
> > The only thing that comes to mind might be to convert the if-return
> > into a switch statement to make it a bit cleaner and easier to patch
> > in the future, but that is soooo far removed from any real concern
> > that I debated even mentioning it.  I only bring it up in case the
> > "3F" discussion results in a respin, and even then I'm not going to
> > hold my ACK over something as silly as a if-return vs switch.
> >
> > For clarity, this is what I was thinking:
> >
> > void __audit_fanontify(...)
> > {
> >   switch (type) {
> >   case FAN_RESPONSE_INFO_NONE:
> >     audit_log(...);
> >     break;
> >   default:
> >     audit_log(...);
> >   }
> > }
>
> I agree that would be cleaner ...

As I said, the "3F" concern of Steve is really the only thing I would
bother respinning for, my other comments were just passing
observations.

-- 
paul-moore.com
