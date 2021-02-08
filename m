Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A7313AE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 18:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhBHR1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 12:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhBHRZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:25:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62303C06178A;
        Mon,  8 Feb 2021 09:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OuAZhNPZ6HL2DLpynEmR1TCITnJZW/sATSf2c6sANsY=; b=vJrCFyeLfV/qoeP5pJT9zHVshm
        fvufU46XGXDGto/8Nnv9exOU2bAdRtYbuLKNTHhUbo3Oxa0TfXtVlRfzmln08ob9OZI3H1YFuaiDM
        reoRDd36Tvb+C1R8XGcwY64KU/8eWoImJ1r6FyYxVHEgICGpoQ9Oct7nPLqrFzZe/ZaXnmj9Px1LY
        cuIpEDOdUJVbUvx3ZL8KF57rC/+6psY7KA6QUPpIk5AIez3fE8lJk6Sl4rk6YcklU3aHxWXlLK6J1
        nF3NV8SoI2iJPurxvXjb422QDtaoEVZ/MTjIbmRGFi5JTsIyQ7VqfpttPdtBClwu2kOujz0opgzoI
        R2wyMFQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9AGZ-006H5e-VE; Mon, 08 Feb 2021 17:24:05 +0000
Date:   Mon, 8 Feb 2021 17:24:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>, jannh@google.com,
        jeffv@google.com, keescook@chromium.org, surenb@google.com,
        minchan@kernel.org, hridya@google.com, rdunlap@infradead.org,
        christian.koenig@amd.com, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        NeilBrown <neilb@suse.de>, Anand K Mistry <amistry@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/2] procfs/dmabuf: Add inode number to /proc/*/fdinfo
Message-ID: <20210208172403.GT308988@casper.infradead.org>
References: <20210208151437.1357458-1-kaleshsingh@google.com>
 <20210208151437.1357458-2-kaleshsingh@google.com>
 <20210208152244.GS308988@casper.infradead.org>
 <20210208171734.GA42740@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208171734.GA42740@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:17:34PM +0300, Alexey Dobriyan wrote:
> On Mon, Feb 08, 2021 at 03:22:44PM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 08, 2021 at 03:14:28PM +0000, Kalesh Singh wrote:
> > > -	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
> > > +	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\ninode_no:\t%lu\n",
> > 
> > You changed it everywhere but here ...
> 
> call it "st_ino", because that's how fstat calls it?

it's called "st_ino" because it's part of the stat structure.
here, it is not part of the stat structure.
