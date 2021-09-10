Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA3C40708C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhIJRcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 13:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhIJRcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:32:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D51C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 10:31:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k13so5558948lfv.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUgCj/lJopc0GwjVatWiteMeBV8t5YRgw6JDQsFTQ7o=;
        b=Hi0tAii0nMOtwacqzu8IZaGMEp7ICkxhr7NLakzC6M+Q7SL4Wvl5+8y67U3RycwtZ6
         vGeyzL7VxnXJDGoZW6peZk58phA/fDES6k0uCAqUhgYMj1rFC4b4PVhooiXP1/HRZpeT
         XTWd30Wr9y+VE+2+lEs+nEFQ2Ou5n+9fS27XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUgCj/lJopc0GwjVatWiteMeBV8t5YRgw6JDQsFTQ7o=;
        b=lx169MhioavQE9mQX+Q2IUAmC7CAL/WQ2B56EPPa9e2tsjNSdeLl1LxEPfW56xyZ7L
         FKObSg+43ICPlMSyc8zoCgKLMhqA1jCfsTLggrdrmNq2Vs+LpsoWRrxtg3zfD3zvzQOn
         Ox1rztLGftAoME7xBXxBxklWRbxhyJTetjvYl5Iwq4ayz9Mfuv1XrIt0aCQp58gBNJc/
         F1BgKA54agenp4cxJfmJcwVvYsp5Ig+5xXXhBczWmlhjPicUtdgDAElj+z6d9PNE+Jlu
         e/rGdIrjmT349lx9vK4fZgae9hvPA9UNiCw73adjn8TCBr8+QUPzTByRcYSGGzbGW0PX
         oomw==
X-Gm-Message-State: AOAM53211dO0mT06iNN2AijmilLymhPM4S9lWmzsLtuE8VXnP1WmOLqX
        m2EUqaPnD2Q3orh1/VslwxkNNloNjAgL9ls4Jcg=
X-Google-Smtp-Source: ABdhPJy3dTBNYnpvp1zF3PhHlvYOHBJDZNx8Y/shAJkEDC8uQ7urbQBFcv14GgSSQkVeKpZSINeMXQ==
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr4787323lfu.419.1631295077871;
        Fri, 10 Sep 2021 10:31:17 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w26sm613694lfa.119.2021.09.10.10.31.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 10:31:17 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id l11so5561411lfe.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 10:31:16 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr4847412lfb.141.1631295076349;
 Fri, 10 Sep 2021 10:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk> <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk> <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk> <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk> <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk> <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk> <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
 <b1944570-0e72-fd64-a453-45f17e7c1e56@kernel.dk>
In-Reply-To: <b1944570-0e72-fd64-a453-45f17e7c1e56@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Sep 2021 10:31:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
Message-ID: <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
Subject: Re: [git pull] iov_iter fixes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:26 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/10/21 10:58 AM, Linus Torvalds wrote:
> > On Fri, Sep 10, 2021 at 9:56 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >>
> >> What's the point of all those contortions, anyway?  You only need it for
> >> iovec case; don't mix doing that and turning it into flavour-independent
> >> primitive.
> >
> > Good point, making it specific to iovec only gets rid of a lot of
> > special cases and worries.
> >
> > This is fairly specialized, no need to always cater to every possible case.
>
> Alright, split into three patches:
>
> https://git.kernel.dk/cgit/linux-block/log/?h=iov_iter

That looks sane to me.

Please add some comment about how that

        i->iov -= state->nr_segs - i->nr_segs;

actually is the right thing for all the three cases (iow how 'iov',
'kvec' and 'bvec' all end up having a union member that acts the same
way).

But yeah, I like how the io_uring.c code looks better this way too.

Al, what do you think?

              Linus
