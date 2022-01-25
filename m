Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CC849B7FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 16:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347067AbiAYPwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 10:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582554AbiAYPtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:49:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BCEC061772
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 07:49:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1C09B818B5
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 15:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC63EC340E0;
        Tue, 25 Jan 2022 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643125781;
        bh=MrV0XALfubzqw8zqQH200sR4UczH9cFZmqg8y2RFcyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hD5hVpn3CgtrkVynf9kERr2ECCVo7HQNHEmVxai4B0Vxp9QARm9Nr4HNpB129htAD
         1uPf8B9iY5eKC2FDrBoFS/Z6xd9J5ThKFSlvm3ATBr8pWk0MtU1NqaANCE8ktz1gi+
         6Z1FXt6hfBSMA80sj9Eh9KiIjirNTIIIMCQJMlaEWX1wYgp5AsodT8lb54hNdEZ3Rd
         IT83prAQD1hGvvARfOsswdE06hL94XmcvzPF28uycgulWe8gZsySlHyvfGTvRr1qYn
         A/FhiUp/7w5kHRKgfDTtnNeFCQN/nmcM0uAHQcod1jG+594MHpzJ5UYpDfTjINhGgd
         9+gJB0EhrBNUA==
Date:   Tue, 25 Jan 2022 16:49:37 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST] fs/namespace: Boost the mount_lock.lock owner
 instead of spinning on PREEMPT_RT.
Message-ID: <20220125154937.zgmoybslcevaej5t@wittgenstein>
References: <20211125120711.dgbsienyrsxfzpoi@linutronix.de>
 <20211126132414.aunpl5gfbju6ajtn@wittgenstein>
 <YfAL0tu5P3T8s3rx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfAL0tu5P3T8s3rx@linutronix.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 03:40:18PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-11-26 14:24:14 [+0100], Christian Brauner wrote:
> > I thought you'd carry this in -rt, Sebastian and Thomas. So I've picked
> > this up and moved this into -next as we want it there soon so it can sit
> > there for as long as possible. I'll drop it if Al objects to the patch
> > or prefers to carry it.
> 
> It appears it missed -rc1. Did Al object to it or is this -rc2 material?

I didn't hear him object. I have it sitting in a separate tree [1] ready
to be sent. If I don't hear anything by the end of this week I'll send it!

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fs.fixes

Christian
