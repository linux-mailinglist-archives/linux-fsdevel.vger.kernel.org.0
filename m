Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE877D088
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbjHORCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbjHORCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:02:35 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2D51737
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 10:02:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6878db91494so1108887b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692118954; x=1692723754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrSl2ZCZiwomCVB7SGbqfJy+FNMd/x894i9xPTJvjUk=;
        b=CeX0j2XHHdsMxRuV6c4dzI/nP2s88I2NKLW18or6xiO0XQOOq8x2FldJMTgPkfRhZt
         VJBEF3t+VP8/cttywrg+uku+cIOWhRr5p9961dSFoBKLQLzi/xfTy6fv4ZaoBwuTm8WA
         MKqgfNXny6Zz725ZvH/zrwN4iIRyvOj3NkKvSpTh2dFdIZ7n/1119qHQXxRj1eLQY+jX
         gbo2lDI4Ylz/fxMvijLO9T8NbWxNcW7SuXDQwMZ5PpLJ6fuZ+jLOltOkOAFEO3/yRE3g
         H/BJHfWSNHcqgOyhdmKgUjw3GfvH9T4mrkZcodgx2783WqdFLCTQWGBNfYbRWe145o57
         yn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692118954; x=1692723754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrSl2ZCZiwomCVB7SGbqfJy+FNMd/x894i9xPTJvjUk=;
        b=Q8TQwrN/CYwu+EEH6Tk09Pab8eu8YYEpJ3upHPUpxEvnRs5/Ggj0oUDl9BoRGtp6fm
         F5qplnKNyVS10KbjLSEqYQ8g887MBKW1EDCHtnGkzXPfa7EbHhGlCrML4sBznmTbvRAb
         OX1lFFt9wgR+7E51M/LvLDYLAkNRv/uIHbncnsoOV0ZYXEGVJkBnKe8gkN9nukpgvmZG
         7j0sds05TaIEDDJ8ymTXBvtApOWGoCm3DPsAc7T7WPfCXnEPuQYap9tRrEA70xUeLn9A
         aXpCQkPYcoCSb5YS53Eoe58zHj4NSHgqIwqryl0ZhlSDVNCch3IXXrtoBMA1yfazZ+s4
         eavw==
X-Gm-Message-State: AOJu0YwlxwvyDe7xxOH7UYuMSDGl1R3SJ2CN8/iduiF9Z1NbVNqtetYD
        YjkiiwNCb4KsuWzzJ6Wf2E0Jrw==
X-Google-Smtp-Source: AGHT+IHNPtgZqOpft+8G47vHlVWi4wBoEL2QRFAYGvIAshP5vHM6Hxf0ojiOJp+9UUVJ2ppt0l1lRg==
X-Received: by 2002:a05:6a00:1d2a:b0:679:a1f1:a5f8 with SMTP id a42-20020a056a001d2a00b00679a1f1a5f8mr13331087pfx.3.1692118954007;
        Tue, 15 Aug 2023 10:02:34 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f26-20020aa782da000000b0068782960099sm9521380pfn.22.2023.08.15.10.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 10:02:33 -0700 (PDT)
Message-ID: <d8013748-f5ec-47c9-b4ba-75538b7ac93d@kernel.dk>
Date:   Tue, 15 Aug 2023 11:02:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: create kiocb_{start,end}_write() helpers
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20230815165721.821906-1-amir73il@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230815165721.821906-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/15/23 10:57 AM, Amir Goldstein wrote:
> +/**
> + * kiocb_start_write - get write access to a superblock for async file io
> + * @iocb: the io context we want to submit the write with
> + *
> + * This is a variant of file_start_write() for async io submission.
> + * Should be matched with a call to kiocb_end_write().
> + */
> +static inline void kiocb_start_write(struct kiocb *iocb)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	iocb->ki_flags |= IOCB_WRITE;
> +	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_WRITE_STARTED))
> +		return;
> +	if (!S_ISREG(inode->i_mode))
> +		return;
> +	sb_start_write(inode->i_sb);
> +	/*
> +	 * Fool lockdep by telling it the lock got released so that it
> +	 * doesn't complain about the held lock when we return to userspace.
> +	 */
> +	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
> +	iocb->ki_flags |= IOCB_WRITE_STARTED;
> +}
> +
> +/**
> + * kiocb_end_write - drop write access to a superblock after async file io
> + * @iocb: the io context we sumbitted the write with
> + *
> + * Should be matched with a call to kiocb_start_write().
> + */
> +static inline void kiocb_end_write(struct kiocb *iocb)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (!(iocb->ki_flags & IOCB_WRITE_STARTED))
> +		return;
> +	if (!S_ISREG(inode->i_mode))
> +		return;
> +	/*
> +	 * Tell lockdep we inherited freeze protection from submission thread.
> +	 */
> +	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> +	sb_end_write(inode->i_sb);
> +	iocb->ki_flags &= ~IOCB_WRITE_STARTED;
>  }

Please don't add code that dips into the inode when it's not needed for
all callers.

-- 
Jens Axboe

