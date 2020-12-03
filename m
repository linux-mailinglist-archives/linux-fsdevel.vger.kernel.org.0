Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A42CCF0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 07:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgLCGTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 01:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgLCGTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:19:15 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528DC061A4D;
        Wed,  2 Dec 2020 22:18:35 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id y9so914280ilb.0;
        Wed, 02 Dec 2020 22:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWc60qRkgAP4/AhDOQSUVOyIFCAFSIZPZYbAmsVDLvA=;
        b=EqpQt8WKlMC8JpSDIKOhSMtpE8OLP1oVgZoGnQCqrKr5aya3IfoFAIVVV7pxqHhBNC
         vH8CZ69gqkbB/jsZcwclPIJpseIVlVfnBw5ef+COmtquSWN8IH+fFdTneGPeyDN7I11F
         llHyti6dL8jqm+rZxrPMEhbLNGHgL2eNFOEHSD+qzFKO6bkF337ruSgWlIvBxljO78zQ
         pbxUr0pR5FGT4C2OSJSx5NgMgSG5uyL2d0rCI1oXuHac1xlbrFAr9oSmyUCxfi0cW5Al
         UYo62/Kvvdj1QNdaBCbNxOcjje6IVKc/7GoacsW9wP018ySMJhSQkl2LZR8gdUhZ/i0k
         1C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWc60qRkgAP4/AhDOQSUVOyIFCAFSIZPZYbAmsVDLvA=;
        b=Cx9Z67zY+YSWqiergWd5Oy9+XOzN+Hh5PqG0P8SjpfRbDp+cS7rzGHKZzZNwqoZlhA
         9fp4W9mvPN9qzoHMGTRypjiZR0jhXzTtRucbRcD4ZL+1I3hYKotpfYN5lKXwQN1/2rpp
         bLqERdAyW7UgkaY/FqleBVrleeJqsjkvr375XQ2+W0X8taEhsJ6+r47/TqiTvwFR8SEa
         8N6SRim5bgN93k3MyXpIRNbaZfoEYy1ottOMvnFOBu6wo5xDncaURvkbh70hLMXbySSt
         clnBtoI//9+6qCgiuAvrmitWGX+UBWWtDCqRj95FlUsqQh6R4Iges9EJ64ukROKN2iL0
         5ahg==
X-Gm-Message-State: AOAM5302uJOUbPdLCtM2MhWrsl83D71naepYL4ne6BvUO7fEdCqfLvc/
        DkWoZl49734oMWzvlgWEt2Cr6q6pxyXstKhRMKI=
X-Google-Smtp-Source: ABdhPJz36LCXTX0/SCIOBeXZg650dbCCwPENwVekcYOEKfG4AR3MNh3N57CJyu1yS3dMiCG4Jr+vOaeTZ+tl7lnJmvM=
X-Received: by 2002:a92:da82:: with SMTP id u2mr1725751iln.137.1606976314613;
 Wed, 02 Dec 2020 22:18:34 -0800 (PST)
MIME-Version: 1.0
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
 <20201202160049.GD1447340@iweiny-DESK2.sc.intel.com> <CAJfpegt6w4h28VLctpaH46r2pkbcUNJ4pUhwUqZ-zbrOrXPEEQ@mail.gmail.com>
 <641397.1606926232@warthog.procyon.org.uk> <CAJfpegsQxi+_ttNshHu5MP+uLn3px9+nZRoTLTxh9-xwU8s1yg@mail.gmail.com>
 <X8flmVAwl0158872@kroah.com> <20201202204045.GM2842436@dread.disaster.area> <X8gBUc0fkdh6KK01@kroah.com>
In-Reply-To: <X8gBUc0fkdh6KK01@kroah.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Dec 2020 08:18:23 +0200
Message-ID: <CAOQ4uxhNvTxEo_-wkHy-KO8Jhz0Amh-g2Nz+PzN_8OODWJPz7w@mail.gmail.com>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>,
        Sasha Levin <sashal@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > It seems like this can all be avoided simply by scheduling the
> > automated fixes scans once the upstream kernel is released, not
> > while it is still being stabilised by -rc releases. That way stable
> > kernels get better tested fixes, they still get the same quantity of
> > fixes, and upstream developers have some margin to detect and
> > correct regressions in fixes before they get propagated to users.
>
> So the "magic" -final release from Linus would cause this to happen?
> That means that the world would go for 3 months without some known fixes
> being applied to the tree?  That's not acceptable to me, as I started
> doing this because it was needed to be done, not just because I wanted
> to do more work...
>

Nobody was trying to undermine the need for expediting important fixes
into stable kernels. Quite the contrary.

> > It also creates a clear demarcation between fixes and cc: stable for
> > maintainers and developers: only patches with a cc: stable will be
> > backported immediately to stable. Developers know what patches need
> > urgent backports and, unlike developers, the automated fixes scan
> > does not have the subject matter expertise or background to make
> > that judgement....
>
> Some subsystems do not have such clear demarcation at all.  Heck, some
> subsystems don't even add a cc: stable to known major fixes.  And that's
> ok, the goal of the stable kernel work is to NOT impose additional work
> on developers or maintainers if they don't want to do that work.
>

Greg,

Please acknowledge that there is something to improve.
Saying that some subsystems maintainers don't care is not a great
argument for subsystem maintainers that do care and try to improve the process.

I am speaking here both as a maintainer of a downstream stable kernel,
who cares specifically about xfs fixes and as an upstream developer who
"contributes" patches to stable kernels. And I am not a passive contributor
to stable kernels. I try to take good care of overlayfs and fsnotify patches
being properly routed to stable kernels, as well as prepping the patches
for backport-ability during review and occasional backporting.
I also try to help with auditing the AUTOSEL patch selection of xfs.

The process can improve. This is an indisputable fact, because as contributors
we want to improve the quality of the stable kernels but missing the
tools to do so.

As a downstream user of stable kernels I learned to wait out a few .y releases
after xfs fixes have flowed in. This is possible because xfs stable
fixes are not
flowing that often.
Do you see what happened? You did not make the problem go away, but pushed
it down to your downstream users.
I would not have complained unless I thought that we could do better.

Here is a recent example, where during patch review, I requested NOT to include
any stable backport triggers [1]:
"...We should consider sending this to stable, but maybe let's merge
first and let it
 run in master for a while before because it is not a clear and
immediate danger..."

This is just one patch and I put a mental trigger to myself to stop it
during stable
patch review if it gets selected, but you can see how this solution
does not scale.

As a developer and as a reviewer, I wish (as Dave implied) that I had a way to
communicate to AUTOSEL that auto backport of this patch has more risk than
the risk of not backporting. I could also use a way to communicate
that this patch
(although may fix a bug) should be "treated as a feature", meaning that it needs
a full release cycle to stabilize should not see the light of day
before the upstream
.0 release. Some fixes are just like that.

The question is how to annotate these changes.
Thinking out loud:
    Cc: stable@vger.kernel.org#v5.9<<v5.10
    Cc: stable@vger.kernel.org#v5.9<<v5.10-rc5

For patches that need to soak a few cycles in master or need to linger in
master until the .0 release.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/CAOQ4uxiUTsXEdQsE275qxTh61tZOB+-wqCp6gaNLkOw5ueUJgw@mail.gmail.com/
