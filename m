Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9EB88D56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 22:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHJUpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 16:45:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41856 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfHJUpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:45:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so10889669ota.8;
        Sat, 10 Aug 2019 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxgKq0uvzgCy9T3HtT1FHqYi+XIOfhSX9HlOxN06+Q4=;
        b=EnyNaVfR6RBYyx+WdJpxHBqOGXStQ1CR0UViT9LmJrhpXHZ5Alpzl4erD6vu8UVFzM
         I9CJTMHWXU4ehhHPipZ1rmTYULmZPQS9rqB4pma/8MFzAww89hM3o+6zHWAa7dmgisgt
         4WgI36e6M1CT1qGPrFHWP3AKge2nY1sqhCZyFZ3BT9r5q+aVkdJDQelvthvwqDNcrf3A
         ukr13yXnMF6hyqJlgsj20W7fvSREYyhh/OXa6WJp4gunXU6tyXU+4l8lfSJsTMBUFAgc
         g+4efOCXNnsp8NIVq/EGXOAB2FssqWCGILegUSJntnVYC9oC3k1MPhSjmaI3wmHj0vNh
         OifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxgKq0uvzgCy9T3HtT1FHqYi+XIOfhSX9HlOxN06+Q4=;
        b=pLacBFqNSqow4FejV7dGsE5xePHaWuMdWp3n1tUASRaDftLkHVzPeiQQhUAeeUIbVK
         DyG+vPRJF68PnBWaxHLCMjWTbvqplmcNwMpqikbBSA6ZUMntVrGoE/TLn+7aTxnlsJ4E
         kLtrkZQn5970AxH0h8g+8CiAe9MLOelco6jxJFUqZ3KhnYG2A0qRY9iB49k0l8Iph2/7
         QhycdomXpMVSN/VfmOwLG8AuoI6LXAu0d9MfQnYCw3ZRG/ND+BPWQEDVrCnDBlVAN9vb
         wr6zxR2c9FrHWy99q8Xcp9MhbaF9yv2QjMGeNgPPwtMTcAinj7U2DNNMQd7EbwUD4pBP
         z+Nw==
X-Gm-Message-State: APjAAAWCOmkWaWE/q28XM3AcbXyVIDCMZdJvw5CJvCA2Pr/p6bhHOf3f
        f8PLpIKbgSsHGO18ElJRviVMGBQVrxEBqKtZ21l5sw==
X-Google-Smtp-Source: APXvYqyLFLjwXOVFOcYFXPODdfCLOQdnEaEv3OW/QjfpGeANuOjHLCLd/XzqkJzMQdfsBj81W8y7nvyUQG5WyUUUgKs=
X-Received: by 2002:a02:10:: with SMTP id 16mr15375851jaa.96.1565469909350;
 Sat, 10 Aug 2019 13:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-5-deepa.kernel@gmail.com>
 <c508fe0116b77ff0496ebb17a69f756c47be62b7.camel@codethink.co.uk>
In-Reply-To: <c508fe0116b77ff0496ebb17a69f756c47be62b7.camel@codethink.co.uk>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 10 Aug 2019 13:44:57 -0700
Message-ID: <CABeXuvruROn7j1DiCDbP6MLBt9SB4Pp3HoKqcQbUNPDJgGWLgw@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 04/20] mount: Add mount warning for impending
 timestamp expiry
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 5, 2019 at 7:14 AM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
> > The warning reuses the uptime max of 30 years used by the
> > setitimeofday().
> >
> > Note that the warning is only added for new filesystem mounts
> > through the mount syscall. Automounts do not have the same warning.
> [...]
>
> Another thing - perhaps this warning should be suppressed for read-only
> mounts?

Many filesystems support read only mounts only. We do fill in right
granularities and limits for these filesystems as well. In keeping
with the trend, I have added the warning accordingly. I don't think I
have a preference either way. But, not warning for the red only mounts
adds another if case. If you have a strong preference, I could add it
in.

-Deepa
