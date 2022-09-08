Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5865B21FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiIHPWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiIHPW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:22:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B917C1BD;
        Thu,  8 Sep 2022 08:22:25 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-160-104.corp.google.com [104.133.160.104] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 288FLnMO009638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 11:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662650518; bh=Q7EMQjEL1wIQNoEXbyxh/iG24EeohO2u4jvmmKyErqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OxRR92RnotcXfOTtwLsEY0ShIG1KHzjTk+CbAOULYcjYZUv9LckN/LC+5Bc0r0Ign
         m3K0Izjlrgh8xSPsTv51RN/SHipXczb4ohPsZ3re7pCWMXfqNAOE7rFSme/t6unRJl
         /GbzJyT9SM3yZWP0vAWjR6FopNoq8h0eSqtEsCyOnQ1uI1JttKA2qDHVDd2hUesVbi
         zenF9h86n3uqN/PsDpRHFzCOwa/YZWFebRbHZYIOeiKHiCtIMkNViPv1l/Vx75zqLp
         lLYP14b8W4Dbvx058k1ma7fGQKNg1r1b36fu8gwTJBSvLc5iIK+fliDRf0/X5Kn0Qq
         s/ktNGi6MuVZw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 2CCE98C2B48; Thu,  8 Sep 2022 11:21:49 -0400 (EDT)
Date:   Thu, 8 Sep 2022 11:21:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <YxoIjV50xXKiLdL9@mit.edu>
References: <20220907111606.18831-1-jlayton@kernel.org>
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
 <20220907125211.GB17729@fieldses.org>
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
 <20220907135153.qvgibskeuz427abw@quack3>
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>
 <20220908083326.3xsanzk7hy3ff4qs@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908083326.3xsanzk7hy3ff4qs@quack3>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 10:33:26AM +0200, Jan Kara wrote:
> It boils down to the fact that we don't want to call mark_inode_dirty()
> from IOCB_NOWAIT path because for lots of filesystems that means journal
> operation and there are high chances that may block.
> 
> Presumably we could treat inode dirtying after i_version change similarly
> to how we handle timestamp updates with lazytime mount option (i.e., not
> dirty the inode immediately but only with a delay) but then the time window
> for i_version inconsistencies due to a crash would be much larger.

Perhaps this is a radical suggestion, but there seems to be a lot of
the problems which are due to the concern "what if the file system
crashes" (and so we need to worry about making sure that any
increments to i_version MUST be persisted after it is incremented).

Well, if we assume that unclean shutdowns are rare, then perhaps we
shouldn't be optimizing for that case.  So.... what if a file system
had a counter which got incremented each time its journal is replayed
representing an unclean shutdown.  That shouldn't happen often, but if
it does, there might be any number of i_version updates that may have
gotten lost.  So in that case, the NFS client should invalidate all of
its caches.

If the i_version field was large enough, we could just prefix the
"unclean shutdown counter" with the existing i_version number when it
is sent over the NFS protocol to the client.  But if that field is too
small, and if (as I understand things) NFS just needs to know when
i_version is different, we could just simply hash the "unclean
shtudown counter" with the inode's "i_version counter", and let that
be the version which is sent from the NFS client to the server.

If we could do that, then it doesn't become critical that every single
i_version bump has to be persisted to disk, and we could treat it like
a lazytime update; it's guaranteed to updated when we do an clean
unmount of the file system (and when the file system is frozen), but
on a crash, there is no guaranteee that all i_version bumps will be
persisted, but we do have this "unclean shutdown" counter to deal with
that case.

Would this make life easier for folks?

						- Ted
