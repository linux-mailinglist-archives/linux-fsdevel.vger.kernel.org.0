Return-Path: <linux-fsdevel+bounces-47-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ED47C4D8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 10:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5B0282344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 08:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F219BD7;
	Wed, 11 Oct 2023 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sgTbVrlX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="95LkS4Hn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA42F2E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:48:54 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5F8AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 01:48:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9AB481FDF9;
	Wed, 11 Oct 2023 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697014130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d/xcucRm2vfU5BeeajNKtHojaE9B5YSooU7TxCKx8TU=;
	b=sgTbVrlXp11hAQBtz6s6jMobfstNfAs7qWFkxuKjfMzyNFl5LP0zfodXy/irp7uBeBC+mS
	0OqrOotp/M8dMsTzouyXjObVzZb1XWId9XmpCP48HIj90U2Qb1px7peCCPF9OwA//kz778
	7ZnsIT419qW/CLeebmtWgod0tb1v47Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697014130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d/xcucRm2vfU5BeeajNKtHojaE9B5YSooU7TxCKx8TU=;
	b=95LkS4Hn2/3/zRjBF/Af/xwfLopkYRL4Lx+pRqmoxtsoRIErHAA9O8XxuPzLvsdeo0TEP9
	Jbocx4l7snoma0DQ==
Received: from g78 (unknown [10.163.25.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 147E32C654;
	Wed, 11 Oct 2023 08:48:50 +0000 (UTC)
References: <20231004124712.3833-1-chrubis@suse.cz> <87o7h6zsth.fsf@suse.de>
 <ZSVPpG4_ui4k5nES@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 0/3] Add tst_iterate_fd()
Date: Wed, 11 Oct 2023 09:42:37 +0100
Organization: Linux Private Site
Reply-To: rpalethorpe@suse.de
In-reply-to: <ZSVPpG4_ui4k5nES@yuki>
Message-ID: <87fs2hzgr4.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> >  - adds tst_iterate_fd() functionality
>> >  - make use of tst_iterate_fd() in readahead01
>> >  - add accept03 test which uses tst_iterate_fd()
>> >
>> > This is a prototype for how the functionality to iterate over different
>> > file descriptors should look like it converts one tests and adds
>> > another. There is plenty of other syscalls that can use this kind of
>> > testing, e.g. all fooat() syscalls where we can pass invalid dir_fd, the
>> > plan is to add these if/once we agree on the API.
>> 
>> I imagine the results of using this with splice could be very interesting.
>
> Good idea, I guess that we need to figure out how to do carthesian
> multiplication on the different file descriptors though. Maybe we need
> to treat the tst_interate_fd() as an iterator so that we can advance to
> the next fd with each call, so that we can do:
>
> 	struct tst_fd fd_in = {}, fd_out = {};
>
> 	while (tst_iterate_fd(&fd_in)) {
> 		while (tst_iterate_fd(&fd_out)) {
> 			...
> 			TST_TEST(splice(fd_in.fd, 0, fd_out.fd, 0, ...));
> 			...
> 		}
> 	}

This looks promising. I think it would be good to try this sooner rather
than later.

-- 
Thank you,
Richard.

