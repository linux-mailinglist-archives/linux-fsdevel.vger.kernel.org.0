Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1955457980
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 00:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhKSX0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 18:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhKSX0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:26:01 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480CDC061574;
        Fri, 19 Nov 2021 15:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637364178;
        bh=QhpEd3Ok9D7p4d26itQMrgucyfEtnJI77U70RxTvW4U=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Z8M+jTv1y84CEHDEdBBNjF1faR4iHvIQSvkLHt4D4MNl0SJ1Wpd72eURREMCXDP6Q
         dn4Y+7VsyCJlWpKb+n5lgiF91GNxSU3KwElZe9fjIEEHq8u2Jqmn5TpRdxR9SGzACT
         /QojjYiHVyzXoc1iXw9cpdTaUOJsqpCtF2Z+NdjA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0DEC112801EE;
        Fri, 19 Nov 2021 18:22:58 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Klscw9XzJmkC; Fri, 19 Nov 2021 18:22:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637364177;
        bh=QhpEd3Ok9D7p4d26itQMrgucyfEtnJI77U70RxTvW4U=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=m98UlP2+ZGTHzEvkL9JZKv4+BG/iKv3MjoEwSyaH6hArsQmcfVtD3J+BdAzxOEodk
         zHOhWzk4BkfIcuYFBjZW/suPcIcahye3mkXVfBeXWzoDCYq+ua1XYKcq4SGTBcSRxm
         C2qzi0NxljNUaOmExcs1MvQg8H5wDmEw2cERJaRE=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7E8F3128010E;
        Fri, 19 Nov 2021 18:22:56 -0500 (EST)
Message-ID: <f141c401560d90a546968514c6cfc63d7fdb8e00.camel@HansenPartnership.com>
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
Date:   Fri, 19 Nov 2021 18:22:55 -0500
In-Reply-To: <de336e53-68e1-1d4b-7f71-e276b5363b7c@gmail.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
         <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
         <20211118142440.31da20b3@gandalf.local.home>
         <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
         <20211119092758.1012073e@gandalf.local.home>
         <47bf8da26b5ec71f98b9bc736dbca2d8277417f2.camel@HansenPartnership.com>
         <de336e53-68e1-1d4b-7f71-e276b5363b7c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-11-19 at 19:14 +0200, Yordan Karadzhov wrote:
> On 19.11.21 г. 18:42 ч., James Bottomley wrote:
[...]
> > Can we back up and ask what problem you're trying to solve before
> > we start introducing new objects like namespace name?  The problem
> > statement just seems to be "Being able to see the structure of the
> > namespaces can be very useful in the context of the containerized
> > workloads."  which you later expanded on as "trying to add more
> > visibility into the working of things like kubernetes".  If you
> > just want to see the namespace "tree" you can script that (as root)
> > by matching the process tree and the /proc/<pid>/ns changes without
> > actually needing to construct it in the kernel.  This can also be
> > done without introducing the concept of a namespace name.  However,
> > there is a subtlety of doing this matching in the way I described
> > in that you don't get proper parenting to the user namespace
> > ownership ... but that seems to be something you don't want anyway?
> > 
> 
> The major motivation is to be able to hook tracing to individual
> containers. We want to be able to quickly discover the 
> PIDs of all containers running on a system. And when we say all, we
> mean not only Docker, but really all sorts of 
> containers that exist now or may exist in the future. We also
> considered the solution of brute-forcing all processes in 
> /proc/*/ns/ but we are afraid that such solution do not scale.

What do you mean does not scale?  ps and top use the /proc tree to
gather all the real time interface data for every process; do they not
"scale" as well and should therefore be done as in-kernel interfaces?

>  As I stated in the Cover letter, the problem was 
> discussed at Plumbers (links at the bottom of the Cover letter) and
> the conclusion was that the most distinct feature 
> that anything that can be called 'Container' must have is a separate
> PID namespace.

Unfortunately, I think I was fighting matrix fires at the time so
couldn't be there.  However, I'd have pushed back on the idea of
identifying containers by the pid namespace (mainly because most of the
unprivileged containers I set up don't have one).  Realistically, if
you're not a system container (need for pid 1) and don't have multiple
untrusted tenants (global process tree information leak), you likely
shouldn't be using the pid namespace either ... it just adds isolation
for no value.

>  This is why the PoC starts with the implementation of this
> namespace. You can see in the example script that discovering the
> name and all PIDs of all  containers gets quick and trivial with the
> help of this new filesystem. And you need to add just few more lines
> of code in order to make it start tracing a selected container.

But I could write a script or a tool to gather all the information
without this filesystem.  The namespace tree can be reconstructed by
anything that can view the process tree and the /proc/<pid>/ns
directory.

James


