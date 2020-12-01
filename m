Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE22CA74C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 16:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbgLAPk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 10:40:26 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39024 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391784AbgLAPk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:40:26 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B1FdSYh012373
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Dec 2020 10:39:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D771D420136; Tue,  1 Dec 2020 10:39:27 -0500 (EST)
Date:   Tue, 1 Dec 2020 10:39:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Clarification of statx->attributes_mask meaning?
Message-ID: <20201201153927.GL5364@mit.edu>
References: <20201125212523.GB14534@magnolia>
 <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
 <1942931.1606341048@warthog.procyon.org.uk>
 <eb47ab08-67fc-6151-5669-d4fb514c2b50@sandeen.net>
 <20201201032051.GK5364@mit.edu>
 <f259c5ee-7465-890a-3749-44eb8be0f8cf@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f259c5ee-7465-890a-3749-44eb8be0f8cf@sandeen.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 09:37:29PM -0600, Eric Sandeen wrote:
> > We should be really clear how applications are supposed to use the
> > attributes_mask.  Does it mean that they will always be able to set a
> > flag which is set in the attribute mask?  That can't be right, since
> > there will be a number of flags that may have some more complex checks
> > (you must be root, or the file must be zero length, etc.)  I'm a bit
> > unclear about what are the useful ways in which an attribute_mask can
> > be used by a userspace application --- and under what circumstances
> > might an application be depending on the semantics of attribute_mask,
> > so we don't accidentally give them an opportunity to complain and
> > whine, thus opening ourselves to another O_PONIES controversy.
> 
> Hah, indeed.
> 
> Sorry if I've over-complicated this, I'm honestly just confused now.

Yeah, I'm honestly confused too how applications can use the
attributes mask, too.

Presumably there is some case where the flag not being set *and* the
file system can support that attribute, that the application could
infer something interesting.  I just can't figure out what that case
would be.

Yes, I see your pointer to Cristoph's question on this very issue back
in April 2017.  Pity it was never answered, at least that was archived
on lore.

					- Ted

