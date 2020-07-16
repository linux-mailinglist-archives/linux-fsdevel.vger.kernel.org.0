Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4313A2227E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgGPP5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 11:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgGPP5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:57:30 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B403C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 08:57:30 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r12so5485766ilh.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rhXE8to2+Mye2riYz2x1JxlLqxOWYOjgM0fM7NJ42c=;
        b=t95d+34YlD1y8PW18chxzaqiviKIIHkkumf4UQzXn2i9tYrGpxSFE5+mxJVWyUHJ5n
         tztvyOYN2XwKcC9Xuk1lSYsOo6SyZah3+Q0Qw3llH7nH+yd4c8LZHNlfZbACuqgLgPnC
         EB+b8/bF8YE+O+7dmpPeGpV11+XPMVpWj8QpDy3AVZ2HWxXu9U8BWGGceojhhuGUcngx
         vor2pbaHGAkxusXQlgOPVreUe4Me3w9aSVCyoWw8H9h7Y89VoykZfzZlaft0OerdTxt6
         7rIv4PNnwvrIAP6kd9leT7rICzKfEwXv37bH3FOsrgjTFNWpvbogl/D/t6bEm6BJ/xAq
         Kg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rhXE8to2+Mye2riYz2x1JxlLqxOWYOjgM0fM7NJ42c=;
        b=YNq4ftpR3JN2WBuSbgybHxCemHo2K94pfHd5BW1SEBDTZSB16k5JWIRgK2nej6TXb2
         qSNPHgv3hBVoisJq25DpvrkfZcQ3k+2rCIyTHkYZYQlJcgBNWO4DuIXkf84kO6uT0iIm
         8hQWFAOykFPwznHdMPRNpL/lkoOhB64pK/88G51+MExyipM/1L1ai8uGAM1t6JJs1Etg
         PCiMGhkLcySrqfKYl2+KAizOQFQyMeNsqlmO25643QGQaneG4k+CHCnx8TN754fdks2g
         OFardm93NF4mgcToCAW8jI6gW/BauiuG0TPG/Qh5T/DCRI3UCflLftiT2DmtkYivwmgg
         02ew==
X-Gm-Message-State: AOAM530Y4o3d2iz55GclB3kneMkL5sl8y6xmlYnlF8ZkPQ6BMEcdTC6V
        1QyKiQWFqSCfY6nsLpyeUw97m0WB5c2cM6+pjGal7A0Q
X-Google-Smtp-Source: ABdhPJzgNwoFRlCEdTpfwFOP9TDPyEWToxEwuIEciZ4dRZt8F7lAjBmxvUF2uNnULywDRxE1I04f4nWEa3+DlQGvo9Q=
X-Received: by 2002:a92:490d:: with SMTP id w13mr5246385ila.250.1594915049765;
 Thu, 16 Jul 2020 08:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-18-amir73il@gmail.com>
 <20200716134556.GE5022@quack2.suse.cz> <CAOQ4uxiYAviCUAzp0oz8dEmDzJvCW1z_Cyh0FiCONH7kY72rFQ@mail.gmail.com>
 <CAOQ4uxjViX_UhSY7KZBf04yqJK8qORP8EisXBvUpnvfoRWmRLg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjViX_UhSY7KZBf04yqJK8qORP8EisXBvUpnvfoRWmRLg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 18:57:18 +0300
Message-ID: <CAOQ4uxjxHQc9BoWbb8waLKnYGnqPq4pdiYHamTZtJNCJmyZubg@mail.gmail.com>
Subject: Re: [PATCH v5 17/22] fsnotify: send MOVE_SELF event with parent/name info
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 5:10 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jul 16, 2020 at 4:59 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Jul 16, 2020 at 4:45 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 16-07-20 11:42:25, Amir Goldstein wrote:
> > > > MOVE_SELF event does not get reported to a parent watching children
> > > > when a child is moved, but it can be reported to sb/mount mark or to
> > > > the moved inode itself with parent/name info if group is interested
> > > > in parent/name info.
> > > >
> > > > Use the fsnotify_parent() helper to send a MOVE_SELF event and adjust
> > > > fsnotify() to handle the case of an event "on child" that should not
> > > > be sent to the watching parent's inode mark.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > What I find strange about this is that the MOVE_SELF event will be reported
> > > to the new parent under the new name (just due to the way how dentry
> > > handling in vfs_rename() works). That seems rather arbitrary and I'm not
> > > sure it would be useful? I guess anybody needing dir info with renames
> > > will rather use FS_MOVED_FROM / FS_MOVED_TO where it is well defined?
> > >
> > > So can we leave FS_MOVE_SELF as one of those cases that doesn't report
> > > parent + name info?
> > >
> >
> > I can live with that.
> > I didn't have a use case for it.
> > This patch may be dropped from the series without affecting the rest.
> >
>
> BTW, I checked my man page and it doesn't say anything about whether
> parent fid and child fid can be reported together with MOVE_SELF.
> The language is generic enough on that part.
>

FYI, I pushed a commit to the LTP branch that adapts the test to MOVE_SELF
that does not report name and tested with this patch reverted.

The test now has less special cases when setting expected values,
which is generally a good sign ;-)

Thanks,
Amir.
