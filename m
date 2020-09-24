Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35A327787A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 20:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgIXS1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgIXS1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:27:38 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788CBC0613CE;
        Thu, 24 Sep 2020 11:27:38 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c13so2813oiy.6;
        Thu, 24 Sep 2020 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UE6/rwXOyOuMtozU8IwKWv9j7YKRsvmRzbInQl8GDEU=;
        b=mLzRMy6Wm44ME1Y0a7Oa+lpU7BnpnQgqxmAx4UiuwfcTCSfj1LL4Tcda+HHSQiayrb
         j8/3SCV+JIGpJIcwOcUJOWV+NRAzFiI8parzOht0aP0VUO/limQM9ZN9jj0pvFU3yrtv
         xt2rqBjqc9nNth0r94XtyzQy5iGEI2Xon4I3PR9bM3gPabbbo+yNwSm5t3SaU9qt4+am
         J96OGpqCePShcZj1zCHjmy+wkIfRvWssH2/dYfJqQB2jfAPsQp27u+1eSDPukj4Wpq+X
         5LrtCCH+ksBnI9annurC8NFIEAHU+XJkBdnqIWRvxCBQNPn2hirnfhQP35170RePUqmK
         g5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UE6/rwXOyOuMtozU8IwKWv9j7YKRsvmRzbInQl8GDEU=;
        b=cqfJlzN0Ak8YL+kN8nvhyF744l0+H6lq/+S4QEX5gK4Cpk2GEp/GWGSqlx0I246sSq
         vUziqFC4nTo1QWpfn+AubG76inYkZZurOnqTkgTGbZQL7i/UIRcN7LEcPEHqXxHgAiOs
         BoCHmHfSK6GlmwzC/FWiBMcwaFX4ToJ7TeUhN+hor8W08GOEEb+fsT1PtSzZ0lTjmx2j
         ORbxliVfbmU85u8Vk3gdRTjV1KywAChOCXc//JRjOfInF0YzoT4IiNxzaLMwyjF0otGG
         mZYmCb8PdoweT+J4bpZhJwmd5xoL+37zlynFK/kyq+QfknQ6DHaMCjARFdCAOF6iJPyE
         zIfw==
X-Gm-Message-State: AOAM5324rB5wX032cElmBW01PkJ7LymdyvMLOes4DyCIGBQc5LsaMX6P
        5z94UxCpZCYtvk5S+Cjkn6YNNWweLQ8+9QR3+4zQee1zxHCnBQ==
X-Google-Smtp-Source: ABdhPJzQksIY5cZQiJVhVkQi8qhUF+cLR7NEdB8hZ3hIingeHk+2t4QuY5PPleI3pRP054ita1e7h5W8Y+ejL//tmCg=
X-Received: by 2002:aca:d409:: with SMTP id l9mr80253oig.70.1600972057780;
 Thu, 24 Sep 2020 11:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200924125608.31231-1-willy@infradead.org> <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
 <20200924151538.GW32101@casper.infradead.org> <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
 <20200924152755.GY32101@casper.infradead.org> <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org>
In-Reply-To: <20200924163635.GZ32101@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 24 Sep 2020 20:27:26 +0200
Message-ID: <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 6:36 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 24, 2020 at 06:19:03PM +0200, Sedat Dilek wrote:
> > On Thu, Sep 24, 2020 at 5:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Sep 24, 2020 at 05:21:00PM +0200, Sedat Dilek wrote:
> > > > Great and thanks.
> > > >
> > > > Can you send out a seperate patch and label it with "PATCH v5.9"?
> > > > I run:
> > > > $ git format-patch -1 --subject-prefix="PATCH v5.9" --signoff
> > > >
> > > > Normally, I catch patches from any patchwork URL in mbox format.
> > >
> > > Maybe wait a few hours for people to decide if they like the approach
> > > taken to fix the bug before diving into producing backports?
> >
> > That make sense.
> >
> > You have a test-case for me?
> > I have here Linux-Test-Project and FIO available.
>
> Qian reported preadv203.c could reproduce it easily on POWER and ARM.
> They have 64kB pages, so it's easier to hit.  You need to have a
> filesystem with block size < page size to hit the problem.
>
> If you want to check that your test case hits the problem, stick a printk
> in iomap_page_create().

I run both linux-kernel on my Debian/unstable AMD64 host (means not in
a VM) with and without your patch.

Instructions:
cd /opt/ltp
./runltp -f syscalls -s preadv203

Unfortunately, the logs in the "results" directory have only the short summary.

Testcase                                           Result     Exit Value
--------                                           ------     ----------
preadv203                                          PASS       0
preadv203_64                                       PASS       0

So, I guess I am not hitting the issue?
Or do I miss some important kernel-config?

- Sedat -
