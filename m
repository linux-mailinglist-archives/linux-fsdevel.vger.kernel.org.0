Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4644868F31E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjBHQYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 11:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjBHQYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:24:35 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB9301BD
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 08:24:33 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id u75so6401919pgc.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5QZBwNZEGMpaQZL+RItnX9+RrhVVFdDL8hLibIYIFRQ=;
        b=GfYOwxVa/r+ukce82JTJsCehwXyu6NCJGN4utdN6/a2arSgvit/xFzuoJIIMCNlzDf
         8wFO96FAlmWmBzPRz1L9HZa8ouwSAdHzdJouADV62qaYw+DOJhCLqMgTdmEmuQeV7b7u
         y3D9o0zOOgXRhgibIA5jTrmmRuGWcrIIn+y+dqrPHSqxG/PGoMd7boyVSAXAQtcC0WCL
         JPsKxdpo77TWEVFxfUcTV3qVL4wCjgZi+Zn+KQwzY54DftvMTQyLFNWth0jMnmi5Bo0m
         KW5kXt50wCjRuRMUDWqclRFWmc+pb+aGrc9c7+zN3CQB1sLsFwEG4JbbOX5jLuns3WeC
         wsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QZBwNZEGMpaQZL+RItnX9+RrhVVFdDL8hLibIYIFRQ=;
        b=1AqbG0uBw/KEK3EWUyOKOhcXRVve6TvTuql4C0Q7hDWm+6nJuC/r54oP9m5AFtn9yC
         a0Qegv6g33aiZqjk7GskwUt6C73d3BHmp/KJFPaRsAFK3HntAGnNriv57VLFzBBU0EU6
         GoTzpOVmpiNAX5zkJ9H/8DdtjzF8O6UJg5z2Q3E3+P3bYwP5Op7/iJhwRfGkRunAOpXO
         w0zxP63Fzt2oyQpTvuFz/LI0JmglFEB3HwKxMlnim1ZHaceoTwgEM1KYtaywVxo9qOLk
         +3S7ebVddc4WTcHj62CTTq+sEK8DaAzFP7csb4WQRaeQfl0/7IezANsmJ1bcdHWdA2Vz
         kxIQ==
X-Gm-Message-State: AO0yUKWeA/CyBD8cIbqFBPzejeRTV98LcY4MZ5hYHZfcPwK7LwBp5qYK
        KsvC49AWJySL6BxLLLmBJLcK8IEJXBof51Jvdd3X
X-Google-Smtp-Source: AK7set9WlFaBqCNORMZ/MtBXsv1aS6hOrWsBpVZnP2fZuQOkIA7m8VhFW/MJusvpHxTKmRVoJCojHg6fu9Q91jymSL0=
X-Received: by 2002:a63:3544:0:b0:4f5:8a1b:7d0 with SMTP id
 c65-20020a633544000000b004f58a1b07d0mr1697887pga.88.1675873472991; Wed, 08
 Feb 2023 08:24:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675373475.git.rgb@redhat.com> <20230208120816.2qhck3sb7u67vsib@quack3>
 <CAHC9VhSumNxmoYQ9JPtBgV0dc1fgR38Lqbo0w4PRxhvBdS=W_w@mail.gmail.com> <5912195.lOV4Wx5bFT@x2>
In-Reply-To: <5912195.lOV4Wx5bFT@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Feb 2023 11:24:21 -0500
Message-ID: <CAHC9VhQnajhwOiW-0GvgnkPJ=QOTuLaYt2WBbm8vJoyEDso=2Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] fanotify: Allow user space to pass back additional
 audit info
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
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

