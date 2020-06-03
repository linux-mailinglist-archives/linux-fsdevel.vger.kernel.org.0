Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB671EC77B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 04:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFCCk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 22:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgFCCk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:40:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9DFC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2020 19:40:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so796395ljj.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2020 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTgMCCg/n7vIKmnl7JnJOYWZtJtsVV/Gf24uT9lr2Aw=;
        b=QcTPtcnEFRe4wGMNruzjSvrdchyjYkSAIk5hEnLYVqjEeoZ4zrQs/W1xUpzehhnR8c
         P327F8+VJu1M6lTDNEqANb4RW5ovuuGTM3+tD1GzoEYxzJget2it2p/ORrwwDG6+0K97
         N/TKfXmUqCnobORfjbBlOHbJDMbbld37vZe0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTgMCCg/n7vIKmnl7JnJOYWZtJtsVV/Gf24uT9lr2Aw=;
        b=XExdddaH0YSL+tfU2pIa7CRWrITygfqAfrjAxBNgAqZIJdmiC3zYMhsqubStyZVqte
         WxvnjlZcMTp2aAFCLlwd/9sQrjhiPdMPorAFt/u68/tymZUjjjz/QuNFvqxso+0cxDBj
         VBUnROlxBhHbUFu0KIGojUf+0GtX7CLCHUXAjNDvbEGG3+cD9BjcsPvPOpPLoQ4v/qxy
         sP9es76pqdCSYLC0CKrL1HFBimE/bwmkp0epvyuIjZs7Bjm3nB+yB/nLhEOXEyBOWXlL
         ZWHxu5o6xiR7WUFroU0Yyn+sZp+WVUFM0nlWdbkN9MMB5qTb3MAHXPo4LnxX0YH+b9WQ
         b8zQ==
X-Gm-Message-State: AOAM5334bKss+p7pwWf6n466wMuQObEcqavCmh8hKW6QgLPbgrRnr5z6
        YFG6EoBekFFyXi7JBGKw6Sj47fYyVFk=
X-Google-Smtp-Source: ABdhPJx10unAN9ijTra2lw4kFnEU3AsFBr3imbzMZSUNLE0I6X8cwOGWR/+MWdSeUCHCC8JptNKcbQ==
X-Received: by 2002:a2e:9855:: with SMTP id e21mr116835ljj.214.1591152053571;
        Tue, 02 Jun 2020 19:40:53 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t30sm221912lfd.29.2020.06.02.19.40.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 19:40:52 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j12so338592lfh.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2020 19:40:51 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr1173928lfo.152.1591152051293;
 Tue, 02 Jun 2020 19:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200602162644.GE8204@magnolia>
In-Reply-To: <20200602162644.GE8204@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 19:40:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeiqB0TH_V2uTd2CX2hks+3TW344j73ftJFjqUteTxXA@mail.gmail.com>
Message-ID: <CAHk-=wgeiqB0TH_V2uTd2CX2hks+3TW344j73ftJFjqUteTxXA@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.8 (now with fixed To line)
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 2, 2020 at 9:26 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> fs/xfs/xfs_log_recover.c                           | 2561 ++------------------
>  102 files changed, 4244 insertions(+), 4817 deletions(-)

Interestingly, the changes to that xfs_log_recover.c file really seem
to break the default git diff algorithm (the linear-space Myers'
algorithm)

The default settings give me

 fs/xfs/xfs_log_recover.c                           | 2801 ++------------------
 102 files changed, 4366 insertions(+), 4939 deletions(-)

which is not very close to yours. With the extra effort "--minimal" I get

 fs/xfs/xfs_log_recover.c                           | 2561 ++------------------
 102 files changed, 4246 insertions(+), 4819 deletions(-)

but based on your output, I suspect you used "--patience", which gives that

 fs/xfs/xfs_log_recover.c                           | 2561 ++------------------
 102 files changed, 4244 insertions(+), 4817 deletions(-)

output (the difference there wrt minimal came from
fs/xfs/libxfs/xfs_symlink_remote.c).

I'm used to seeing small differences in the line counts due to
different diff heuristics, but that 250 line difference for
"--patience" is more than you usually get.

None of this matters, and I'm not at all suggesting you change any of
your workflow.

I'm just commenting because I was going "why am I not getting a
matching diffstat", and while I'm used to seeing small differences
from diff algorithms, that 240 line-count change was really a lot more
than I normally encounter.

                      Linus
