Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B770759EF0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 00:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiHWW0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 18:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiHWWZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:25:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC20870B0;
        Tue, 23 Aug 2022 15:25:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 907001F8A4;
        Tue, 23 Aug 2022 22:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661293540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FE2Al3t7IgXV7i658F8wCx+Pqa+fMKLd8YrmqYyjo2c=;
        b=Q8gYMSsjemD43l+fHVukhYF+p5VRwHuwy5zy3Z1Y1vPTh5o6FIc+a/PSpQguOzy6uydL3h
        BBARFegh4V6Xpilsra7Mbe7ZJ28h0POtsHebNM1hpK1qKdeXl5Aq5vuoZEI49hixlX9usF
        45/ruW2liXm17FeQdAvoqBLEwUwjr8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661293540;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FE2Al3t7IgXV7i658F8wCx+Pqa+fMKLd8YrmqYyjo2c=;
        b=95Q12KkjJZdTEM7YMhnQyCV8dNijN9rMkjz2xVhuBNxLQruqJU6pchIWCDC9TliBDFTLzt
        ZqqcH6RHJETiDBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EBAF13A89;
        Tue, 23 Aug 2022 22:25:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TMt4DuFTBWMmKAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Aug 2022 22:25:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
In-reply-to: <df469d936b2e1c1a8c9c947896fa8a160f33b0e8.camel@kernel.org>
References: <20220822133309.86005-1-jlayton@kernel.org>,
 <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>,
 <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>,
 <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>,
 <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>,
 <20220822233231.GJ3600936@dread.disaster.area>,
 <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>,
 <166125468756.23264.2859374883806269821@noble.neil.brown.name>,
 <df469d936b2e1c1a8c9c947896fa8a160f33b0e8.camel@kernel.org>
Date:   Wed, 24 Aug 2022 08:24:47 +1000
Message-id: <166129348704.23264.10381335282721356873@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Aug 2022, Jeff Layton wrote:
> On Tue, 2022-08-23 at 21:38 +1000, NeilBrown wrote:
> > On Tue, 23 Aug 2022, Jeff Layton wrote:
> > > So, we can refer to that and simply say:
> > > 
> > > "If the function updates the mtime or ctime on the inode, then the
> > > i_version should be incremented. If only the atime is being updated,
> > > then the i_version should not be incremented. The exception to this rule
> > > is explicit atime updates via utimes() or similar mechanism, which
> > > should result in the i_version being incremented."
> > 
> > Is that exception needed?  utimes() updates ctime.
> > 
> > https://man7.org/linux/man-pages/man2/utimes.2.html
> > 
> > doesn't say that, but
> > 
> > https://pubs.opengroup.org/onlinepubs/007904875/functions/utimes.html
> > 
> > does, as does the code.
> > 
> 
> Oh, good point! I think we can leave that out. Even better!

Further, implicit mtime updates (file_update_time()) also update ctime.
So all you need is
   If the function updates the ctime, then i_version should be
   incremented.

and I have to ask - why not just use the ctime?  Why have another number
that is parallel?

Timestamps are updated at HZ (ktime_get_course) which is at most every
millisecond.
xfs stores nanosecond resolution, so about 20 bits are currently wasted.
We could put a counter like i_version in there that only increments
after it is viewed, then we can get all the precision we need but with
exactly ctime semantics.

The 64 change-id could comprise
 35 bits of seconds (nearly a millenium)
 16 bits of sub-seconds (just in case a higher precision time was wanted
                         one day)
 13 bits of counter. - 8192 changes per tick

The value exposed in i_ctime would hide the counter and just show the
timestamp portion of what the filesystem stores.  This would ensure we
never get changes on different files that happen in one order leaving
timestamps with the reversed order (the timestamps could be the same,
but that is expected).

This scheme could be made to handle a sustained update rate of 1
increment every 8 nanoseconds (if the counter were allowed to overflow
into unused bits of the sub-second field).  This is one ever 24 CPU
cycles.  Incrementing a counter and making it visible to all CPUs can
probably be done in 24 cycles.  Accessing it and setting the "seen" flag
as well might just fit with faster memory.  Getting any other useful
work done while maintaining that rate on a single file seems unlikely.

NeilBrown
