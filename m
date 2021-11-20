Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2954B4579FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 01:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhKTARb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 19:17:31 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:46714 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233135AbhKTAR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 19:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637367264;
        bh=nW1EPhmlebUWaASHEfN8ljsRhUxyrCzO9GcXIzU3+ys=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Suu/U7/MbvHnHelr+3pzkMU/0gsHJpOQv7uHTqJde28LtW3DNs0eWXg7Cx5ejvvxj
         AcaDAvO2f+ztIPCb0v8fOm/QqwQn2zTQ6Atq/ZzSjQD7Z+pr72PgFkYycQYpTv5osn
         aWngnU4VfeQDxFV/7bMoTQQkhL6gOhNMbbIJfqZE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E466A128010E;
        Fri, 19 Nov 2021 19:14:24 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bFB0L5qCa9Hp; Fri, 19 Nov 2021 19:14:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637367264;
        bh=nW1EPhmlebUWaASHEfN8ljsRhUxyrCzO9GcXIzU3+ys=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Suu/U7/MbvHnHelr+3pzkMU/0gsHJpOQv7uHTqJde28LtW3DNs0eWXg7Cx5ejvvxj
         AcaDAvO2f+ztIPCb0v8fOm/QqwQn2zTQ6Atq/ZzSjQD7Z+pr72PgFkYycQYpTv5osn
         aWngnU4VfeQDxFV/7bMoTQQkhL6gOhNMbbIJfqZE=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 81C45128004F;
        Fri, 19 Nov 2021 19:14:23 -0500 (EST)
Message-ID: <48d53b265664f020579c70a7bffc45156032bf69.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yordan Karadzhov <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, akpm@linux-foundation.org, vvs@virtuozzo.com,
        shakeelb@google.com, christian.brauner@ubuntu.com,
        mkoutny@suse.com, Linux Containers <containers@lists.linux.dev>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri, 19 Nov 2021 19:14:22 -0500
In-Reply-To: <20211119190745.3b706c4b@gandalf.local.home>
References: <20211118181210.281359-1-y.karadz@gmail.com>
         <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
         <20211118142440.31da20b3@gandalf.local.home>
         <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
         <20211119092758.1012073e@gandalf.local.home>
         <47bf8da26b5ec71f98b9bc736dbca2d8277417f2.camel@HansenPartnership.com>
         <de336e53-68e1-1d4b-7f71-e276b5363b7c@gmail.com>
         <f141c401560d90a546968514c6cfc63d7fdb8e00.camel@HansenPartnership.com>
         <20211119190745.3b706c4b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-11-19 at 19:07 -0500, Steven Rostedt wrote:
> On Fri, 19 Nov 2021 18:22:55 -0500
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > But I could write a script or a tool to gather all the information
> > without this filesystem.  The namespace tree can be reconstructed
> > by anything that can view the process tree and the /proc/<pid>/ns
> > directory.
> 
> So basically you're stating that we could build the same thing that
> the namespacefs would give us from inside a privileged container that
> had access to the system procfs?

I think so, yes ... and if some information is missing, we could export
it for you.  This way the kernel doesn't prescribe what the namespace
tree looks like and the tool can display it in many different ways. 
For instance, your current RFC patch misses the subtlety of the owning
user namespace, but that could simply be an alternative view presented
by a userspace tool.

James



