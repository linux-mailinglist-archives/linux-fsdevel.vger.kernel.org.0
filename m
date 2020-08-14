Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F22442AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 03:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHNBQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 21:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNBQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 21:16:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A58C061757;
        Thu, 13 Aug 2020 18:16:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so3629230pjr.0;
        Thu, 13 Aug 2020 18:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Yw5NvrZ7py/AfK1/21pelmf51DWKBK3KehQc53liuws=;
        b=PswvHwShhQO111W2vm1LZRsMGj/YXg4kxI11Wd6TuAozXkxw9VmximFPjzjCkKT+Sw
         I+daJG5NM+mh5+3zEkMCunKOIs/Q0Z+10jTL57oHEnRMZBBic9OgcWY3BI46rKzepJcb
         jwLc+EJR4xnnsX/KOorawVm1UoYa1BNWBaS0NtDCo1x5uA13UKiHNhUmvbs9zQA7JHc5
         pjS95YQavyuno3bcip59e9iNi4HFyZU+GsdyJ+fIMDVBtRkJHkAJK8+G0q/8LEjCylQN
         0+F4N+x96VZAbDCcUaB2tOo+H9fhoDrW3WQ62sWs2JgDcW9scDo2HymDWi6MdmV6J69R
         GBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Yw5NvrZ7py/AfK1/21pelmf51DWKBK3KehQc53liuws=;
        b=i+X+4L7xqIDPyC+fmFxEksF8xzH6LPsLo1FZuYoGcWoVj0nOekWBvvc5cTK4I1iKUi
         oPlfdRdZz7ucfHljGMhOFe3b/+/MdcQzsa5vNLO2nmZ7mtDai8bpXBi8YwzabPP7/9BZ
         wwdbiAIvVba2vqBbgsZLQXLORd2WByR8BUNVBVxlOPDK0HCgExBbs2zXqDT0TR7HZ32F
         tDmYDyK+UQ/71J7IJJ5F8HFrynYG/UGG90MKo/7JVrIlRC4cvEynrMZZHIubG8FMoFKx
         blHjbmSume7zy6yRtRJotiLlgvgg33zoZA636h4AUAOFWeeptfrHTg7xgh6QExX9VImx
         mCvw==
X-Gm-Message-State: AOAM533JEWMXVrD8ltHJ4X/eCZWog5jrnvpexpBBumb55pofFE3U/6zA
        wig9EpeHp2Dy7ItLVPlEpew=
X-Google-Smtp-Source: ABdhPJyZBLypw4zgRxl1tnP6fOejxskRTX4VXfulQG6t1bsYrpo7zHEvEpGy9wnvO+bu0XDmc+r8YQ==
X-Received: by 2002:a17:90a:aa90:: with SMTP id l16mr305273pjq.210.1597367812165;
        Thu, 13 Aug 2020 18:16:52 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id a19sm7161329pfn.10.2020.08.13.18.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 18:16:51 -0700 (PDT)
Date:   Thu, 13 Aug 2020 18:16:49 -0700
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
Message-ID: <20200814011649.GA611947@gmail.com>
References: <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
 <875za43b3w.fsf@x220.int.ebiederm.org>
 <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
 <20200806080540.GA18865@gmail.com>
 <2d65ca28-bcfa-b217-e201-09163640ebc2@virtuozzo.com>
 <20200810173431.GA68662@gmail.com>
 <33565447-9b97-a820-bc2c-a4ff53a7675a@virtuozzo.com>
 <20200812175338.GA596568@gmail.com>
 <8f3c9414-9efc-cc01-fb2a-4d83266e96b2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f3c9414-9efc-cc01-fb2a-4d83266e96b2@virtuozzo.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 11:12:45AM +0300, Kirill Tkhai wrote:
