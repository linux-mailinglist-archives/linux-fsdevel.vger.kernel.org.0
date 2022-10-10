Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C785F9ADF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 10:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJJIUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 04:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiJJIU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:20:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5430526EA
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 01:20:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C1161F385;
        Mon, 10 Oct 2022 08:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665390027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=093olVpFAOd5+rpPDwklI88fnyKO9394Ypglns+HZTA=;
        b=DrB23gznKBusCCnBtR89IB3acZbLGWdJR476SgFrsYp6FX1ZERkScLsSBp99zKc90eNCYF
        PC8WV01ufu+BolSB7sR9QHUordB9BCIrxCJW8BZB0numyyOMUWU922V82/TRvMfWpDn7Lj
        t0aHU6Zmq/wYIoKGTh+SgZ71fXRJaX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665390027;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=093olVpFAOd5+rpPDwklI88fnyKO9394Ypglns+HZTA=;
        b=+oUgQ8uM0gMPjONksFJROkSbXUfVGvrnBCaGjf5IOrr9at/v/LS/7O1Dpgek5lEUnOllj1
        Vg3j8dQPl7ridqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B99D013ACA;
        Mon, 10 Oct 2022 08:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mYgELcrVQ2OZawAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 10 Oct 2022 08:20:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C1263A06ED; Mon, 10 Oct 2022 10:20:22 +0200 (CEST)
Date:   Mon, 10 Oct 2022 10:20:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] fsnotify changes for v6.1-rc1
Message-ID: <20221010082022.z6f523vuek7dlstf@quack3>
References: <20221007124834.4guduq5n5c6argve@quack3>
 <CAHk-=wh1uSKn+_grsPF+1nhpQ25o4ZsGJO0mEpHQpftD=GvkTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1uSKn+_grsPF+1nhpQ25o4ZsGJO0mEpHQpftD=GvkTA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 07-10-22 08:37:10, Linus Torvalds wrote:
> On Fri, Oct 7, 2022 at 5:48 AM Jan Kara <jack@suse.cz> wrote:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify-for_v6.1-rc1
> 
> Oh, I only now noticed that your recent pull requests have been
> tagged, but the tags haven't been signed.
> 
> The first time this happened (middle of June), you made me aware of it
> ("not signed because I'm travelling until Sunday"), but then the
> signatures never came back, and I forgot all about it until this one
> ..
> 
> Mind reinstating the signing?

Oh, right. I've hand-edited my script generating the pull request at that
time and then forgot about it. Thanks for noticing! Change reverted so now
I should be generating signed tags again.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
