Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1863D456EF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 13:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhKSMsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 07:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhKSMsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:48:07 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C23CC061574;
        Fri, 19 Nov 2021 04:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637325904;
        bh=KC11muGBGBkkp5sLwFID+9dMZgpYQl97DyJqkTb+W+s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=GbBVeRnL7HML6p7NyN7VAmkSbR5T7l8wt+L0oTOPxGgZ8ZwLjdLN80QDMebg5r4Km
         f3LIf5P4E0vCplwKZ25Vv6y5YmjKIA1OgsWKX63MGllxUz5+aVi2TTjXw3+RdiKPNq
         9H4Z2ST63q3qwhQKUC2SAnXznO92Yw4dp3OPpvNQ=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A433D12805A8;
        Fri, 19 Nov 2021 07:45:04 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0jGiuwE0eec2; Fri, 19 Nov 2021 07:45:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637325904;
        bh=KC11muGBGBkkp5sLwFID+9dMZgpYQl97DyJqkTb+W+s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=GbBVeRnL7HML6p7NyN7VAmkSbR5T7l8wt+L0oTOPxGgZ8ZwLjdLN80QDMebg5r4Km
         f3LIf5P4E0vCplwKZ25Vv6y5YmjKIA1OgsWKX63MGllxUz5+aVi2TTjXw3+RdiKPNq
         9H4Z2ST63q3qwhQKUC2SAnXznO92Yw4dp3OPpvNQ=
Received: from [IPv6:2601:5c4:4300:c551::c447] (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4BB47128035A;
        Fri, 19 Nov 2021 07:45:03 -0500 (EST)
Message-ID: <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, akpm@linux-foundation.org, vvs@virtuozzo.com,
        shakeelb@google.com, christian.brauner@ubuntu.com,
        mkoutny@suse.com, Linux Containers <containers@lists.linux.dev>
Date:   Fri, 19 Nov 2021 07:45:01 -0500
In-Reply-To: <20211118142440.31da20b3@gandalf.local.home>
References: <20211118181210.281359-1-y.karadz@gmail.com>
         <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
         <20211118142440.31da20b3@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-11-18 at 14:24 -0500, Steven Rostedt wrote:
> On Thu, 18 Nov 2021 12:55:07 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > It is not correct to use inode numbers as the actual names for
> > namespaces.
> > 
> > I can not see anything else you can possibly uses as names for
> > namespaces.
> 
> This is why we used inode numbers.
> 
> > To allow container migration between machines and similar things
> > the you wind up needing a namespace for your names of namespaces.
> 
> Is this why you say inode numbers are incorrect?

The problem is you seem to have picked on one orchestration system
without considering all the uses of namespaces and how this would
impact them.  So let me explain why inode numbers are incorrect and it
will possibly illuminate some of the cans of worms you're opening.

We have a container checkpoint/restore system called CRIU that can be
used to snapshot the state of a pid subtree and restore it.  It can be
used for the entire system or piece of it.  It is also used by some
orchestration systems to live migrate containers.  Any property of a
container system that has meaning must be saved and restored by CRIU.

The inode number is simply a semi random number assigned to the
namespace.  it shows up in /proc/<pid>/ns but nowhere else and isn't
used by anything.  When CRIU migrates or restores containers, all the
namespaces that compose them get different inode values on the restore.
If you want to make the inode number equivalent to the container name,
they'd have to restore to the previous number because you've made it a
property of the namespace.  The way everything is set up now, that's
just not possible and never will be.  Inode numbers are a 32 bit space
and can't be globally unique.  If you want a container name, it will
have to be something like a new UUID and that's the first problem you
should tackle.

James


