Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDDD186A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEIIPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 04:15:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43750 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfEIIPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 04:15:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id p19so1180047ywe.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2019 01:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E4YbTHOUSx4GFjCJTaxb0OlZp07YKWVrsdo88C4VI4U=;
        b=X4vfKHmwuKRMQefr2UcmdaqqIPwpHCUE1t1S3JanWYQvMqRUCsTiEItPO5apehROdb
         9GdAvEq2ayVGrTrlFGlBQFfavxlqA84RkCOO+6pqCcTYh6AHQrkCNJQkhoudwMB7q6Em
         Wzy2ukqBjXHRkpzQxhwW6fka7OPITKr8Ms+znY+6OWe9CYxm3fO+41BjOrVxVcYE26SN
         RLhNjJyg2XbFkVfKHIFG8D2R6U+i2BpMczeMb9VV77yiIdZeArXUkpism4uRp2ZtxCcf
         fZDels8a4+chNlKk2HfDADvQzByQZzwJIefW09hdxr/tAzZETZXKf1zGKjm/prk6/mSQ
         KFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E4YbTHOUSx4GFjCJTaxb0OlZp07YKWVrsdo88C4VI4U=;
        b=ZRuVZx49DBXqGqTjMbY+zQmxjoaJnDWsZca8B3qbMubDNZ1sWJk8SyBwItACWeEW1L
         qkw+EOTBqobTBJi0Xr0nrsQup09czBwQfj8/ZyPK6cr/X3hVfBpnmYhDUvsnUk4NZT6v
         y4e0ZcMATy2n3EBjFDpl65QQCYUKeHXmFhAMJnIR/d1J6afRcxCyrRBYxSW07Tf1kkuv
         ljX39otNPIQT//rcaKCRQAgLVJF7tgAMAVqMhCNRCpYMykbMw2X5wWhBbo2Vq4cAUPob
         bctWYIHLZ3XDIwFdwQCg7JrpjlZJnuxfLR7RKOwH7HH1TDI0j6qKC3OCs8+E5tSN4o8d
         nEsw==
X-Gm-Message-State: APjAAAW/wCTvxu1bYwbygchhA+S1htOoPKkpKcFnFbJYqf+TAYGWwomt
        XTPq6hDw3XKqTEIMx2qPhL1yLrVVQaf15SbVDZE=
X-Google-Smtp-Source: APXvYqyhJJT4d+8ZLHj8Pb7K0HX1n7bsajTwB8ELCxZNyClVzRfKnrApkuRLa671Xa7aZo6yzFptIqCPM06RAbIrzL0=
X-Received: by 2002:a25:b948:: with SMTP id s8mr1303649ybm.325.1557389746771;
 Thu, 09 May 2019 01:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com> <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
In-Reply-To: <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 9 May 2019 11:15:34 +0300
Message-ID: <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Eugene Zemtsov <ezemtsov@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Tso <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 8, 2019 at 11:10 PM Eugene Zemtsov <ezemtsov@google.com> wrote:
>
> > This really sounds to me like the properties of a network filesystem
> > with local cache. It seems that you did a thorough research, but
> > I am not sure that you examined the fscache option properly.
> > Remember, if an existing module does not meet your needs,
> > it does not mean that creating a new module is the right answer.
> > It may be that extending an existing module is something that
> > everyone, including yourself will benefit from.
>
> > I am sure you can come up with caching policy that will meet your needs
> > and AFAIK FUSE protocol supports invalidating cache entries from server
> > (i.e. on "external" changes).
>
> You=E2=80=99re right. On a very high level it looks quite plausible that =
incfs can be
> replaced by a combination of
> 1. fscache interface change to accomodate compression, hashes etc
> 2. a new fscache backend
> 3. a FUSE change, that would allow FUSE to load data to fscache and serve=
r data
>     from directly fscache.
>
> After it is all done, FUSE and fscache will have more features and suppor=
t more
> use cases for years to come. But this approach is not without
> tradeoffs, features
> increase support burden and FUSE interface changes are almost
> impossible to deprecate.
>
> On the other hand we have a simple self-contained module, which handles
> incremental app loading for Android. All in all, incfs currently has
> about 6KLOC,
> where only 3.5KLOC is actual kernel code. It is not likely to be used =E2=
=80=9Cas is=E2=80=9D
> for other purposes, but it doesn=E2=80=99t increase already significant c=
omplexity of
> fscache, FUSE, and VFS. People working with those components won=E2=80=99=
t need to fret
> about extra hooks and corner cases created for incremental app loading.
> If for some reason incfs doesn=E2=80=99t gain wide adoption, it can be re=
latively
> painlessly removed from the kernel.
>

If you add NEW fscache APIs you won't risk breaking the old ones.
You certainly won't make VFS more complex because you won't be
changing VFS.
You know what, even if you do submit incfs a new user space fs, without FUS=
E,
I'd rather that you used fscache frontend/backend design, so that at
least it will
make it easier for someone else in the community to take the backend parts
and add fronend support to FUSE or any other network fs.

And FYI, since fscache is an internal kernel API, the NEW interfaces could
be just as painlessly removed if the incfs *backend* doesn't gain any adopt=
ion.

> Having a standalone module is very important for me on a yet another leve=
l.
> It helps in porting it to older kernels. Patches scattered across fs/ sub=
stree
> will be less portable and self contained. (BTW this is the reason to have
> a version file in sysfs - new versions of incfs can be backported to
> older kernels.)
>
> Hopefully this will clarify why I think that VFS interface is the right b=
oundary
> for incremental-fs. It is sufficiently low-level to achieve all
> goals of incremental app loading, but at the same time sufficiently isola=
ted
> not to meddle with the rest of the kernel.
>
> Thoughts?
>

I think you have made the right choice for you and for the product you are
working on to use an isolated module to provide this functionality.

But I assume the purpose of your posting was to request upstream inclusion,
community code review, etc. This is not likely to happen when the
implementation and design choices are derived from Employer needs vs.
the community needs. Sure, you can get high level design review, which is
what *this* is, but I recon not much more.

This discussion has several references to community projects that can benef=
it
from this functionality, but not in its current form.

This development model has worked well in the past for Android and the Andr=
oid
user base leverage could help to get you a ticket to staging, but eventuall=
y,
those modules (e.g. ashmem) often do get replaced with more community orien=
ted
APIs.

Thanks,
Amir.
