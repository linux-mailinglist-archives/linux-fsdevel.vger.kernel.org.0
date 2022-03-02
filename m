Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657944CAD4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbiCBSPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 13:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244652AbiCBSPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:15:47 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFF75EBD2
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 10:14:42 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id f14so2913395ioz.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7GGRDag+j9GsGlE0Mu9n2Q98sUOElh/laoWX7BzhjSU=;
        b=XdmMeXuamuGS+B7Edmj8b3QUmXTPrF0agQn3Kwkp36jPeLPTBTcu8UMcdWry68EhI7
         w5JArC8Gc58hktBnc5JmmAPYWfZWNy1dxuj3B1jui5PE0fM62h1ww9Kf+kydVGPUpdqX
         LOHE3wHYKksRzG6rMDVMz9yYkSKTwkCBBa9fNo4iXzkIkVOkCX85cOQeMcWT4HWbngqW
         oME9vzke1pONRe99aHopnhImdXv/JJUgo/dvW/vCVqw7/BDgMOeKlnU1Rf2eSHCA3sgL
         rXQaSNyCCHp/77ZZ/858aF/8aQDrwOBvz+ztKBY+WfsCeCDbPlGYP8mXh6V7AHamlnwa
         wwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7GGRDag+j9GsGlE0Mu9n2Q98sUOElh/laoWX7BzhjSU=;
        b=2izD9IBQDH1s7tbTEdn5/bVm5dvuY/CwGoNchF2NRiZjblNZlXOVTzTQgBOXIEtlIL
         ydsch1jW67dOroY7D3ve/PSbuLe2B+uVNys+OHlMe5suUtAnQ9+fURAd4TGOPWADFtXx
         iPKxvMyR+mq2rcsknXxPs9zG4vAcM4nfMZWiT+wNTxeBKh962Bkh9jsbNgV6d0oWfP2U
         rQY3lOioFoKSOVc8E5/dVkPeJUxkmfb9g3mNUNEaT602q2y/+KcrOx+ovSIbnItd8+1y
         6kMh7fWDHPE77MX+UFdiPOzCsATxQaLE3qxjaN3LJfEDg/1IivmK5+BTw9bjQj0i389U
         tHZQ==
X-Gm-Message-State: AOAM5338KRE0ergUedU7AZ3P36ZbrnZ95Z/yYqRbp00uXxkm6GVdbfRB
        HPq8nHVC8dAWGCi2V+GBY9ABSlqTX84uHF733P0=
X-Google-Smtp-Source: ABdhPJyyzTEe2artjuiDN43/fxq5oNYfOZhSZ2fBMWcJrK17pezSxlj5nJHb2qtoFe+fy6tVwgAlwcBdQ5JYJIuySHw=
X-Received: by 2002:a02:a411:0:b0:314:b51c:3b74 with SMTP id
 c17-20020a02a411000000b00314b51c3b74mr25575398jal.69.1646244880210; Wed, 02
 Mar 2022 10:14:40 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan> <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de> <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
 <8c636384-8db6-d7d1-b89b-424ef1accfe8@mail.de>
In-Reply-To: <8c636384-8db6-d7d1-b89b-424ef1accfe8@mail.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 2 Mar 2022 20:14:29 +0200
Message-ID: <CAOQ4uxgLovYffU5epFy+r3qa7WjD9637YNuiFJHGj_du7H8gOA@mail.gmail.com>
Subject: Re: [RFC] Volatile fanotify marks
To:     Tycho Kirchner <tychokirchner@mail.de>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 2, 2022 at 12:04 PM Tycho Kirchner <tychokirchner@mail.de> wrot=
e:
>
>
>
> Am 01.03.22 um 17:58 schrieb Amir Goldstein:
> > On Tue, Mar 1, 2022 at 2:26 PM Tycho Kirchner <tychokirchner@mail.de> w=
rote:
> >>
> >>
> >>
> >>>>> I wanted to get your feedback on an idea I have been playing with.
> >>>>> It started as a poor man's alternative to the old subtree watch pro=
blem.
> >>
> >>
> >>> I do agree that we should NOT add "subtree filter" functionality to f=
anotify
> >>> (or any other filter) and that instead, we should add support for att=
aching an
> >>> eBPF program that implements is_subdir().
> >>> I found this [1] convection with Tycho where you had suggested this i=
dea.
> >>> I wonder if Tycho got to explore this path further?
> >>>
> >>> [1] https://lore.kernel.org/linux-fsdevel/20200828084603.GA7072@quack=
2.suse.cz/
> >>
> >> Hi Amir, Hi Jan,
> >> Thanks for pinging back on me. Indeed I did "explore this path further=
".
> >> In my project
> >> https://github.com/tycho-kirchner/shournal
> >>
> >> the goal is to track read/written files of a process tree and all it's=
 child-processes and connect this data to a given shell-command. In fact af=
ter Amir's and mine last correspondence I implemented a kernel module which=
 instruments ftrace and tracepoints to trace fput-events (kernel/event_hand=
ler.c:event_handler_fput) of specific tasks, which are then further process=
ed in a dedicated kernel thread. I considered eBPF for this task but found =
no satisfying approach to have dynamic, different filter-rules (e.g. includ=
e-paths) for each process tree of each user.
> >>
> >>
> >> Regarding improvement of fanotify let's discriminate two cases: system=
-monitoring and tracing.
> >> Regarding system-monitoring: I'm not sure how exactly FAN_MARK_VOLATIL=
E would work (Amir, could you please elaborate?)
> >
> > FAN_MARK_VOLATILE is not a solution for "include" filters.
> > It is a solution for "exclude" filters implemented in userspace.
> > If monitoring program gets an event and decides that its path should be=
 excluded
