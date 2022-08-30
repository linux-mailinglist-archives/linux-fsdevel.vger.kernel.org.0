Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CDE5A6E28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 22:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiH3UKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiH3UKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:10:52 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E904454A
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 13:10:51 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11e9a7135easo16963391fac.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qJlLpOkELPi/QHoI5MOqP2NXG1iWQCH2fEv8e9Ssxoo=;
        b=xxEodV7a1e7/J/CC+G/b+UaD2Ii0/Rn30BjWnLmnHXaqxBbJn27dTX5+BSX6y2T0VC
         600IGhnHSDehtxBC5L8x9dLnBArvX53kytinB+b/jGnGVCVUS6T2E6Tc5ilPu6cFI71+
         502VF3G+Bep6f5sAH+kr0v2hYHzzsysrsYYKAfmYJEK+0VAyw/bUPTe6WuaNI6F8Nue4
         BVO8z6ThCYrr8+HaYvlCZ2FMVbZTODrKqx22p0S3vziQ0cbciSBGRpVvwLRB/mT45d8d
         la+wIdrLeEcfxsMJNYYJlHi+yiXYFQqhpgwl7P4jtf7+CdlAuwpy+NQqrluhn0DiqfLi
         EFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qJlLpOkELPi/QHoI5MOqP2NXG1iWQCH2fEv8e9Ssxoo=;
        b=Y2cRhL/a16ICKWN5B/yy8HxiLCu7GrH7wdb+VhwApcAJkIVGOhP9Qt9vj5/nZe9AbD
         G4N3lQAn9soiLLbJxW1XRM3USJmVQi8RRQnfXj2lC2UY50Xq8aS4H+huA6+bsz9g3SBj
         joQsePjAk1tTlZMWVdKvOiBnSqfLBC3kzlbU1oKWRkHZFfnU5Hco3H76B+EezkQ2nogi
         x8K7BpMPE6gcPsgngjFJGdj+xWcxTLeWPiGUBVMOZsRXShn+BOjoEJFGI2P3PqIrW9OB
         febgLm/U1g2oKUP5kpumg/95RYL6iJeKjsBwbLGzNM8QTdcMMzd/SaAd11LMwLezmfXl
         V3FA==
X-Gm-Message-State: ACgBeo0tAl8mAnnrVA2J5r8Ge0pajXNv3wPin5XpVfdCOY+lkgPNlIju
        IYThaIj7LH+IlTpPJilCtC7B9FINLig9kO+3wM+P
X-Google-Smtp-Source: AA6agR7feW5/dLGJw4vAhaYoiUlA13S/ZyDm4jHFn05WI9FtjAPitCZNc7BF6TEeUYC8sgScaZjEpWOJ3swzuHG2cYU=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr11313980oao.136.1661890250283; Tue, 30
 Aug 2022 13:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220708093451.472870-1-omosnace@redhat.com> <CAHC9VhSFUJ6J4_wt1SKAoLourNGVkxu0Tbd9NPDbYqjjrs-qoQ@mail.gmail.com>
 <CAHC9VhRtLEg-xR5q33bVNOBi=54uJuix2QCZuCiKX2Qm6CaLzw@mail.gmail.com> <20220826084354.a2jrrvni6mf7zzyw@wittgenstein>
In-Reply-To: <20220826084354.a2jrrvni6mf7zzyw@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 16:10:39 -0400
Message-ID: <CAHC9VhR=+vVzx1-sKO=UxZyNG6J4-8q+WfxTmHPqxBFbs2-mtw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <roc@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 4:44 AM Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Aug 19, 2022 at 02:50:57PM -0400, Paul Moore wrote:
> > On Tue, Aug 16, 2022 at 6:12 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Jul 8, 2022 at 5:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Since userfaultfd doesn't implement a write operation, it is more
> > > > appropriate to open it read-only.
> > > >
> > > > When userfaultfds are opened read-write like it is now, and such fd is
> > > > passed from one process to another, SELinux will check both read and
> > > > write permissions for the target process, even though it can't actually
> > > > do any write operation on the fd later.
> > > >
> > > > Inspired by the following bug report, which has hit the SELinux scenario
> > > > described above:
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=1974559
> > > >
> > > > Reported-by: Robert O'Callahan <roc@ocallahan.org>
> > > > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >
> > > > Resending as the last submission was ignored for over a year...
> > > >
> > > > https://lore.kernel.org/lkml/20210624152515.1844133-1-omosnace@redhat.com/T/
> > > >
> > > > I marked this as RFC, because I'm not sure if this has any unwanted side
> > > > effects. I only ran this patch through selinux-testsuite, which has a
> > > > simple userfaultfd subtest, and a reproducer from the Bugzilla report.
> > > >
> > > > Please tell me whether this makes sense and/or if it passes any
> > > > userfaultfd tests you guys might have.
> > > >
> > > >  fs/userfaultfd.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > VFS folks, any objection to this patch?  It seems reasonable to me and
> > > I'd really prefer this to go in via the vfs tree, but I'm not above
> > > merging this via the lsm/next tree to get someone in vfs land to pay
> > > attention to this ...
> >
> > Okay, final warning, if I don't see any objections to this when I make
> > my patch sweep next week I'm going to go ahead and merge this via the
> > LSM tree.
>
> Makes sense,
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Merged into lsm/next, thanks all.

-- 
paul-moore.com
