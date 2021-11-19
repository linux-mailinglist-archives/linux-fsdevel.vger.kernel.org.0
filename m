Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD39C45734B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 17:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhKSQpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 11:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbhKSQpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:45:23 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E837C061574;
        Fri, 19 Nov 2021 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637340141;
        bh=S3tqbZO5Rlul7onRk41NRHP4ESMa/qmMnn6fYAI4Orw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=MUVho1oUpRMMPU0y7O3yAPiEAN+G3Df6TrpgXE5vwPDG/9beEkS9qbqL6K+NSzUeB
         qHP3ClUqpiEnvJTxzj6UmiNH+dJYCm55Zeo2Tld8yepId4WbuCXiftDPBSJK02W7fA
         Dr6lR9Xwcs+/vweMrgi40uX+I4Imniu8MTsb5WMc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 08F84128035A;
        Fri, 19 Nov 2021 11:42:21 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NGLNnwndHCFH; Fri, 19 Nov 2021 11:42:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1637340140;
        bh=S3tqbZO5Rlul7onRk41NRHP4ESMa/qmMnn6fYAI4Orw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rmEb5c7WPA3N9rCKPsQ8UFb/udB1jF3EZ1DCDIUP+5xD09kPL5tIU376LCm0ifFMd
         GMlCvqvV9ooD281wWpP/Cgf+ImqHG/2xaSD1KRN919c9JTRLDAII9cTmd+BDZE6MAI
         qGtcio/0M7LDnlOoYmbpi7Sp1+1O6skpA0v06IHI=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 645C712800E8;
        Fri, 19 Nov 2021 11:42:19 -0500 (EST)
Message-ID: <47bf8da26b5ec71f98b9bc736dbca2d8277417f2.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, akpm@linux-foundation.org, vvs@virtuozzo.com,
        shakeelb@google.com, christian.brauner@ubuntu.com,
        mkoutny@suse.com, Linux Containers <containers@lists.linux.dev>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri, 19 Nov 2021 11:42:18 -0500
In-Reply-To: <20211119092758.1012073e@gandalf.local.home>
References: <20211118181210.281359-1-y.karadz@gmail.com>
         <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
         <20211118142440.31da20b3@gandalf.local.home>
         <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
         <20211119092758.1012073e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[resend due to header mangling causing loss on the lists]
On Fri, 2021-11-19 at 09:27 -0500, Steven Rostedt wrote:
> On Fri, 19 Nov 2021 07:45:01 -0500
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > On Thu, 2021-11-18 at 14:24 -0500, Steven Rostedt wrote:
> > > On Thu, 18 Nov 2021 12:55:07 -0600
> > > ebiederm@xmission.com (Eric W. Biederman) wrote:
> > >   
> > > > It is not correct to use inode numbers as the actual names for
> > > > namespaces.
> > > > 
> > > > I can not see anything else you can possibly uses as names for
> > > > namespaces.  
> > > 
> > > This is why we used inode numbers.
> > >   
> > > > To allow container migration between machines and similar
> > > > things the you wind up needing a namespace for your names of
> > > > namespaces.  
> > > 
> > > Is this why you say inode numbers are incorrect?  
> > 
> > The problem is you seem to have picked on one orchestration system
> > without considering all the uses of namespaces and how this would
> > impact them.  So let me explain why inode numbers are incorrect and
> > it will possibly illuminate some of the cans of worms you're
> > opening.
> > 
> > We have a container checkpoint/restore system called CRIU that can
> > be used to snapshot the state of a pid subtree and restore it.  It
> > can be used for the entire system or piece of it.  It is also used
> > by some orchestration systems to live migrate containers.  Any
> > property of a container system that has meaning must be saved and
> > restored by CRIU.
> > 
> > The inode number is simply a semi random number assigned to the
> > namespace.  it shows up in /proc/<pid>/ns but nowhere else and
> > isn't used by anything.  When CRIU migrates or restores containers,
> > all the namespaces that compose them get different inode values on
> > the restore.  If you want to make the inode number equivalent to
> > the container name, they'd have to restore to the previous number
> > because you've made it a property of the namespace.  The way
> > everything is set up now, that's just not possible and never will
> > be.  Inode numbers are a 32 bit space and can't be globally
> > unique.  If you want a container name, it will have to be something
> > like a new UUID and that's the first problem you should tackle.
> 
> So everyone seems to be all upset about using inode number. We could
> do what Kirill suggested and just create some random UUID and use
> that. We could have a file in the directory called inode that has the
> inode number (as that's what both docker and podman use to identify
> their containers, and it's nice to have something to map back to
> them).
> 
> On checkpoint restore, only the directories that represent the
> container that migrated matter, so as Kirill said, make sure they get
> the old UUID name, and expose that as the directory.
> 
> If a container is looking at directories of other containers on the
> system, then it gets migrated to another system, it should be treated
> as though those directories were deleted under them.
> 
> I still do not see what the issue is here.

The issue is you're introducing a new core property for namespaces they
didn't have before.  Everyone has different use cases for containers
and we need to make sure the new property works with all of them.

Having a "name" for a namespace has been discussed before which is the
landmine you stepped on when you advocated using the inode number as
the name, because that's already known to be unworkable.

Can we back up and ask what problem you're trying to solve before we
start introducing new objects like namespace name?  The problem
statement just seems to be "Being able to see the structure of the
namespaces can be very useful in the context of the containerized
workloads."  which you later expanded on as "trying to add more
visibility into the working of things like kubernetes".  If you just
want to see the namespace "tree" you can script that (as root) by
matching the process tree and the /proc/<pid>/ns changes without
actually needing to construct it in the kernel.  This can also be done
without introducing the concept of a namespace name.  However, there is
a subtlety of doing this matching in the way I described in that you
don't get proper parenting to the user namespace ownership ... but that
seems to be something you don't want anyway?

James



