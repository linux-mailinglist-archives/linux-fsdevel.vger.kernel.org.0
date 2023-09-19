Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548B07A593A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 07:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjISFPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 01:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjISFPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:15:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFEFF;
        Mon, 18 Sep 2023 22:15:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c4586b12feso16452225ad.2;
        Mon, 18 Sep 2023 22:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695100504; x=1695705304; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fjszh/DitAw4XSOo3Lq7Xpzq4mY58xIKOU75EljiC8g=;
        b=A+UMyn+mo0FQkYWYPBj6072BgY1EKm4BNIbduwlKXk09y5LeRHiPCI2NkzWcBvSfrX
         pb7ZgI6tnGJcBob2UY3nXKqoWU10u3h5rM0OP+86RKYA7WexxqfmXEqL7/GDCW9/GfYg
         Qzc1z/Lubi8RSgtIDsqNjMmxcsIh8p/mvwnYw5bQ834NBnWH2p1KYVgvnwcypdIpvrkT
         iHqE1EdnmMAjKl1tKBSuvyiryIg5lW0dx1dfeqDpCSpv1xKkxuk0IIYhUCF8ihX2/xFS
         ksSoy3SvoyepSc2GT6Z62LGNfibutb40CJ1CYhsAK5rMbYN6QSNLvSmmNv/3+Xgeb27/
         CoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695100504; x=1695705304;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fjszh/DitAw4XSOo3Lq7Xpzq4mY58xIKOU75EljiC8g=;
        b=Rsch2OJXdc3yRaYeHqu1hoXix8kSp/1/hGq0/GqWkel4696PSwPsv+30fXa+Jjhrym
         fOvWrIEga9RLzPjbnd3hE2z5oWJQWbDAVCjvEWe0TC1d17R5Ntaclf8MfTLwnLCQi+Hb
         Y0mNG5E63ncqpSIDGShCchRxEa+DgSqRIrWdmp6OMyfGgPMKPgl3pG4yNhCShIN4+KJL
         0WjSlPNVOTC4T8HhDqetT+O8rAGo4PE9OCTWP+GLCzNbBp+WAvfkJ2Lb7ti8U46PYpnZ
         arUTYsPtf8sfvsRZlxbVBJmYsyxihNn5LUhA9BbZtIqPKI/nh2BPHHeaEHgDP/rk+1kD
         iOwg==
X-Gm-Message-State: AOJu0YxqtL26baIDlexaVF0HYFKarmiB+GA8kGUZHbbJKlH04i0Q3IJk
        W4K4iqlKYIQEee4ErsOBJxCXIfm5IWY=
X-Google-Smtp-Source: AGHT+IHlqKtYrr5I+sO6GyUZZI7pdW5mpxUNrF7zz3/Pu73avrloJiElMVXzjzXERXTssJoUD9M4CQ==
X-Received: by 2002:a17:903:32ca:b0:1c1:f3f8:3949 with SMTP id i10-20020a17090332ca00b001c1f3f83949mr11324218plr.1.1695100503510;
        Mon, 18 Sep 2023 22:15:03 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090282c700b001b3bf8001a9sm4877636plz.48.2023.09.18.22.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 22:15:02 -0700 (PDT)
Date:   Tue, 19 Sep 2023 10:44:58 +0530
Message-Id: <87o7hy7nhp.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, djwong@kernel.org
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 1/2] iomap: don't skip reading in !uptodate folios when unsharing a range
In-Reply-To: <169507872536.772278.18183365318216726644.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> From: Darrick J. Wong <djwong@kernel.org>
>
> Prior to commit a01b8f225248e, we would always read in the contents of a
> !uptodate folio prior to writing userspace data into the folio,
> allocated a folio state object, etc.  Ritesh introduced an optimization
> that skips all of that if the write would cover the entire folio.
>
> Unfortunately, the optimization misses the unshare case, where we always
> have to read in the folio contents since there isn't a data buffer
> supplied by userspace.  This can result in stale kernel memory exposure
> if userspace issues a FALLOC_FL_UNSHARE_RANGE call on part of a shared
> file that isn't already cached.
>
> This was caught by observing fstests regressions in the "unshare around"
> mechanism that is used for unaligned writes to a reflinked realtime
> volume when the realtime extent size is larger than 1FSB,

I was wondering what is testcase that you are referring here to? 
Can you please tell the testcase no. and the mkfs / mount config options
which I can use to observe the regression please?

> though I think it applies to any shared file.
>
> Cc: ritesh.list@gmail.com, willy@infradead.org
> Fixes: a01b8f225248e ("iomap: Allocate ifs in ->write_begin() early")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ae8673ce08b1..0350830fc989 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -640,11 +640,13 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  	size_t poff, plen;
>  
>  	/*
> -	 * If the write completely overlaps the current folio, then
> +	 * If the write or zeroing completely overlaps the current folio, then
>  	 * entire folio will be dirtied so there is no need for
>  	 * per-block state tracking structures to be attached to this folio.
> +	 * For the unshare case, we must read in the ondisk contents because we
> +	 * are not changing pagecache contents.
>  	 */
> -	if (pos <= folio_pos(folio) &&
> +	if (!(iter->flags & IOMAP_UNSHARE) && pos <= folio_pos(folio) &&
>  	    pos + len >= folio_pos(folio) + folio_size(folio))
>  		return 0;
>  
