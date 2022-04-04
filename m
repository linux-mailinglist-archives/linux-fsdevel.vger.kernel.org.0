Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA74F1574
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 15:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiDDNHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348961AbiDDNHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:07:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD62C0;
        Mon,  4 Apr 2022 06:05:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A892210EE;
        Mon,  4 Apr 2022 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649077513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wC86gbUg8Q4G9+5Yh9zn7w8RySmSqCqeIm64QO9mOtE=;
        b=RRl3Ow3dGGV/s0GtOYqND8FDvBjDPcuucOKEmxJhaBcg62IE3bwOhSXMJciuwie00la3Dt
        vIfvgni/VDrCBhutbnKt8xpngOFzHx/wcKTCF8tYsbDVCtNQg+wwBylUkJIqgBiNZBAaT7
        Sh95Qo2GYHO9iiR89s0vrUg4OpctFYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649077513;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wC86gbUg8Q4G9+5Yh9zn7w8RySmSqCqeIm64QO9mOtE=;
        b=97OjsjXSzuzMn9M2iOy1/9cSLKyhZw16LE9piwwkUvv526LZ2e1h0R4Z7Gx6tzk2drEP5w
        WAJgVKn6SFSswSAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E2D46A3B82;
        Mon,  4 Apr 2022 13:05:12 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DD60CA0615; Mon,  4 Apr 2022 15:05:11 +0200 (CEST)
Date:   Mon, 4 Apr 2022 15:05:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Willy Tarreau <w@1wt.eu>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220404130511.rq7evchtxk7s7dre@quack3.lan>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220402105454.GA16346@amd>
 <20220404085535.g2qr4s7itfunlrqb@quack3.lan>
 <20220404100732.GB1476@duo.ucw.cz>
 <20220404101802.GB8279@1wt.eu>
 <20220404105828.GA7162@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404105828.GA7162@duo.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Mon 04-04-22 12:58:28, Pavel Machek wrote:
> > So maybe you're right and there are still a bit more than expected out
> > there. However I really think that most users who still have one are in
> > the same situation as I am, they're not aware of it. So aside big fat
> > warnings at mount time (possibly with an extra delay), there's nothing
> > that will make that situation change.
> > 
> > At the very least disabling it by default in Kconfig and in distros
> > should be effective. I really don't think that there are still users
> > who regularly update their system and who have it on their rootfs, but
> > still having data on it, yes, possibly. The earlier they're warned,
> > the better.
> 
> I guess we should start by making sure that distributions don't use it
> by default. Big fat warning + delay is a bit harsh for that, talking
> to them should be enough at this point :-).
> 
> Someone start with Arch Linux ARM.

Yeah, I will write them and CC you. Thanks for notifying me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
