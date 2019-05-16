Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 667F820A8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 17:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfEPO7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 10:59:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44441 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfEPO7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 10:59:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so5654587edm.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9KSZWGLEZmzzku3a/BIVpEpdyfxDETMafUlcIGbaGkM=;
        b=U6zq47FzoLAi+b5aB6R87xgXMlJSHtX2ZWhNh+CpTsgGf/e0RtGT4/vP/NctcAL2Rp
         sMxaf9Drfma0PxYrMUCpH9dyOBA4phV+kW/nvPoHht3MeN5m85i6PUdM3bY2ap00D+n2
         CJg3t28fjY2M/LJyRa4RH5bbVaYkhAZtbDu4JnGH6BJqvSXQv+lReOnQgkJOGY08+QSy
         17AtTzfu59sJs2sMlTt2MPJnCaq/K2OLVU245mLBQALmSPA541gl0t0emEChlAyaBVTk
         qyKU/l5pCBoWzve7JCQmrzeEBpCbak2GdD2pKyG8bNj0/CnbYmhB85v/LGuGBDl7Dwhj
         p/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9KSZWGLEZmzzku3a/BIVpEpdyfxDETMafUlcIGbaGkM=;
        b=Fha1aNhIEdGvoHzmdlTRTE9nI0PrAsKL+B7kC5RAts5EqcoX/TOirbNmWeaz7shnTs
         r2stbf17oqRfWhvdLZAgJq/I1Ywh8rRL2TZTrwjXvFhdID7B+ClD/TGQF1E8xVDQVPav
         fxkNUvBUv7Q0rH1hX58g37qgJSnpIGoMZrctReyC1H8Fg3KSWJC6uvP7TyaaCf4vfEv5
         HBtRhoOeIg3ZSd0lJ40Suats42pSxDdFolP+irDnqkMCG2EaubTCfnsrgrjBWnnrTVgg
         XYgswqnQ+8Xe7ejEtb5V9nx8ugNZDzbn/zCJpUy9CUJf0XwHY1AOtuiila3LPr0cuH63
         HmHw==
X-Gm-Message-State: APjAAAXbhsPHn0SexsLN2cA2m/GHw/WyF4HbkBmgNPmUSF4xMwVYFfUE
        jL0i6OPadTNooB5FWtWOWMZCzg==
X-Google-Smtp-Source: APXvYqzlsUl3pftfA6oXcxjyn7dDmYqpibTf4H0mIhgsIaTlcrCxLNC0GR5Fgj6uHWo0H3FOAaDMbA==
X-Received: by 2002:a17:906:f84c:: with SMTP id ks12mr28651055ejb.270.1558018783866;
        Thu, 16 May 2019 07:59:43 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id hb11sm1125567ejb.43.2019.05.16.07.59.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 07:59:43 -0700 (PDT)
Date:   Thu, 16 May 2019 16:59:42 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Howells <dhowells@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] uapi: Wire up the mount API syscalls on non-x86
 arches [ver #2]
Message-ID: <20190516145941.dzlf4kxrxoeeoa6t@brauner.io>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <155800755482.4037.14407450837395686732.stgit@warthog.procyon.org.uk>
 <CAMuHMdWsgSWC2AFGf_XBaEc0g=FDkGB1=UH+Ekh9n6k3W4ifWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWsgSWC2AFGf_XBaEc0g=FDkGB1=UH+Ekh9n6k3W4ifWQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 04:56:10PM +0200, Geert Uytterhoeven wrote:
> Hi David, Christian,
> 
> On Thu, May 16, 2019 at 1:54 PM David Howells <dhowells@redhat.com> wrote:
> > Wire up the mount API syscalls on non-x86 arches.
> >
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> > +428    common  open_tree                       sys_open_tree
> > +429    common  move_mount                      sys_move_mount
> > +430    common  fsopen                          sys_fsopen
> > +431    common  fsconfig                        sys_fsconfig
> > +432    common  fsmount                         sys_fsmount
> > +433    common  fspick                          sys_fspick
> 
> The first number conflicts with "[PATCH v1 1/2] pid: add pidfd_open()".
> 
> Note that none of this is part of linux-next.

Yep, already spotted this thanks to Arnd.
David, there's nothing you need to do of course. I'll change the syscall
number for pidfd_open(). Your patchset obviously has priority!

Thanks!
Christian

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
