Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C51649B6AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 15:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580072AbiAYOo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 09:44:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49772 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578687AbiAYOkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:40:24 -0500
Date:   Tue, 25 Jan 2022 15:40:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643121620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxGcF+TkUWCt27KuFgM5m5QlNagJHxzQSviptRLlH2w=;
        b=LZNFEhIRi0fUU/h2KoqXfbVDxx3MXBwyD4mxNSgd0hUn9FwwRdJjDTnUfhRMh2lbjtDZLU
        hGgzFB+kfnfLv3YGvBiwQ9Lh7IsKBSrEMTDZnyR55hT3cEvLRxDhyscipMguiaaF7xVF6d
        +Aymvy7rlXcyfOBJtCvWVn0bKDy87xOrvkkBwPuvHAGWSE4ZzNeq7qQOKlPik3WYFm9rWJ
        QCaTXrNsbzm3RDANWX032IcDf7fjMZD+rTPI7GWBI0kRL1vz93bI0EXtb+cWAxsy/SlgyW
        B2jSV6jxtCaibze4OyQPYN/N2WBN6KaptRtoLi75ZYur4ECYOiPc6uHksZ8wVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643121620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxGcF+TkUWCt27KuFgM5m5QlNagJHxzQSviptRLlH2w=;
        b=ort6qlgi6F9d5XwINlGptYZsqz6LKfWaZ1mJKpvlAQgHw4owSwIjg2HMO6PKK45URTYGbS
        IzOG9VvScNcZ5yBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST] fs/namespace: Boost the mount_lock.lock owner
 instead of spinning on PREEMPT_RT.
Message-ID: <YfAL0tu5P3T8s3rx@linutronix.de>
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

It appears it missed -rc1. Did Al object to it or is this -rc2 material?

> Christian

Sebastian
