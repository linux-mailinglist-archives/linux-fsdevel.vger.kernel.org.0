Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E940B47F98A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 01:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhL0AUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 19:20:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35780 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhL0AUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 19:20:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA61CB80E60;
        Mon, 27 Dec 2021 00:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC51C36AE9;
        Mon, 27 Dec 2021 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1640564431;
        bh=dz0d7VtRMAKNb+Cz150JnO93L9QGOb0RAcPA2AMg2H0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rS2fWUtoqFgTV1/rXQfhsYpsSQthWzhCJOIXEP+rx2AKAAgCn/VMeOjKNXQfrk0fP
         NOAqxBBJWWI+QbPplXYn0zTr7SUCdr9MqJBiuHhtmMWHj/BoCdnRc2qhzhEuBXT1fx
         xsjC4BdURlu9nFcOMeDTcGGu+X9a6UrwAeJ/TJKA=
Date:   Sun, 26 Dec 2021 16:20:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Gregor Beck <gregor.beck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH REPOST REPOST v2] fscache: Use only one
 fscache_object_cong_wait.
Message-Id: <20211226162030.fc5340c2278c95342690467d@linux-foundation.org>
In-Reply-To: <YcS8rc64cVIckeW0@linutronix.de>
References: <20211223163500.2625491-1-bigeasy@linutronix.de>
        <901885.1640279829@warthog.procyon.org.uk>
        <YcS8rc64cVIckeW0@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Dec 2021 19:15:09 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2021-12-23 17:17:09 [+0000], David Howells wrote:
> > Thanks, but this is gone in the upcoming fscache rewrite.  I'm hoping that
> > will get in the next merge window.
> 
> Yes, I noticed that. What about current tree, v5.16-rc6 and less?
> Shouldn't this be addressed?

If the bug is serious enough to justify a -stable backport then yes, we
should merge a fix such as this ahead of the fscache rewrite, so we
have something suitable for backporting.

Is the bug serious enough?

Or is the bug in a not-yet-noticed state?  In other words, is it
possible that four years from now, someone will hit this bug in a
5.15-based kernel and will then wish we'd backported a fix?

