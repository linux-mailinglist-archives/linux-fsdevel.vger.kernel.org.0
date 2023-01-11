Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1A665177
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 03:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjAKCFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 21:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjAKCFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:05:38 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54F6246;
        Tue, 10 Jan 2023 18:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tzjEE7eo4pfZIl8gdpx99Jy7b3Efr0s8W424Og+smhM=; b=vQyk+WHrBXBXLx+geNjzazw4Np
        v5sOF5blNFqowKDQlarNT0a1/uVAQGfAzjLQCJmPOF8AdOol+3KleW8l6wuqG+NWS8sSPXfFMODof
        hYtWZ0YdTvVJf2VfkQ4QXHI1HCae8ibYAZ8awyGquoZrx6i2yhVJvmz7NY1q/bWTC4Szs0AMVlNtF
        +tvIUGcq4NaaFxMlmb0ZuscjyV6qZTeRmTfll8fFr56/7zgqVJunc4NtmWjLESFzMpE1byGyvgTuH
        l/wU1ZMqLpm+/C/gQgScfhalIP5g6dX6+9c5FhxVdAYe4FgzTNjNnw4hLqjCbu4eNQmude5MzLlpB
        jeqh1oJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFQUJ-0016WG-2Z;
        Wed, 11 Jan 2023 02:05:11 +0000
Date:   Wed, 11 Jan 2023 02:05:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: remove locks_inode
Message-ID: <Y74ZVx8Vm1scSBMN@ZenIV>
References: <20230110104501.11722-1-jlayton@kernel.org>
 <Y7375Zo5pE7g4P4H@ZenIV>
 <b38ad39f0572f31d27479f04bf085bd678887dc2.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38ad39f0572f31d27479f04bf085bd678887dc2.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:33:45PM -0500, Jeff Layton wrote:
> On Tue, 2023-01-10 at 23:59 +0000, Al Viro wrote:
> > On Tue, Jan 10, 2023 at 05:44:59AM -0500, Jeff Layton wrote:
> > > locks_inode was turned into a wrapper around file_inode in de2a4a501e71
> > > (Partially revert "locks: fix file locking on overlayfs"). Finish
> > > replacing locks_inode invocations everywhere with file_inode.
> > 
> > Looks good to me.  Which tree do you want that to go through?
> 
> I'll take it via the file locking tree, if that's ok. Let me know if
> you'd rather pick it up though.

Fine by me - I don't have anything pending in that area, so...  Oh, and
ACKed-by: Al Viro <viro@zeniv.linux.org.uk>
in case it's not obvious from the above...
