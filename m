Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2424241DE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgHKQKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 12:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgHKQJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:09:58 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA9C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 09:09:57 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id s9so6971289lfs.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARDqa0ttwGGpwIjIpukccBn4z80sUg1Y95J7pw/cBrc=;
        b=ARjGfgTTe8Hs0S97+HBco6KPkmP42m5OKE0ERo6Sf2t684ErIUsYZb+F9N6GI8m7VH
         sHrR/7XxUU0WvzcWkmBHB9j/WQDrOrGh9T97uhNn/7Dj2ZTIxVy3Iz23WUYyWjs31hnR
         EPcWsf2mQ8nUFDg+i2/4NJ7eEH6TQJE7uk7EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARDqa0ttwGGpwIjIpukccBn4z80sUg1Y95J7pw/cBrc=;
        b=ayqS7px4wBk6/iebmZoAwsLCLJ0w19Y8mU7Kjz7ugU4P3nzkZQVGRaR3h/fJRAn+Kw
         lkfSxstP9Vs8if2FPkQrlVFGToJ0R+EXlJt+9hcTQ7xK+jRhzKT0c22HHcOvBBnjZuN4
         /NpapqmhxhQTzc54WEaiiLl6TBFxEoM9RzZnw3r1AcOActbqcqltgqg/C5uTn+OwgMtt
         HylU43AYKlGOGsQJLnfjH7HdvSWdH+gftl4sJ8PoxitZaGSoc7u7XN5EY+7ngF47mkwt
         GgQpzmqbtluypTXAjp2YKNRdSC87njaJ9f6UgDRfCU2t9KQQrt1jCXNctrAPgUSUvqSZ
         //WA==
X-Gm-Message-State: AOAM531VmhVQ6fEASGzwLHx1tTjkB41YLoyYHCfU16BgfiCho+jR0BRZ
        hf5GIXroFNaOjPllQM44PP2GwIwLruc=
X-Google-Smtp-Source: ABdhPJydJK/f/SPkJh+N3iFoLQ5C17cfJ/4cKU4LMYSlwuqM5G3RYmNHEvXVrzUc86U8de5kN8cVEA==
X-Received: by 2002:a19:cc9:: with SMTP id 192mr3592250lfm.61.1597162195064;
        Tue, 11 Aug 2020 09:09:55 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id j1sm10220274ljb.35.2020.08.11.09.09.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:09:53 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v9so14159056ljk.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 09:09:53 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr3191279ljc.371.1597162192777;
 Tue, 11 Aug 2020 09:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <20200811160534.GL1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200811160534.GL1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 09:09:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHZig-+dXQeW4pPEjdYsrq=3bgc+vUhwiT2Ox4ipLHwg@mail.gmail.com>
Message-ID: <CAHk-=wgHZig-+dXQeW4pPEjdYsrq=3bgc+vUhwiT2Ox4ipLHwg@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
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

On Tue, Aug 11, 2020 at 9:05 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Except that you suddenly see non-directory dentries get children.
> And a lot of dcache-related logics needs to be changed if that
> becomes possible.

Yeah, I think you'd basically need to associate a (dynamic)
mount-point to that path when you start doing O_ALT. Or something.

And it might not be reasonably implementable. I just think that as
_interface_ it's unambiguous and fairly clean, and if Miklos can
implement something like that, I think it would be maintainable.

No?

                Linus
