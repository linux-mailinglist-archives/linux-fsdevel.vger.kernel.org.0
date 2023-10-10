Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255E97BFD2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjJJNUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 09:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjJJNT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:19:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173FE1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 06:19:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D74141F45A;
        Tue, 10 Oct 2023 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696943994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5Vb6GB0GE+FDsx3580vS2ntU4j+c+h4IwqaebVjKuE=;
        b=L0rbhRBlgs+blHaWr/0k8eLsennmeRfFo3lGPKD9+QYE1FJbKu6Bax3R8aIpbmrwltin/j
        XrwlSlGXWq/ADqcK7nY9+zbzM9ymFIN7rP07fXfYOBypW1LVAh9N1MplFShYLS32yHj4sO
        IEpMGHkXdjREErOSobSFv9OLdLIHY2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696943994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5Vb6GB0GE+FDsx3580vS2ntU4j+c+h4IwqaebVjKuE=;
        b=BC8KCJ5sDV+ByXCel/EVVfa6prrX8HlRP82ItyfqsFG2fzBdOJsYVIOcfC8Ukwyccp5y/b
        ahZ4UhR6bOYRgsAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C13491358F;
        Tue, 10 Oct 2023 13:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ELVnLnpPJWViZQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Tue, 10 Oct 2023 13:19:54 +0000
Date:   Tue, 10 Oct 2023 15:20:36 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.de>
Cc:     mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 0/3] Add tst_iterate_fd()
Message-ID: <ZSVPpG4_ui4k5nES@yuki>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <87o7h6zsth.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7h6zsth.fsf@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> >  - adds tst_iterate_fd() functionality
> >  - make use of tst_iterate_fd() in readahead01
> >  - add accept03 test which uses tst_iterate_fd()
> >
> > This is a prototype for how the functionality to iterate over different
> > file descriptors should look like it converts one tests and adds
> > another. There is plenty of other syscalls that can use this kind of
> > testing, e.g. all fooat() syscalls where we can pass invalid dir_fd, the
> > plan is to add these if/once we agree on the API.
> 
> I imagine the results of using this with splice could be very interesting.

Good idea, I guess that we need to figure out how to do carthesian
multiplication on the different file descriptors though. Maybe we need
to treat the tst_interate_fd() as an iterator so that we can advance to
the next fd with each call, so that we can do:

	struct tst_fd fd_in = {}, fd_out = {};

	while (tst_iterate_fd(&fd_in)) {
		while (tst_iterate_fd(&fd_out)) {
			...
			TST_TEST(splice(fd_in.fd, 0, fd_out.fd, 0, ...));
			...
		}
	}

-- 
Cyril Hrubis
chrubis@suse.cz
