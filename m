Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC91F9E13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 00:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKLXTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 18:19:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKLXTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:19:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so171486pfn.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6YV9sWAtldt7QV9Z/E9MQlXJpOYClepPj0qjQfRgXwA=;
        b=XGXmNN3ZtFcSV8anGunyLg32IAPhkzgurDq12Of06HDlvW+4TU61212ZPbAEkps7J6
         7Qa9r1bNn2sil0rw9KEflTbVHGutMm6nju0oQKdhZ8cmhPwwbf3vMV6roozAimYwRasg
         CIYlbuKg0UiKlJiwToV1Ma+VBoqXB0UZf4iCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6YV9sWAtldt7QV9Z/E9MQlXJpOYClepPj0qjQfRgXwA=;
        b=MKjdaztAV+Zd4YD6LmomGNZZ+BMC5+uqnBb8yf+IEt45vfH9V5nkSxokDZeraS6kui
         EYe7Gt9EFCKa/szHYiOkRirZsJ1oNYnpuLRkMxj9cSN34HMwNRahDgYqiiXBjxA2k8mx
         XSAM8K0EYwFIDc1HZ0GvZ/KOrWDFAnMGJWbJJu7aDVJPgfvTy9roRAlnGd8NuKF/JRzR
         zJXanH2wWvdvrE7eD90DO/9+HA9DITtNmeLH64n0bccf8L9FqNAQss4bXWYe5OD5kRX1
         qm697QInKqG+yckAviIxXpBiADnoHK+vwFTZpRkFFO+8fKiQ3k0Ez9T93wU3YCQbYRx/
         RpzA==
X-Gm-Message-State: APjAAAXFOMxRnpFYWRXW0aP0BkK1nbTqYhLAEnxoWY93nNXyb77GvK+n
        U+6+K+opQ4CwhBKIi2J5pXM4ng==
X-Google-Smtp-Source: APXvYqzQdx6tFm8+bFhI0MhOEBcFZb7HQJUVAkbjAwYjSIls6XpKRirm8QaRzCKijyu2DFLv8vtyGg==
X-Received: by 2002:a63:f441:: with SMTP id p1mr78629pgk.362.1573600742209;
        Tue, 12 Nov 2019 15:19:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x192sm42848pfd.96.2019.11.12.15.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:19:01 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:19:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
Message-ID: <201911121517.DC317D5D@keescook>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <87d0e8g5f4.fsf@x220.int.ebiederm.org>
 <f272bdd3-526d-6737-c906-143d5e5fc478@gmail.com>
 <87h83jejei.fsf@x220.int.ebiederm.org>
 <eb2da7e4-23ff-597a-08e1-e0555d490f6f@gmail.com>
 <87tv7jciq3.fsf@x220.int.ebiederm.org>
 <1b0f94ef-ab1c-cb79-dd52-954cf0438af1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0f94ef-ab1c-cb79-dd52-954cf0438af1@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 09:35:46AM +0200, Topi Miettinen wrote:
> On 5.11.2019 1.41, Eric W. Biederman wrote:
> > My sense is that if there is any kind of compelling reason to make
> > world-readable values not world-readable, and it doesn't break anything
> > (except malicious applications) than a kernel patch is probably the way
> > to go.
> 
> With kernel patch, do you propose to change individual sysctls to not
> world-readable? That surely would help everybody instead of just those who
> care enough to change /proc/sys permissions. I guess it would also be more
> effort by an order of magnitude or two to convince each owner of a sysctl to
> accept the change.

I would think of this as a two-stage process: provide a mechanism to
tighten permissions arbitrarily so that it is easier to gather evidence
about which could have their default changed in the future.

> These code paths have not changed much or at all since the initial version
> in 2007, so I suppose the maintenance burden has not been overwhelming.
> 
> By the way, /proc/sys still allows changing the {a,c,m}time. I think those
> are not backed anywhere, so they probably suffer from same caching problems
> as my first version of the patch.

Is a v2 of this patch needed? It wasn't clear to me if the inode modes
were incorrectly cached...?

-- 
Kees Cook
