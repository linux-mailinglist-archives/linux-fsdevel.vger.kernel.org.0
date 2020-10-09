Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F01288D89
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbgJIP6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 11:58:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35487 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389135AbgJIP6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:58:51 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 099FwhHJ008865
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Oct 2020 11:58:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 73313420107; Fri,  9 Oct 2020 11:58:43 -0400 (EDT)
Date:   Fri, 9 Oct 2020 11:58:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz,
        anju@linux.vnet.ibm.com,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/1] ext4: Fix bs < ps issue reported with dioread_nolock
 mount opt
Message-ID: <20201009155843.GL235506@mit.edu>
References: <af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com>
 <CA+icZUVPXFkc7ow5-vF4bxggE63LqQkmaXA6m9cAZVCOnbS1fQ@mail.gmail.com>
 <22e5c5f9-c06b-5c49-d165-8f194aad107b@linux.ibm.com>
 <CA+icZUXLDGfHVGJXp2dA2JAxP8LUV4EVDNJmz20YjHa5A9oTtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXLDGfHVGJXp2dA2JAxP8LUV4EVDNJmz20YjHa5A9oTtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 12:18:23PM +0200, Sedat Dilek wrote:
> > > Fixes: tag should be 12 digits (see [1]).
> > > ( Seen while walking through ext-dev Git commits. )
> >
> > Thanks Sedat, I guess it should be minimum 12 chars [1]

Right, the point is that the commit ID referenced should be at least
12 bytes to avoid ambiguity.  There's nothing really wrong with using
more than 12 bytes.  I sometimes use 16, myself.  It does look like
there is a (mostly harmless) inconsistency between lines 177 and 183
of submitting-patches.rst.

> In my ~/.gitconfig:
> 
> [core]
>        abbrev = 12
> 
> # Check for 'Fixes:' tag used in the Linux-kernel development process
> (Thanks Kalle Valo).2
> # Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
> # Usage: $ git log --format=fixes | head -5
> [pretty]
>    fixes = Fixes: %h (\"%s\")
> 
> Hope this is useful for others.

Personally, I find cutting and pasting the full SHA-1 hash and
description, and then cutting down the hash in emacs to be more
convenient, since I generaslly have the git commit from "git log" in
terminal window anyway.  But whatever works for each developer.  :-)

       	      	      	    	 	    - Ted
