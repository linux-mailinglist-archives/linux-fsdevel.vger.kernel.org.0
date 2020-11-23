Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1782C161B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 21:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbgKWULN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 15:11:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732570AbgKWULL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:11:11 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87FB20715;
        Mon, 23 Nov 2020 20:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606162270;
        bh=S16KBwhaL/01tGXV0yjo+fhZ/1ZXyYm+GDtWWM3lQiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s0Z9tEU4SklazDQUZnIX5EresDQad7SkzVV2bA8lAe3AE+57E0+xaXNcttXDY4c3N
         2DLWeaq2KtP2uKBIu+v5SmBGjWPsJqeNodCJ3t2iSZYrAGR5dAAy9wYfOqec5z79Bc
         gQMMbWP6RmrFDEd8+nDIcp2R2ji6h62jIynqVV8A=
Date:   Mon, 23 Nov 2020 12:11:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-mm@kvack.kernel.org, Daniel Colascione <dancol@google.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH v6 1/2] Add UFFD_USER_MODE_ONLY
Message-Id: <20201123121108.24d178769cfc9500c7c51317@linux-foundation.org>
In-Reply-To: <CA+EESO7xnnJAsPneuy1dNj6F47gViGiL-z8rajY5EoGdFWs+-A@mail.gmail.com>
References: <20201120030411.2690816-1-lokeshgidra@google.com>
        <20201120030411.2690816-2-lokeshgidra@google.com>
        <20201120153337.431dc36c1975507bb1e44596@linux-foundation.org>
        <CA+EESO7xnnJAsPneuy1dNj6F47gViGiL-z8rajY5EoGdFWs+-A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Nov 2020 11:17:43 -0800 Lokesh Gidra <lokeshgidra@google.com> wrote:

> > > A future patch adds a knob allowing administrators to give some
> > > processes the ability to create userfaultfd file objects only if they
> > > pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
> > > will exploit userfaultfd's ability to delay kernel page faults to open
> > > timing windows for future exploits.
> >
> > Can we assume that an update to the userfaultfd(2) manpage is in the
> > works?
> >
> Yes, I'm working on it. Can the kernel version which will have these
> patches be known now so that I can mention it in the manpage?

5.11, if all proceeds smoothly.
