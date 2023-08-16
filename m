Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5433077E523
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbjHPP3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344166AbjHPP2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:28:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC9B1FE2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 08:28:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf095e1becso86085ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692199728; x=1692804528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVe8WOvg8Lfa0WItyc/0CqS+Bb2dkjc5bYb8c3I+ZmI=;
        b=SSFnZAFLpDAVR/peuS2whZAlayxatjOnqbzJkE5844BFAIYPmHdwCNbmt4JKKC2A/j
         mJoQG0Alk3SCYKnP5j0q27IjtC8FWaJRUgrnSRhK/ODiqv5J81fg2dvFvtbf2/j7kEw5
         RdStgSOClHI+sQurAi22SGKw8zBFWyXcMJsYYxtVygVyXF2A7dk6w/s2iZkZNgOubKaq
         oxa7EH+jOwvYRoJ9qveFf6QFikp6H95HHaLNqAnFvGcgbe+AZbasFS51fHZ7LGFXv6ON
         E1Lqn/5+dwe+3RO7vDQJ1vV9zsrCTfkiLwHofqpdQLaLS3Fr0RWWvhZMV+U3IIqT4ZRN
         EH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692199728; x=1692804528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVe8WOvg8Lfa0WItyc/0CqS+Bb2dkjc5bYb8c3I+ZmI=;
        b=dTS6F674vtzOCl5UAAEhRSTI2fI22SYKJAuwOBUgFHT4qiU6oHoCQzw3KFb2tMXyXa
         xVtdVj69+WLyJtBTHiLFAb1VQtYKG8/ralxJqORVrn/o55zOiIrpFIUG+wPtB6HXmRn6
         o8EeRroKrx/kM1lfubqPa47FKcjofj9aoPFgcQsxN5OV2TCR1peKKl1GDEWO76K0hPAs
         ZqMGWMA7W97gBXanwVzNLKpMkIsP+fGvW56jyMRNc6P18gXK9+MUC4RltOFs+j+B9Uqn
         /83IAi+aes35dx773gVQnqq9zUdx/kVVQz+taHrirlbXg13ZuIOrIcCQYkuLojXUWtt0
         U7yA==
X-Gm-Message-State: AOJu0YwJfWIurpi3LNtbsX43Z4wN8F3mchBuW31aGOCq32uEwYG2sTLS
        0A0Cz3POcfW/Lbiy+KIPX1xXhg==
X-Google-Smtp-Source: AGHT+IFe+TtoSpYT/oNqF1bNprMaM0K4llMMUBaRX7ECC7woIbQkL9BKunBvL3CGVoqvlv1MF9+oNg==
X-Received: by 2002:a17:902:ce8e:b0:1b8:811:b079 with SMTP id f14-20020a170902ce8e00b001b80811b079mr2631741plg.0.1692199728355;
        Wed, 16 Aug 2023 08:28:48 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a31c600b00267eead2f16sm12172541pjf.36.2023.08.16.08.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 08:28:47 -0700 (PDT)
Message-ID: <7725feff-8d9d-4b54-9910-951b79f67596@kernel.dk>
Date:   Wed, 16 Aug 2023 09:28:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: create kiocb_{start,end}_write() helpers
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20230816085439.894112-1-amir73il@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230816085439.894112-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/23 2:54 AM, Amir Goldstein wrote:
> aio, io_uring, cachefiles and overlayfs, all open code an ugly variant
> of file_{start,end}_write() to silence lockdep warnings.
> 
> Create helpers for this lockdep dance and use the helpers in all the
> callers.
> 
> Use a new iocb flag IOCB_WRITE_STARTED to indicate if sb_start_write()
> was called.

Looks better now, but I think you should split this into a prep patch
that adds the helpers, and then one for each conversion. We've had bugs
with this accounting before which causes fs freeze issues, would be
prudent to have it split because of that.

> diff --git a/fs/aio.c b/fs/aio.c
> index 77e33619de40..16fb3ac2093b 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1444,17 +1444,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
>  	if (!list_empty_careful(&iocb->ki_list))
>  		aio_remove_iocb(iocb);
>  
> -	if (kiocb->ki_flags & IOCB_WRITE) {
> -		struct inode *inode = file_inode(kiocb->ki_filp);
> -
> -		/*
> -		 * Tell lockdep we inherited freeze protection from submission
> -		 * thread.
> -		 */
> -		if (S_ISREG(inode->i_mode))
> -			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> -		file_end_write(kiocb->ki_filp);
> -	}
> +	if (kiocb->ki_flags & IOCB_WRITE)
> +		kiocb_end_write(kiocb);

Can't we just call kiocb_end_write() here, it checks WRITE_STARTED
anyway? Not a big deal, and honestly I'd rather just get rid of
WRITE_STARTED if we're not using it like that. It doesn't serve much of
a purpose, if we're gating this one IOCB_WRITE anyway (which I do like
better than WRITE_STARTED). And it avoids writing to the kiocb at the
end too, which is a nice win.

> index b2adee67f9b2..8e5d410a1be5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -338,6 +338,8 @@ enum rw_hint {
>  #define IOCB_NOIO		(1 << 20)
>  /* can use bio alloc cache */
>  #define IOCB_ALLOC_CACHE	(1 << 21)
> +/* file_start_write() was called */
> +#define IOCB_WRITE_STARTED	(1 << 22)
>  
>  /* for use in trace events */
>  #define TRACE_IOCB_STRINGS \
> @@ -351,7 +353,8 @@ enum rw_hint {
>  	{ IOCB_WRITE,		"WRITE" }, \
>  	{ IOCB_WAITQ,		"WAITQ" }, \
>  	{ IOCB_NOIO,		"NOIO" }, \
> -	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }
> +	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
> +	{ IOCB_WRITE_STARTED,	"WRITE_STARTED" }
>  
>  struct kiocb {
>  	struct file		*ki_filp;

These changes will conflict with other changes in linux-next that are
going upstream. I'd prefer to stage this one after those changes, once
we get to a version that looks good to everybody.

-- 
Jens Axboe

