Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5281223A7DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHCNmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgHCNmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:42:03 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854FDC06174A;
        Mon,  3 Aug 2020 06:42:03 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z22so2660754oid.1;
        Mon, 03 Aug 2020 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=n1O9BpBkGKm0Dn1d9dK+DgN04J7paPhI+arHj4RxQqc=;
        b=BzpkbIFAc7As9Wym8RKGqk6I4F1OJEEtLMtRyBlh3IoB7rJNlIT1odIF3gRrxit8qx
         EwcUmL+FGwcYKufF3XqRap+T6SRfHWDIc6vVpon7z4O/24jfujo2nrxRPCqaBQqQmDWG
         21l6Cx/kZTiUQxDod1FFaLNpAYrg8RimD+3dp4Vpt577FqGNpy5pvEgDJ+8NNnJ6n5M5
         SRa/DP/UjKBJZJKZspg3/M+cQWJQj0x9DpBLvShILLdzcR88gCRsT/an6BPdEVvwfleL
         bBBdV5B73iquzgbAMHUo2bjHIoIee1a17Bn+DSpbtlwXci3SGFsvgzaTGje5KOn/bl/7
         kTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=n1O9BpBkGKm0Dn1d9dK+DgN04J7paPhI+arHj4RxQqc=;
        b=mbY+qt0Y0VMs9MQ5ljdR4n6dPE2Kw5C/wjhgh9Giq8RYSCRb60SxhsDiljE9czpRxO
         NE2uDDhswh9eL7kjlEiMHduO8iArIj1VDJckmvpp//0XOPe6IHQN199oe6SvjzAI8LYN
         sufx6Ue0x3xvq3oOm/cL05IzSz1D/XsYx7+YSY+my0AOpMl9A2Rad8nJynfJ+9KAOouG
         s2mOtfTt7Lr5ouXRQQVtnAGLzw/mv/wR108Ls3Mahqb3slWHMg6rAFTFbMDecaAyqySw
         zVNfBQETfrl56sCECx/pFqE2wh0RMCxLQrR5bCSQmC8Kzxbrga7Qk7z3iwaGChjqcDXi
         aIgw==
X-Gm-Message-State: AOAM532V8x4YgYdVyG3HQsw8l6HIWmow5yBsG6CVc/AoT8c+Gd1Qi8xe
        EIavaz9VhRQC4EdqP6rIi9sntDsArPM8TdxkYAc=
X-Google-Smtp-Source: ABdhPJy2s7JnnAMZg+Xjgd7o2046/kvLCZ5lfDdRATFloMgGUURRfOJSzm3J9BVGqcakar8pvBhf+VKMRGJfuuONzlk=
X-Received: by 2002:a05:6808:b36:: with SMTP id t22mr12769611oij.159.1596462118081;
 Mon, 03 Aug 2020 06:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjyXcXZkEczRz2yvJRFBy2zAwTaNfyiSmskAFWN_3uY1g@mail.gmail.com>
 <2007335.1595587534@warthog.procyon.org.uk>
In-Reply-To: <2007335.1595587534@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 3 Aug 2020 15:41:46 +0200
Message-ID: <CAKgNAkgYZ4HrFpOW_n8BshbR8d=03wetmxX2zNv7hX4ZmeQPmg@mail.gmail.com>
Subject: Re: Mount API manual pages
To:     David Howells <dhowells@redhat.com>
Cc:     Petr Vorel <pvorel@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 24 Jul 2020 at 12:45, David Howells <dhowells@redhat.com> wrote:
>
> Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
>
> > Would you be willing to do the following please:
> >
> > 1. Review the pages that you already wrote to see what needs to be
> > updated. (I did take a look at some of those pages a while back, and
> > some pieces--I don't recall the details--were out of sync with the
> > implementation.)
> >
> > 2. Resend the pages, one patch per page.
> >
> > 3. Please CC linux-man@, linux-api@, linux-kernel@, and the folk in CC
> > on this message.
>
> For this week and next, I have an online language course taking up 8-10 hours
> a day.  I'll pick it up in August, if that's okay with you.

Hi David,

This is just a reminder mail :-).

Cheers,

Michael



--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
