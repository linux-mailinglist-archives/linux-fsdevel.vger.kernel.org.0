Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD4A240C13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 19:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHJReh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgHJRef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:34:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75459C061756;
        Mon, 10 Aug 2020 10:34:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so5328281plz.10;
        Mon, 10 Aug 2020 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mWNNGRPEImrQ+jMxGRJaBTOD+o6Djl9ph4Czfnp/DXk=;
        b=bo39z7QmTYhJ3Zo5VYxLP4trCXFs4Qm/xeLQ+e8/xQdVsL6uZiFvbrc/cszlNQ+i+G
         61spnEUypIJFfpd/zr6eBtfrbzti/ZdWmyaCEGog6LVyk6RMCyuiSFs+ZyVYjIjStFhF
         A84vu1nb/uAPUfZ0nyBLnAN+xgXw4XTxzTQzNW88HoyTWldy0HXjRkSGsCzbPd3UWa/L
         NSXR7MzOY2Cdf43Q2LP8fhz5V4xH7EEaSQUE1eGaH0D+XlsYx+nOwcAUIcj1AML1KlZ/
         CYfaP0y1JGnP5pwcipaZxc+VEozrDnEzUXNtV9xOeYqUtVh1ITCGqM96hkJIK9EN3r0J
         EgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mWNNGRPEImrQ+jMxGRJaBTOD+o6Djl9ph4Czfnp/DXk=;
        b=ACrm0o6ucWLSVw3cYPHWzon2O7V2dYPVcyLRAY7QVDPI40Wgl8t+ZAWiwfoPItG8Nu
         VumBLK61/uDtIb7AQ2UCTynPD4nghTHIGkFY0f1lW35cKzQl8ESJIRaNWCFGxysC6hMZ
         vtXupU2nuw39tbUpvJYGru0vaTTe1uC6WB/6eiqcTpMvL3+XqAnsiKw1rZWVnNHpuMum
         bO455wCKnzEAsYBoQQ0CooyrWAjHStV8pdqZ2NoHUMuRIJcHpRMcvvfSJHnw79MPZmaL
         Ti/RIcTSpIOI6IhbQbAnQZNbpSQtLxKg8fy+rT7JTden6+GcC5p3bbOKwubDVIaUnGHY
         XVCA==
X-Gm-Message-State: AOAM531yiiDdzsS/hF4V+kKAHTL/LcjVZnU89TUfAdk+do7cRMnVT02x
        xqCU543KRMELFwHBUt6i8YE=
X-Google-Smtp-Source: ABdhPJx4L1LtxcPBz64ifBDJDQfUAH3yoKHtPIwpPBZLZcWX2HUFZctYiH6R+cxsfkayNzbkZw/rKQ==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr409160pju.44.1597080873604;
        Mon, 10 Aug 2020 10:34:33 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id b26sm25367902pff.54.2020.08.10.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 10:34:32 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:34:31 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     adobriyan@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
Message-ID: <20200810173431.GA68662@gmail.com>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
 <875za43b3w.fsf@x220.int.ebiederm.org>
 <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
 <20200806080540.GA18865@gmail.com>
 <2d65ca28-bcfa-b217-e201-09163640ebc2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d65ca28-bcfa-b217-e201-09163640ebc2@virtuozzo.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 11:47:57AM +0300, Kirill Tkhai wrote:
