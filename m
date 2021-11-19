Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6370F457367
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 17:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhKSQwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 11:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232454AbhKSQwP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:52:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226406112E;
        Fri, 19 Nov 2021 16:49:12 +0000 (UTC)
Date:   Fri, 19 Nov 2021 11:49:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Yordan@web.codeaurora.org, Karadzhov@web.codeaurora.org,
        VMware <" <y.karadz"@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        mingo@redhat.com, hagen@jauu.net, rppt@kernel.org,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        "Linux Containers <containers@lists.linux.dev>" 
        <""@web.codeaurora.org>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Message-ID: <20211119114910.177c80d6@gandalf.local.home>
In-Reply-To: <20211119114736.5d9dcf6c@gandalf.local.home>
References: <20211118181210.281359-1-y.karadz@gmail.com>
        <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
        <20211118142440.31da20b3@gandalf.local.home>
        <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
        <20211119092758.1012073e@gandalf.local.home>
        <f6ca1f5bdb3b516688f291d9685a6a59f49f1393.camel@HansenPartnership.com>
        <20211119114736.5d9dcf6c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 Nov 2021 11:47:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Can we back up and ask what problem you're trying to solve before we
> > start introducing new objects like namespace name?

TL;DR; verison:

We want to be able to install a container on a machine that will let us
view all namespaces currently defined on that machine and which tasks are
associated with them.

That's basically it.

-- Steve
