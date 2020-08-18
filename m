Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F17248F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 22:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHRUSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgHRUSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:18:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C780C061389
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 13:18:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i26so16289153edv.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeMExisTCX54PfEU0UFsxsWYaAtAPl2dvOoQQ7l6gvs=;
        b=SELtgIId7tpSP3rmyBh4NRgeVCONpRS3Kwr7JecG6Xg6+vzYRIisCUg3FJv+Cr6T6n
         r4cGwCap2uiavvQL3GQY2HPmVJFtyyif7TGfGMQQV2oMQDdM+f6uaXHdF++Gpi5mVMhF
         widzUPi29Qjx42/Abjmra+ObbS6HtZ+ev4gqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeMExisTCX54PfEU0UFsxsWYaAtAPl2dvOoQQ7l6gvs=;
        b=dctELRQmaWD6tleeVBug6xo0DLRk1hRALSjjrKHRWvXMoIQVlOKCFy+NBD29CrBcLC
         WpoKLwKhC0r/CnbvW+J7KJGR8aIWzdPH0B8Pg4jc8roPIBAYT7pYPXqlcbheXqX2E6fZ
         0EgwlIkg6gSh7VRQ5lGR0kswI1JgglmKXHXHkUDs5DUmyPxwndU6/0Q6NipiiGQButCg
         nGyWwlwMRJFNbeBPfYZVxdaWCBLzXYiGNxGhw2lAMmgN/Rj9lJhJudzmcIbJZxKStbXI
         RB3mBAD8/IYNG4RulBj9GoOb0PE0KZStDN0ZkEVBD8+uvtau/FvOKF9YDN/L+SWzgI2/
         BsPg==
X-Gm-Message-State: AOAM530w1mfyl5ZMyb4Etk68UsMGfCRLrOjjN182epUVSMhSICg9OvBH
        bn97sD86SEaEjisiAW5ly6959B7h5oXvyeyWPeFdFw==
X-Google-Smtp-Source: ABdhPJwQ2obJGVbMSKVirBR81H6xRXbWQqC1R7MEO/Fz7AW23R0Arh8JQvECxjqKxtFxUrpY3WjBonHXIE3ypgOllSU=
X-Received: by 2002:aa7:d5d0:: with SMTP id d16mr20989643eds.212.1597781920338;
 Tue, 18 Aug 2020 13:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com> <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
 <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com> <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
 <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
 <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com> <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
In-Reply-To: <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Aug 2020 22:18:29 +0200
Message-ID: <CAJfpegt9yEHX3C-sF9UyOXJcRa1cfDnf450OEJ47Xk=FmyEs8A@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 8:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> I think people who have problems parsing plain ASCII text are just
> wrong. It's not that expensive. The thing that makes /proc/mounts
> expensive is not the individual lines - it's that there are a lot of
> them.

I agree completely with the above.

So why mix a binary structure into it?  Would it not make more sense
to make it text only?

I.e. NAME=VALUE pairs separated by newlines and quoting non-printable chars.

Thanks,
Miklos
