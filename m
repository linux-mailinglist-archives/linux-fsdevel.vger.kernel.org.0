Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C817B45F003
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377794AbhKZOlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 09:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377815AbhKZOjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:39:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE54DC061A13
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Nov 2021 06:04:46 -0800 (PST)
Date:   Fri, 26 Nov 2021 15:04:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637935484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y82s6+Tiy9sz6b6tncCRJcNlNgUXJUHvcl+BFqtRUFY=;
        b=2Kshjb5DD42UQaYCk3s4p2jYpeH82aPQlh6rmv6laXK68/4RyF6vlQ6g2pkcNCBze4IP78
        p1oQBrooqLTiRRLh1tFyvK5eh6NYwVsKFMPjgG8znCUv/L3w6dCao71nt2PXF2KW9vm7XV
        g5QNVocbzK2uzu00uBVjaX+g9ic8DRPxaZCygJdNth0ME7jpjYcGZLuUNUONDsZLHgBvKP
        7HSfsy7LI1fcwJcZOJbJzOJ8hENIoRjFXPPPOby7QZPtIslqjHmJ7wCsOPTlguMo5lrACr
        yZf0R2AnY+j1+NDAmDK4aSMdQfTafv+DbohKcusrvE9hlmQ8eQJu/ALjUMvNgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637935484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y82s6+Tiy9sz6b6tncCRJcNlNgUXJUHvcl+BFqtRUFY=;
        b=zvMRj7EJmIQIpz7ERZaq94NJOXmNhzwQWktD7bh5B4IgR1BvbMBaOrBRkurrQa1SfE5Hu2
        YEneJyF4Huz4oiAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST] fs/namespace: Boost the mount_lock.lock owner
 instead of spinning on PREEMPT_RT.
Message-ID: <20211126140443.6yyt5hpo24cf7buu@linutronix.de>
References: <20211125120711.dgbsienyrsxfzpoi@linutronix.de>
 <20211126132414.aunpl5gfbju6ajtn@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211126132414.aunpl5gfbju6ajtn@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-11-26 14:24:14 [+0100], Christian Brauner wrote:
> I thought you'd carry this in -rt, Sebastian and Thomas. So I've picked
> this up and moved this into -next as we want it there soon so it can sit
> there for as long as possible. I'll drop it if Al objects to the patch
> or prefers to carry it.

Thanks.

> Christian

Sebastian
