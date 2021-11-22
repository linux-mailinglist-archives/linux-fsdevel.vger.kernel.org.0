Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606A2459197
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 16:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbhKVPuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 10:50:10 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:43144 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234636AbhKVPuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637596023;
        bh=1uDlFLrgaSL10WCfqyQ8IfoWuiwun2pKDp1EhWUNXLk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=JgYHC0cnyxAcgzX+cc7Hzz1D+obsixUBRsh+JUOQH/rvaOvG9OjxLULw2Zv7T3ucn
         paRnI2Lv8uuLD174oxGfbO07yPUCLXBO0fdhEoAmc+jCxbYW4IBu/RLA2F0YRyKUbu
         KF74GQmFZFlHeghtZoAPqaxcIo5rKG8egrNGDI4c=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 17BAE128028D;
        Mon, 22 Nov 2021 10:47:03 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YwC9t3ajzgS8; Mon, 22 Nov 2021 10:47:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637596022;
        bh=1uDlFLrgaSL10WCfqyQ8IfoWuiwun2pKDp1EhWUNXLk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WtVIe+aHaqolJaW6i2Zjhkm0T3A7UTs7pjzuxPcJCivbcYccQKCVfMTrhnrwNScFV
         2mLSqs8ZGCZ/+jExpMOtkXiTc4v7uDbUrXVUoXWjtNL0OrHaaxbumWv8j/TBZ2pXrz
         tUflAC73YoXKFxxn8yHDvlmNd1sABXJcot8OzyYg=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AF00A12800EF;
        Mon, 22 Nov 2021 10:47:01 -0500 (EST)
Message-ID: <63f54c213253b80fcf3f8653766d5c6f5761034a.camel@HansenPartnership.com>
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
Date:   Mon, 22 Nov 2021 10:47:00 -0500
In-Reply-To: <e94c2ba9-226b-8275-bef7-28e854be3ffa@gmail.com>
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
         <4d2b08aa854fcccd51247105edb18fe466a2a3f1.camel@HansenPartnership.com>
         <e94c2ba9-226b-8275-bef7-28e854be3ffa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-11-22 at 17:00 +0200, Yordan Karadzhov wrote:
> 
> On 22.11.21 г. 15:44 ч., James Bottomley wrote:
> > Well, no, the information may not all exist.  However, the point is
> > we can add it without adding additional namespace objects.
> > 
> > > Let's look the following case (oversimplified just to get the
> > > idea):
> > > 1. The process X is a parent of the process Y and both are in
> > > namespace 'A'.
> > > 3. "unshare" is used to place process Y (and all its child
> > > processes) in a new namespace B (A is a parent namespace of B).
> > > 4. "setns" is s used to move process X in namespace C.
> > > 
> > > How would you find the parent namespace of B?
> > Actually this one's quite easy: the parent of X in your setup still
> > has it.
> 
> Hmm, Isn't that true only if somehow we know that (3) happened before
> (4).

This depends.  There are only two parented namespaces: pid and user. 
You said you were only interested in pid for now.  setns on the process
only affects pid_for_children because you have to fork to enter the pid
namespace, so in your scenario X has a new ns/pid_for_children but its
own ns/pid never changed.  It's the ns/pid not the ns/pid_for_children
which is the parent.  This makes me suspect that the specific thing
you're trying to do: trace the pid parentage, can actually be done with
the information we have now.

If you do this with the user_ns, then you have a problem because it's
not fork on entry.  But, as I listed in the examples, there are a load
of other problems with tracing the user_ns tree.

James


