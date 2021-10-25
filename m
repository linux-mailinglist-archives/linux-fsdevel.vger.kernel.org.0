Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF2439230
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhJYJXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 05:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhJYJXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:23:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A8C061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 02:20:48 -0700 (PDT)
Date:   Mon, 25 Oct 2021 11:20:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635153647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMalYUie8dVY09MQ3yMkoxPY0K+Ym8Kmq8sBXL/1LmE=;
        b=hDFfn6v3xn+wGLuIRVC0dHGzfax9x7MXnB0INe83HRWqjwpgge3FFM2vxRqpeGFIBlC0Db
        ZilNG1uXCKYRHe7aHnDZVEXPrlkyMFwbZVUGjfnfn2f+Wq1uwQ4DD2LlmwYYXVy/u2eGdS
        G3GgFqmXrYUEXoz4bjJC9RlXy8es6OMQUZNXE1yLJJ5B6sr1yYV7yAG0ziS3hYVg7Wu0EL
        ktIW7VOyl9KfYbOPrLOZZleDdDtxr5IPAkpgM+epAUZBTnaP7ANADUabk+qsiCee+fDKFM
        +oC5wSLVXKT7HHJKenIcTI0xTGZ5SayeaOtY7VZX6EGc1e4NuaX/Xfge7pUXWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635153647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMalYUie8dVY09MQ3yMkoxPY0K+Ym8Kmq8sBXL/1LmE=;
        b=ZBk0fV0ppzRNH1vkQGgLqZraF7dQQnicP6pUXNt+D83ZpKdPYdkc+S2EL+ACcTwc9R6BI8
        4C5aPZAkuYSu73CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] fs/namespace: use percpu_rw_semaphore for writer
 holding
Message-ID: <20211025092045.rx5fe6uipzlq554d@linutronix.de>
References: <20211021220102.bm5bvldjtzsabbfn@linutronix.de>
 <20211025091504.6k7d57awbfpqmmqs@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211025091504.6k7d57awbfpqmmqs@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-10-25 11:15:04 [+0200], Christian Brauner wrote:
> 
> So the locking would be unchanged on non-rt kernels and only change on
> rt kernels? Would be ok to send that patch for comparison if it's not
> too much work?

Yes. I will drop a patch likely today as this is the only solution I
have right now (based on the brain dump).

> Christian

Sebastian
