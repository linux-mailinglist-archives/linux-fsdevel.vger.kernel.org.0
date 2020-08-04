Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E1A23C0DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 22:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHDUnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 16:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgHDUnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:43:03 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43951C061757
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 13:43:03 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id 186so1949617vkx.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TlCjdbRMbP/wUOWxhVpHiQRbe/DkH4AfQXHxlQhoVjA=;
        b=EOi3TYycOATstmP6d5D/4kHK77cpmm07nIj5AHuvfKmnLxKlJXrFY2QFvli6qNNCKA
         wqQ6Gx1OjpknqNrHPOsQ6i5pA4Nsl/0P+o8YnHG9NApjT17RZYWFm2ppHG2Oa91sfuxA
         V7/UnvO5E3bSeNaQiSfAOAo3JPrbiEZyVWI1xZBomo1Dr5q+3bfJwXgF9dxiWHQGZQ2B
         pLhcuu+09iTwu7nNQoaBdcI38gAj4GsGHfeAu8E+COwEkQ7qG41AYUnujdSx6sdIvWGB
         LIzkgD64Cktj4Lrk9qYaJk7E7mh6dWZ2/a0BboxrjqurpZNuVBcAGleuhJxvMUPytp7k
         494Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TlCjdbRMbP/wUOWxhVpHiQRbe/DkH4AfQXHxlQhoVjA=;
        b=qpWSZfxU9cg19EuHjsdGc8uTUy7dzZyAD403oEysutpnMg6j5TLFAj4f+TbBch7/u9
         nYmpMdm1i9ks/LrpIH+sO2kzM7YKHqAw0wishDEXLkyYI4vmEw7lr0J9TdnSGu0FOv7/
         d08vRBH82kgk3d4rW+2ZMaONLpRrTNcWBsE1CUQ41Xz6+ZbOm5MtXKIIL2EkV4Hq8Ob4
         tPIvEm6bRgaYOtEaXAK7/1mGIOPknCx0O7WErYJpouZAzUGI3KofEApYZ/Sbd4KygYyd
         WUdsbcyKPkD5u3s3MYmSfu6Hujof3QOuzRpf3zI+GnzFBOoh6TBNScaK4EJC1r280VU4
         gzKA==
X-Gm-Message-State: AOAM533JqmQ1LAR+P9Q8AVpyWC47Pd0hVnbmA5hzhOM5//M6loDWCIyZ
        OqL0Qc9MpHb+V4hrGSFpu8Qz5Q==
X-Google-Smtp-Source: ABdhPJw4pSB0K0iA7nRulTXnJfiqTxaQf1+i2vnos6vZbo7/HN0GM59TI/tMLvET0NGIlCFNwPQn1A==
X-Received: by 2002:a1f:eac1:: with SMTP id i184mr80498vkh.66.1596573782070;
        Tue, 04 Aug 2020 13:43:02 -0700 (PDT)
Received: from google.com (182.71.196.35.bc.googleusercontent.com. [35.196.71.182])
        by smtp.gmail.com with ESMTPSA id a3sm2560129vsh.31.2020.08.04.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:43:01 -0700 (PDT)
Date:   Tue, 4 Aug 2020 20:42:58 +0000
From:   Kalesh Singh <kaleshsingh@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 2/2] dmabuf/tracing: Add dma-buf trace events
Message-ID: <20200804204258.GA1002979@google.com>
References: <20200803144719.3184138-1-kaleshsingh@google.com>
 <20200803144719.3184138-3-kaleshsingh@google.com>
 <20200803154125.GA23808@casper.infradead.org>
 <CAJuCfpFLikjaoopvt+vGN3W=m9auoK+DLQNgUf-xUbYfC=83Mw@mail.gmail.com>
 <20200803161230.GB23808@casper.infradead.org>
 <CAJuCfpGot1Lr+eS_AU30gqrrjc0aFWikxySe0667_GTJNsGTMw@mail.gmail.com>
 <20200803222831.GI1236603@ZenIV.linux.org.uk>
 <20200804010913.GA2096725@ZenIV.linux.org.uk>
 <20200804154451.GA948167@google.com>
 <20200804182724.GK1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804182724.GK1236603@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:27:24PM +0100, Al Viro wrote:
> On Tue, Aug 04, 2020 at 03:44:51PM +0000, Kalesh Singh wrote:
> 
> > Hi Al. Thank you for the comments. Ultimately what we need is to identify processes
> > that hold a file reference to the dma-buf. Unfortunately we can't use only
> > explicit dma_buf_get/dma_buf_put to track them because when an FD is being shared
> > between processes the file references are taken implicitly.
> > 
> > For example, on the sender side:
> >    unix_dgram_sendmsg -> send_scm -> __send_scm -> scm_fp_copy -> fget_raw
> > and on the receiver side:
> >    unix_dgram_recvmsg -> scm_recv -> scm_detach_fds -> __scm_install_fd -> get_file
> > 
> > I understand now that fd_install is not an appropriate abstraction level to track these.
> > Is there a more appropriate alternative where we could use to track these implicit file
> > references?
> 
> There is no single lock that would stabilize the descriptor tables of all
> processes.  And there's not going to be one, ever - it would be a contention
> point from hell, since that would've been a system-wide lock that would have
> to be taken by *ALL* syscalls modifying any descriptor table.  Not going to
> happen, for obvious reasons.  Moreover, you would have to have fork(2) take
> the same lock, since it does copy descriptor table.  And clone(2) either does
> the same, or has the child share the descriptor table of parent.
> 
> What's more, a reference to struct file can bloody well survive without
> a single descriptor refering to that file.  In the example you've mentioned
> above, sender has ever right to close all descriptors it has sent.   Files
> will stay opened as long as the references are held in the datagram; when
> that datagram is received, the references will be inserted into recepient's
> descriptor table.  At that point you again have descriptors refering to
> that file, can do any IO on it, etc.
> 
> So "the set of processes that hold a file reference to the dma-buf" is
> 	* inherently unstable, unless you are willing to freeze every
> process in the system except for the one trying to find that set.
> 	* can remain empty for any amount of time (hours, weeks, whatever),
> only to get non-empty later, with syscalls affecting the object in question
> done afterwards.
> 
> So... what were you going to do with that set if you could calculate it?
> If it's really "how do we debug a leak?", it's one thing; in that case
> I would suggest keeping track of creation/destruction of objects (not
> gaining/dropping references - actual constructors and destructors) to
> see what gets stuck around for too long and use fuser(1) to try and locate
> the culprits if you see that something *was* living for too long.  "Try"
> since the only reference might indeed have been stashed into an SCM_RIGHTS
> datagram sitting in a queue of some AF_UNIX socket.  Note that "fuser
> needs elevated priveleges" is not a strong argument - the ability to
> do that sort of tracking does imply elevated priveleges anyway, and
> having a root process taking requests along the lines of "gimme the
> list of PIDs that have such-and-such dma_buf in their descriptor table"
> is not much of an attack surface.
> 
> If you want to use it for something else, you'll need to describe that
> intended use; there might be sane ways to do that, but it's hard to
> come up with one without knowing what's being attempted...

Hi Al. Thanks for the guidance and detailed explanation. It appears what we
were trying to accomplish here is not feasible.

Thanks, Kalesh
