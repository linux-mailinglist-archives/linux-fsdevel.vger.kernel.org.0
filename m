Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4919FBF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgDFRqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 13:46:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34048 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDFRqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:46:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10so669700ljn.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNmBf+GRC0EIGToMk4/t6rTIUh9OjAdpy4aFeKb4Rqc=;
        b=hfU2c40KDKDREWI3c/+ZfwIxoUGC8kXZ7TPtVMQl00LsrJlpHdN1scbOc8M0YueuXz
         vQC0UqJcUs6XJVxo1sj6tZnoGwiW1ExbjzQZ41FY0L479xo0CkFn4/T04xa6mC5BTQ8Q
         g43VaoZI2VXzPbpA7qyuFqiAMi6P/SZuMDO8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNmBf+GRC0EIGToMk4/t6rTIUh9OjAdpy4aFeKb4Rqc=;
        b=pORSLe+2SscDsnSef7nKH5gGL4fQUKSN97Zg06yoGBcTZOzoIkiJz/WKOzzq4v+dF6
         ro91c9zHReWqHlGSTB6vATcL54y8WEjvRZQIJev7gZKj30s0uOitLznk+ebW+dHHdtuB
         UtTb8MW1gX5/1JcGfMzql+hrdPmOpGpLyG1randGx4nOZcm4iwU1+Yks3kCZIVDYGILv
         H/JyVtethIsfKrffG1mjuyPndNemYRZnwH8tJRRtq6RCTZ2sRYvlvpfoCE6EjxZjbGo4
         4JjGpAt0SgPFMOo4/UI2p4tTHjdrjee75jm7/ndKJIiXGgGuWtHgXtcnrlRuG9/fAik3
         6tHg==
X-Gm-Message-State: AGi0PuZo0WMkKkSvd8VpF9koLCq/ldbjWpwspXZ8NgAL1IjcJDNkS3nI
        65mAjARFFRrTvuHN3mrdmFconpq3a58=
X-Google-Smtp-Source: APiQypJyWCKGpF0DMFIg9tnItmJqVf7F5q3NhNOgBV9xu/Oasd92hImDLMpDzj/SOkXjc/qN15fC+A==
X-Received: by 2002:a2e:740e:: with SMTP id p14mr251975ljc.290.1586195191264;
        Mon, 06 Apr 2020 10:46:31 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id h14sm10000250lfm.60.2020.04.06.10.46.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 10:46:30 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id f8so153784lfe.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 10:46:30 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr2122522lfl.125.1586195189986;
 Mon, 06 Apr 2020 10:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica> <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica> <20200406164641.GF21484@bombadil.infradead.org>
 <CAHk-=wiAiGMH=bw5N1nOVWYkE9=Pcx+mxyMwjYfGEt+14hFOVQ@mail.gmail.com> <20200406173957.GI21484@bombadil.infradead.org>
In-Reply-To: <20200406173957.GI21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 10:46:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjh0szm+btaHptV1_XMMih=c1zP5wU8MQmREVKmJSYUcA@mail.gmail.com>
Message-ID: <CAHk-=wjh0szm+btaHptV1_XMMih=c1zP5wU8MQmREVKmJSYUcA@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.7
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 6, 2020 at 10:40 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > But look at anybody who ever worked more with NFS mounts, and they got
> > used to having the 'intr' mount flag set and incomplete reads and
> > -EAGAIN as a result.
>
> That's why you had me implement TASK_KILLABLE ;-)

Oh, absolutely. We can *NOT* do this in general. Applications _will_
break if you end up just randomly breaking POSIX behavior.

But network filesystems are almost never fully POSIX anyway. And yes,
they do break some apps.  'intr' may not be a thing any more, but
other differences wrt various atomicity guarantees (or file locking)
etc still exist.

So the whole "network filesystems do odd things in corner cases" isn't
exactly unusual.

I think the O_NONBLOCK difference is one of the more benign ones.

I just think it should be documented more.

             Linus
