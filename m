Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990A21D1741
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 16:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbgEMOOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 10:14:25 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53750 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbgEMOOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 10:14:24 -0400
Received: by mail-pj1-f66.google.com with SMTP id hi11so11154424pjb.3;
        Wed, 13 May 2020 07:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MlF3xsxNQ24kh83NEFYAuZGvsZbUSwZ90HPe+BTs3NI=;
        b=Nsc1bQEwmGVebP2I4yLsJVoQIaa48Svo6wj9nr9QU7jO0dpcWDgkGfuoJD8EzYjI7a
         0ETmDRI8R/Q4wLWIWBsXn1nwtbcH6lv8hv4cPx6b8ZqcuKq5GfsABkVPX3epQgGPXj3P
         1iuTgaNr6cFYKsiS2i8hgCC2oU0IUf4aAAa5+ZfUf3Ci+SO1q8e9vZcFbT0V5uhRxlwU
         Mzf0qpuQ1k3wR9RAkSVKAGT9STS8WMrt+fBkaKqzccdXXWk8nV5X9a9Rx8t8R1v6ZFIP
         y2I9jCPGEZI2H4U5naI2FZWKsBTcUPWNXo/AVUtyXst/lEPbi8WmV6A2Cf7pphEsqn43
         YW9w==
X-Gm-Message-State: AOAM530tN+aM/O3B5Yg6YEe2mNSf8XreqtYcyhaUSzzardqb1jCLrlDi
        Ph+D2i0WZm8dYkHP65bMedY=
X-Google-Smtp-Source: ABdhPJzE4tMBjOobxccjL+b09F5IPma+z3oaYdHU4RpWwNZ3a+l1KF5etN81bsitZm9zC2Gl4S2KZw==
X-Received: by 2002:a17:90a:be09:: with SMTP id a9mr1634824pjs.165.1589379263954;
        Wed, 13 May 2020 07:14:23 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id ft14sm15515877pjb.46.2020.05.13.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 07:14:22 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 12A244063E; Wed, 13 May 2020 14:14:22 +0000 (UTC)
Date:   Wed, 13 May 2020 14:14:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
Message-ID: <20200513141421.GP11244@42.do-not-panic.com>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
 <87y2pxs73w.fsf@x220.int.ebiederm.org>
 <20200512172413.GC11244@42.do-not-panic.com>
 <87k11hrqzc.fsf@x220.int.ebiederm.org>
 <20200512220341.GE11244@42.do-not-panic.com>
 <87d078oss9.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d078oss9.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 08:42:30AM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > On Tue, May 12, 2020 at 12:40:55PM -0500, Eric W. Biederman wrote:
> >> Luis Chamberlain <mcgrof@kernel.org> writes:
> >> 
> >> > On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
> >> >> Luis Chamberlain <mcgrof@kernel.org> writes:
> >> >> 
> >> >> > +static struct ctl_table fs_base_table[] = {
> >> >> > +	{
> >> >> > +		.procname	= "fs",
> >> >> > +		.mode		= 0555,
> >> >> > +		.child		= fs_table,
> >> >> > +	},
> >> >> > +	{ }
> >> >> > +};
> >> >>   ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
> >> >> > > +static int __init fs_procsys_init(void)
> >> >> > +{
> >> >> > +	struct ctl_table_header *hdr;
> >> >> > +
> >> >> > +	hdr = register_sysctl_table(fs_base_table);
> >> >>               ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
> >> >> 	AKA
> >> >>         hdr = register_sysctl("fs", fs_table);
> >> >
> >> > Ah, much cleaner thanks!
> >> 
> >> It is my hope you we can get rid of register_sysctl_table one of these
> >> days.  It was the original interface but today it is just a
> >> compatibility wrapper.
> >> 
> >> I unfortunately ran out of steam last time before I finished converting
> >> everything over.
> >
> > Let's give it one more go. I'll start with the fs stuff.
> 
> Just to be clear moving the tables out of kernel/sysctl.c is a related
> but slightly different problem.

Sure, but also before we go on this crusade, how about we add a few
helpers:

register_sysctl_kernel()
register_sysctl_vm()
register_sysctl_fs()
register_sysctl_debug()
register_sysctl_dev()

That should make it easier to look for these, and shorter. We *know*
this is a common path, given the size of the existing table.

> Today it looks like there are 35 calls of register_sysctl_table
> and 9 calls of register_sysctl_paths.
> 
> Among them is lib/sysctl_test.c and check-sysctl-docs.
> 
> Meanwhile I can only find 5 calls to register_sysctl in the tree
> so it looks like I didn't get very far converting things over.

While we're on the spring cleaning topic, I've tried to put what I can
think of for TODO items here, anything else? Feel free to edit, its a
wiki after all.

https://kernelnewbies.org/KernelProjects/proc

Feel free to add wishlist items.

  Luis