> On 12.08.2020 20:53, Andrei Vagin wrote:
> > On Tue, Aug 11, 2020 at 01:23:35PM +0300, Kirill Tkhai wrote:
> >> On 10.08.2020 20:34, Andrei Vagin wrote:
> >>> On Fri, Aug 07, 2020 at 11:47:57AM +0300, Kirill Tkhai wrote:
> >>>> On 06.08.2020 11:05, Andrei Vagin wrote:
> >>>>> On Mon, Aug 03, 2020 at 01:03:17PM +0300, Kirill Tkhai wrote:
> >>>>>> On 31.07.2020 01:13, Eric W. Biederman wrote:
> >>>>>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> >>>>>>>
> >>>>>>>> On 30.07.2020 17:34, Eric W. Biederman wrote:
> >>>>>>>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> >>>>>>>>>
> >>>>>>>>>> Currently, there is no a way to list or iterate all or subset of namespaces
> >>>>>>>>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
> >>>>>>>>>> but some also may be as open files, which are not attached to a process.
> >>>>>>>>>> When a namespace open fd is sent over unix socket and then closed, it is
> >>>>>>>>>> impossible to know whether the namespace exists or not.
> >>>>>>>>>>
> >>>>>>>>>> Also, even if namespace is exposed as attached to a process or as open file,
> >>>>>>>>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
> >>>>>>>>>> this multiplies at tasks and fds number.
> >>>>>>>>>
> >>>>>>>>> I am very dubious about this.
> >>>>>>>>>
> >>>>>>>>> I have been avoiding exactly this kind of interface because it can
> >>>>>>>>> create rather fundamental problems with checkpoint restart.
> >>>>>>>>
> >>>>>>>> restart/restore :)
> >>>>>>>>
> >>>>>>>>> You do have some filtering and the filtering is not based on current.
> >>>>>>>>> Which is good.
> >>>>>>>>>
> >>>>>>>>> A view that is relative to a user namespace might be ok.    It almost
> >>>>>>>>> certainly does better as it's own little filesystem than as an extension
> >>>>>>>>> to proc though.
> >>>>>>>>>
> >>>>>>>>> The big thing we want to ensure is that if you migrate you can restore
> >>>>>>>>> everything.  I don't see how you will be able to restore these files
> >>>>>>>>> after migration.  Anything like this without having a complete
> >>>>>>>>> checkpoint/restore story is a non-starter.
> >>>>>>>>
> >>>>>>>> There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.
> >>>>>>>>
> >>>>>>>> CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
> >>>>>>>> As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
> >>>>>>>> problem here.
> >>>>>>>
> >>>>>>> An obvious diffference is that you are adding the inode to the inode to
> >>>>>>> the file name.  Which means that now you really do have to preserve the
> >>>>>>> inode numbers during process migration.
> >>>>>>>
> >>>>>>> Which means now we have to do all of the work to make inode number
> >>>>>>> restoration possible.  Which means now we need to have multiple
> >>>>>>> instances of nsfs so that we can restore inode numbers.
> >>>>>>>
> >>>>>>> I think this is still possible but we have been delaying figuring out
> >>>>>>> how to restore inode numbers long enough that may be actual technical
> >>>>>>> problems making it happen.
> >>>>>>
> >>>>>> Yeah, this matters. But it looks like here is not a dead end. We just need
> >>>>>> change the names the namespaces are exported to particular fs and to support
> >>>>>> rename().
> >>>>>>
> >>>>>> Before introduction a principally new filesystem type for this, can't
> >>>>>> this be solved in current /proc?
> >>>>>
> >>>>> do you mean to introduce names for namespaces which users will be able
> >>>>> to change? By default, this can be uuid.
> >>>>
> >>>> Yes, I mean this.
> >>>>
> >>>> Currently I won't give a final answer about UUID, but I planned to show some
> >>>> default names, which based on namespace type and inode num. Completely custom
> >>>> names for any /proc by default will waste too much memory.
> >>>>
> >>>> So, I think the good way will be:
> >>>>
> >>>> 1)Introduce a function, which returns a hash/uuid based on ino, ns type and some static
> >>>> random seed, which is generated on boot;
> >>>>
> >>>> 2)Use the hash/uuid as default names in newly create /proc/namespaces: pid-{hash/uuid(ino, "pid")}
> >>>>
> >>>> 3)Allow rename, and allocate space only for renamed names.
> >>>>
> >>>> Maybe 2 and 3 will be implemented as shrinkable dentries and non-shrinkable.
> >>>>
> >>>>> And I have a suggestion about the structure of /proc/namespaces/.
> >>>>>
> >>>>> Each namespace is owned by one of user namespaces. Maybe it makes sense
> >>>>> to group namespaces by their user-namespaces?
> >>>>>
> >>>>> /proc/namespaces/
> >>>>>                  user
> >>>>>                  mnt-X
> >>>>>                  mnt-Y
> >>>>>                  pid-X
> >>>>>                  uts-Z
> >>>>>                  user-X/
> >>>>>                         user
> >>>>>                         mnt-A
> >>>>>                         mnt-B
> >>>>>                         user-C
> >>>>>                         user-C/
> >>>>>                                user
> >>>>>                  user-Y/
> >>>>>                         user
> >>>>
> >>>> Hm, I don't think that user namespace is a generic key value for everybody.
> >>>> For generic people tasks a user namespace is just a namespace among another
> >>>> namespace types. For me it will look a bit strage to iterate some user namespaces
> >>>> to build container net topology.
> >>>
> >>> I can’t agree with you that the user namespace is one of others. It is
> >>> the namespace for namespaces. It sets security boundaries in the system
> >>> and we need to know them to understand the whole system.
> >>>
> >>> If user namespaces are not used in the system or on a container, you
> >>> will see all namespaces in one directory. But if the system has a more
> >>> complicated structure, you will be able to build a full picture of it.
> >>>
> >>> You said that one of the users of this feature is CRIU (the tool to
> >>> checkpoint/restore containers)  and you said that it would be good if
> >>> CRIU will be able to collect all container namespaces before dumping
> >>> processes, sockets, files etc. But how will we be able to do this if we
> >>> will list all namespaces in one directory?
> >>
> >> There is no a problem, this looks rather simple. Two cases are possible:
> >>
> >> 1)a container has dedicated namespaces set, and CRIU just has to iterate
> >>   files in /proc/namespaces of root pid namespace of the container.
> >>   The relationships between parents and childs of pid and user namespaces
> >>   are founded via ioctl(NS_GET_PARENT).
> >>   
> >> 2)container has no dedicated namespaces set. Then CRIU just has to iterate
> >>   all host namespaces. There is no another way to do that, because container
> >>   may have any host namespaces, and hierarchy in /proc/namespaces won't
> >>   help you.
> >>
> >>> Here are my thoughts why we need to the suggested structure is better
> >>> than just a list of namespaces:
> >>>
> >>> * Users will be able to understand securies bondaries in the system.
> >>>   Each namespace in the system is owned by one of user namespace and we
> >>>   need to know these relationshipts to understand the whole system.
> >>
> >> Here are already NS_GET_PARENT and NS_GET_USERNS. What is the problem to use
> >> this interfaces?
> > 
> > We can use these ioctl-s, but we will need to enumerate all namespaces in
> > the system to build a view of the namespace hierarchy. This will be very
> > expensive. The kernel can show this hierarchy without additional cost.
> 
> No. We will have to iterate /proc/namespaces of a specific container to get
> its namespaces. It's a subset of all namespaces in system, and these all the
> namespaces, which are potentially allowed for the container.

