Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD536EE5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbhD2Qqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbhD2Qqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:46:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F3C06138D
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 09:46:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b23so23295103lfv.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fv1o4ACMgluHoz1tubBqI30O1OAulg9d7QxnCnSiG9c=;
        b=KDkNvN4NBhwsvv2Vt/X74vt7KVgzUpJkoRwK5HYd1W+ax7k1/dGgufUKiRP3X8w5Ql
         H5lHQo0imA8GXWxUOZUx++5LlJIaiJwjb17/VyeO+Shqq/nhIWw9KJuVJxGvXm/uTM1x
         86MzDL52wXvA28OjsoGhD6CKmP2Q62dV3Gr70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fv1o4ACMgluHoz1tubBqI30O1OAulg9d7QxnCnSiG9c=;
        b=I/u/kUY7PDbAmF66cSDuN1hMy5me1i8wIppNA2qbw+5udGAOvQ9D/8cPm5k2tKDMwv
         uPe8Q4QcYs9+rN7OFoIMMZI44gRwrpskrKcqRC8lLeby4iCnwfkhhoEtr5aF8IO6TOq7
         6fkPOFAloksMBGmu7dZrgnnOKpk8BlvpYzK+Ll4BkdJvoq9YQf8CByKRbvLpbpyw8/qG
         2f3x3sj5zGElDnq+9ZWdylzy4ise7PWGnzZYDyHCbj3zExX467cQzrAYZ7HBgtYm0yAW
         K6BvAJYVkMsaKDzOpZ25L+v9E8u8Y9xHQ7unfowsFTnemF4LyHYNfT5so62m9eZ25fh+
         dr7g==
X-Gm-Message-State: AOAM5334q2E7bK6gadt6/Ctthjy8XXI6gsIYR1u/0Eu6NWKNp7NM8PD4
        CTeLJ+aNQF0KZLcjEBLYAfjLEuhrcto/FIaS
X-Google-Smtp-Source: ABdhPJxJF/cu8r8gU9icjDEa9p0mu7levmIiQ2WGTp39yIDrS26024eyc4KUDoIFIsacCp/Mtd1nxA==
X-Received: by 2002:ac2:4c4a:: with SMTP id o10mr322199lfk.480.1619714758709;
        Thu, 29 Apr 2021 09:45:58 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m22sm28068lfh.63.2021.04.29.09.45.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 09:45:56 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h36so51695488lfv.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 09:45:55 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr284849lfu.201.1619714755208;
 Thu, 29 Apr 2021 09:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210427025805.GD3122264@magnolia> <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
 <20210427195727.GA9661@lst.de> <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
 <20210428061706.GC5084@lst.de> <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
 <20210428064110.GA5883@lst.de> <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
 <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk> <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
 <26d06c27-4778-bf75-e39a-3b02cd22d0e3@rasmusvillemoes.dk>
In-Reply-To: <26d06c27-4778-bf75-e39a-3b02cd22d0e3@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Apr 2021 09:45:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJmDjTLYLeF=Ax31vTOq4PHXKo6JUqm1mQNGZdy-6=3Q@mail.gmail.com>
Message-ID: <CAHk-=whJmDjTLYLeF=Ax31vTOq4PHXKo6JUqm1mQNGZdy-6=3Q@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, Jia He <justin.he@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:40 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> > That also does explain the arguably odd %pD defaults: %pd came first,
> > and then %pD came afterwards.
>
> Eh? 4b6ccca701ef5977d0ffbc2c932430dea88b38b6 added them both at the same
> time.

Ahh, I looked at "git blame", and saw that file_dentry_name() was
added later. But that turns out to have been an additional fix on top,
not actually "later support".

Looking more at that code, I am starting to think that
"file_dentry_name()" simply shouldn't use "dentry_name()" at all.
Despite that shared code origin, and despite that similar letter
choice (lower-vs-upper case), a dentry and a file really are very very
different from a name standpoint.

And it's not the "a filename is the whale pathname, and a dentry has
its own private dentry name" issue. It's really that the 'struct file'
contains a _path_ - which is not just the dentry pointer, but the
'struct vfsmount' pointer too.

So '%pD' really *could* get the real path right (because it has all
the required information) in ways that '%pd' fundamentally cannot.

At the same time, I really don't like printk specifiers to take any
real locks (ie mount_lock or rename_lock), so I wouldn't want them to
use the full  d_path() logic.

                Linus
