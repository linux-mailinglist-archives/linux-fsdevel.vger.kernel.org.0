Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA7D1D1890
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbgEMPC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 11:02:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37249 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbgEMPC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 11:02:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id x10so6925109plr.4;
        Wed, 13 May 2020 08:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MT118aZMRZUFyZNYM/mGEw6BOShbBFfm71Ixm+ag1Wk=;
        b=cVIFMuVnuPs7PgQTPIo1QazG+t0er1quF9fQ7qhDhobKz8hMN23xAH5+oHk6o5CjtS
         UDZmbUuXecLs9AnPr0NFKHB4Gcr0klmaAwRfFBkGcOw1tpavFaH0or7jpYJMDnLrfUj9
         YF7Ltz+KbOLUq7GXkcGhcWOa9ArVCXLwgnQMAp9mOZSQTFKrAsdsEYgKf8CFITzszOTM
         QmJ2ej+zSFiWCPaiwPqPPrQA3VIxJ1fgWAsHqZrEY0cSLR9wDxEnTy89/OC1V90Y+7OL
         fNTICzNHLvaDdU4bQmtwCVeuzrjCEqaUr/Ct4LqS127gDX8bozGEW57N0M/Q+0TeM3/v
         Tzaw==
X-Gm-Message-State: AGi0Pub2/mRccT3gjZSzv9ByWYcEZGxgS3T9pNCnFNxu3WYyR4Dv1wga
        FFKS7Hw/dQGg4uyg6lOr/qw=
X-Google-Smtp-Source: APiQypK/sufcq0cPAVcSuD3w73WdinHwTgnomrdyOeuh+IFkYrhqG3MPdpqAxWm6ywWZBeKsT2aoCA==
X-Received: by 2002:a17:90a:8c9:: with SMTP id 9mr35596299pjn.183.1589382143917;
        Wed, 13 May 2020 08:02:23 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c124sm14605811pfb.187.2020.05.13.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:02:22 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8E5C34063E; Wed, 13 May 2020 15:02:21 +0000 (UTC)
Date:   Wed, 13 May 2020 15:02:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
Message-ID: <20200513150221.GQ11244@42.do-not-panic.com>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
 <87y2pxs73w.fsf@x220.int.ebiederm.org>
 <20200512172413.GC11244@42.do-not-panic.com>
 <87k11hrqzc.fsf@x220.int.ebiederm.org>
 <20200512220341.GE11244@42.do-not-panic.com>
 <87d078oss9.fsf@x220.int.ebiederm.org>
 <20200513141421.GP11244@42.do-not-panic.com>
 <87tv0jopwn.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv0jopwn.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 09:44:40AM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > On Wed, May 13, 2020 at 08:42:30AM -0500, Eric W. Biederman wrote:
> >> Luis Chamberlain <mcgrof@kernel.org> writes:
> >> 
> >> > On Tue, May 12, 2020 at 12:40:55PM -0500, Eric W. Biederman wrote:
> >> >> Luis Chamberlain <mcgrof@kernel.org> writes:
> >> >> 
> >> >> > On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
> >> >> >> Luis Chamberlain <mcgrof@kernel.org> writes:
> >> >> >> 
> >> >> >> > +static struct ctl_table fs_base_table[] = {
> >> >> >> > +	{
> >> >> >> > +		.procname	= "fs",
> >> >> >> > +		.mode		= 0555,
> >> >> >> > +		.child		= fs_table,
> >> >> >> > +	},
> >> >> >> > +	{ }
> >> >> >> > +};
> >> >> >>   ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
> >> >> >> > > +static int __init fs_procsys_init(void)
> >> >> >> > +{
> >> >> >> > +	struct ctl_table_header *hdr;
> >> >> >> > +
> >> >> >> > +	hdr = register_sysctl_table(fs_base_table);
> >> >> >>               ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
> >> >> >> 	AKA
> >> >> >>         hdr = register_sysctl("fs", fs_table);
> >> >> >
> >> >> > Ah, much cleaner thanks!
> >> >> 
> >> >> It is my hope you we can get rid of register_sysctl_table one of these
> >> >> days.  It was the original interface but today it is just a
> >> >> compatibility wrapper.
> >> >> 
> >> >> I unfortunately ran out of steam last time before I finished converting
> >> >> everything over.
> >> >
> >> > Let's give it one more go. I'll start with the fs stuff.
> >> 
> >> Just to be clear moving the tables out of kernel/sysctl.c is a related
> >> but slightly different problem.
> >
> > Sure, but also before we go on this crusade, how about we add a few
> > helpers:
> >
> > register_sysctl_kernel()
> > register_sysctl_vm()
> > register_sysctl_fs()
> > register_sysctl_debug()
> > register_sysctl_dev()
> 
> Hmm.
> 
>   register_sysctl("kernel")
> 
> > That should make it easier to look for these, and shorter. We *know*
> > this is a common path, given the size of the existing table.
> 
> I don't really care but one character shorter doesn't look like it
> really helps.  Not really for grepping and not maintenance as we get a
> bunch of trivial one line implementations.

Alright, let's skip the helpers for now.

  Luis