"""
Every /proc is related to a pid_namespace, and the pid_namespace
is related to a user_namespace. The items, we show in this
/proc/namespaces/ directory, are the namespaces,
whose user_namespaces are the same as /proc's user_namespace,
or their descendants.
""" // [PATCH 11/23] fs: Add /proc/namespaces/ directory

This means that if a user want to find out all container namespaces, it
has to have access to the container procfs and the container should
a separate pid namespace.

I would say these are two big limitations. The first one will not affect
CRIU and I agree CRIU can use this interface in its current form.

The second one will be still the issue for CRIU. And they both will
affect other users.

For end users, it will be a pain. They will need to create a pid
namespaces in a specified user-namespace, if a container doesn't have
its own. Then they will need to mount /proc from the container pid
namespace and only then they will be able to enumerate namespaces.

But to build a view of a hierarchy of these namespaces, they will need to
use a binary tool which will open each of these namespaces, call
NS_GET_PARENT and NS_GET_USERNS ioctl-s and build a tree.

> 
> >>
> >>> * This is simplify collecting namespaces which belong to one container.
> >>>
> >>> For example, CRIU collects all namespaces before dumping file
> >>> descriptors. Then it collects all sockets with socket-diag in network
> >>> namespaces and collects mount points via /proc/pid/mountinfo in mount
> >>> namesapces. Then these information is used to dump socket file
> >>> descriptors and opened files.
> >>
> >> This is just the thing I say. This allows to avoid writing recursive dump.
> > 
> > I don't understand this. How are you going to collect namespaces in CRIU
> > without knowing which are used by a dumped container?
> 
> My patchset exports only the namespaces, which are allowed for a specific
> container, and no more above this. All exported namespaces are alive,
> so someone holds a reference on every of it. So they are used.
> 
> It seems you haven't understood the way I suggested here. See patch [11/23]
> for the details. It's about permissions, and the subset of exported namespaces
> is formalized there.

