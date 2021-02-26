Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171EB326397
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 15:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZOAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 09:00:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZOAl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:00:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50F5F64EE7;
        Fri, 26 Feb 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614347999;
        bh=BMSFrJi4c0wVHcWkPrJYSSmWsdZe2GehkTFStvm+2Ig=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VC4Vi//e+SEFROFzp+BPUah0KUtgvvqR8cwUnr9EMVqMV9PZTTSIipqun+8oAnlL3
         R4Tfk2lumJrYsmSEbfNZk6ycB2mjJ8PVO9b57scDjjqkOAlviLEWCHGtYJOs+n9DW7
         R67JohGjysNk+rbqhiyIUGPtYEOV7hukucYNTYSpfqqB76/hQ5d7IA5VZY53yWre56
         tOA+up7IJ+H+OKcWiQV0pNbUXxNTjmTu6cqVnsmgQYIl7xvMyACE4McGQimAFK8zuA
         9kbMc+SZenqCcZBSaw7BrrCM5rIYPI6s/1u5tt4z3ftRw8NMzDcOq8Jdsdfg+l3YSL
         +W32agANE0eGQ==
Message-ID: <5da210ecdf9d01552f1f69f928ce68747a68bf08.camel@kernel.org>
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
From:   Jeff Layton <jlayton@kernel.org>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Date:   Fri, 26 Feb 2021 08:59:56 -0500
In-Reply-To: <abf61760-2099-634a-7519-2138bb75e41b@gmail.com>
References: <20210222102456.6692-1-lhenriques@suse.de>
         <20210224142307.7284-1-lhenriques@suse.de>
         <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
         <YDd6EMpvZhHq6ncM@suse.de> <fd5d0d24-35e3-6097-31a9-029475308f15@gmail.com>
         <CAOQ4uxiVxEwvgFhdHGWLpdCk==NcGXgu52r_mXA+ebbLp_XPzQ@mail.gmail.com>
         <abf61760-2099-634a-7519-2138bb75e41b@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-02-26 at 12:15 +0100, Alejandro Colomar (man-pages) wrote:
> Hello Amir,
> 
> On 2/26/21 11:34 AM, Amir Goldstein wrote:
> > Is this detailed enough? ;-)
> > 
> > https://lwn.net/Articles/846403/
> 
> I'm sorry I can't read it yet:
> 
> [
> Subscription required
> The page you have tried to view (How useful should copy_file_range() 
> be?) is currently available to LWN subscribers only. Reader 
> subscriptions are a necessary way to fund the continued existence of LWN 
> and the quality of its content.
> [...]
> (Alternatively, this item will become freely available on March 4, 2021)
> ]
> 


Here's a link that should work. I'm probably breaking the rules a bit as
a subscriber, but hopefully Jon won't mind too much. FWIW, I've found it
to be worthwhile to subscribe to LWN if you're doing a lot of kernel
development:

    https://lwn.net/SubscriberLink/846403/0fd639403e629cab/

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

