Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0610D49B938
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 17:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585763AbiAYQuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 11:50:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586093AbiAYQq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:46:59 -0500
Date:   Tue, 25 Jan 2022 17:46:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643129216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iondWTXrYojd6ORptZ88IRD2n3NBuDO7jh+MjTLhrG0=;
        b=GXJyM8bk1G7mwMXSTUv6n1Q8kI9wIXQY6ZPdyUWAO+a4SItNWSGK0R4KugirzSy2rgcZj/
        C8+BtY23Iwkhs1t2va+YZcwTJKk+7eCkfbRDhumYdrknZZ10HKuYRWa9vYRCUTnc2gZbKs
        Km76HUJLxgH1SDBw3WBIrcLQyr3pSdFBPCWlgR3Ih0ccwmEWMxY15bnsL1Tyi3CTHA2O69
        pabmbP99+m6iLIKnOUn4bw4hpmT/s4p/cbP13CYIE3Qv5/RftESVsm8/3TQ6n7cgPlouMW
        J9p/N7FYU61/ZLUsHbDRrerawqRab8t6KqjTjasBUDXbIqBELIstdLBYbus2uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643129216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iondWTXrYojd6ORptZ88IRD2n3NBuDO7jh+MjTLhrG0=;
        b=VJYKSvqKTp2fc/93H0vL0ipcE3o74qPKeJj3+oP9ELWMS0xp8F2CbFYFq5WxMdxavtvitx
        7l+N4DptKjZaNmBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST] fs/namespace: Boost the mount_lock.lock owner
 instead of spinning on PREEMPT_RT.
Message-ID: <YfApfnalZeWaybRv@linutronix.de>
References: <20211125120711.dgbsienyrsxfzpoi@linutronix.de>
 <20211126132414.aunpl5gfbju6ajtn@wittgenstein>
 <YfAL0tu5P3T8s3rx@linutronix.de>
 <20220125154937.zgmoybslcevaej5t@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125154937.zgmoybslcevaej5t@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-01-25 16:49:37 [+0100], Christian Brauner wrote:
> I didn't hear him object. I have it sitting in a separate tree [1] ready
> to be sent. If I don't hear anything by the end of this week I'll send it!

Thank you.

> Christian

Sebastian
