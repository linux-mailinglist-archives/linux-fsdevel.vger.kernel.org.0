Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39CD1E8955
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgE2U54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 16:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2U54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 16:57:56 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB440C03E969
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 13:57:55 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c12so491390lfc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMYB1DtpdiIUC5Hq3/MKsg9W34brhT1SCCn+MooLpt8=;
        b=WOJNDSngSwvWbLC2sXGabc4EsYy/SY5WCyG2Wcz4ga+pMjXDofuGha/vYFN9lzucI/
         nJ5ARc+8aqxDiqUOr0euKYd9U3Oe8PMKryjwX6vi0gvtIqx6Hr/BTyDvR/9dLvYzMajO
         qg5gVi+OH0yIvezUJoOvXcjcwZOZR02jRQ5Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMYB1DtpdiIUC5Hq3/MKsg9W34brhT1SCCn+MooLpt8=;
        b=iR/iJjz91zr10mkYrvLmuL2tw55iRN/b5NWrtljvSZ6HxxsYblwUbhYJ0+6/Z0+TMM
         fIMDkFX+XTDg6V6a8x40X0ploHGVMrExYtLjItrXx9wIaEqaMAx0GFr8C3bfUfh3Yc+2
         BEEUw54N94ffa1r8Elw1QE7OXcQS2T8oGEdE0//2ajG4+boGEC7xxqsj08gT5D71BfPT
         InG9VSyVyZOhAPHseL+6uHYmppwYcE1ay7IVShRPyX6Rur8pu5XpdLoIE3vI481UhicB
         2BVHuErftCIae3bxEe5NBBS+w3pLtDfETsdBd2BZ99xOvMOc55ts/jho71RzJnS8Pmt2
         3BaQ==
X-Gm-Message-State: AOAM532+ic/GSVOrnUXdry6iKyo6PtLiy/aDIxlQcCz7YFIHBgJSOUPu
        MMCoN4BcgG9shgVyecq9+pmhzgKqi48=
X-Google-Smtp-Source: ABdhPJzKtTOO9101DYj6SnA5LlXecualpW+I8bTSjqHISj/WA5QQxKK9DmWQwGpyAkCn2H9BMawOsQ==
X-Received: by 2002:a19:8313:: with SMTP id f19mr5477504lfd.207.1590785873787;
        Fri, 29 May 2020 13:57:53 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id s13sm2863646lfp.81.2020.05.29.13.57.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 13:57:53 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 82so521586lfh.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 13:57:52 -0700 (PDT)
X-Received: by 2002:ac2:504e:: with SMTP id a14mr5417023lfm.30.1590785872566;
 Fri, 29 May 2020 13:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200529000345.GV23230@ZenIV.linux.org.uk> <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk> <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
 <20200529014753.GZ23230@ZenIV.linux.org.uk> <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
 <20200529031036.GB23230@ZenIV.linux.org.uk> <CAHk-=wgM0KbsiYd+USqbiDgW8WyvAFMfLXMgebc7Z+-Q6WjZqQ@mail.gmail.com>
 <20200529204628.GI23230@ZenIV.linux.org.uk>
In-Reply-To: <20200529204628.GI23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 May 2020 13:57:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-pyJOf1GPCvusRtW1EzRC3KAhebGYijy4iqitCMEgWg@mail.gmail.com>
Message-ID: <CAHk-=wj-pyJOf1GPCvusRtW1EzRC3KAhebGYijy4iqitCMEgWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 1:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  I'd been concerned about code generation, but it actually gets
> split into a pair of scalars just fine...

We actually have depended on that for a long time: our 'pte_t' etc on
32-bit kernels were very much about "structs of two words are handled
fairly well by gcc".

IIrc, we (for a while) had a config option to switch between "long
long" and the struct, but passing and returning two-word structs ends
up working fine even when it's a function call, and when it's all
inlined it ends up generating pretty good code on just two registers
instead.

> Al, trying to resist the temptation to call those struct bad_idea and
> struct bad_idea_32...

I'm sure you can contain yourself.

> All jokes aside, when had we (or anybody else, really) _not_ gotten
> into trouble when passing structs across the kernel boundary?  Sure,
> sometimes you have to (stat, for example), but just look at the amount
> of PITA stat() has spawned...

I'd rather see the struct than some ugly manual address calculations
and casts...

Because that's fundamentally what a struct _is_, after all.

               Linus
