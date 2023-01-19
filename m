Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3958C672E6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 02:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjASBsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 20:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjASBps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1A5A817;
        Wed, 18 Jan 2023 17:42:08 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so339369pgr.12;
        Wed, 18 Jan 2023 17:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jTlfNksJalEp/A5sUIxTgRksg/f/RnRMjUOcu8kx0c=;
        b=HhQ0xvQYH31klAmXtATKS3umnYmXZLm1jhsZWhY3zxBGOzV5UvC5+HOPQ74rr4IVdi
         viO/Y5h6rjpyVuXjVmkMpid4adWtXK4TcpYhNdh+uqU61rqAA1IX1TTxWrgFsu0nAjYv
         pEHPxHYljLtPQJXN+O6urbgXNUpZIUh/KPHt2pNpVujsQKrpObeQwaVMOXNVtZ2ZTmgG
         mCabkxYu51M5Et0B+06U98ut2+y9rh+wqmiT9RAjZd/7Qpxgy2qIxFHyXRB0ecZzXka8
         35bnEcCT49LzCAgRfD16Hw63IDP1lVjOfzJsgtTU1yLw/mkfQipeMdguETXNW4GFO4kl
         JyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1jTlfNksJalEp/A5sUIxTgRksg/f/RnRMjUOcu8kx0c=;
        b=hj/c/uBBgfRr0zc4GwkK1M1A6B3nJ1YDJPkxZH1Hej1Z6uiTKarUwx4IycScUhLcEN
         LRBYRYD83/JSg+5trOTMp2rp0zhbtXVf3kbV/cE5x1Z1oaPJrxEog0G+Ype/dchRhKIv
         /25bF1gUUQGwcgqg3OWbJW/Uqf52vzg87QVCpjwefNHh05BnyXvmaFKIRilTID4UE70N
         LcxJ+PTYEG7TTO9+vgWFvbams2zusxVP0+JLlV1zYz2Kk1qveqhh9GVJgE88OelYVzva
         16CE4QEhNrawAE0Z4S5zvK7TSu3nmys7/ZGjgiBGNfvRxWhiIy4Q8FaYIDS8Du9Tgkyi
         7y4Q==
X-Gm-Message-State: AFqh2kp8K6XAbpvyRWHBDAwBoJZ8y1ltY7VV+MgmQGtjZQlSAbiim4Rn
        +sLtuTR04yNg43E7QBL0s2Y=
X-Google-Smtp-Source: AMrXdXvV7ofDOm4aFHya2EIoCDpKJMrm+bHqraoK2hS0COfWYM90GBxg+hCw2OE54Bb8LzJ88DhU0g==
X-Received: by 2002:a62:ab02:0:b0:58d:982a:f1ed with SMTP id p2-20020a62ab02000000b0058d982af1edmr8724476pff.27.1674092528248;
        Wed, 18 Jan 2023 17:42:08 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id z13-20020aa79e4d000000b0058bc1a13ffcsm9337947pfq.25.2023.01.18.17.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 17:42:07 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 19 Jan 2023 11:41:57 +1000
Message-Id: <CPVS9PAXZRPK.3HFH2LTB662XP@bobo>
Subject: Re: Memory transaction instructions
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "David Howells" <dhowells@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Mateusz Guzik" <mjguzik@gmail.com>,
        "linux-arch" <linux-arch@vger.kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>, <tony.luck@intel.com>,
        <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        "Jan Glauber" <jan.glauber@gmail.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.13.0
References: <CAHk-=whjFwzEq0u04=n=t7-kNJdX0HkAOjAMjmLXDDycJ+j9yQ@mail.gmail.com> <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com> <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com> <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo> <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com> <1966767.1673878095@warthog.procyon.org.uk> <2496131.1674032743@warthog.procyon.org.uk>
In-Reply-To: <2496131.1674032743@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed Jan 18, 2023 at 7:05 PM AEST, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > And for the kernel, where we don't have bad locking, and where we
> > actually use fine-grained locks that are _near_ the data that we are
> > locking (the lockref of the dcache is obviously one example of that,
> > but the skbuff queue you mention is almost certainly exactly the same
> > situation): the lock is right by the data that the lock protects, and
> > the "shared lock cacheline" model simply does not work. You'll bounce
> > the data, and most likely you'll also touch the same lock cacheline
> > too.
>
> Yeah.  The reason I was actually wondering about them was if it would be
> possible to avoid the requirement to disable interrupts/softirqs to, say,
> modify the skbuff queue.  On some arches actually disabling irqs is quite=
 a
> heavy operation (I think this is/was true on ppc64, for example; it certa=
inly
> was on frv) and it was necessary to "emulate" the disablement.

Not too bad on modern ppc64. Changing MSR in general has to flush the
pipe and even re-fetch, because it can alter memory translation among
other things, so it was heavy. Everything we support has a lightweight
MSR change that just modifies the interrupt enable bit and only needs
minor serialisation (although we still have that software-irq-disable
thing which avoids the heavy MSR problem on old CPUs).

Thanks,
Nick
