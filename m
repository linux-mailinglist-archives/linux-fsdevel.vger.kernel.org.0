Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E051B50D82F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 06:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbiDYEWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 00:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbiDYEWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:22:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BB018361;
        Sun, 24 Apr 2022 21:19:13 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q75so9986891qke.6;
        Sun, 24 Apr 2022 21:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n9ZQHKz6biJiRkpy+CyyBSek4fjy21imjdDmRA8Vqgw=;
        b=cmnAJJkP34bjVns2uO/86rkj5RTyiJm45vA+lAwj5O1/o0Y0+K/ZQz858LHcAhf/Wj
         o33vdISVSpM7OTXmNjeVFiQpYuzIAYHFTIFr/IYykpp2p63xBZDt34cM8T6iFOltM7N8
         BTBERl3etwNlD+7WAHI7TqcOWnntTf1hJQFhTL/j3Bi5MkhQ/TXngcZTR0s9OshoZPXm
         opl0oTVWYCec68WYkUBR1YC+i11/f3aNqqKMbRxnS2w5mpyFYdu7LWtdLCtiaIerJMuz
         ixhVtMKpJYI4FqxSKCKzcGJWRJb/98HN+0dlS3m8onn1Pv0gnODJbuUKWmbSuMFM8sXb
         fDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9ZQHKz6biJiRkpy+CyyBSek4fjy21imjdDmRA8Vqgw=;
        b=FzTzXzfDOVo6KZWSvrVVJd7N1BnSky+E8rDcZPGUAOqoDnL2xO8qlgcu+Dfc5ZwGhk
         PlBMZPdqDbT/btapAEVtwZdI8koUTD0s7Kq/GaSmau4J3coNwKtq6hry/sFEeIrs5LCt
         Ev4GQN4Gvue/foWPINI+5fJXs3mKZaug4azUVrr7vFOFY1enjB0e+RTKZFlOX97m0I8g
         wzBLYmTM+579t5KcOYvkXDdRe72lVAllMshkCrMX1eCsWDuqhduSQXjckwOZX0ntPkAh
         FNViIbV8NB3RS57XZFKWrkeT6BZacEw2/TLZNJm+NJw5b/e4qko00n2BElcnzLij6aw+
         L0Bg==
X-Gm-Message-State: AOAM530MM6mwXT330QR99OYABeCH7+deLTWpsSMnvME1rTaGUcm0mMhY
        RmjYMmFMdxxR+vMmwuYMAA==
X-Google-Smtp-Source: ABdhPJxeI09oROlDGdyr6/aGBGZksem4gbPjLwqSs0XVQfJosORnc9e+ZOIM168DGIgRrzo9YgWVhA==
X-Received: by 2002:a05:620a:13a5:b0:69e:e3b1:91a0 with SMTP id m5-20020a05620a13a500b0069ee3b191a0mr8995546qki.5.1650860352586;
        Sun, 24 Apr 2022 21:19:12 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id c21-20020ac87dd5000000b002f36347ddabsm3300316qte.77.2022.04.24.21.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 21:19:11 -0700 (PDT)
Date:   Mon, 25 Apr 2022 00:19:09 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220425041909.hcyirjphrkhxz6hx@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <fcaf18ed6efaafa6ca7df79712d9d317645215f8.camel@perches.com>
 <YmYLEovwj9BqeZQA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmYLEovwj9BqeZQA@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:44:34AM +0100, Matthew Wilcox wrote:
> On Sun, Apr 24, 2022 at 04:46:03PM -0700, Joe Perches wrote:
> > > + * pr_human_readable_u64, pr_human_readable_s64: Print an integer with human
> > > + * readable units.
> > 
> > Why not extend vsprintf for this using something like %pH[8|16|32|64] 
> > or %pH[c|s|l|ll|uc|us|ul|ull] ?
> 
> The %pX extension we have is _cute_, but ultimately a bad idea.  It
> centralises all kinds of unrelated things in vsprintf.c, eg bdev_name()
> and clock() and ip_addr_string().

And it's not remotely discoverable. I didn't realize we had bdev_name()
available as a format string until just now or I would've been using it!

> Really, it's working around that we don't have something like Java's
> StringBuffer (which I see both seq_buf and printbuf as attempting to
> be).  So we have this primitive format string hack instead of exposing
> methods like:
> 
> void dentry_string(struct strbuf *, struct dentry *);

Exactly!

> as an example,
>                 if (unlikely(ino == dir->i_ino)) {
>                         EXT4_ERROR_INODE(dir, "'%pd' linked to parent dir",
>                                          dentry);
>                         return ERR_PTR(-EFSCORRUPTED);
>                 }
> 
> would become something like:
> 
> 		if (unlikely(ino == dir->i_ino)) {
> 			struct strbuf strbuf;
> 			strbuf_char(strbuf, '\'');
> 			dentry_string(strbuf, dentry);
> 			strbuf_string(strbuf, "' linked to parent dir");
> 			EXT4_ERROR_INODE(dir, strbuf);
> 			return ERR_PTR(-EFSCORRUPTED);
> 		}
> 
> which isn't terribly nice, but C has sucky syntax for string
> construction.  Other languages have done this better, including Rust.

Over IRC just now you proposed "%p(%p)", dentry_name, dentry - I'm _really_
liking this idea, especially if we can get glibc to take it.

Then your ext4 example becomes just 

	if (unlikely(ino == dir->i_ino)) {
		EXT4_ERROR_INODE(dir, "'%p(%p)' linked to parent dir",
				 dentry_name, dentry);
		return ERR_PTR(-EFSCORRUPTED);
	}

And you can cscope to the pretty-printer! And dentry_name becomes just

void dentry_name(struct printbuf *out, struct dentry *dentry)
{
	...
}

Which is quite a bit simpler than the current definition.

Sweeeeeet.
