Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2F41C396
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 13:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbhI2LpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 07:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhI2LpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:45:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C7C06161C;
        Wed, 29 Sep 2021 04:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KZ+E5oLWKLFJuTU5cjsoTqwki26dY/76dJGUFcLVMr0=; b=F9oHWZHp+ANB74Bdvmb61IHqGM
        lVKUQ77K30NvjSxDEmcy7FNyL/lmVrziueVtRSjjIYMC1/6LhovsbjtcJ6zA3JzmU6BB6BfQhL2tP
        ZKhRYkZNacOHaXjFAgwnwbfZ7j+m7iW+sa5QoFbXdVwbB817JSVnJFEqU7Ax8Zn6QbkurF8fRceJk
        wcP/n1CAjN+HwMDWiQwxjXExlrGAFBCyX8XAx2fqBVSibrpwRroXB2eYyQCN5AJfPogBBNrSkEz87
        xEDJf/GUKCa0MqQPB1J1zOqDG6Ehjil3VoXXw2aer3JZzGZV+BcoF15O+yexOV0XlpW3e3dqQpClD
        m7be70jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVXzg-006hZh-4W; Wed, 29 Sep 2021 11:43:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3001300056;
        Wed, 29 Sep 2021 13:43:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 754302C905DB5; Wed, 29 Sep 2021 13:43:23 +0200 (CEST)
Date:   Wed, 29 Sep 2021 13:43:23 +0200
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
Message-ID: <YVRRWzXqhMIpwelm@hirez.programming.kicks-ass.net>
References: <CACT4Y+ZjRgb57EV6mvC-bVK0uT0aPXUjtZJabuWasYcshKNcgw@mail.gmail.com>
 <20210927170122.GA9201@C02TD0UTHF1T.local>
 <20210927171812.GB9201@C02TD0UTHF1T.local>
 <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
 <20210928103543.GF1924@C02TD0UTHF1T.local>
 <20210929013637.bcarm56e4mqo3ndt@treble>
 <YVQYQzP/vqNWm/hO@hirez.programming.kicks-ass.net>
 <20210929085035.GA33284@C02TD0UTHF1T.local>
 <YVQ5F9aT7oSEKenh@hirez.programming.kicks-ass.net>
 <20210929103730.GC33284@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929103730.GC33284@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:37:30AM +0100, Mark Rutland wrote:

> > This is because _ASM_EXTABLE only generates data for another section.
> > There doesn't need to be code continuity between these two asm
> > statements.
> 
> I think you've missed my point. It doesn't matter that the
> asm_volatile_goto() doesn't contain code, and this is solely about the
> *state* expected at entry/exit from each asm block being different.

Urgh.. indeed :/
