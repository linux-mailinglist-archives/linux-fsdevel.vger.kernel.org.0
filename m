Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020923155C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhBISWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 13:22:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35332 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233243AbhBISSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:18:36 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 119Hv8sX007209
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Feb 2021 12:57:09 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7C99415C39D8; Tue,  9 Feb 2021 12:57:08 -0500 (EST)
Date:   Tue, 9 Feb 2021 12:57:08 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, jack@suse.com,
        viro@zeniv.linux.org.uk, amir73il@gmail.com, dhowells@redhat.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <YCLM9NPSwsWFPu4t@mit.edu>
References: <87lfcne59g.fsf@collabora.com>
 <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com>
 <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu>
 <87wnvi8ke2.fsf@collabora.com>
 <20210208221916.GN4626@dread.disaster.area>
 <YCHgkReD1waTItKm@mit.edu>
 <20210209085501.GS4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209085501.GS4626@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 07:55:01PM +1100, Dave Chinner wrote:
> 
> That means we have to work together to find common ground and a
> solution that works for everyone.  What I've suggested allows all
> filesystems to supply the same information for the same events.  It
> also allows filesystems to include their own private diagnostic
> information appended to the generic message, thereby fulfulling both
> the goals of both David Howells' original patchset and Gabriel's
> derived ext4 specific patchset.

So the simple common ground would be a plain text message, which is
what *I* had suggested.  But I saw you requesting some complex object
based system which XFS has.

I think if we want to keep something that is common, it's going to
have to be kept simple.  Do you not agree?

     	   		    	    - Ted