On Wed, Feb 8, 2023 at 10:27 AM Steve Grubb <sgrubb@redhat.com> wrote:
> On Wednesday, February 8, 2023 10:03:24 AM EST Paul Moore wrote:
> > On Wed, Feb 8, 2023 at 7:08 AM Jan Kara <jack@suse.cz> wrote:
> > > On Tue 07-02-23 09:54:11, Paul Moore wrote:
> > > > On Tue, Feb 7, 2023 at 7:09 AM Jan Kara <jack@suse.cz> wrote:
> > > > > On Fri 03-02-23 16:35:13, Richard Guy Briggs wrote:
> > > > > > The Fanotify API can be used for access control by requesting
> > > > > > permission
> > > > > > event notification. The user space tooling that uses it may have a
> > > > > > complicated policy that inherently contains additional context for
> > > > > > the
> > > > > > decision. If this information were available in the audit trail,
> > > > > > policy
> > > > > > writers can close the loop on debugging policy. Also, if this
> > > > > > additional
> > > > > > information were available, it would enable the creation of tools
> > > > > > that
> > > > > > can suggest changes to the policy similar to how audit2allow can
> > > > > > help
> > > > > > refine labeled security.
> > > > > >
> > > > > > This patchset defines a new flag (FAN_INFO) and new extensions that
> > > > > > define additional information which are appended after the response
> > > > > > structure returned from user space on a permission event.  The
> > > > > > appended
> > > > > > information is organized with headers containing a type and size
> > > > > > that
> > > > > > can be delegated to interested subsystems.  One new information
> > > > > > type is
> > > > > > defined to audit the triggering rule number.
> > > > > >
> > > > > > A newer kernel will work with an older userspace and an older
> > > > > > kernel
> > > > > > will behave as expected and reject a newer userspace, leaving it up
> > > > > > to
> > > > > > the newer userspace to test appropriately and adapt as necessary.
> > > > > > This
> > > > > > is done by providing a a fully-formed FAN_INFO extension but
> > > > > > setting the
> > > > > > fd to FAN_NOFD.  On a capable kernel, it will succeed but issue no
> > > > > > audit
> > > > > > record, whereas on an older kernel it will fail.
> > > > > >
> > > > > > The audit function was updated to log the additional information in
> > > > > > the
> > > > > > AUDIT_FANOTIFY record. The following are examples of the new record
> > > > > >
> > > > > > format:
> > > > > >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1
> > > > > >   fan_info=3137 subj_trust=3 obj_trust=5 type=FANOTIFY
> > > > > >   msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=0
> > > > > >   subj_trust=2 obj_trust=2> > >
> > > > > Thanks! I've applied this series to my tree.
> > > >
> > > > While I think this version of the patchset is fine, for future
> > > > reference it would have been nice if you had waited for my ACK on
> > > > patch 3/3; while Steve maintains his userspace tools, I'm the one
> > > > responsible for maintaining the Linux Kernel's audit subsystem.
> > >
> > > Aha, I'm sorry for that. I had the impression that on the last version of
> > > the series you've said you don't see anything for which the series should
> > > be respun so once Steve's objections where addressed and you were silent
> > > for a few days, I thought you consider the thing settled... My bad.
> >
> > That's understandable, especially given inconsistencies across
> > subsystems.  If it helps, if I'm going to ACK something I make it
> > explicit with a proper 'Acked-by: ...' line in my reply; if I say
> > something looks good but there is no explicit ACK, there is usually
> > something outstanding that needs to be resolved, e.g. questions,
> > additional testing, etc.
> >
> > In this particular case I posed some questions in that thread and
> > never saw a reply with any answers, hence the lack of an ACK.  While I
> > think the patches were reasonable, I withheld my ACK until the
> > questions were answered ... which they never were from what I can
> > tell, we just saw a new patchset with changes.
> >
> > /me shrugs
>
> Paul,
>
> I reread the thread. You only had a request to change if/else to a switch
> construct only if there was a respin for the 3F. You otherwise said get
> Steve's input and the 3F borders on being overly clever. Both were addressed.
> If you had other questions that needed answers on, please restate them to
> expedite approval of this set of patches. As far as I can tell, all comments
> are addressed.

Steve,

It might be helpful to reread my reply below:

https://lore.kernel.org/linux-audit/CAHC9VhRWDD6Tk6AEmgoobBkcVKRYbVOte7-F0TGJD2dRk7NKxw@mail.gmail.com/

You'll see that I made a comment in that email about not following
Richard's explanation about "encoding the zero" (the patch was
encoding a "?" to the best I could tell).  I was hoping for some
clarification from Richard on his comments, and I never saw anything
in my inbox.  I just checked the archives on lore and I don't see
anything there either.

-- 
paul-moore.com
