Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659D6315BB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 01:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhBJAyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 19:54:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234819AbhBJAws (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:52:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0978764E53;
        Wed, 10 Feb 2021 00:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612918328;
        bh=PHzKsgtY64tpTeuCxH4DekYrsDlAXHF3WSBJ/LVJhec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHOgu2iukk1CbsCxthP3cIHCBQP4bNQWYPxQAKh/l2cktNAZHVEMloDZU50tWsoKb
         UEjNcgyte670mlXEJTC5uGy+g3wMF7GMlgho3KgQz/ahiAqxjs1DcuvL2Hx+N/uYbl
         Od7Bxzz9UEcYwqaBeYYJDSr1i4GngED5B7sCTt/aQOKT8Vqv7QgKgHN3Y3QH6fG1iy
         /CtMRwdJRHD3e+ARpZzSN1pgn/a/UktSSDjdLiCxGx26YTO8wHdtMMSu84lIPscau/
         6BwLKLpSWJBaE5xBeqbmrCRRK3xMTufI8i8nldZ5NOFOkZBIIwCQG1Yr5kacIgPy0l
         ehiUcZr4XsMyQ==
Date:   Tue, 9 Feb 2021 16:52:07 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        jack@suse.com, viro@zeniv.linux.org.uk, amir73il@gmail.com,
        dhowells@redhat.com, darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <20210210005207.GE7187@magnolia>
References: <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com>
 <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu>
 <87wnvi8ke2.fsf@collabora.com>
 <20210208221916.GN4626@dread.disaster.area>
 <YCHgkReD1waTItKm@mit.edu>
 <20210209085501.GS4626@dread.disaster.area>
 <YCLM9NPSwsWFPu4t@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCLM9NPSwsWFPu4t@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:57:08PM -0500, Theodore Ts'o wrote:
> On Tue, Feb 09, 2021 at 07:55:01PM +1100, Dave Chinner wrote:
> > 
> > That means we have to work together to find common ground and a
> > solution that works for everyone.  What I've suggested allows all
> > filesystems to supply the same information for the same events.  It
> > also allows filesystems to include their own private diagnostic
> > information appended to the generic message, thereby fulfulling both
> > the goals of both David Howells' original patchset and Gabriel's
> > derived ext4 specific patchset.
> 
> So the simple common ground would be a plain text message, which is
> what *I* had suggested.  But I saw you requesting some complex object
> based system which XFS has.
> 
> I think if we want to keep something that is common, it's going to
> have to be kept simple.  Do you not agree?

I definitely don't want to implement string parsing for xfs_scrub.

The kernel already has enough information to fill out the struct
xfs_scrub_metadata structure for userspace in case it decides to repair.

(HA, maybe that should be the notification format for xfs metadata :P)

--D

>      	   		    	    - Ted
