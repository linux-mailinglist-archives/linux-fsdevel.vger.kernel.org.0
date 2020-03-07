Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3917CD55
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 10:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGJsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 04:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGJsk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:48:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A1D2070A;
        Sat,  7 Mar 2020 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583574518;
        bh=cPpuEcuoYPfsokOR2Tl6vph58NA3oVUGnjnGJvqn9Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oW7gpCaBYbilRdEyOH3/KpNpwEewkJjAbXdf7AYJzWS07GeR53ATEYDJqIMsLgwTL
         SEZXJyDNKbBvqx++GhTsIMN5Iqg8Nm0f3g4KiINFWqZENTVFo1VvukSSwFA0sciBmW
         qR5zCQzwXdkWzgrZj9zdcjhzGyms2cYv0mBtrjCM=
Date:   Sat, 7 Mar 2020 10:48:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200307094834.GA3888906@kroah.com>
References: <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306162549.GA28467@miu.piliscsaba.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 05:25:49PM +0100, Miklos Szeredi wrote:
> On Tue, Mar 03, 2020 at 08:46:09AM +0100, Miklos Szeredi wrote:
> > 
> > I'm doing a patch.   Let's see how it fares in the face of all these
> > preconceptions.
> 
> Here's a first cut.  Doesn't yet have superblock info, just mount info.
> Probably has rough edges, but appears to work.
> 
> I started with sysfs, then kernfs, then went with a custom filesystem, because
> neither could do what I wanted.

Hm, what is wrong with kernfs that prevented you from using it here?
Just complexity or something else?

thanks,

greg k-h
