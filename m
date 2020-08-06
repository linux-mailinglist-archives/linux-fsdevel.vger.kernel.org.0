Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0823D7CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgHFIHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 04:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgHFIF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:05:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73339C061574;
        Thu,  6 Aug 2020 01:05:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c10so4378331pjn.1;
        Thu, 06 Aug 2020 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gvp/wmpdcbsDD44F7FznYVLBzaBcr2CE7TDbqpCKwbU=;
        b=LVS4O7bvmc+JPqtBelCbg8GGxi6WGmozkQmlelPXT13ddLBLKLCC+o8/XdLfU/04Mx
         41mYpUktmB+EEYY/iIMTOmXAFjhugSv4Bc+MwjRmOyG2gsvGXTUl4WEmcfjzZjyCdpf8
         V1Zy75NR0ITGyBTcCHW6HHgCDjWJ7llfmREAM2DczFwzm0zUrazm8YqjSkex4Kov43NR
         GzM2NhjSMzHWMwLHGOoP3FvghbXdmKDOtBgGIo9CKrg+1wacsC95YvEsGXmhMQMK+dTL
         5qcJmCXW6HOVwxCAQrN7TDftejgpNZchWiEKplPzgtNF1oT7P95aOmfmZbY7kN4xp9hv
         Naqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gvp/wmpdcbsDD44F7FznYVLBzaBcr2CE7TDbqpCKwbU=;
        b=Lc/HNk613VCVXPMmK7+VRl/yztWxFfmfg/6M36s/mtESFw6j9qzCgXAmQ/ia4IDPBk
         yVGVGWBq3WGn0PBYgaecFnpSX+V69RxRgnCIW+PkqRwz/jmx+yO4/O5tqVMHnCg78li8
         eQji5QvG2VNceTwVXwc5GTMAL6Fn/LUQN8kvhCBYlRunEPCm6NlbOF5SmsdZwjBkkSVs
         uH1hVw1ARudzYgOVCh9D6JazvhpZ0QEtaXW44BoiCSIvgvowCfD4td2eed0wqH+Xa+BO
         T3R9sTXNaUIm5u8x2oFEnzz5wlQy096SQJlKMEoYNwYHPQyROOPMfltIkgmHydy/uner
         ckPA==
X-Gm-Message-State: AOAM5339DLzReZTBT+Jgem8UrHoE6X8G9ODgAQWMKasyIbs0vbiIlNTu
        TMiaUDaKH6DSh5wyMMfZJCU=
X-Google-Smtp-Source: ABdhPJz7G7hkX91BoQ5RlVkjBTZKCspgkfr419sacZ/yxk05eABOpYQDgpGIC6gHk6dvBfA5N67Lvg==
X-Received: by 2002:a17:902:be17:: with SMTP id r23mr6624739pls.284.1596701143493;
        Thu, 06 Aug 2020 01:05:43 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id d22sm6939369pfd.42.2020.08.06.01.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 01:05:42 -0700 (PDT)
Date:   Thu, 6 Aug 2020 01:05:40 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
Message-ID: <20200806080540.GA18865@gmail.com>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
 <875za43b3w.fsf@x220.int.ebiederm.org>
 <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 01:03:17PM +0300, Kirill Tkhai wrote:
> On 31.07.2020 01:13, Eric W. Biederman wrote:
> > Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> > 
> >> On 30.07.2020 17:34, Eric W. Biederman wrote:
> >>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> >>>
> >>>> Currently, there is no a way to list or iterate all or subset of namespaces
> >>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
> >>>> but some also may be as open files, which are not attached to a process.
> >>>> When a namespace open fd is sent over unix socket and then closed, it is
> >>>> impossible to know whether the namespace exists or not.
> >>>>
> >>>> Also, even if namespace is exposed as attached to a process or as open file,
> >>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
> >>>> this multiplies at tasks and fds number.
> >>>
> >>> I am very dubious about this.
> >>>
> >>> I have been avoiding exactly this kind of interface because it can
> >>> create rather fundamental problems with checkpoint restart.
> >>
> >> restart/restore :)
> >>
> >>> You do have some filtering and the filtering is not based on current.
> >>> Which is good.
> >>>
> >>> A view that is relative to a user namespace might be ok.    It almost
> >>> certainly does better as it's own little filesystem than as an extension
> >>> to proc though.
> >>>
> >>> The big thing we want to ensure is that if you migrate you can restore
> >>> everything.  I don't see how you will be able to restore these files
> >>> after migration.  Anything like this without having a complete
> >>> checkpoint/restore story is a non-starter.
> >>
> >> There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.
> >>
> >> CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
> >> As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
> >> problem here.
> > 
> > An obvious diffference is that you are adding the inode to the inode to
> > the file name.  Which means that now you really do have to preserve the
> > inode numbers during process migration.
> >
> > Which means now we have to do all of the work to make inode number
> > restoration possible.  Which means now we need to have multiple
> > instances of nsfs so that we can restore inode numbers.
> > 
> > I think this is still possible but we have been delaying figuring out
> > how to restore inode numbers long enough that may be actual technical
> > problems making it happen.
> 
> Yeah, this matters. But it looks like here is not a dead end. We just need
> change the names the namespaces are exported to particular fs and to support
> rename().
> 
> Before introduction a principally new filesystem type for this, can't
> this be solved in current /proc?

do you mean to introduce names for namespaces which users will be able
to change? By default, this can be uuid.

And I have a suggestion about the structure of /proc/namespaces/.

Each namespace is owned by one of user namespaces. Maybe it makes sense
to group namespaces by their user-namespaces?

/proc/namespaces/
                 user
                 mnt-X
                 mnt-Y
                 pid-X
                 uts-Z
                 user-X/
                        user
                        mnt-A
                        mnt-B
                        user-C
                        user-C/
                               user
                 user-Y/
                        user

Do we try to invent cgroupfs for namespaces?

Thanks,
Andrei
