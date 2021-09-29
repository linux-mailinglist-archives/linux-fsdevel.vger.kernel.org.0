Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B041C230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbhI2KDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbhI2KDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:03:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F91C06161C;
        Wed, 29 Sep 2021 03:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y/myciqa/Ii7kvQkDckQ0UnF342MIwILYQStokAXlmk=; b=Ap1iixLQB+oxVlqgXgINkzdr20
        SaXiRwb42MeC84kvZqqpWg8wVxSk+JRxrUx4dZCyMO92h+r/76LCYH7ksq4/DDTojdIBPJgQJIfM2
        no+6xg5HiSXno/JHm5PZQJbpDWxa4XRRQC7rqWqZK5KzRA6yadi1KuZQMSJRKnGosMmA47J4qEnuG
        RvL/2V0eDkwdN7K2DXfp/q4GTCNVKPiMizvxyeu+wQvVmeelUom7G5aS3u+YZAQ2VbtSYkwFduwDL
        lrxgn55TgBQjtQK3UrchFF1wiqBQf2CHz/h7BPHP3zeuy3gNPTF4KAbpAFChYDpCiwKrIYQ5DW+aA
        hej3ItRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVWNU-00Bi8j-H6; Wed, 29 Sep 2021 10:00:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12908300056;
        Wed, 29 Sep 2021 11:59:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1B5D2DC92D0B; Wed, 29 Sep 2021 11:59:51 +0200 (CEST)
Date:   Wed, 29 Sep 2021 11:59:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org, x86@kernel.org
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <YVQ5F9aT7oSEKenh@hirez.programming.kicks-ass.net>
References: <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
 <20210921165134.GE35846@C02TD0UTHF1T.local>
 <CACT4Y+ZjRgb57EV6mvC-bVK0uT0aPXUjtZJabuWasYcshKNcgw@mail.gmail.com>
 <20210927170122.GA9201@C02TD0UTHF1T.local>
 <20210927171812.GB9201@C02TD0UTHF1T.local>
 <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
 <20210928103543.GF1924@C02TD0UTHF1T.local>
 <20210929013637.bcarm56e4mqo3ndt@treble>
 <YVQYQzP/vqNWm/hO@hirez.programming.kicks-ass.net>
 <20210929085035.GA33284@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929085035.GA33284@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:50:45AM +0100, Mark Rutland wrote:
> On Wed, Sep 29, 2021 at 09:39:47AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 28, 2021 at 06:36:37PM -0700, Josh Poimboeuf wrote:

> > > +	asm volatile("417: rdmsr\n"
> > > +		     : EAX_EDX_RET(val, low, high)
> > > +		     : "c" (msr));
> > > +	asm_volatile_goto(_ASM_EXTABLE(417b, %l[Efault]) :::: Efault);
> > 
> > That's terrible :-) Could probably do with a comment, but might just
> > work..
> 
> The compiler is well within its rights to spill/restore/copy/shuffle
> registers or modify memory between the two asm blocks (which it's liable
> to do that when optimizing this after a few layers of inlining), and
> skipping that would cause all sorts of undefined behaviour.

Ah, but in this case it'll work irrespective of that (which is why we
needs a comment!).

This is because _ASM_EXTABLE only generates data for another section.
There doesn't need to be code continuity between these two asm
statements.

As I said, this is terrible :-)
