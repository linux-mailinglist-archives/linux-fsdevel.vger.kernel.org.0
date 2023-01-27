Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB067EF13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 21:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjA0UC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 15:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjA0UCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:02:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0808E17F
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 12:00:50 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v23so6110769plo.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 12:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=am+vlnLsg0XsWPedwqTMfueZR+oGnG7UWNBHwR8AcYc=;
        b=Q0U8C4RtPDRpzAiibd2GVE0E00+3tsbOeaPeNHaMiolmsmk9YV+x/VYoBGp+R5j2L8
         +lc5XAHQMvX8YDrGROEibXrLzof6cGPZpgv+q3LsrVMN3BMnfa48T1BokWA3LIMH0aI0
         wP1RJonGnMGPsEJ2H8MBmmF7ZZbqx7Pu6e6cGlhSsr4qXkaxhYmAqCDfarmNVHLNcK82
         ozQ4gaksTPaJmsZN17hEU2/Hfpk0Fu2DoXPZM0M9GfaLb1GEAkEvV0Dnjr8WyOW/TIS4
         3dqCV71phS8pxZ+H/QcAw6Boxoo8/ZdHvHiwWEGMsZyWSa36bv/ntULg6yNA7bJsj8Gn
         O+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=am+vlnLsg0XsWPedwqTMfueZR+oGnG7UWNBHwR8AcYc=;
        b=DI9kdhnT/pddZEUDDHptQG1BPHDKgjvlo9nHTZXOkMS160wD+6JfF8VoZIjrDCZXrf
         hF1wHYnc70hEa0JfoxAqZeMW1fLUiunCzRFOq0Ns9DKjr0WCwzC0jmCay63BuU7BWMtW
         eCu2Y7bFqIf3awBxIldjgyYdTo9t5ox7cfBt0OxzA/zSVeXmLCQnPRF+aYMRTpckYZK5
         ewp5R2Mhi2RwaH563b/EHb74AFybA6NzCFvUTyRntlaCnKXIXr71+5FtxjeVbV6FEvqr
         96du4o3mJUUekY8UZUydWKaxXbB8sVzPKMrfHr4aSyVkNBd0ACJl52md1/MU9f3AYoPN
         PPNQ==
X-Gm-Message-State: AFqh2kpgrSNk6x+gGk4C6D9snTyhQTI2+NPQgmM41luboyULsTLBY8H/
        p0cDCCNJwtOH9jkgbLkQTp4A1KTClRPom1dRfgeR
X-Google-Smtp-Source: AMrXdXtgDZu6IiaCLCwfyX/1peJyGjLyCaHOG29QZFCt9RV37pAXcnEo7stUTPwkGz0Tc+B2pfdv256KSKwS87gRKSQ=
X-Received: by 2002:a17:90b:3903:b0:225:de08:b714 with SMTP id
 ob3-20020a17090b390300b00225de08b714mr4950213pjb.193.1674849648652; Fri, 27
 Jan 2023 12:00:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673989212.git.rgb@redhat.com> <82aba376bfbb9927ab7146e8e2dee8d844a31dc2.1673989212.git.rgb@redhat.com>
 <5680172.DvuYhMxLoT@x2> <CAHC9VhQbSCxmSbLFJZidAr952uHt-KktfRRJN3Lr+uDSCzHtfQ@mail.gmail.com>
 <Y9Gn4YmKFBot/R4l@madcap2.tricolour.ca>
In-Reply-To: <Y9Gn4YmKFBot/R4l@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Jan 2023 15:00:37 -0500
Message-ID: <CAHC9VhRWDD6Tk6AEmgoobBkcVKRYbVOte7-F0TGJD2dRk7NKxw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fanotify,audit: Allow audit to use the full
 permission event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, Jan Kara <jack@suse.cz>,
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

On Wed, Jan 25, 2023 at 5:06 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2023-01-20 13:52, Paul Moore wrote:
> > On Wed, Jan 18, 2023 at 1:34 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > Hello Richard,
> > >
> > > I built a new kernel and tested this with old and new user space. It is
> > > working as advertised. The only thing I'm wondering about is why we have 3F
> > > as the default value when no additional info was sent? Would it be better to
> > > just make it 0?
> >
> > ...
> >
> > > On Tuesday, January 17, 2023 4:14:07 PM EST Richard Guy Briggs wrote:
> > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > index d1fb821de104..3133c4175c15 100644
> > > > --- a/kernel/auditsc.c
> > > > +++ b/kernel/auditsc.c
> > > > @@ -2877,10 +2878,19 @@ void __audit_log_kern_module(char *name)
> > > >       context->type = AUDIT_KERN_MODULE;
> > > >  }
> > > >
> > > > -void __audit_fanotify(u32 response)
> > > > +void __audit_fanotify(u32 response, struct
> > > > fanotify_response_info_audit_rule *friar) {
> > > > -     audit_log(audit_context(), GFP_KERNEL,
> > > > -             AUDIT_FANOTIFY, "resp=%u", response);
> > > > +     /* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
> > > > +     if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > > > +             audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > > > +                       "resp=%u fan_type=%u fan_info=3F subj_trust=2
> > > obj_trust=2",
> > > > +                       response, FAN_RESPONSE_INFO_NONE);
> > > > +             return;
> > > > +     }
> >
> > (I'm working under the assumption that the "fan_info=3F" in the record
> > above is what Steve was referring to in his comment.)
> >
> > I vaguely recall Richard commenting on this in the past, although
> > maybe not ... my thought is that the "3F" is simply the hex encoded
> > "?" character in ASCII ('man 7 ascii' is your friend).  I suppose the
> > question is what to do in the FAN_RESPONSE_INFO_NONE case.
> >
> > Historically when we had a missing field we would follow the "field=?"
> > pattern, but I don't recall doing that for a field which was
> > potentially hex encoded, is there an existing case where we use "?"
> > for a field that is hex encoded?  If so, we can swap out the "3F" for
> > a more obvious "?".
>
> I was presuming encoding the zero: "30"

I'm sorry, but you've lost me here.

> > However, another option might be to simply output the current
> > AUDIT_FANOTIFY record format in the FAN_RESPONSE_INFO_NONE case, e.g.
> > only "resp=%u".  This is a little against the usual guidance of
> > "fields should not disappear from a record", but considering that
> > userspace will always need to support the original resp-only format
> > for compatibility reasons this may be an option.
>
> I don't have a strong opinion.

I'm not sure I care too much either.  I will admit that the "3F" seems
to be bordering on the "bit too clever" side of things, but it's easy
to argue it is in keeping with the general idea of using "?" to denote
absent/unknown fields.

As Steve was the one who raised the question in this latest round, and
he knows his userspace tools the best, it seems wise to get his input
on this.

-- 
paul-moore.com
