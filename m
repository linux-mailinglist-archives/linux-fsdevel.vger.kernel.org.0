Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8647AAF73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 12:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjIVK01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 06:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjIVK00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:26:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1EFA9;
        Fri, 22 Sep 2023 03:26:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC5D51F8A8;
        Fri, 22 Sep 2023 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695378378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4AvMudYjwCrVMWQjwvaN8DzatOa9/zfzofVKveg1pg=;
        b=tsiD5VsQYcpHO8ajHr1h3pxzqNxc+L9pmaBiM0rQZCs7rGr/NVrbcx0s9pOvGSoph67yY/
        TebdOVih+9mG225vKDsLMd7IuktVSwMKBEsPgWt+eGDAL84r8Xo3336db9sdwz6lTmHr8n
        sHZN0fd1bnU4SPXj2aSsaExqk1UH2yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695378378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4AvMudYjwCrVMWQjwvaN8DzatOa9/zfzofVKveg1pg=;
        b=OsVHhogZ2UOSBN5YsdPA5MQ6ypl+w+Nbiyen+aKWeOYqa2bZaWyOMjUqYAAXrrh073XWg2
        UowJPBEpC/gevuAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 793F913597;
        Fri, 22 Sep 2023 10:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uO7AHMprDWXregAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Sep 2023 10:26:18 +0000
Date:   Fri, 22 Sep 2023 12:19:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [GIT PULL v2] timestamp fixes
Message-ID: <20230922101943.GA13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:28:13PM -0700, Linus Torvalds wrote:
> On Thu, 21 Sept 2023 at 11:51, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > We have many, many inodes though, and 12 bytes per adds up!
> 
> That was my thinking, but honestly, who knows what other alignment
> issues might eat up some - or all - of the theoreteical 12 bytes.
> 
> It might be, for example, that the inode is already some aligned size,
> and that the allocation alignment means that the size wouldn't
> *really* shrink at all.
> 
> So I just want to make clear that I think the 12 bytes isn't
> necessarily there. Maybe you'd get it, maybe it would be hidden by
> other things.

I think all filesystem developers appreciate when struct inode shrinks,
it's usually embedded with additional data and the size grows. I'm on a
mission to squeeze btrfs_inode under 1024 so it fits better to the slab
pages and currently it's about 1100 bytes. 1024 is within reach but it
gets harder to find potential space savings.
