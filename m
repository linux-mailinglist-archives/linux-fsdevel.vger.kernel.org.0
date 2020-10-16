Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0D290B42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 20:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391675AbgJPSZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391640AbgJPSZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:25:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DBAC061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 11:25:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m16so3508936ljo.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVhhuBbfLfLYQkngLsFD3UUt9rOgtrwkRBlITbSg1HA=;
        b=TuiG8BFDTqK33IsdvgsRzNjznNYhEPcEgZFtMZZjFXUvdEnKTK4CAvhFDpeWkfixSk
         PzmIe02r8wdxJIriM9RvsAEtD1V1EB7cQ4vXwojwGXrW9atpUOegVSWIg31NFsMHC/as
         MGmSGZm4CYtxH+Ah7sO9FCAths+ONkR8lo9xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVhhuBbfLfLYQkngLsFD3UUt9rOgtrwkRBlITbSg1HA=;
        b=W3ww+P+0aBwx76rDjYR7z4YKeVafOWPpx4s7VvV8wO4ch7Z67szJwWH6cwen8xry/b
         cyeqhXmNF3CJeQJ9+sreoTdJFR2z5XI6vrlpAhYMSCLKWw7zeqqUZAwX5jHfL1yyVdqt
         tMkMD1e9G4sLt4a/FdwcKA4z2uVAKkvo/P55ziiZP2axauvaM5ydKVGkTifEPxUeFEoo
         NQwwlFlvUt9l3iD0CJI0Sl0Y/XFdNxr1myQu7lqNmeLbQJqwF9KVC8wxCnrwf4IFmG82
         7YC0djiNG1I7ugRd8HrpiXwYcRGPR64u4UqYUmx6q25eqyeP/X6Afuq8DlqfZdB5KCnC
         Gy4A==
X-Gm-Message-State: AOAM53022o6M0Gk4/rT52RYD/5CDr48vplWr0XhbUp/RwX5PoMD0mX+b
        ZHIyvNhWBKKTQ93EpDnUpCLbz53mSMU6Bw==
X-Google-Smtp-Source: ABdhPJwpQ1GVjFmDKvc8PH7KqdxJ67R2dc9VdLbe7uCI3X0HOG+LfQvDQVihlcKQk6cFhvzE0SmSNg==
X-Received: by 2002:a2e:9689:: with SMTP id q9mr2031382lji.434.1602872712096;
        Fri, 16 Oct 2020 11:25:12 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u23sm1040363lfq.173.2020.10.16.11.25.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 11:25:10 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id v6so4095049lfa.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 11:25:10 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr1987164lfz.344.1602872709767;
 Fri, 16 Oct 2020 11:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw> <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com> <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
 <20201016181908.GA282856@redhat.com> <CAHk-=wgDFTqJckA_Na6_qZFMUm3xAu_jvfM7ZRakEAwb0CPSQw@mail.gmail.com>
In-Reply-To: <CAHk-=wgDFTqJckA_Na6_qZFMUm3xAu_jvfM7ZRakEAwb0CPSQw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Oct 2020 11:24:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOcG95Pj5CkFm_-LkAUmLndjoaeOs_AyyxmQ7nr795vw@mail.gmail.com>
Message-ID: <CAHk-=wgOcG95Pj5CkFm_-LkAUmLndjoaeOs_AyyxmQ7nr795vw@mail.gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Qian Cai <cai@lca.pw>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looking at that code, I don't see why the page needs to be unlocked [..]

That "unlocked" should be "locked", of course.

            Linus
