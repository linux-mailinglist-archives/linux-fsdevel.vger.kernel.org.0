Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAA060E03
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 00:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfGEW4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 18:56:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41772 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfGEW4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 18:56:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so4854670pff.8;
        Fri, 05 Jul 2019 15:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=06JUTzixYUXWQY0p1Jz65kPaFqNhgzPg1UvDWl35Q3s=;
        b=aWRLXF+yp34AJWOgwsVUMtNAxkxdtX1M3GTiqOqyjhiTOxWYPUpsx2qExKnaE9h9DZ
         rn6cNcP6Z6Ny0WhHNZuMyXkHwgp3L0K9l1OV2xk4pNEApeY8byUdbMWuf4JqmsZaX1YW
         k4gdyRbYGf8WIFPBU8x4SiBUKmrpCOoGj+h5KCMOo8mgWdVR61U7gC/WRSVMEZOAs17K
         xXTxQZgYyr0nR7geQyYggl9Rj5vr7wH//uy7tzZNl9fmOgypGmV9jmqvzJjd0fG43a7i
         HIjAAg9vDkYnI4etZ2yRJi9crSYLxSCTiNkO94wTLN0GDIhtiMNOSPa1v60/A54wLmSM
         E5Tw==
X-Gm-Message-State: APjAAAUSFAZgYbfoW1zzUfw0dhN1jHdEIX3h/CgIReb2C93IhNH6yZUc
        rk/U6I8/mS6Q5TYD2S+gCb8=
X-Google-Smtp-Source: APXvYqzz7n3ucjroxXkpghyaWOYj8PQVSs0g4K17SzC3IQOel3z7xFa8GZBW5LLyK43Jd+D51NdiUA==
X-Received: by 2002:a65:534b:: with SMTP id w11mr8073665pgr.210.1562367372992;
        Fri, 05 Jul 2019 15:56:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r196sm9030930pgr.84.2019.07.05.15.56.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 15:56:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0CE5E40190; Fri,  5 Jul 2019 22:56:11 +0000 (UTC)
Date:   Fri, 5 Jul 2019 22:56:10 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Radoslaw Burny <rburny@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Sperbeck <jsperbeck@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] fs: Fix the default values of i_uid/i_gid on
 /proc/sys inodes.
Message-ID: <20190705225610.GF19023@42.do-not-panic.com>
References: <20190705163021.142924-1-rburny@google.com>
 <20190705200218.GZ19023@42.do-not-panic.com>
 <CAFkxGoMu7Efy+nzkW=HFrbpUdWNCt5x2jGGDRSHHwyd=hhXzrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkxGoMu7Efy+nzkW=HFrbpUdWNCt5x2jGGDRSHHwyd=hhXzrA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please Cc Andrew Morton <akpm@linux-foundation.org> on future follow
ups.

On Sat, Jul 06, 2019 at 12:19:16AM +0200, Radoslaw Burny wrote:
> On Fri, Jul 5, 2019 at 10:02 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> >
> > Please re-state the main fix in the commit log, not just the subject.
> 
> Sure, I'll do this. Just to make sure - for every iteration on the
> commit message, I need to increment the patch "version" and resend the
> whole patch, right?

Right.

> >
> > Also, this does not explain why the current values are and the impact to
> > systems / users. This would help in determine and evaluating if this
> > deserves to be a stable fix.
> 
> This commit a (much overdue) resend of https://lkml.org/lkml/2018/11/30/990
> I think Eric's comment on the previous thread explained it best:

Ah, I knew this smelled familiar. Yes I recall. Please add more
information about all this to the commit log. The more info, the better
including refence to the old discussion and also a distilled summary of
what was discussed.

Preference if you can avoid using lkml.org and instead use this URL
instead, as lkml.org is not under out control and can die, etc.

https://lore.kernel.org/lkml/20181126172607.125782-1-rburny@google.com/

> > We spoke about this at LPC.  And this is the correct behavioral change.

Again, none of this is clear to the patch reviewer and again you didn't
mention any of it.

> >
> > The problem is there is a default value for i_uid and i_gid that is
> > correct in the general case.  That default value is not corect for
> > sysctl, because proc is weird.  As the sysctl permission check in
> > test_perm are all against GLOBAL_ROOT_UID and GLOBAL_ROOT_GID we did not
> > notice that i_uid and i_gid were being set wrong.
> >
> > So all this patch does is fix the default values i_uid and i_gid.
> 
> If my new commit message is still not conveying this clearly, feel
> free to suggest the specific wording (I'm new to the kernel patch
> process, and I might not be explaining the problems well enough).

