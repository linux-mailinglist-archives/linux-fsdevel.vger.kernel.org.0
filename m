Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF322EB836
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 03:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAFCoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 21:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbhAFCoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 21:44:17 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381B0C06134B
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jan 2021 18:43:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ga15so3224299ejb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jan 2021 18:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rl30GHiO7+ok45uxZXaNkdS1h9GOZB8/wNoJsPJg7EY=;
        b=r3Wpg2DR14agmLIdTiA23ZamhLdjd5Hm7Yrz7aomhIgcxuBcp/fDg++5xrguOlESBz
         n2O7qtM4JWyW1jfJKnotNRpb7gQ1dFSi+sT8LKIgj//ooGAkIOe9NfFIfluFrnW7g+ZZ
         Ez5ejKOt7uptWA4vV4/asbGgisa0Sjv7zlGMd+xUTxJeIc/9gWBjLKuupEPDg7iUyC1a
         xhUyNX38fpxgcLcOd/XsfrF7ERPBwD97GpFrBiVcE+a91hetKV3oUfAxl0armtD0xI39
         ji1CcYPOVCbt3ygNwrOMhU8BekaxTCfYyijIfRkTC4z7ZjipSBnn+/QOrMLq037LCmKU
         R1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rl30GHiO7+ok45uxZXaNkdS1h9GOZB8/wNoJsPJg7EY=;
        b=Kdzg6hxo8mQVira8fNT9gUCM32eOCjLvF5tgZUDWpqw9rQRfMmHfoRnaFi8R+BA0YA
         FUuGO4ojc5JcnyMknrKVF38BLbdYIPPh5fO+yUyZxvzuVTk4smk0DIgdAe8cKaL40NYg
         9QQbG3UphrW65w+kc+HAC7EfhIXzSOC0NECZ9NO4VS5/sIwyeOYm1TX7c1LLYB/cVnxp
         xP0eZ9A2lHw6x4pcgmaUOJvxPqu0E33Sj0nXg8ciPk19/SwMK5sPYl5Dix4GqSXHuw2K
         /W07qxrtOJK5wTcHuQPjRy3GbY5YX/9AwgIWO0Ilz1zXsswTZbmKEuf9zdOfspT8cbp+
         4FCw==
X-Gm-Message-State: AOAM530dHEkVd+vwDQqHjtuLw/duc5ekiZavf7VEErr0gqo2TFj4G1QN
        8AtckqJJtBVloreR2wmw6nHQJ7BMGofMxzA1emDq
X-Google-Smtp-Source: ABdhPJxBGghK0hX4bygHQKZbY85SZEF5lnAAJg7KT5u9deBBsKhmsljHRmL87cbGrw8/2aPatl5OyzOxF6pU1QwhjSM=
X-Received: by 2002:a17:906:2e82:: with SMTP id o2mr1559118eji.106.1609901004776;
 Tue, 05 Jan 2021 18:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk> <20210105165005.GV3579531@ZenIV.linux.org.uk>
 <20210105195937.GX3579531@ZenIV.linux.org.uk> <87a6tnge5k.fsf@stepbren-lnx.us.oracle.com>
 <CAHC9VhQnQW8RvTzyb4MTAvGZ7b=AHJXS8PzD=egTcpdDz73Yzg@mail.gmail.com> <20210106003803.GA3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210106003803.GA3579531@ZenIV.linux.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Jan 2021 21:43:13 -0500
Message-ID: <CAHC9VhQyZOewT5nQ5fqqx-tvSx1kt62i26ruF_Unk5K_iFQTKA@mail.gmail.com>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 5, 2021 at 7:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Jan 05, 2021 at 07:00:59PM -0500, Paul Moore wrote:

...

> > I would expect the problem here to be the currently allocated audit
> > buffer isn't large enough to hold the full audit record, in which case
> > it will attempt to expand the buffer by a call to pskb_expand_head() -
> > don't ask why audit buffers are skbs, it's awful - using a gfp flag
> > that was established when the buffer was first created.  In this
> > particular case it is GFP_ATOMIC|__GFP_NOWARN, which I believe should
> > be safe in that it will not sleep on an allocation miss.
> >
> > I need to go deal with dinner, so I can't trace the entire path at the
> > moment, but I believe the potential audit buffer allocation is the
> > main issue.
>
> Nope.  dput() in dump_common_audit_data(), OTOH, is certainly not
> safe.

My mistake.  My initial reaction is to always assume audit is the
problem; I should have traced everything through before commenting.

> OTTH, it's not really needed there - see vfs.git #work.audit
> for (untested) turning that sucker non-blocking.  I hadn't tried
> a followup that would get rid of the entire AVC_NONBLOCKING thing yet,
> but I suspect that it should simplify the things in there nicely...

It would be nice to be able to get rid of the limitation on when we
can update the AVC and do proper auditing.  I doubt the impact is
anything that anyone notices, but I agree that it should make things
much cleaner.  Thanks Al.

-- 
paul moore
www.paul-moore.com
