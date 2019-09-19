Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D12B7F15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404349AbfISQaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 12:30:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41595 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfISQ37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:29:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id f5so4232379ljg.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOeYjhY2TaFJW9wyBh4aTYbME8oCFKdq0q4U7z5/glg=;
        b=fANktzJy2S3Kc/Mm9Tv5QoHvYpucXsOuKEmCGX95UhOvTtrVw5xZLOL8D7SbT7J7zp
         q+wtuj988DKgYQxlWbNSygEa2IyFNISOALjUyMsG5jZ8BlpqlP7BCkXN9vlUCPzen3oH
         MZUBRP7j1WuGyLw3Kl49isvHiIAcdB2Y/jIdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOeYjhY2TaFJW9wyBh4aTYbME8oCFKdq0q4U7z5/glg=;
        b=BkzE/Iez2Ai/D2d7otfchCvT/gVk3ql55ptNkLRgddG3dRZ1nWtuzKGMmmX575J6yw
         JHWQ/n2Rfg6yjtcPLeod2dm3E6vhjhqbfpFbv5q6mfh2gWXncgdkHwThzEvFDMl/t/cw
         RVGoLUAfClTLqLvUoBd0oRgosUpu9F5O0VqDOkqn7lEZwC8ccxWfZZ/ZyxFbIyd9nK2u
         qTbmNnRZWQiLPazfeQdN6lQ8wC+Os/aBFHCRTtwaWvTTIcVh1+uiQ8XEuXrpDbiMXsZK
         SulMfZKZce6JvT6tiwRIu2bOt+BV1KRS6aFMFTSNrIB6SZSwLVrDnT6/EKr4iwys2FOD
         jZnQ==
X-Gm-Message-State: APjAAAXcBrgtt5TU78ety84Vp0yuuKnYxxyMykfHFPzlX8qq+b1baZ0m
        VLIf58OVcttlCd6X2/yCF/sfnJo5png=
X-Google-Smtp-Source: APXvYqziCVHgk9Xvv4xU6KySYpfYwucdlOJ/1D9lYCNXLXi9sFE0008yLvt+oPT4IylbfQWn2K7LEQ==
X-Received: by 2002:a2e:9059:: with SMTP id n25mr1584467ljg.134.1568910596792;
        Thu, 19 Sep 2019 09:29:56 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b67sm1786868ljf.5.2019.09.19.09.29.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 09:29:55 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 7so4233355ljw.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 09:29:55 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr6081705ljj.72.1568910595160;
 Thu, 19 Sep 2019 09:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
 <16147.1568632167@warthog.procyon.org.uk> <28368.1568875207@warthog.procyon.org.uk>
 <16257.1568886562@warthog.procyon.org.uk>
In-Reply-To: <16257.1568886562@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 09:29:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmbGSxdJDMjtGNqFs+r0Z62xv_i_5TBRPECuqXN-ax9g@mail.gmail.com>
Message-ID: <CAHk-=wgmbGSxdJDMjtGNqFs+r0Z62xv_i_5TBRPECuqXN-ax9g@mail.gmail.com>
Subject: Re: [GIT PULL afs: Development for 5.4
To:     David Howells <dhowells@redhat.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 2:49 AM David Howells <dhowells@redhat.com> wrote:
>
> Actually, waiting for all outstanding fixes to get merged and then rebasing
> might not be the right thing here.  The problem is that there are fixes in
> both trees: afs fixes go directly into yours whereas rxrpc fixes go via
> networking and I would prefer to base my patches on both of them for testing
> purposes.  What's the preferred method for dealing with that?  Base on a merge
> of the lastest of those fixes in each tree?

If you absolutely *have* to have something from another development
tree, that's generally a sign that something is screwed up with the
model in the first place, but when it happens,  you should make sure
that you have a stable point in that development tree.

You might ask the upstream developer (ie Davem, in the case of the
network tree) what would be a good point, for example. Don't just pick
a random "tree of the day".

The same very much goes for my tree, btw. You should simply never just
pick a random tree of the day as your base for work if you start with
my tree. That's true whether you do a merge or just start new
development on top of some point, or anything else, for that matter.

Generally, you should never merge other peoples code without having
them _tell_ you that some particular point is a good thing to merge.
Releases are obviously implicitly such points, but generally
cross-tree merges need communication (a pull request to upstream is
the obvious such communication, but not necessarily the only one:
we've had cross-tree development that has involved separate branches
and just various synchronization emails between the two groups).

Looking at rxrpc in particular - if that is what you were waiting for
- it looks more like you should just had an rxrpc branch, and asked
David to pull it for the 5.4 merge window. Then you could have used
that branch itself, as a starting point, perhaps. Or - better yet,
perhaps - merged it into your development tree based on a good AFS
starting point, with a *big* merge message explaining what you are
merging and why.

Right now there is a merge with absolutely no explanation for why the
merge exists at all, and with some very non-obvious bases that really
look like they are just random points of development for both me and
for Davem.

              Linus