Honestly, I have not read all patches in this series and you didn't
describe this behavior in the cover letter. Thank you for pointing out
to the 11 patch, but I still think it doesn't solve the problem
completely. More details is in the comment which is a few lines above
this one.

> 
> >> But this has nothing about advantages of hierarchy in /proc/namespaces.

Yes, it has. For example, in cases when a container doesn't have its own
pid namespaces.

> > 
> > Really? You said that you implemented this series to help CRIU dumping
> > namespaces. I think we need to implement the CRIU part to prove that
> > this interface is usable for this case. Right now, I have doubts about
> > this.
> 
> Yes, really. See my comment above and patch [11/23].
> 
> >>
> >>> * We are going to assign names to namespaces. But this means that we
> >>> need to guarantee that all names in one directory are unique. The
> >>> initial proposal was to enumerate all namespaces in one proc directory,
> >>> that means names of all namespaces have to be unique. This can be
> >>> problematic in some cases. For example, we may want to dump a container
> >>> and then restore it more than once on the same host. How are we going to
> >>> avoid namespace name conficts in such cases?
> >>
> >> Previous message I wrote about .rename of proc files, Alexey Dobriyan
> >> said this is not a taboo. Are there problem which doesn't cover the case
> >> you point?
> > 
> > Yes, there is. Namespace names will be visible from a container, so they
> > have to be restored. But this means that two containers can't be
> > restored from the same snapshot due to namespace name conflicts.
> > 
> > But if we will show namespaces how I suggest, each container will see
> > only its sub-tree of namespaces and we will be able to specify any name
> > for the container root user namespace.
> 
> Now I'm sure you missed my idea. See proc_namespaces_readdir() in [11/23].
> 
> I do export sub-tree.

I got your idea, but it is unclear how your are going to avoid name
conflicts.

In the root container, you will show all namespaces in the system. These
means that all namespaces have to have unique names. This means we will
not able to restore two containers from the same snapshot without
renaming namespaces. But we can't change namespace names, because they
are visible from containers and container processes can use them.

> 
> >>
> >>> If we will have per-user-namespace directories, we will need to
> >>> guarantee that names are unique only inside one user namespace.
> >>
> >> Unique names inside one user namespace won't introduce a new /proc
> >> mount. You can't pass a sub-directory of /proc/namespaces/ to a specific
> >> container. To give a virtualized name you have to have a dedicated pid ns.
> >>
> >> Let we have in one /proc mount:
> >>
> >> /mnt1/proc/namespaces/userns1/.../[namespaceX_name1 -- inode XXX]
> >>
> >> In another another /proc mount we have:
> >>
> >> /mnt2/proc/namespaces/userns1/.../[namespaceX_name1_synonym -- inode XXX]
> >>
> >> The virtualization is made per /proc (i.e., per pid ns). Container should
> >> receive either /mnt1/proc or /mnt2/proc on restore as it's /proc.
> >>
> >> There is no a sense of directory hierarchy for virtualization, since
> >> you can't use specific sub-directory as a root directory of /proc/namespaces
> >> to a container. You still have to introduce a new pid ns to have virtualized
> >> /proc.
> > 
> > I think we can figure out how to implement this. As the first idea, we
> > can use the same way how /proc/net is implemented.
> > 
> >>
> >>> * With the suggested structure, for each user namepsace, we will show
> >>>   only its subtree of namespaces. This looks more natural than
> >>>   filltering content of one directory.
> >>
> >> It's rather subjectively I think. /proc is related to pid ns, and user ns
> >> hierarchy does not look more natural for me.
> > 
> > or /proc is wrong place for this
