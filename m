Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BD322C3A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGXKtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 06:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGXKtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:49:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81847C0619D3;
        Fri, 24 Jul 2020 03:49:03 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r8so7665658oij.5;
        Fri, 24 Jul 2020 03:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=umNG0bCwzsY56yb8Lvp7QR76/+OQaJlUV4OImgDt+Z8=;
        b=pU9BJm7J+II6zNxN4UvCGVQoQIJJwXLUp6PLXWSN2Y0ddExpq0fOAWQpMOu68Q0YNY
         8NVPUCPfPuJgdJIWLc5CgUd/RhP97I8HnU0+hgCi3nxPjsXTNIBWH0PD4mq6spCdoV99
         Tok/wB6/xw+BC7bEo3tnZtR5HSmA4bjc8B+LIsC99bIbeio5l6+EeYmk5U2gL6m8Lj6n
         DaBvDdhS2J46gUV66G1WaYxwNiONLZcg4WrtsOr/61TbUmkTahApBRgxLc+BrWWxXk9u
         T+xUxmm46qKZ1XmeQGR3y0oMRtF2jB25XPHhTR4upyJPsvikQ5kNLpCWsy8KFpvq2KWW
         qhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=umNG0bCwzsY56yb8Lvp7QR76/+OQaJlUV4OImgDt+Z8=;
        b=MU8VpeokmvcqlCqsPnZBv/Boa/JtgmW+4pu3B5npU/XWdJg79xSn1YR25IjQDCOMf0
         5YPLrgVhXeQ+BvG6rHssj8KXmVnhoTKtc0uKCbtydTlJdb++eC7hHV9hthtZMNqY9v0n
         0Qlt0XvmpbOnzMIoxpHAxC2eSgq/jjIC2I0oU1Vg4b44LVADBsbS7kmT/vK0w62OlEgM
         P78l0+XQE1rYpCij9J2a0dhRv7116kGy5kaiGI0L7t36kUU/dWY8mzyVhkH5i7w1yEGa
         jW77gCPtgsA/1mqdgXlp/ap+AfWc+cn12XeoGwEapgAhn2HYmMSpkl9Ja5gYYeGFYuyr
         0Ubg==
X-Gm-Message-State: AOAM531MIDpfg1cbI5/w5Ut0x636TOV5yMNSajWb28VEGg1JtYO56BSu
        RFV9pFDiaB8SdTBVz6t/Ca/mTNcGP91QKOgjFvs=
X-Google-Smtp-Source: ABdhPJza2qNxYJ/DLBVTEYPYOAuuHzbhjzvO5vCZv/Ja89JofeWChcyZUVny91MeCnYRr8rsTEYs+fkAUeKUyaLPd2g=
X-Received: by 2002:aca:5683:: with SMTP id k125mr7561380oib.159.1595587742937;
 Fri, 24 Jul 2020 03:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjyXcXZkEczRz2yvJRFBy2zAwTaNfyiSmskAFWN_3uY1g@mail.gmail.com>
 <2007335.1595587534@warthog.procyon.org.uk>
In-Reply-To: <2007335.1595587534@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 24 Jul 2020 12:48:51 +0200
Message-ID: <CAKgNAkgJqGEZsD0UJKcuB_11gFW+zRp-jDbVCB2F1iVMKgHwMg@mail.gmail.com>
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

Okay -- enjoy the course!  I'll ping again in a couple of weeks.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