> > it may set a "volatile" exclude mark on that directory that will
> > suppress further
> > events from that directory for as long as the directory inode remains
> > in inode cache.
> > After directory inode has not been accessed for a while and evicted
> > from inode cache
> > the monitoring program can get an event in that directory again and the=
n it can
> > re-install the volatile ignore mark if it wants to.
> >
> Thanks for this explanation. Regarding few exclude-directories this sound=
s useful.
> However, if a whole directory-tree of filesystem events shall be excluded=
 I guess the
> performance benefit will be rather small. A benchmark may clarify this
> ( I have some yet unpublished code ready, in case you are interested).

Code for what?

> If an efficient algorithm can be found I would rather vote for "include" =
dirs with unlimited depth.

As I said, this is desirable, difficult and completely orthogonal to
FAN_MARK_VOLATILE
functionality.

> Btw. similar to the process-filter approach by unshared mount namespaces =
about which
> I wrote in our last correspondence, you may be able to exclude your .priv=
ate/ directory
> by bind-mounting over it and otherwise only marking only those mounts of =
interest
> instead of the entire filesystem. But yeah, this is kinda messy.
>

Marking bind mounts could be a good option for some use cases.
But unlike your monitoring app, my app needs to track create/unlink/rename =
as
well and those events are not currently available for mount marks.
I had several attempts to tackle that but they did not work out yet.
Partly, because marking a bind mount is not as useful as filtering by subtr=
ee.

> >> but what do you think about the following approach, in order to solve =
the subtree watch problem:
> >> - Store the include/exlude-paths of interest as *strings* in a hashset=
.
> >> - on fsevent, lookup the path by calling d_path() only once and cache,=
 whether events for the given path are of interest. This
> >>     can either happen with a reference on the path (clear older paths =
periodically in a work queue)
> >>     or with a timelimit in which potentially wrong paths are accepted =
(path pointer freed and address reused).
> >>     The second approach I use myself in kernel/event_consumer_cache.c.=
 See also kpathtree.c for a somewhat efficient
> >>     subpath-lookup.
> >
> > I would implement filtering with is_subdir() and not with d_path(),
> > but there are
> > advantages to either approach.
> > In any case, I see there is BPF_FUNC_d_path, so why can't your approach=
 be
> > implemented using an eBPF program?
> >It seems that bpf_d_path was introduced with v5.10 (6e22ab9da79343532cd3=
cde39df25e5a5478c692), however, shournal must still run on older kernels (e=
.g. openSUSE Leap v5.3.18). Further, as far as I remember, at least in Linu=
x 4.19 there was quite some overhead to just install the fd into the eBPF u=
ser-space process, but I have to re-check that once that functionality is m=
ore widespread.
>

There is no need to install any fd.
The program should hook a function that has access to a struct path.

>
> >>
> >> Regarding tracing I think fanotify would really benefit from a FAN_MAR=
K_PID (with optional follow fork-mode). That way one of the first filter-st=
eps would be whether events for the given task are of interest, so we have =
no performance problem for all other tasks. The possibility to mark specifi=
c processes would also have another substantial benefit: fanotify could be =
used without root privileges by only allowing the user to mark his/her own =
processes.
> >> That way existing inotify-users could finally switch to the cleaner/mo=
re powerful fanotify.
> >
> > We already have partial support for unprivileged fanotify.
> > Which features are you missing with unprivileged fanotify?
> > and why do you think that filtering by process tree will allow those
> > features to be enabled?
>
>
> I am missing the ability to filter for (close-)events of large directory =
trees in a race-free manner, so that no events are lost on newly created di=
rs. Even without the race, monitoring my home-directory is impossible (with=
out privileges) as I have far more than 8192 directories (393941 as of writ=
ing (; ).
> Monitoring mounts solves these problems but introduces two others:
> First it requires privileges, second a potentially large number of events=
 *not of interest* have to be copied to user-space (except unshared mount n=
amespaces are used). Allowing a user to only monitor his/her own processes =
would make mark_mount privileges unnecessary (please correct me if I'm wron=
g). While still events above the directory of interest are reported, at lea=
st events from other users are filtered beforehand.
>

I don't know. Security model is hard.
What do you mean by "his/her own processes"? processes owned by the same ui=
d?
With simple look it sounds right, but other security policy may be in
play (e.g. sepolicy)
which can grand different processes owned by same user different file acces=
s
permissions and not any process may be allowed to ptrace other processes.
userns has more clear semantics, so monitoring all processes/mounts inside
an unprivileged userns may be easier to prove.

> > A child process may well have more privileges to read directories than
> > its parent.
> >
> Similar to ptrace fanotiy should then not follow suid-programs, so this c=
ase should not occur.
>
> After all I totally understand that you do not want to feature-bloat fano=
tify and maybe my use-case is already too far from the one casual users hav=
e. On the other hand, pid- or path-filtering is maybe basic enough and fano=
tify does offer the ability to filter for paths - it is just quite limited =
due to the mark-concept. I think it should not be necessary in order to mon=
itor a directory tree, to touch every single directory inside beforehand. M=
aybe a hybrid-solution fits best here: hard-code pid-filtering as a securit=
y feature into fanotify, allow marking of mounts for the user's own process=
es and allow for eBPF filter rules afterwards.
>

This is a bit too hand waving for me to understand.
In the end, it's all in the details.
Need to see a whole design and/or implementation to be able to say
what are its benefits and how doable it is.

Thanks,
Amir.
