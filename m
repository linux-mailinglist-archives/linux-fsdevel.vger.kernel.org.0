Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7056A457C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 16:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjB0PCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 10:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0PB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:01:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8585A5262
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 07:01:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 317831FD65;
        Mon, 27 Feb 2023 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677510116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ehaTZ+bGuePVfH1s2PTqaZD5xdifEOR/BACcpbQ4b0=;
        b=fWUavvPfuaiosYQ2s1U/62EsLY4krQzXMtulfmqBa1bYsOJHdaoPN/zmEPBw+44zOCtcQL
        2XIiHwXZuY40rYtjH/sPxyH7q1nZDiv5kHdRtTrotkuSmSrDHQa0RtEnHEG3nqyMsN7hg0
        k2cMsMvb+nwt4WVkwgHg9EQt0vXXTlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677510116;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ehaTZ+bGuePVfH1s2PTqaZD5xdifEOR/BACcpbQ4b0=;
        b=lH7RIszqiyjBtW4aw5dHpkdVDC7z95IgZ8O1SRzbO1PaD5wblwOUcrfQjtlK33nrr9+Imt
        Zke8KmONpp/oALBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 233A113A43;
        Mon, 27 Feb 2023 15:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xw+PCOTF/GMnGwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Feb 2023 15:01:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8FEF9A06F2; Mon, 27 Feb 2023 16:01:55 +0100 (CET)
Date:   Mon, 27 Feb 2023 16:01:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] UDF and ext2 fixes
Message-ID: <20230227150155.ubw5s3z2s2isiwev@quack3>
References: <20230217114342.vafa3sf7tm4cojh6@quack3>
 <CAHk-=whwuQw=mP2G6qx9M-9GSNU5Ej-Y5E1RJ1Pq+PeCXYzLFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whwuQw=mP2G6qx9M-9GSNU5Ej-Y5E1RJ1Pq+PeCXYzLFQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-02-23 12:51:26, Linus Torvalds wrote:
> On Fri, Feb 17, 2023 at 3:43 AM Jan Kara <jack@suse.cz> wrote:
> >
> >   * One fix to mpage_writepages() on which other udf fixes depend
> 
> I've pulled this, and this doesn't look *wrong* per se, but it really
> didn't look like a bug in mpage_writepages() to me.
> 
> The bug seems to be clearly in the filesystem not returning a proper
> error code from its "->get_block()" function.
> 
> If the VFS layer asks for block creation, and the filesystem returns
> no error, but then a non-mapped result, that sounds like _clearly_ a
> filesystem bug to me.

I agree having saner way to pass information from ->get_block "I cannot
write this buffer in the page but please keep writing other buffers in this
page" to the VFS is desirable. But this "return unmapped buffer" hack is
what happened to work for __block_write_full_page() since ages and I belive
it was occasionally used by filesystems so that's why I've made
mpage_writepages() compatible with this behavior.

> Blaming mpage_writepages() seems entirely wrong.
> 
> The extra sanity check in the vfs layer doesn't strike me as wrong, but ...
> 
> Maybe it could have been a WARN_ON_ONCE() if "get_block(.., 1)"
> returns success with an unmapped result?

A cleanup in this area would be certainly good but maybe the energy is
better invested in the attempt to make filesystems use iomap instead of
get_block based interfaces?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
