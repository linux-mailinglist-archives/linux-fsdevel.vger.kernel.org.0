Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60E4314544
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 02:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBIBJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 20:09:34 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60085 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229587AbhBIBJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:09:34 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11918XuD020182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 Feb 2021 20:08:34 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 883F715C3708; Mon,  8 Feb 2021 20:08:33 -0500 (EST)
Date:   Mon, 8 Feb 2021 20:08:33 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, jack@suse.com,
        viro@zeniv.linux.org.uk, amir73il@gmail.com, dhowells@redhat.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <YCHgkReD1waTItKm@mit.edu>
References: <87lfcne59g.fsf@collabora.com>
 <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com>
 <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu>
 <87wnvi8ke2.fsf@collabora.com>
 <20210208221916.GN4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208221916.GN4626@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:19:16AM +1100, Dave Chinner wrote:
> Nope, not convinced at all. As a generic interface, it cannot be
> designed explicitly for the needs of a single filesystem, especially
> when there are other filesystems needing to implement similar
> functionality.
>
> As Amir pointed up earlier in the thread, XFS already already has
> extensive per-object verification and error reporting facilicities...

Sure, but asking Collabora to design something which works for XFS and
not for ext4 is also not fair.

If we can't design something that makes XFS happy, maybe it will be
better to design something specific for ext4.  Alternatively, perhaps
the only thing that can be made generic is to avoid scope creep, and
just design something which allows telling userspace "something is
wrong with the file system", and leaving it at that.

But asking Collabora to design something for XFS, but doesn't work for
ext4, is an absolute non-starter.

> If we've already got largely standardised, efficient mechanisms for
> doing all of this in a filesystem, then why would we want to throw
> that all away when implementing a generic userspace notification
> channel?

You don't.  And if you want to implement something that works
perfectly for xfs, but doesn't work for ext4, feel free.

Cheers,

					- Ted
