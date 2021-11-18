Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E0456311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 20:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhKRTFP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 14:05:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhKRTFO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:05:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA1C611F2;
        Thu, 18 Nov 2021 19:02:12 +0000 (UTC)
Date:   Thu, 18 Nov 2021 14:02:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     "Yordan Karadzhov \(VMware\)" <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        Linux Containers <containers@lists.linux.dev>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Message-ID: <20211118140211.7d7673fb@gandalf.local.home>
In-Reply-To: <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
References: <20211118181210.281359-1-y.karadz@gmail.com>
        <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Nov 2021 12:55:07 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Eric

Eric, 

As you can see, the subject says "Proof-of-Concept" and every patch in the
the series says "RFC". All you did was point out problems with no help in
fixing those problems, and then gave a nasty Nacked-by before it even got
into a conversation.

From this response, I have to say:

  It is not correct to nack a proof of concept that is asking for
  discussion.

So, I nack your nack, because it's way to early to nack this.

-- Steve
