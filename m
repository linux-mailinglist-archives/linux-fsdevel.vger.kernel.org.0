Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352645E6F7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 00:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiIVWOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 18:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIVWN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:13:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314631129E3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:13:56 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o184so14123464oif.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lVxzQXoJt8yJlDUfwhT+9PZwkUKntLnGspL2HrKQRnw=;
        b=2rNsM24o5o8hp8REt3SbWPwTx8H5Ez3ZVvyMWYf5FOdHA8xvcb/s6T3cf9ZhMiy3OP
         MDdYwXnChE4uteJTJDHMEi8RLXFZGzmOTkgTSBHYlLbQL2LOCNWn0DqhjSlw8EX/xU5S
         SCZiL+x23crfmJ/eL3IASKIFIVOL3SKGMReJgMvJTl9GR/r6TUXJq04VuznLBC8FZlK5
         gwnkH0J8ZvFAX8tkJnFHz+4rwP5HuXjWm16MDs1da8iT1dmxlTlJuv45gp2mH/hITSlE
         doBl/3YfKxuORFXqyNLacs3tmmDXNmz4gUtP8RWBRXj3USNFf82tUbXoz6a1mNVkhty+
         GxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lVxzQXoJt8yJlDUfwhT+9PZwkUKntLnGspL2HrKQRnw=;
        b=tpnP4KCZbTcW/eflwTnVgImbIr4q5sa9CBV1RZ+6jo86+95gTsolcEKH+TfL7mnO9w
         htnn4G5yHNaDbJwTj4I8RJGordx+lqtc21C/dkO7eiM3ru/Xn44T1mkJG+ncuxgt410I
         REoqQ1pzqQBJQ0S8BMrV1/+mZxgs71V29iKK5XdvPxA06TTTFtbadrhleouF/UN3nGxe
         FwjUSxSWuw/TFzMySP8tZl3rT56xKkIecgWON+t78t1+P/YFoU7FXBVlKanwerdoYrqU
         x9P/Desd/A6CNetvsDcJsyu4XwwMsv8n8rrxABqTja28t2OupDEJf0N8SDTs5SwZqpiY
         4wMQ==
X-Gm-Message-State: ACrzQf2mFSLGWWy7RR9W8zwKg4UE4picxTiLJKId9kXHuv2JfyrPfR8e
        K6CoTB8Ooem1bmJAOv+lHOlxEC8NVF5Kg2mn+jP9
X-Google-Smtp-Source: AMsMyM5Onvxiq8nCOD2wBV8RegfymgeU0WI0iCMUw//aI9XM1Wpuhd5pGa5VlijH5GzJXc0eysR5lfHbW/Qiu2J+BYc=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr7536588oiv.51.1663884834071; Thu, 22
 Sep 2022 15:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
 <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
 <16ca7e4c-01df-3585-4334-6be533193ba6@schaufler-ca.com> <CAHC9VhQRST66pVuNM0WGJsh-W01mDD-bX=GpFxCceUJ1FMWrmg@mail.gmail.com>
 <20220922215731.GA28876@mail.hallyn.com>
In-Reply-To: <20220922215731.GA28876@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 18:13:44 -0400
Message-ID: <CAHC9VhSBwavTLcgkgJ-AYwH9wzECi3B7BtwdKOx5FJ3n7M+WYg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 5:57 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> On Thu, Sep 22, 2022 at 03:07:44PM -0400, Paul Moore wrote:
> > On Thu, Sep 22, 2022 at 2:54 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > On 9/22/2022 10:57 AM, Linus Torvalds wrote:
> > > > On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > >> Could we please see the entire patch set on the LSM list?
> > > > While I don't think that's necessarily wrong, I would like to point
> > > > out that the gitweb interface actually does make it fairly easy to
> > > > just see the whole patch-set.
> > > >
> > > > IOW, that
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework
> > > >
> > > > that Christian pointed to is not a horrible way to see it all. Go to
> > > > the top-most commit, and it's easy to follow the parent links.
> > >
> > > I understand that the web interface is fine for browsing the changes.
> > > It isn't helpful for making comments on the changes. The discussion
> > > on specific patches (e.g. selinux) may have impact on other parts of
> > > the system (e.g. integrity) or be relevant elsewhere (e.g. smack). It
> > > can be a real problem if the higher level mailing list (the LSM list
> > > in this case) isn't included.
> >
> > This is probably one of those few cases where Casey and I are in
> > perfect agreement.  I'd much rather see the patches hit my inbox than
> > have to go hunting for them and then awkwardly replying to them (and
> > yes, I know there are ways to do that, I just personally find it
> > annoying).  I figure we are all deluged with email on a daily basis
> > and have developed mechanisms to deal with that in a sane way, what is
> > 29 more patches on the pile?
>
> Even better than the web interface, is find the message-id in any of the
> emails you did get, and run
>
> b4 mbox 20220922151728.1557914-1-brauner@kernel.org
>
> In general I'd agree with sending the whole set to the lsm list, but
> then one needs to start knowing which lists do and don't want the whole
> set...  b4 mbox and lei are now how I read all kernel related lists.

In my opinion, sending the entire patchset to the relevant lists
should be the default for all the reasons mentioned above.  All the
other methods are fine, and I don't want to stop anyone from using
their favorite tool, but *requiring* the use of a separate tool to
properly review and comment on patches gets us away from the
email-is-universal argument.  Yes, all the other tools mentioned are
still based in a world of email, but if you are not emailing the
relevant stakeholders directly (or indirectly via a list), you are
placing another hurdle in front of the reviewers by requiring them to
leave their email client based workflow and jump over to lore, b4,
etc. to review the patchset.

The lore.kernel.org instance is wonderful, full stop, and the b4 tool
is equally wonderful, full stop, but they are tools intended to assist
and optimize; they should not replace the practice of sending patches,
with the full context, to the relevant parties.

-- 
paul-moore.com