Please consense the above into the commit log message. What you want
to be made clear is implication issues if this patch is not applied, who
is affected and why.

> > On Fri, Jul 05, 2019 at 06:30:21PM +0200, Radoslaw Burny wrote:
> > > This also fixes a problem where, in a user namespace without root user
> > > mapping, it is not possible to write to /proc/sys/kernel/shmmax.
> >
> > This does not explain why that should be possible and what impact this
> > limitation has.
> 
> Writing to /proc/sys/kernel/shmmax allows setting a shared memory
> limit for that container. Since this is usually a part of container's
> initial configuration, one would expect that the container's owner /
> creator is able to set the limit. Yet, due to the bug described here,
> no process can write the container's shmmax if the container's user
> namespace does not contain root mapping.

Please include this on the commit log. It does seem then worthy as a
stable commit. Please add the Cc: stable tag, ie put this:

Cc: stable@vger.kernel.org # v4.8+

Right above the Signed-off-by tags.

Then the scripts which pick up stable patches will pick this up.

> Using a container with no root mapping seems to be a rare case, but we
> do use this configuration at Google, which is how I found the issue.
> Also, we use a generic tool to configure the container limits, and the
> inability to write any of them causes a hard failure.

This helps folks also, so please include this in the commit log.

> > > The problem was introduced by the combination of the two commits:
> > > * 81754357770ebd900801231e7bc8d151ddc00498: fs: Update
> > >   i_[ug]id_(read|write) to translate relative to s_user_ns
> > >     - this caused the kernel to write INVALID_[UG]ID to i_uid/i_gid
> > >     members of /proc/sys inodes if a containing userns does not have
> > >     entries for root in the uid/gid_map.
> > This is 2014 commit merged as of v4.8.
> >
> > > * 0bd23d09b874e53bd1a2fe2296030aa2720d7b08: vfs: Don't modify inodes
> > >   with a uid or gid unknown to the vfs
> > >     - changed the kernel to prevent opens for write if the i_uid/i_gid
> > >     field in the inode is invalid
> >
> > This is a 2016 commit merged as of v4.8 as well...
> >
> > So regardless of the dates of the commits, are you saying this is a
> > regression you can confirm did not exist prior to v4.8? Did you test
> > v4.7 to confirm?
> 
> I assume no one has noticed this issue before because it requires such
> a specific combination of triggers.
> Yes, I've tested this with older kernel versions. I've additionally
> tested a 4.8 build with just 0aa2720d7b08 reverted, confirming that
> the revert fixes the issue.

Ummm 0aa2720d7b08 is the last part of the gitsum, you want to reference
the first part of the gitsum as otherwise git show 0aa2720d7b08 yields
nothing, but git show 0bd23d09b874e does.

OK so then the *real* issue was commit 0bd23d09b874e, so Just add this
tag:

Fixes: 0aa2720d7b08 ("vfs: Don't modify inodes with a uid or gid unknown to the vfs")

So does commit 81754357770ebd really have any problem? If not I see no
reason to mention it?

> > > This commit fixes the issue by defaulting i_uid/i_gid to
> > > GLOBAL_ROOT_UID/GID.
> >
> > Why is this right?
> 
> Quoting Eric: "the sysctl permission check in test_perm are all
> against GLOBAL_ROOT_UID and GLOBAL_ROOT_GID".
> The values in the inode are not even read during test_perm, but
> logically, the inode belongs to the root of the namespace.

Please add that to the commit log.

> >
> > > Note that these values are not used for /proc/sys
> > > access checks, so the change does not otherwise affect /proc semantics.
> > >
> > > Tested: Used a repro program that creates a user namespace without any
> > > mapping and stat'ed /proc/$PID/root/proc/sys/kernel/shmmax from outside.
> > > Before the change, it shows the overflow uid, with the change it's 0.
> >
> > Why is the overflow uid bad for user experience? Did you test prior to
> > v4.8, ie on v4.7 to confirm this is indeed a regression?
> >
> > You'd want then to also ammend in the commit log a Fixes:  tag with both
> > commits listed. If this is a stable fix (criteria yet to be determined),
> > then we'd need a stable tag.
> 
> The overflow is technically correct; the uid in the inode is invalid,
> hence it must be displayed as overflow uid. The fact that the uid is
> invalid is the issue.
> Logically, this commit fixes 81754357770e (as that commit first
> introduced invalid uid/gid values). If you agree, I'll add this to my
> updated commit.

Yes add alll that to the commit log and thanks for following up!
Once you post a follow up, I'll review and poke Andrew to merge.

  Luis
