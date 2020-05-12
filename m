Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA01D1CEC7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 07:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgELFoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 01:44:11 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34245 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgELFoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 01:44:10 -0400
Received: by mail-pj1-f65.google.com with SMTP id l73so96519pjb.1;
        Mon, 11 May 2020 22:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GP5Aq+uFAcHSWqf5TbEfKkqCWH10YwxwBjLnjkDpTgw=;
        b=iykkvtPajnLR2cEz1UTvVbqN0frqRWsE1PajfI6ssASpG9/XDkGCQ4Tu9UdHN3Jo0Z
         kJmyoUf+O4Z4Rhl+LVjTxSSe7b2KVX/58Huvkhwsgcta3Wmc2pvyb8n3zzLMq8O1PKAq
         Gi9h8Bj5t/0l4odcpISBmBs0Odu5tWvDM9HSj8Rnsk8810Mqb3zFTDuCyQUrQyXKuh3N
         CODGvU38ZSSvP5gPygmcaMkTgLePRej+fQBhjJ5e3Qn+03+gQdmUyGVFGsYEUJyG7kRR
         CMt587coANvMRz8W8geuU9k9Ihgl/XFRPQVkOHOAYuAi/56dim53M4qe0JAafAcuvZYs
         9P8A==
X-Gm-Message-State: AOAM532WXanVou9L609t5eScBiLYHS7QwH25XYxynfybSxhR5RFp3/gX
        7aeTVERcZSQ1UA8DDq4yhhY=
X-Google-Smtp-Source: ABdhPJy5FNalWj7ad0WRBq8wpf33KSe4zNF7L5vvmMJu5PysnhTwIrnkXKA904loq4xm9a62tNMEDQ==
X-Received: by 2002:a17:902:b618:: with SMTP id b24mr2897635pls.155.1589262250172;
        Mon, 11 May 2020 22:44:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s9sm10913434pfc.179.2020.05.11.22.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 22:44:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 986C640E88; Tue, 12 May 2020 05:44:08 +0000 (UTC)
Date:   Tue, 12 May 2020 05:44:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
Message-ID: <20200512054408.GZ11244@42.do-not-panic.com>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
 <202005112219.0FB0A7A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005112219.0FB0A7A@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 10:22:04PM -0700, Kees Cook wrote:
> On Tue, May 12, 2020 at 12:33:05AM +0000, Luis Chamberlain wrote:
> > On Mon, May 11, 2020 at 09:55:16AM +0800, Xiaoming Ni wrote:
> > > On 2020/5/11 9:11, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Today's linux-next merge of the vfs tree got a conflict in:
> > > > 
> > > >    kernel/sysctl.c
> > > > 
> > > > between commit:
> > > > 
> > > >    b6522fa409cf ("parisc: add sysctl file interface panic_on_stackoverflow")
> > > > 
> > > > from the parisc-hd tree and commit:
> > > > 
> > > >    f461d2dcd511 ("sysctl: avoid forward declarations")
> > > > 
> > > > from the vfs tree.
> > > > 
> > > > I fixed it up (see below) and can carry the fix as necessary. This
> > > > is now fixed as far as linux-next is concerned, but any non trivial
> > > > conflicts should be mentioned to your upstream maintainer when your tree
> > > > is submitted for merging.  You may also want to consider cooperating
> > > > with the maintainer of the conflicting tree to minimise any particularly
> > > > complex conflicts.
> > > > 
> > > 
> > > 
> > > Kernel/sysctl.c contains more than 190 interface files, and there are a
> > > large number of config macro controls. When modifying the sysctl interface
> > > directly in kernel/sysctl.c , conflicts are very easy to occur.
> > > 
> > > At the same time, the register_sysctl_table() provided by the system can
> > > easily add the sysctl interface, and there is no conflict of kernel/sysctl.c
> > > .
> > > 
> > > Should we add instructions in the patch guide (coding-style.rst
> > > submitting-patches.rst):
> > > Preferentially use register_sysctl_table() to add a new sysctl interface,
> > > centralize feature codes, and avoid directly modifying kernel/sysctl.c ?
> > 
> > Yes, however I don't think folks know how to do this well. So I think we
> > just have to do at least start ourselves, and then reflect some of this
> > in the docs.  The reason that this can be not easy is that we need to
> > ensure that at an init level we haven't busted dependencies on setting
> > this. We also just don't have docs on how to do this well.
> > 
> > > In addition, is it necessary to transfer the architecture-related sysctl
> > > interface to arch/xxx/kernel/sysctl.c ?
> > 
> > Well here's an initial attempt to start with fs stuff in a very
> > conservative way. What do folks think?
> > 
> > [...]
> > +static unsigned long zero_ul;
> > +static unsigned long long_max = LONG_MAX;
> 
> I think it'd be nice to keep these in one place for others to reuse,
> though that means making them non-static. (And now that I look at them,
> I thought they were supposed to be const?)

So much spring cleaning to do. I can add the const and share it.
It seems odd to stuff this into a sysctl.h, types.h doesn't seem
right... I can't think of something proper, so I'll just move them
to sysctl.h for now.

Any thought on the approach though? I mean, I realize that this will
require more of the subsystem specific folks to look at the code and
review, but if this seems fair, I'll get the ball rolling.

  Luis
