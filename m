Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2834ADAD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 15:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377752AbiBHOH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 09:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376619AbiBHOH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:07:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE52C03FED3
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Feb 2022 06:07:57 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:07:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644329274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4sZyqTXpyRYIpR/R3m9NusNrOJFlpvhcHq1ZL9AY5j0=;
        b=WWfsKanHrblCjIj3dCzvRZJ4ZE5jz584PnY+eum7hwxCp2+0vwPcg2mI8WJZ+aNdjUfNwJ
        SIiDIoKt5xKuVaa1va2pnfcpNQtL6Cl+kiJ2TeLwcVmUfrAr1WAlK9XXyyvp2/AtjUHwf5
        l7fQmroUgPiNdZK4s9YmrNU24/7tzb3gAEV97JPRfGKqphfL5mlRfa/nwmw5gPzQH1F4SY
        1eNbYgEB/c8PbXfuTiB+Wk9sUJtAkizkRwwh3cfmusA85Muz+cxg+y3uFAxtx1H/LJOWQo
        TktqJgHkrBxfhh9D7ITyaS6EEsGxjhpb7uTl9F+hEsKc5emonWf0WO3OyBsE2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644329274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4sZyqTXpyRYIpR/R3m9NusNrOJFlpvhcHq1ZL9AY5j0=;
        b=WzkounVvVrphU5Equ44PtwtUnfUDer9jhu1vOHoR4Xn7ZHmeC9/XCRueX+mLjtkJAUJGXx
        foYP/obGcIBU7uDg==
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
Message-ID: <YgJ5OHXAgIdQiozZ@linutronix.de>
References: <20211125120711.dgbsienyrsxfzpoi@linutronix.de>
 <20211126132414.aunpl5gfbju6ajtn@wittgenstein>
 <YfAL0tu5P3T8s3rx@linutronix.de>
 <20220125154937.zgmoybslcevaej5t@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125154937.zgmoybslcevaej5t@wittgenstein>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-01-25 16:49:37 [+0100], Christian Brauner wrote:
> I didn't hear him object. I have it sitting in a separate tree [1] ready
> to be sent. If I don't hear anything by the end of this week I'll send it!

No complains so far, I guess? ;)

> Christian

Sebastian
