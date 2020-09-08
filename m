Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE326237A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 01:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgIHXMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgIHXL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:11:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCF6C061573;
        Tue,  8 Sep 2020 16:11:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gf14so360438pjb.5;
        Tue, 08 Sep 2020 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d2eXmnCqu0SOOWoMlCLyygGtYkUiwKo4dKRW0ixC3Qc=;
        b=F83+yibeQuEhJKMBgMMEZWgtOX/N47s7/FjWmpncrajXpMzj3DycInSP57lZ9TFWvA
         WD2/GU2ySfG155GFM68+rkB+PiulBHhHFFmSA48T8p7AB7bJPqR/7tJGXqafOknQfUjz
         fdzr1AutBPLDKqqsuJ3SXGVQzE0lgR9HDYKeOclqPfBlgv9cxHi8XnC7o37LoWc71CGi
         Ev1/f8oylIXxSK64AcOJvZXFfXcYoTHL7XVF892uqeDO/vNm2MUJdcUS03wtB8ors6JX
         yHojeq1iu/DcEOVWL0dftXD4XIZW3VcfZPQDDXV/a1alUDa/BGneHydY7Y0BDQMV4d92
         y0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d2eXmnCqu0SOOWoMlCLyygGtYkUiwKo4dKRW0ixC3Qc=;
        b=f/9vxT2NAK5RzpnzwRGm0xYbw5fOuYvdiE0kUj7128T1MpIC0bXMP5AmvecZgjQggq
         BrEeevOyCNHeP+Aig8/di4H2QERnBtGSkKLI9QwQub0bDTV2ckuxRZWzpBk312ob376o
         mUzaqz4x0GPCbfAaCpz6W+BSjRVHfTmKX9I48qDi3xNKY0YH4RRMNojEaHJ4T0N3544o
         8pPbcp/qJE0JCUmJxixnueMAFWERjccWBwnv4uJaG/LXAw9rOgPqmGyV5x2ZkTU7jWbh
         /tJGy3h9deTnrsQtgqnZwNK10DDNAh+JC5y1UhsiEV6nNqiYu6nj72cwjroRBe741O+D
         xXKw==
X-Gm-Message-State: AOAM533qoZopHE0DCOtxAzLT6M7pBpEBsFOCfpuXNaIBNK+I9VJk4LTI
        Lxs6KWQI/uTMbi2mssiiDhNFf4TMVMMKc8Zk
X-Google-Smtp-Source: ABdhPJzPpNPLNQ3z9wRKwxsyFYUr3HWELu38gHveaOKPMujSahmpKQbLkQeNvGxoSNM0c6C7Y0QDJA==
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr1031212pjr.228.1599606719169;
        Tue, 08 Sep 2020 16:11:59 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id 82sm313998pgd.6.2020.09.08.16.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 16:11:58 -0700 (PDT)
Date:   Tue, 8 Sep 2020 23:11:56 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Eliminate a local variable to make the code more
 clear
Message-ID: <20200908231156.GA23779@haolee.github.io>
References: <20200729151740.GA3430@haolee.github.io>
 <20200908130656.GC22780@haolee.github.io>
 <20200908184857.GT1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908184857.GT1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 07:48:57PM +0100, Al Viro wrote:
> On Tue, Sep 08, 2020 at 01:06:56PM +0000, Hao Lee wrote:
> > ping
> > 
> > On Wed, Jul 29, 2020 at 03:21:28PM +0000, Hao Lee wrote:
> > > The dentry local variable is introduced in 'commit 84d17192d2afd ("get
> > > rid of full-hash scan on detaching vfsmounts")' to reduce the length of
> > > some long statements for example
> > > mutex_lock(&path->dentry->d_inode->i_mutex). We have already used
> > > inode_lock(dentry->d_inode) to do the same thing now, and its length is
> > > acceptable. Furthermore, it seems not concise that assign path->dentry
> > > to local variable dentry in the statement before goto. So, this function
> > > would be more clear if we eliminate the local variable dentry.
> 
> How does it make the function more clear?  More specifically, what
> analysis of behaviour is simplified by that?

When I first read this function, it takes me a few seconds to think
about if the local variable dentry is always equal to path->dentry and
want to know if it has special purpose. This local variable may confuse
other people too, so I think it would be better to eliminate it.

Thanks,
Hao Lee
