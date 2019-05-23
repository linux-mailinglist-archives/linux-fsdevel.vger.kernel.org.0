Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2827279C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 11:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfEWJzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 05:55:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44384 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfEWJzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 05:55:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so8338019edm.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XcnGRhVVyNL37UuM2RMXdYZmMPDHmNAhLUCRA5xcUDo=;
        b=O0wuggV6ZTRRY9IuFVi+Hy5ZffEWKgbDaxa4tUMjnr9ukzoVJ+6ESsFv482ScAF+lN
         mZJQMUGVUc4J6DhDCUH25aotoYsf10ISXjQ03OgcydZlHj6YMDwmwdTgHrQqfRbY0b2e
         +MkrirnkhnUODJSGZeiiTghbv1k678cPmDD5fU0dyiykv7ixjjepA8wUU/TvIq5ADMeM
         kIanjFRf+sWTGKkUkejAd32KCh2rj29VqwW4ask3xJXreRH1UwkrmEqpFdxwP5lfiJyz
         B7vkZAjE7n6GGVkd8y1t6z+9fq6lyZO7i9b0KYvFE/HJTlsRZElQrWIEP1p047EJSUyE
         oRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XcnGRhVVyNL37UuM2RMXdYZmMPDHmNAhLUCRA5xcUDo=;
        b=M23EOEnvrIyq9gamgdSFf7E9OiLXLy4CHftxnWvKzdA26p/ieYFyWQKMMIzKPFOFcC
         wPF1EZHHxVVOQ96cE/m71PsKxFR63/lzzRnNDbz5ok6JhzQBMbSungNl9bJFRG7IxFCy
         DAYsdbT6nsc5cxXzu4HXQCIydjhI1iSPUKhuxjoYJggauNI45G/XCyFygyAJcriTDHJq
         8aKxXN/GJt1TCm1i+NIo12ggLDFqaXXhLPFwQbEY0FBAQsLRIpWbQSHqr9+Tu93piXCY
         avmqNe6AYFho5b3m+HyBu3HE8VhCSWp2sCqBCy2gpkSw2DQ3/bGbbMIHO+zercIhZMWN
         I9cA==
X-Gm-Message-State: APjAAAWfY7behS0JRgza7kedAmytcnCjojQnZQeruHCgFZKVul4+EEMz
        +eeZLuHhs620r3Rse++iGJ9OI5Z3O0uv/Q==
X-Google-Smtp-Source: APXvYqybccPv5N0s4ahkfYQemfrz5kSo1mA+KsJL9r2ibL+W2QszQceCSAyrL2eQwh8lWs+J+tYolQ==
X-Received: by 2002:a50:ad77:: with SMTP id z52mr95891367edc.174.1558605309242;
        Thu, 23 May 2019 02:55:09 -0700 (PDT)
Received: from brauner.io (178-197-142-46.pool.kielnet.net. [46.142.197.178])
        by smtp.gmail.com with ESMTPSA id o47sm7838488edc.37.2019.05.23.02.55.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 02:55:08 -0700 (PDT)
Date:   Thu, 23 May 2019 11:55:07 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
Message-ID: <20190523095506.nyei5nogvv63lm4a@brauner.io>
References: <20190522163150.16849-1-christian@brauner.io>
 <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
 <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 11:00:22PM +0300, Amir Goldstein wrote:
> On Wed, May 22, 2019 at 9:57 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On May 22, 2019 8:29:37 PM GMT+02:00, Amir Goldstein <amir73il@gmail.com> wrote:
> > >On Wed, May 22, 2019 at 7:32 PM Christian Brauner
> > ><christian@brauner.io> wrote:
> > >>
> > >> This removes two redundant capable(CAP_SYS_ADMIN) checks from
> > >> fanotify_init().
> > >> fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN)
> > >at the
> > >> beginning. So the other two capable(CAP_SYS_ADMIN) checks are not
> > >needed.
> > >
> > >It's intentional:
> > >
> > >commit e7099d8a5a34d2876908a9fab4952dabdcfc5909
> > >Author: Eric Paris <eparis@redhat.com>
> > >Date:   Thu Oct 28 17:21:57 2010 -0400
> > >
> > >    fanotify: limit the number of marks in a single fanotify group
> > >
> > >There is currently no limit on the number of marks a given fanotify
> > >group
> > >can have.  Since fanotify is gated on CAP_SYS_ADMIN this was not seen
> > >as
> > >a serious DoS threat.  This patch implements a default of 8192, the
> > >same as
> > >inotify to work towards removing the CAP_SYS_ADMIN gating and
> > >eliminating
> > >    the default DoS'able status.
> > >
> > >    Signed-off-by: Eric Paris <eparis@redhat.com>
> > >
> > >There idea is to eventually remove the gated CAP_SYS_ADMIN.
> > >There is no reason that fanotify could not be used by unprivileged
> > >users
> > >to setup inotify style watch on an inode or directories children, see:
> > >https://patchwork.kernel.org/patch/10668299/
> > >
> > >>
> > >> Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue
> > >depth")
> > >> Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max
> > >marks")
> > >
> > >Fixes is used to tag bug fixes for stable.
> > >There is no bug.
> > >
> > >Thanks,
> > >Amir.
> >
> > Interesting. When do you think the gate can be removed?
> 
> Nobody is working on this AFAIK.
> What I posted was a simple POC, but I have no use case for this.
> In the patchwork link above, Jan has listed the prerequisites for
> removing the gate.
> 
> One of the prerequisites is FAN_REPORT_FID, which is now merged.
> When events gets reported with fid instead of fd, unprivileged user
> (hopefully) cannot use fid for privilege escalation.
> 
> > I was looking into switching from inotify to fanotify but since it's not usable from
> > non-initial userns it's a no-no
> > since we support nested workloads.
> 
> One of Jan's questions was what is the benefit of using inotify-compatible
> fanotify vs. using inotify.
> So what was the reason you were looking into switching from inotify to fanotify?
> Is it because of mount/filesystem watch? Because making those available for

Yeah. Well, I would need to look but you could probably do it safely for
filesystems mountable in user namespaces (which are few).
Can you do a bind-mount and then place a watch on the bind-mount or is
this superblock based?

Thanks!
Christian
