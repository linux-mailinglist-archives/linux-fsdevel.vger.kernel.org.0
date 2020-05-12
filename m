Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5F41D018B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgELWDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 18:03:45 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53276 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgELWDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 18:03:44 -0400
Received: by mail-pj1-f65.google.com with SMTP id hi11so10202018pjb.3;
        Tue, 12 May 2020 15:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jPas3FVTQ077tq4XLx1f6zCjNgfjXBxht/KPP+7OEug=;
        b=az4dz60fUx0TGGjY0OrzgvIn5nL20WbvyWATzslSo72V9Xh97IG4zxDBaUFWstzD83
         1cJAssqckTzhAJrErel+8Jy5DyzW1W+EHs6SWD/zvCpQmYoe43upNVCoRYFlUXxu/laS
         Is4FhS9BzLfVBg5gKkA+WS/y8VQHD2eEITkyk9CVaPatEyRsmHwBluvFJsqxGaKIRKor
         UVPiDusOgvr3IQXwqYS9QqdfNlhVYE6/LZy0l1zRgjL1Qge5g5UnmNltUJcOj2EIadNx
         aYnCPDUqT3COouxtUA8A631HOJExzblSCrybWmvJalZnexGSuifiJhfImrPJhtJUBKLQ
         fCdA==
X-Gm-Message-State: AGi0PuaTP6oVnQzFYJJlsyhQWfZc2pCYQSdyDWzr3/1eW/7jJ4QieZ/r
        UGk++10ynz+ne2w/ovCeJRU=
X-Google-Smtp-Source: APiQypLRR8P3Hy27Aan2ceEueeRcL0xTQS/0wfLdqo/lGe83BBK2NFiFKG1bubvoAzbVD2Yk3HpUbQ==
X-Received: by 2002:a17:902:c281:: with SMTP id i1mr21719181pld.85.1589321023383;
        Tue, 12 May 2020 15:03:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o27sm681142pgd.18.2020.05.12.15.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:03:42 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 76A134063E; Tue, 12 May 2020 22:03:41 +0000 (UTC)
Date:   Tue, 12 May 2020 22:03:41 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
Message-ID: <20200512220341.GE11244@42.do-not-panic.com>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
 <87y2pxs73w.fsf@x220.int.ebiederm.org>
 <20200512172413.GC11244@42.do-not-panic.com>
 <87k11hrqzc.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k11hrqzc.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 12:40:55PM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
> >> Luis Chamberlain <mcgrof@kernel.org> writes:
> >> 
> >> > +static struct ctl_table fs_base_table[] = {
> >> > +	{
> >> > +		.procname	= "fs",
> >> > +		.mode		= 0555,
> >> > +		.child		= fs_table,
> >> > +	},
> >> > +	{ }
> >> > +};
> >>   ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
> >> > > +static int __init fs_procsys_init(void)
> >> > +{
> >> > +	struct ctl_table_header *hdr;
> >> > +
> >> > +	hdr = register_sysctl_table(fs_base_table);
> >>               ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
> >> 	AKA
> >>         hdr = register_sysctl("fs", fs_table);
> >
> > Ah, much cleaner thanks!
> 
> It is my hope you we can get rid of register_sysctl_table one of these
> days.  It was the original interface but today it is just a
> compatibility wrapper.
> 
> I unfortunately ran out of steam last time before I finished converting
> everything over.

Let's give it one more go. I'll start with the fs stuff.

  Luis
