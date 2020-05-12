Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D61CEC63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 07:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgELFWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 01:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELFWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 01:22:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D4AC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 22:22:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id z15so208913pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 22:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tui6R+wLa0kQmrDETUfafc3KbI5b0/0SxwmiRjNIF7A=;
        b=cfLoppT6e2JbWKXLzwROnhBqU7urDGmXU6Ivw2izkCXo/+x7WT/Ebs1LICZTajvBLq
         3asbc7tjFnP38cIPLziD7oWYkFhtGKVBRMn0MsxP0ouJdxB/FZZ+XXdBniOBsRzzJ47S
         VvHVnTfJyrUrE66iJ6A9neuBL/mUQBnftZqfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tui6R+wLa0kQmrDETUfafc3KbI5b0/0SxwmiRjNIF7A=;
        b=kAJkuwtMK47zZm/6G/F/mAJ0nx79pavV2Dlo8MuzBc+EZjtlIhNwXDtLpIiaayXs0i
         mimjm/ynK1nUcEJULnhTRwH4my2Bl4BZa4AzPqMdyxt52lsLYQA+ToCOUN0aM7If83fd
         rw0J0pIvkFvWXtRDpoFXXg8rpLG9b2SLc46zk1l2X7g8vAEmYWrVjo+8S3IhFrRRpe+S
         qjM/uQHreasu72KPy1o1CihJTDw14Rdijn3AQPgXeI7SlcXqxqn4gfoD31KsOpQwXb/0
         oyAu46aFgo8IZebNFp00AE0SNtax9O/8zfjwKX29RAwf6ed47vkY2z0dYRt8uIfdwKxT
         5d1g==
X-Gm-Message-State: AOAM530wyj12FFGrtWIZuGq19fZIV+cjTChCgc/EBXQjOZeYmh3whTJf
        VQboYMHOw7G2/WZlR5biA+m8qQ==
X-Google-Smtp-Source: ABdhPJzpcqmP6SfdzxFzIUYtW3i2pwdFwJgS5MLGiC8zzR/ZRdQQ6sNBrbCe+7GqW7hufQlLuAGEnw==
X-Received: by 2002:a17:90a:24ac:: with SMTP id i41mr790988pje.24.1589260926558;
        Mon, 11 May 2020 22:22:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gz19sm11526688pjb.7.2020.05.11.22.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 22:22:05 -0700 (PDT)
Date:   Mon, 11 May 2020 22:22:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <202005112219.0FB0A7A@keescook>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512003305.GX11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 12:33:05AM +0000, Luis Chamberlain wrote:
> On Mon, May 11, 2020 at 09:55:16AM +0800, Xiaoming Ni wrote:
> > On 2020/5/11 9:11, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the vfs tree got a conflict in:
> > > 
> > >    kernel/sysctl.c
> > > 
> > > between commit:
> > > 
> > >    b6522fa409cf ("parisc: add sysctl file interface panic_on_stackoverflow")
> > > 
> > > from the parisc-hd tree and commit:
> > > 
> > >    f461d2dcd511 ("sysctl: avoid forward declarations")
> > > 
> > > from the vfs tree.
> > > 
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.
> > > 
> > 
> > 
> > Kernel/sysctl.c contains more than 190 interface files, and there are a
> > large number of config macro controls. When modifying the sysctl interface
> > directly in kernel/sysctl.c , conflicts are very easy to occur.
> > 
> > At the same time, the register_sysctl_table() provided by the system can
> > easily add the sysctl interface, and there is no conflict of kernel/sysctl.c
> > .
> > 
> > Should we add instructions in the patch guide (coding-style.rst
> > submitting-patches.rst):
> > Preferentially use register_sysctl_table() to add a new sysctl interface,
> > centralize feature codes, and avoid directly modifying kernel/sysctl.c ?
> 
> Yes, however I don't think folks know how to do this well. So I think we
> just have to do at least start ourselves, and then reflect some of this
> in the docs.  The reason that this can be not easy is that we need to
> ensure that at an init level we haven't busted dependencies on setting
> this. We also just don't have docs on how to do this well.
> 
> > In addition, is it necessary to transfer the architecture-related sysctl
> > interface to arch/xxx/kernel/sysctl.c ?
> 
> Well here's an initial attempt to start with fs stuff in a very
> conservative way. What do folks think?
> 
> [...]
> +static unsigned long zero_ul;
> +static unsigned long long_max = LONG_MAX;

I think it'd be nice to keep these in one place for others to reuse,
though that means making them non-static. (And now that I look at them,
I thought they were supposed to be const?)

-- 
Kees Cook
