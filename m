Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99927AFB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgI1OJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 10:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgI1OJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:09:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BC3C061755;
        Mon, 28 Sep 2020 07:09:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601302155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L54CoEWBVUEoUgztDt/fYNcIrindjGfPg4BQ9nlbPQo=;
        b=VmyQ/I6TAsPuwzLBO6cfGye6Wn8MjHGHtWSifSjlyyS/R7oMk2CUHj5jdOFtvGazuZC7Nf
        Cc2js+/3MKg0e2OjeQnO9igShic/Qa/MtBotcz5exYr6KSGq0I37WOv96B0mAErsWpAbm7
        THIKjrKqE0wRl7ez5BhNQi+nr3gKIchVhnRnwwvgyLYrb3zhs5ipvymvTf9EH+Ti+mfo4t
        ZniajsbINh8qmlPXwlJMggFEiuCtdMykpg3uyK5oO7sK49FKaA3SQcIkwWPcTsTPVLA7iL
        ZYh6fGmh4dPdip6tKT+pw+H//s4JrW+VkvErKjlNSONadvHOBGdvTHccU9Iyow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601302155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L54CoEWBVUEoUgztDt/fYNcIrindjGfPg4BQ9nlbPQo=;
        b=araDj3lJgWWBYqYuu6vxXooeGxxvWeo4wwx8v/QShwQYym4CotMKDeQPI9yzBzbGrldE8O
        lmeL4Vli8hz32qBA==
To:     Tom Hromatka <tom.hromatka@oracle.com>
Cc:     mingo@kernel.org, fweisbec@gmail.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] /proc/stat: Simplify iowait and idle calculations when cpu is offline
In-Reply-To: <061c43fb-5f0d-4d4f-85ca-5fff2ef6f4db@default>
References: <061c43fb-5f0d-4d4f-85ca-5fff2ef6f4db@default>
Date:   Mon, 28 Sep 2020 16:09:15 +0200
Message-ID: <873632kn78.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tom,

On Sun, Sep 27 2020 at 19:59, Tom Hromatka wrote:

> My sincere apologies.  2020 has been a challenging year for
> my family and me, and I readily admit that I have struggled
> with all of the added stress.  I realize and acknowledge that
> this is not an acceptable excuse for a patchset that doesn't
> hold up to the kernel or my standards.

don't worry. We all have periods where we are not up to the task. Take
your time!

Thanks,

        Thomas
