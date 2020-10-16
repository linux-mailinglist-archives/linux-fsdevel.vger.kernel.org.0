Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC0290B3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 20:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391626AbgJPSYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 14:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391390AbgJPSYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:24:25 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974EC061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 11:24:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so3472319ljn.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eKAiz03REd9F2BGqg3XB1WUDmxvOSQH4Qk1B3giWI8=;
        b=HOlq+tisLvBTlTkFI/Z1ZSYH9Wc7UVWpNJU7I96TvJHnJe60SklqXQXpuap3g3Wr6t
         /fhT2idAFuMGsWtDh3IH2dl1NZH9H6o+MX8J2YDyMyV5Ld28VbG1rw+ZZdOWX5M2VPVN
         mVK3DM8QqneboyILTGgxDOv71Bcc70VPxXjl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eKAiz03REd9F2BGqg3XB1WUDmxvOSQH4Qk1B3giWI8=;
        b=H6SxjlH1hNUT4nWhOXmLMJWRRRJQCBzGYB1Pb53ePgCT3nhiLEhEPRigEWqp8sYOOk
         S2pSPbgs+tSjuJL2BOjzcWj5exQQssXwblTdk3ln58b1n2YtyQtYDPPb5MLQMXLulwGM
         81LO/Bnfm2AjW1O3Wn9W7kAnSUnTaJ8EQtm3Szejg03ftpRhiI4o1tOaL6kCDkzimI3J
         3PsC8/yGMTK5lYKO1mnUtMl1U5bRklP48hAjSLrlLcJuj5tnvPbovTW6EHlCBXA6NZZN
         kBWznkrxnTJVdkPtZzIPYfIEwp20G//ThQXRYJbBb1DCI9EBt5oJ2tDlT/mcpoHKET08
         JA1Q==
X-Gm-Message-State: AOAM533WZgUI5z87sS3xiQBKDMz8eDpQqNfjO64hnW0rDY5I7rw1ABWA
        iJFpwhWgU0sfoHXWPGL+STER+PqgEVRl3w==
X-Google-Smtp-Source: ABdhPJwIurFOfuxIuGiM0YPh+8196ahQjaIE/JoHn1F+ah92F8dkODL4xgxTRD+rKCqZknzmveGc3w==
X-Received: by 2002:a2e:8757:: with SMTP id q23mr2101244ljj.82.1602872663197;
        Fri, 16 Oct 2020 11:24:23 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r2sm1134118ljd.20.2020.10.16.11.24.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 11:24:19 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id v6so4091792lfa.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 11:24:18 -0700 (PDT)
X-Received: by 2002:a19:cbcb:: with SMTP id b194mr2024112lfg.133.1602872658198;
 Fri, 16 Oct 2020 11:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw> <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com> <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com> <20201016181908.GA282856@redhat.com>
In-Reply-To: <20201016181908.GA282856@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Oct 2020 11:24:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDFTqJckA_Na6_qZFMUm3xAu_jvfM7ZRakEAwb0CPSQw@mail.gmail.com>
Message-ID: <CAHk-=wgDFTqJckA_Na6_qZFMUm3xAu_jvfM7ZRakEAwb0CPSQw@mail.gmail.com>
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

On Fri, Oct 16, 2020 at 11:19 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> So with multi page writes performance seems much better for this
> particular workload.

Looking at that code, I don't see why the page needs to be unlocked
after it's been filled, so I do think the easy solution is to just
always unlock the pages. Then the rest of the multi-page code is
probably fine.

But hey, who knows. I might be missing something.

            Linus
