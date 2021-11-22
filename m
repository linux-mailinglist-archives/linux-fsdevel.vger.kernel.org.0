Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D443458FA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 14:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhKVNrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 08:47:18 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:43142 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239591AbhKVNrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637588650;
        bh=/6FwUIopWGEZF2iH1TImnWQkKZ/1gFqOd7wHAdmKlBQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HzmqkquWAZhr0kVjs8geFPZDLWzJW2gieSY7v2k+PkOjYL/Bga7Xz8xa4bfvaZCyb
         tElGS9eJNC9EBwW35gQ2vH+7JtsHQnYDob43/m6Zyvw4Wi/9uSyelPZK9HBPA1yUGf
         3Tahc9eZ/jrOKSWPeP6NxhWxojfAIckcFGwCKOBA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E4866128028D;
        Mon, 22 Nov 2021 08:44:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E3eGFrCm2n21; Mon, 22 Nov 2021 08:44:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637588650;
        bh=/6FwUIopWGEZF2iH1TImnWQkKZ/1gFqOd7wHAdmKlBQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HzmqkquWAZhr0kVjs8geFPZDLWzJW2gieSY7v2k+PkOjYL/Bga7Xz8xa4bfvaZCyb
         tElGS9eJNC9EBwW35gQ2vH+7JtsHQnYDob43/m6Zyvw4Wi/9uSyelPZK9HBPA1yUGf
         3Tahc9eZ/jrOKSWPeP6NxhWxojfAIckcFGwCKOBA=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 81F7712800CE;
        Mon, 22 Nov 2021 08:44:09 -0500 (EST)
Message-ID: <4d2b08aa854fcccd51247105edb18fe466a2a3f1.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Yordan Karadzhov <y.karadz@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, akpm@linux-foundation.org, vvs@virtuozzo.com,
        shakeelb@google.com, christian.brauner@ubuntu.com,
        mkoutny@suse.com, Linux Containers <containers@lists.linux.dev>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 22 Nov 2021 08:44:07 -0500
In-Reply-To: <ba0f624c-fc24-a3f4-749a-00e419960de2@gmail.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
         <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
         <20211118142440.31da20b3@gandalf.local.home>
         <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
         <20211119092758.1012073e@gandalf.local.home>
         <f6ca1f5bdb3b516688f291d9685a6a59f49f1393.camel@HansenPartnership.com>
         <20211119114736.5d9dcf6c@gandalf.local.home>
         <20211119114910.177c80d6@gandalf.local.home>
         <cc6783315193be5acb0e2e478e2827d1ad76ba2a.camel@HansenPartnership.com>
         <ba0f624c-fc24-a3f4-749a-00e419960de2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-11-22 at 15:02 +0200, Yordan Karadzhov wrote:
> 
> On 20.11.21 г. 1:08 ч., James Bottomley wrote:
> > [trying to reconstruct cc list, since the cc: field is bust again]
> > > On Fri, 19 Nov 2021 11:47:36 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > > Can we back up and ask what problem you're trying to solve
> > > > > before we start introducing new objects like namespace name?
> > > 
> > > TL;DR; verison:
> > > 
> > > We want to be able to install a container on a machine that will
> > > let us view all namespaces currently defined on that machine and
> > > which tasks are associated with them.
> > > 
> > > That's basically it.
> > 
> > So you mentioned kubernetes.  Have you tried
> > 
> > kubectl get pods --all-namespaces
> > 
> > ?
> > 
> > The point is that orchestration systems usually have interfaces to
> > get this information, even if the kernel doesn't.  In fact,
> > userspace is almost certainly the best place to construct this
> > from.
> > 
> > To look at this another way, what if you were simply proposing the
> > exact same thing but for the process tree.  The push back would be
> > that we can get that all in userspace and there's even a nice tool
> > (pstree) to do it which simply walks the /proc interface.  Why,
> > then, do we have to do nstree in the kernel when we can get all the
> > information in exactly the same way (walking the process tree)?
> > 
> 
> I see on important difference between the problem we have and the
> problem in your example. /proc contains all the 
> information needed to unambiguously reconstruct the process tree.
> 
> On the other hand, I do not see how one can reconstruct the namespace
> tree using only the information in proc/ (maybe this is because of my
> ignorance).

Well, no, the information may not all exist.  However, the point is we
can add it without adding additional namespace objects.

> Let's look the following case (oversimplified just to get the idea):
> 1. The process X is a parent of the process Y and both are in
> namespace 'A'.
> 3. "unshare" is used to place process Y (and all its child processes)
> in a new namespace B (A is a parent namespace of B).
> 4. "setns" is s used to move process X in namespace C.
> 
> How would you find the parent namespace of B?

Actually this one's quite easy: the parent of X in your setup still has
it.

However, I think you're looking to set up a scenario where the
namespace information isn't carried by live processes and that's
certainly possible if we unshare the namespace, bind it to a mount
point and exit the process that unshared it.  If will exist as a bound
namespace with no processes until it gets entered via the binding and
when that happens the parent information can't be deduced from the
process tree.

There's another problem, that I think you don't care about but someone
will at some point: the owning user_ns can't be deduced from the
current tree either because it depends on the order of entry.  We fixed
unshare so that if you enter multiple namespaces, it enters the user_ns
first so the latter is always the owning namespace, but if you enter
the rest of the namespaces first via one unshare then unshare the
user_ns second, that won't be true.

Neither of the above actually matter for docker like containers because
that's not the way the orchestration system works (it doesn't use mount
bindings or the user_ns) but one day, hopefully, it might.

> Again, using your arguments, I can reformulate the problem statement
> this way: a userspace program is well instrumented 
> to create an arbitrary complex tree of namespaces. In the same time,
> the only place where the information about the 
> created structure can be retrieved is in the userspace program
> itself. And when we have multiple userspace programs 
> adding to the namespaces tree, the global picture gets impossible to
> recover.

So figure out what's missing in the /proc tree and propose adding it. 
The interface isn't immutable it's just that what exists today is an
ABI and can't be altered.  I think this is the last time we realised we
needed to add missing information in /proc/<pid>/ns:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eaa0d190bfe1ed891b814a52712dcd852554cb08

So you can use that as the pattern.

James


