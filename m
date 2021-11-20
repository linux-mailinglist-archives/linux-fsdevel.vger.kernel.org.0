Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925E04579FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 01:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhKTAKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 19:10:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236230AbhKTAKu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 19:10:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A0E61ACE;
        Sat, 20 Nov 2021 00:07:47 +0000 (UTC)
Date:   Fri, 19 Nov 2021 19:07:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Yordan Karadzhov <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, akpm@linux-foundation.org, vvs@virtuozzo.com,
        shakeelb@google.com, christian.brauner@ubuntu.com,
        mkoutny@suse.com, Linux Containers <containers@lists.linux.dev>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Message-ID: <20211119190745.3b706c4b@gandalf.local.home>
In-Reply-To: <f141c401560d90a546968514c6cfc63d7fdb8e00.camel@HansenPartnership.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
        <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
        <20211118142440.31da20b3@gandalf.local.home>
        <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
        <20211119092758.1012073e@gandalf.local.home>
        <47bf8da26b5ec71f98b9bc736dbca2d8277417f2.camel@HansenPartnership.com>
        <de336e53-68e1-1d4b-7f71-e276b5363b7c@gmail.com>
        <f141c401560d90a546968514c6cfc63d7fdb8e00.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 Nov 2021 18:22:55 -0500
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> But I could write a script or a tool to gather all the information
> without this filesystem.  The namespace tree can be reconstructed by
> anything that can view the process tree and the /proc/<pid>/ns
> directory.

So basically you're stating that we could build the same thing that the
namespacefs would give us from inside a privileged container that had
access to the system procfs?

-- Steve
