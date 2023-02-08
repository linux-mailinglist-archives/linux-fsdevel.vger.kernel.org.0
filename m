Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE6668F18E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 16:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjBHPDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 10:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBHPDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:03:38 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A552031E2F
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 07:03:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ge7-20020a17090b0e0700b002312568942cso451148pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 07:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1675868616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ihjiwlEnazSLR/Xo/oRVwpb499pD51aqltyWYJGNkVs=;
        b=RPQn1iw/xRc+1cVa3RM5oJRtOA2vwu/5R32oiUN3F8Oee1FuHFVX+7vLxNi2d+4Qu5
         KPpJ6rF9NiSj+XO1h1mX/gQJfiFcvlTgd5CkhWC9xlkyD9TlvVCzuV3VHIDHOZXt1P3v
         SgzPC9q/gj8Eha/zhVnRIUcjKhdFtNYhkQIH4w6r2lo5Rur0PzGWCfIwKqxd3TVLU+Rs
         SPWt+5cANOtWo60DUw1LlBWZV8JijMTAUpmZfI6o240lBqX8HOXPitHyq+XHcrHJKGqe
         WFK8ftIdT0TMJ6PRha4WeP0HC/w8h0+H4fYKWYUU3u90dwoguXs/i5zgHGar/7Y66+eI
         KzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1675868616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihjiwlEnazSLR/Xo/oRVwpb499pD51aqltyWYJGNkVs=;
        b=Ef+MJikEeE3t8XGL/W754YA9HEwOH5eQ6GwZUwfGOTmMzCfqz/zO0mqYZgUEcglUXI
         c1FSejSp6DAppiLG51+motYXGorgLYBfZaGIh7xrNcscafhO50iczTyLVtgxXPWttKmB
         vGJWsMn5bsf8GAcgDhUqkzeSwEE0lTMJ3ZcSwzMr9fUNDi/kQugIJdsAkiimhWiTrE5W
         fQPVG30I0MbCpYbx3uap+/KcDshXmBaJTSoduBc7a33DIE5CtYq8AM/4HVktkdrR/SAf
         SN4Nq3hFSseJgRDXawNiDQSTwB33bE8E5faimte5wJ67DHOIl+nZq+F5vvcaa5A+WNHE
         HXbg==
X-Gm-Message-State: AO0yUKUy9hVba5WaR4WT3S13j2n/bfrHXUQ1ED7AqEWnvpi9+UCHBopk
        XYMBYb8/h+XWR5pzf6fgipfPlK7TaZ3qqdvA8db4
X-Google-Smtp-Source: AK7set97wwwjEmTxETvTco6NkGr3kzx4BNOLzV+BA5GR23v21B97EbMG5opdpR48Q4SRlmodujmSwcXTaNhKjoLZ+B4=
X-Received: by 2002:a17:903:2796:b0:199:1faa:1b75 with SMTP id
 jw22-20020a170903279600b001991faa1b75mr1889595plb.32.1675868616002; Wed, 08
 Feb 2023 07:03:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675373475.git.rgb@redhat.com> <20230207120921.7pgh6uxs7ze7hkjo@quack3>
 <CAHC9VhQuD0UMYd12x9kOMwruDmQsyUFxQ8gJ3Q_qF6a58Lu+2Q@mail.gmail.com> <20230208120816.2qhck3sb7u67vsib@quack3>
In-Reply-To: <20230208120816.2qhck3sb7u67vsib@quack3>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Feb 2023 10:03:24 -0500
Message-ID: <CAHC9VhSumNxmoYQ9JPtBgV0dc1fgR38Lqbo0w4PRxhvBdS=W_w@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] fanotify: Allow user space to pass back additional
 audit info
To:     Jan Kara <jack@suse.cz>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 8, 2023 at 7:08 AM Jan Kara <jack@suse.cz> wrote:
> On Tue 07-02-23 09:54:11, Paul Moore wrote:
> > On Tue, Feb 7, 2023 at 7:09 AM Jan Kara <jack@suse.cz> wrote:
> > > On Fri 03-02-23 16:35:13, Richard Guy Briggs wrote:
> > > > The Fanotify API can be used for access control by requesting permission
> > > > event notification. The user space tooling that uses it may have a
> > > > complicated policy that inherently contains additional context for the
> > > > decision. If this information were available in the audit trail, policy
> > > > writers can close the loop on debugging policy. Also, if this additional
> > > > information were available, it would enable the creation of tools that
> > > > can suggest changes to the policy similar to how audit2allow can help
> > > > refine labeled security.
> > > >
> > > > This patchset defines a new flag (FAN_INFO) and new extensions that
> > > > define additional information which are appended after the response
> > > > structure returned from user space on a permission event.  The appended
> > > > information is organized with headers containing a type and size that
> > > > can be delegated to interested subsystems.  One new information type is
> > > > defined to audit the triggering rule number.
> > > >
> > > > A newer kernel will work with an older userspace and an older kernel
> > > > will behave as expected and reject a newer userspace, leaving it up to
> > > > the newer userspace to test appropriately and adapt as necessary.  This
> > > > is done by providing a a fully-formed FAN_INFO extension but setting the
> > > > fd to FAN_NOFD.  On a capable kernel, it will succeed but issue no audit
> > > > record, whereas on an older kernel it will fail.
> > > >
> > > > The audit function was updated to log the additional information in the
> > > > AUDIT_FANOTIFY record. The following are examples of the new record
> > > > format:
> > > >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
> > > >   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=0 subj_trust=2 obj_trust=2
> > >
> > > Thanks! I've applied this series to my tree.
> >
> > While I think this version of the patchset is fine, for future
> > reference it would have been nice if you had waited for my ACK on
> > patch 3/3; while Steve maintains his userspace tools, I'm the one
> > responsible for maintaining the Linux Kernel's audit subsystem.
>
> Aha, I'm sorry for that. I had the impression that on the last version of
> the series you've said you don't see anything for which the series should
> be respun so once Steve's objections where addressed and you were silent
> for a few days, I thought you consider the thing settled... My bad.

That's understandable, especially given inconsistencies across
subsystems.  If it helps, if I'm going to ACK something I make it
explicit with a proper 'Acked-by: ...' line in my reply; if I say
something looks good but there is no explicit ACK, there is usually
something outstanding that needs to be resolved, e.g. questions,
additional testing, etc.

In this particular case I posed some questions in that thread and
never saw a reply with any answers, hence the lack of an ACK.  While I
think the patches were reasonable, I withheld my ACK until the
questions were answered ... which they never were from what I can
tell, we just saw a new patchset with changes.

/me shrugs

-- 
paul-moore.com
