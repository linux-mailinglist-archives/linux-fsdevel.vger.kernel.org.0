Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24E82149EC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 06:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgGEEJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 00:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgGEEJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 00:09:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8ECC061794;
        Sat,  4 Jul 2020 21:09:39 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d4so29328937otk.2;
        Sat, 04 Jul 2020 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PishxRT+7tY2csv4uXKXLuwh6FfnrTZUj/NxIbo0apM=;
        b=hz2iUEPTzGHGBeHhCYB7h0tGja5uhbiMrESl4CAVOld+fdLsEo29MkzGg5cFb4lGBT
         yLfKvrNUGxkJp7asGi2zFLznqJRRvut8KVccZ81pGI5YvbLLTHqT8kHuVKdMmxniBr/g
         gDsmDvnqhdeGjdZSjakEW2l16A0r7kTi0UfmvZBfw2VCWzsoGGd14qRtQCKaLyZXUFON
         jbytcK1r0IwAcKFplGzCjeVRebLADKlA68XRNk1QPXHzkVQciXGOyEnY/+v4/TPAj/MJ
         BzhVvDaXBC+rlL+zw68h267PdbDbnPosXZWWgrUeNNc5tPKvko9sV5jkjMmPwFOaNsck
         T5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PishxRT+7tY2csv4uXKXLuwh6FfnrTZUj/NxIbo0apM=;
        b=WzlWaZzmDY/Pd3VpHTN/Tcp++eg0D/TDOZWEtCrZAt/V65mbKph+Hl6YhOWTiVgqG1
         vMdAsE0mspQVN98Kg/GelvGQQVYSCFHCfGoZheq3hsFotHplNfbwxnkhSkNj2g8NuWDw
         6elysgA9XkDufpo/jguO/mQGrWlsAg8uD8n/Xyz4rj3rLiTSiZBD7QOK6X320Avf/JMf
         11Nzl6TqV3BDyzeY45aFbo0mVingNgJ+uXVgbmdX127WH0rAPjbFee1rUA8vPFDbR9gY
         1QIphxZVpe7BWATwy765efELc1VWIx98xQbQUbSdVpxyuCrB/5pr+/f4Qo/dWYnVIZh4
         akbQ==
X-Gm-Message-State: AOAM532BcMJGT03VAzWpY9m5gfPVqN8W2rk/oEoAVHsZG7uQhttrlUZM
        39XHpIBsjQvBsIEs3eMbNXKKkR4j0ldPEgUuEbE=
X-Google-Smtp-Source: ABdhPJzzEMj0BZ11L8P9HCnxRbPvaK4IDQ6LttX0KznjOVmxkXf+JX+NyjJ/jpfX6fVCTTqmpXDJkYm5/uVuYcVsJuU=
X-Received: by 2002:a9d:66ca:: with SMTP id t10mr20300471otm.358.1593922179004;
 Sat, 04 Jul 2020 21:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org> <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <20200705031208.GS25523@casper.infradead.org> <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
 <20200705032732.GT25523@casper.infradead.org>
In-Reply-To: <20200705032732.GT25523@casper.infradead.org>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sun, 5 Jul 2020 06:09:03 +0200
Message-ID: <CAODFU0rSqQsO9rSiA8Ke=+mk_NgEdFDHPMfmXGSmzmkqQh1KYw@mail.gmail.com>
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gregkh@linuxfoundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 5, 2020 at 5:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jul 05, 2020 at 05:18:58AM +0200, Jan Ziak wrote:
> > On Sun, Jul 5, 2020 at 5:12 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > You should probably take a look at io_uring.  That has the level of
> > > complexity of this proposal and supports open/read/close along with many
> > > other opcodes.
> >
> > Then glibc can implement readfile using io_uring and there is no need
> > for a new single-file readfile syscall.
>
> It could, sure.  But there's also a value in having a simple interface
> to accomplish a simple task.  Your proposed API added a very complex
> interface to satisfy needs that clearly aren't part of the problem space
> that Greg is looking to address.

I believe that we should look at the single-file readfile syscall from
a performance viewpoint. If an application is expecting to read a
couple of small/medium-size files per second, then neither readfile
nor readfiles makes sense in terms of improving performance. The
benefits start to show up only in case an application is expecting to
read at least a hundred of files per second. The "per second" part is
important, it cannot be left out. Because readfile only improves
performance for many-file reads, the syscall that applications
performing many-file reads actually want is the multi-file version,
not the single-file version.

I am not sure I understand why you think that a pointer to an array of
readfile_t structures is very complex. If it was very complex then it
would be a deep tree or a large graph.
