Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9805576B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfFYSzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 14:55:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39042 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbfFYSzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:55:23 -0400
Received: by mail-yw1-f66.google.com with SMTP id u134so7998145ywf.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YoWQjtvkCeSVA1kdmqc11ysNxmHPU03GqQotMHxDp2U=;
        b=JYQNOBN93vshA1tG3sDASUASg0IgzYx8xGpNBbiFRHkUwh3oZdl9OlCx6jtrKyS1PA
         CrWyYZ0jKnkrirlUqW6deRq7Fi6sW4Rq7eUgopdxHjU0QgcSHpvnnweYhXypKLiZZ8vR
         cuf6eyKxBAOFtGHE/zKQbWG3mZn2Wr8Hi+aiv/FAG+RF4izFWbaYnBMO5ymEVTPlxI6o
         GvXxL0SVizG6nae8EeWBXNJsx5f76Ti+nvMB1QSd1ziILN0yR33OlN0W+m7qyFqpJ5Sg
         HCuiwnpaCzlQslCfLzZHyriG7QbIAsi4t7cY765LFqIKVeUOnfdvuu6dRL8/eLhFKxJD
         9o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YoWQjtvkCeSVA1kdmqc11ysNxmHPU03GqQotMHxDp2U=;
        b=p8U6c1yglkwGiKJ91gKVJMRpIu+eJeGwlUwyxndcI8gewOq2z3hh6g9TthCI575Kh2
         +V3+Y/QUTMRroP3HIaIYRlDJ7WFFGRcQmxeE+AaqdEJmvmTFNyLPUN4wQhIz5q41JI+L
         ftWwJC/XkYyw1/wEKQoZqb86rUK77E/LnvaJznhBc9Y8XExp/OTv0dQW6ZUDP74Ithpo
         TNqdBkW8jZ/EL6ndKf/V8ObK8gpy3mmgZOVeBuE+jMFXrziETZIwWEfEo+TvMBBMAv8O
         oND7mvZ0PhkBPlkec1snkDNkeuuluOnq89xRzL4mB1+cjaskaOhVs5yGcH5KtmFmIy+D
         1h5Q==
X-Gm-Message-State: APjAAAXAksf8Mr5MGQOCkqGXp1JvcSyW6qhkNE0HJRaA2mKuXB6tk31j
        Ia30g7dyh07ZDgkiafQsjY7hpKjpn1ClMj1RtqNWUQ==
X-Google-Smtp-Source: APXvYqzrnRLAsUllxL7vPOP5CM7N8fL1sWjlkqRDPfbOcLxlOi/xZjJsQ1aD+hFTQ8G5wxrFE8DwHOAM7ic7kFMTk6c=
X-Received: by 2002:a81:5cd6:: with SMTP id q205mr121944ywb.13.1561488922875;
 Tue, 25 Jun 2019 11:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190511132700.4862-1-colin.king@canonical.com>
 <CAOg9mSQt42NQu-3nwZOCGOPx45y7G8aaiDaVe4SwotGnD9iY1A@mail.gmail.com> <20190521150311.GL31203@kadam>
In-Reply-To: <20190521150311.GL31203@kadam>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 25 Jun 2019 14:55:11 -0400
Message-ID: <CAOg9mSQmV=BDMpTNLJvb4QBr=f96qg4Hr9qu=bB6xZubB+1LZQ@mail.gmail.com>
Subject: Re: [PATCH] orangefs: remove redundant assignment to variable buffer_index
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> The only explanation I can think of is that you guys are discussing
>> different code. :P

My response contained several conflations :-) ...

The code in file.c that Colin has flagged does indeed have buffer_index
being initialized needlessly, and the assignment noted by Dan is also
needless. There's even a second needless assignment done in another
place in the same function. While the code around them has changed over
time, these now needless manipulations of buffer_index are not new. I'll
get rid of them.

>> You often send these patches before they hit linux-next so I had skipped
>> reviewing this one when you sent it.

I know Linus is likely to refuse pull requests for stuff that
has not been through linux-next, so I make sure stuff has been
there at least a few days before asking for it to be pulled.
"A few days" is long enough for robots to see it, perhaps not
long enough for humans. I especially appreciate the human review. One of
the good things about Orangefs is that it is easy to install and configure,
especially for testing. Documentation/filesystems/orangefs.txt has
instructions for dnf installing orangefs on Fedora, and also how to download
a source tarball and install from that.

-Mike

On Tue, May 21, 2019 at 11:04 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, May 16, 2019 at 12:06:31PM -0400, Mike Marshall wrote:
> > Hi Colin...
> >
> > Thanks for the patch. Before I initialized buffer_index, Dan Williams sent
> > in a warning that a particular error path could try to use ibuffer_index
> > uninitialized. I could induce the problem he described with one
> > of the xfstests resulting in a crashed kernel. I will try to refactor
> > the code to fix the problem some other way than initializing
> > buffer_index in the declaration.
> >
>
> The only explanation I can think of is that you guys are discussing
> different code.  :P
>
> regards,
> dan carpenter
>
