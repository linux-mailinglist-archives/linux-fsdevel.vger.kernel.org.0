Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D995166D583
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 06:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjAQFH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 00:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjAQFHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:07:25 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD362364C
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 21:07:22 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-12c8312131fso30928346fac.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 21:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.cerritos.edu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NgVausdspYukLacvT7y7EQmOSIak0Pd9m2HmzLg0gEg=;
        b=cCRdYxiPpkeWtmdSKFpTlKkHNSEVPfPGgsrIiW5COQ4yIhstQoOEVSteJYkp+E04E2
         iq/6S6Mf97hTGroJiwQ/XAqjSPRhglC8g5GZMGaoGR06h8lgFXgijBJTrwXq/4CT/7Do
         rWVpGmk5ngArqFNJg5rugjhH5nlJnHhSp3Pck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgVausdspYukLacvT7y7EQmOSIak0Pd9m2HmzLg0gEg=;
        b=p89Rhdjcds/leP3FthWTN0h8PTEzIz5ohF2fD549/5GEsSCxvikgSh4XpClGHBKDus
         HxKdsfnEjEa/EGQA/VXqwD6sGJOscsOgoCkXLXjf3MuvY72emIYKBpJLrgddDpH6hvvI
         2f5JQAGXvRW/28C0mbEDpi3Xxbm+uV42o7Of6VSwH44++MX/ekSwH+KXTOcwqkL2ui2c
         yhK280+/VXcZXJUdXs9xR/8wfQ5g+r46bynoFGpWXexTRTUJtGt7Ozv2ZF7CexEFaOcQ
         coMQziTLfqOuZYSMveztraThrBz7rgQ5zW1QUYGem6veytYL1RscHtW89CqDNHF3YP4X
         lp3g==
X-Gm-Message-State: AFqh2koQ1PuYXbBaw4//F9vUEmqSGH73av4nqjWg7WBI5Ko7XR5oQye8
        +QQfFkMItU5YdInrtwF5JRm77XjXMst3sEBS1TDAjw==
X-Google-Smtp-Source: AMrXdXvdmjSGckrI0EKh6un4aaaMFBKvJmmn4tCr154MOcuD9sOO+S06Ct5JEDEoikdBuU8vvdiFc0bwleP1rjXkvlI=
X-Received: by 2002:a05:6870:4949:b0:144:8d99:ef86 with SMTP id
 fl9-20020a056870494900b001448d99ef86mr189479oab.254.1673932042042; Mon, 16
 Jan 2023 21:07:22 -0800 (PST)
MIME-Version: 1.0
References: <CAPOgqxF_xEgKspetRJ=wq1_qSG3h8mkyXC58TXkUvx0agzEm_A@mail.gmail.com>
 <Y8YK4c6KQg2xjM+E@casper.infradead.org>
In-Reply-To: <Y8YK4c6KQg2xjM+E@casper.infradead.org>
From:   Amy Parker <apark0006@student.cerritos.edu>
Date:   Mon, 16 Jan 2023 21:07:23 -0800
Message-ID: <CAPOgqxEYzDkfX9re+yZry4BNV8PGAd_G-qsWdpePAOC4dNcAgQ@mail.gmail.com>
Subject: Re: [PATCH] dax: use switch statement over chained ifs
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 6:41 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> CAUTION: This email originated from outside your organization. Exercise caution when opening attachments or clicking links, especially from unknown senders.
>
> On Mon, Jan 16, 2023 at 06:11:00PM -0800, Amy Parker wrote:
> > This patch uses a switch statement for pe_order, which improves
> > readability and on some platforms may minorly improve performance. It
> > also, to improve readability, recognizes that `PAGE_SHIFT - PAGE_SHIFT' is
> > a constant, and uses 0 in its place instead.
> >
> > Signed-off-by: Amy Parker <apark0006@student.cerritos.edu>
>
> Hi Amy,
>
> Thanks for the patch!  Two problems.  First, your mailer seems to have
> mangled the patch; in my tree these are tab indents, and the patch has
> arrived with four-space indents, so it can't be applied.

Ah, gotcha. Next time I'll just use git send-email, was hoping this
time I'd be able to use my normal mailing system directly. (Also
hoping my mail server isn't applying anything outgoing that messes it
up... should probably check on that)

> The second problem is that this function should simply not exist.
> I forget how we ended up with enum page_entry_size, but elsewhere
> we simply pass 'order' around.  So what I'd really like to see is
> a patch series that eliminates page_entry_size everywhere.

Hmm, alright... I'm not really familiar with the enum/how it's used, I
pretty much just added this as a cleanup. If you've got any
information on it so I know how to actually work with it, that'd be
great!

> I can outline a way to do that in individual patches if that would be
> helpful.

Alright - although, would it actually need to be individual patches?
I'm not 100% sure whether the page_entry_size used across the kernel
is the same enum or different enums, my guess looking at the grep
context summary is that they are the same, but the number of usages (I
count 18) should fit in a single patch just fine...
