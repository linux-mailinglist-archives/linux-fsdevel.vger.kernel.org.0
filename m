Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7B201CD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 23:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391778AbgFSVHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 17:07:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32822 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391671AbgFSVHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:07:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id b201so4976392pfb.0;
        Fri, 19 Jun 2020 14:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fgKI9tiUDPjaNu37VXrZWB4azE+juqRY/GXLgBajdA8=;
        b=tuzJn7icnrIX4p63d6zmK2FvbEvHlmz5hTWSL6/1um8CqGPjh8aS2j5LS+Ncga+5hk
         d9pXKBwReO4z6S0KpJbhzqaiH2UDAV0GnCiVXoO0K3pZDHl3ugyHD5m/kIRiNQs/Gtl3
         1STa+Xp42uLI0JNRJ1vHPfB78WJjNgSS4bU9PzU8hWlqUkfdi4vESzJRNyrB2diMpNMi
         7wdHide6LbQvGx6Jm5huWovHrs7L/STVbrgWL0NzfdyOgjN54dH9b9QwjC/fz/Oe/vQY
         Z+3SQFh5qtikfrCC7UdWRVKpw/bzAkP2vhZ/rwIbKxcyUksf9zF10KVdZMP+lE8LM7Hx
         2GDg==
X-Gm-Message-State: AOAM532issOsu1zXIIW0srkdvrGW5a2iK5fz+XCBLh26l8ycga8MZe0/
        d7YBAsg2RBqH7L3pOWlknrw=
X-Google-Smtp-Source: ABdhPJyOaY2vu4Wv5GQOCd0H8uBFHKWtpSNfsj8V4ycknjrch6X+te7gHMq/EQGy7YV3W+a/Mn2mSA==
X-Received: by 2002:a62:31c6:: with SMTP id x189mr10316191pfx.79.1592600828604;
        Fri, 19 Jun 2020 14:07:08 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i3sm5849845pjv.1.2020.06.19.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 14:07:06 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 10DDA4063E; Fri, 19 Jun 2020 21:07:06 +0000 (UTC)
Date:   Fri, 19 Jun 2020 21:07:06 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jessica Yu <jeyu@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, serge@hallyn.com, christian.brauner@ubuntu.com,
        slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org,
        josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org,
        linux-fsdevel@vger.kernel.org, bridge@lists.linux-foundation.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] kmod/umh: a few fixes
Message-ID: <20200619210706.GJ13911@42.do-not-panic.com>
References: <20200610154923.27510-1-mcgrof@kernel.org>
 <20200617174348.70710c3ecb14005fb1b9ec39@linux-foundation.org>
 <20200619204626.GK11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619204626.GK11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry it seems mutt ate my To:, so adding the folks I intended to
address on the To: field now :)

  Luis

On Fri, Jun 19, 2020 at 08:46:26PM +0000, Luis Chamberlain wrote:
> On Wed, Jun 17, 2020 at 05:43:48PM -0700, Andrew Morton wrote:
> > On Wed, 10 Jun 2020 15:49:18 +0000 "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> > 
> > > Tiezhu Yang had sent out a patch set with a slew of kmod selftest
> > > fixes, and one patch which modified kmod to return 254 when a module
> > > was not found. This opened up pandora's box about why that was being
> > > used for and low and behold its because when UMH_WAIT_PROC is used
> > > we call a kernel_wait4() call but have never unwrapped the error code.
> > > The commit log for that fix details the rationale for the approach
> > > taken. I'd appreciate some review on that, in particular nfs folks
> > > as it seems a case was never really hit before.
> > > 
> > > This goes boot tested, selftested with kmod, and 0-day gives its
> > > build blessings.
> > 
> > Any thoughts on which kernel version(s) need some/all of these fixes?
> 
> Well, in so far as fixes, this is the real important part:
> 
> * request_module() used to fail with an error code of
>   256 when a module was not found. Now it properly
>   returns 1.
> 
> * fs/nfsd/nfs4recover.c: we never were disabling the
>   upcall as the error code of -ENOENT or -EACCES was
>   *never* properly checked for error code
> 
> Since the request_module() fix is only affecting userspace
> for the kmod tests, through the kmod test driver, ie, we don't expose
> this to userspace in any other place, I don't see that as critical.
> Let me be clear, we have a test_kmod driver which exposes knobs
> and one of the knobs lets userspace query the return value of a
> request_module() call, and we use this test_kmod driver to stress
> test kmod loader. Let us also recall that the fix is *iff* an error
> *did* occur. I *cannot* think of a reason why this would be critical
> to merge to older stable kernels for this reason for request_module()'s
> sake.
> 
> Bruce, Chuck:
> 
> But... for NFS... I'd like the NFS folks to really look at that
> and tell us is some folks really should care about that. I also
> find it perplexing there was a comment in place there to *ensure*
> the error was checked for, and so it seemed someone cared for that
> condition.
> 
> > >  drivers/block/drbd/drbd_nl.c         | 20 +++++------
> > >  fs/nfsd/nfs4recover.c                |  2 +-
> > >  include/linux/sched/task.h           | 13 ++++++++
> > >  kernel/kmod.c                        |  5 ++-
> > >  kernel/umh.c                         |  4 +--
> > >  lib/test_kmod.c                      |  2 +-
> > >  net/bridge/br_stp_if.c               | 10 ++----
> > >  security/keys/request_key.c          |  2 +-
> > >  tools/testing/selftests/kmod/kmod.sh | 50 +++++++++++++++++++++++-----
> > 
> > I'm not really sure who takes kmod changes - I'll grab these unless
> > someone shouts at me.
> 
> Greg usually takes it, but as usual, thanks for picking up the slack ;)
> 
>   Luis