> On 06.08.2020 11:05, Andrei Vagin wrote:
> > On Mon, Aug 03, 2020 at 01:03:17PM +0300, Kirill Tkhai wrote:
> >> On 31.07.2020 01:13, Eric W. Biederman wrote:
> >>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> >>>
> >>>> On 30.07.2020 17:34, Eric W. Biederman wrote:
> >>>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> >>>>>
> >>>>>> Currently, there is no a way to list or iterate all or subset of namespaces
> >>>>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
> >>>>>> but some also may be as open files, which are not attached to a process.
> >>>>>> When a namespace open fd is sent over unix socket and then closed, it is
> >>>>>> impossible to know whether the namespace exists or not.
> >>>>>>
> >>>>>> Also, even if namespace is exposed as attached to a process or as open file,
> >>>>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
> >>>>>> this multiplies at tasks and fds number.
> >>>>>
> >>>>> I am very dubious about this.
> >>>>>
> >>>>> I have been avoiding exactly this kind of interface because it can
> >>>>> create rather fundamental problems with checkpoint restart.
> >>>>
> >>>> restart/restore :)
> >>>>
> >>>>> You do have some filtering and the filtering is not based on current.
> >>>>> Which is good.
> >>>>>
> >>>>> A view that is relative to a user namespace might be ok.    It almost
> >>>>> certainly does better as it's own little filesystem than as an extension
> >>>>> to proc though.
> >>>>>
> >>>>> The big thing we want to ensure is that if you migrate you can restore
> >>>>> everything.  I don't see how you will be able to restore these files
> >>>>> after migration.  Anything like this without having a complete
> >>>>> checkpoint/restore story is a non-starter.
> >>>>
> >>>> There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.
> >>>>
> >>>> CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
> >>>> As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
> >>>> problem here.
> >>>
> >>> An obvious diffference is that you are adding the inode to the inode to
> >>> the file name.  Which means that now you really do have to preserve the
> >>> inode numbers during process migration.
> >>>
> >>> Which means now we have to do all of the work to make inode number
> >>> restoration possible.  Which means now we need to have multiple
> >>> instances of nsfs so that we can restore inode numbers.
> >>>
> >>> I think this is still possible but we have been delaying figuring out
> >>> how to restore inode numbers long enough that may be actual technical
> >>> problems making it happen.
> >>
> >> Yeah, this matters. But it looks like here is not a dead end. We just need
> >> change the names the namespaces are exported to particular fs and to support
> >> rename().
> >>
> >> Before introduction a principally new filesystem type for this, can't
> >> this be solved in current /proc?
> > 
> > do you mean to introduce names for namespaces which users will be able
> > to change? By default, this can be uuid.
> 
> Yes, I mean this.
> 
> Currently I won't give a final answer about UUID, but I planned to show some
> default names, which based on namespace type and inode num. Completely custom
> names for any /proc by default will waste too much memory.
> 
> So, I think the good way will be:
> 
> 1)Introduce a function, which returns a hash/uuid based on ino, ns type and some static
> random seed, which is generated on boot;
> 
> 2)Use the hash/uuid as default names in newly create /proc/namespaces: pid-{hash/uuid(ino, "pid")}
> 
> 3)Allow rename, and allocate space only for renamed names.
> 
> Maybe 2 and 3 will be implemented as shrinkable dentries and non-shrinkable.
> 
> > And I have a suggestion about the structure of /proc/namespaces/.
> > 
> > Each namespace is owned by one of user namespaces. Maybe it makes sense
> > to group namespaces by their user-namespaces?
> > 
> > /proc/namespaces/
> >                  user
> >                  mnt-X
> >                  mnt-Y
> >                  pid-X
> >                  uts-Z
> >                  user-X/
> >                         user
> >                         mnt-A
> >                         mnt-B
> >                         user-C
> >                         user-C/
> >                                user
> >                  user-Y/
> >                         user
> 
> Hm, I don't think that user namespace is a generic key value for everybody.
> For generic people tasks a user namespace is just a namespace among another
> namespace types. For me it will look a bit strage to iterate some user namespaces
> to build container net topology.

I can’t agree with you that the user namespace is one of others. It is
the namespace for namespaces. It sets security boundaries in the system
and we need to know them to understand the whole system.

If user namespaces are not used in the system or on a container, you
will see all namespaces in one directory. But if the system has a more
complicated structure, you will be able to build a full picture of it.

You said that one of the users of this feature is CRIU (the tool to
checkpoint/restore containers)  and you said that it would be good if
CRIU will be able to collect all container namespaces before dumping
processes, sockets, files etc. But how will we be able to do this if we
will list all namespaces in one directory?

Here are my thoughts why we need to the suggested structure is better
than just a list of namespaces:

* Users will be able to understand securies bondaries in the system.
  Each namespace in the system is owned by one of user namespace and we
  need to know these relationshipts to understand the whole system.

* This is simplify collecting namespaces which belong to one container.

For example, CRIU collects all namespaces before dumping file
descriptors. Then it collects all sockets with socket-diag in network
namespaces and collects mount points via /proc/pid/mountinfo in mount
namesapces. Then these information is used to dump socket file
descriptors and opened files.

* We are going to assign names to namespaces. But this means that we
need to guarantee that all names in one directory are unique. The
initial proposal was to enumerate all namespaces in one proc directory,
that means names of all namespaces have to be unique. This can be
problematic in some cases. For example, we may want to dump a container
and then restore it more than once on the same host. How are we going to
avoid namespace name conficts in such cases?

If we will have per-user-namespace directories, we will need to
guarantee that names are unique only inside one user namespace.

* With the suggested structure, for each user namepsace, we will show
  only its subtree of namespaces. This looks more natural than
  filltering content of one directory.


> 
> > Do we try to invent cgroupfs for namespaces?
> 
> Could you clarify your thought?
