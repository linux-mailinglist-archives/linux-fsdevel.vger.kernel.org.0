Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974B4755ACA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 07:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGQFMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 01:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQFMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:12:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F35E5E;
        Sun, 16 Jul 2023 22:12:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26586e824e7so2007134a91.3;
        Sun, 16 Jul 2023 22:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689570760; x=1692162760;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/IgqUR9PvjzJ1jJmva5aVdtFrmS/jtLMZS//FD+XYVU=;
        b=Ckcr2Y5CE8xWEYz9QwHVm36yHJeL2lcfus7o4m3EY4+MHR1C+g7aRHdpkXlZwW/qsB
         sLjmtm8Q19kLcnJ8ppyTRW3kS47OQvzwLlIAuWpdYwzyAtz2WcW0TVom9BmpPD09x236
         +XUPr0K1ZFhTBZUxvDdBwxOQXsbotx1dltzGMg0UEbXOkQRx2xqa7gKmLQ7S0gTXSFRq
         cVXCxMQNJ4cuaoEgbkT6eX8u7ip25lr0AtlKg3XNXYSNfAgkiN/gyr9kJF0y58K8YumD
         qK/oRyFp3lo5fu5R3qM1JY7B3gNjoU5Y4sGUFuQGD+4TE3MmRS3ln0SRCr2gVEbg857V
         Y2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689570760; x=1692162760;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IgqUR9PvjzJ1jJmva5aVdtFrmS/jtLMZS//FD+XYVU=;
        b=O9y7BYD/9K6ZFrtdR0oAzec48uswSM6ygtfPEpOaMep7FWXyCjHYPm2DXQW6sYNQbu
         BJm4bUoTMp3wOyNdQtYPmJlyCzMpQswp7yXO7Hc4O/l9XDdNXbu2DyZnXMgE6G0w1Sm1
         KPBhrIroE4SSE8GUqZpPtFtmiB/Fu3drbEqCPhDOYcaMzFJMWlwMAQ44eQ0UhLKh2nrH
         sPk3UCh6qmdLU1eYl5JhF5zffih3mU4DjMqCMjlS+pPfjuizW4TVGDL+GMUKQ5/6Ytdl
         GJYKzeGt1XhDW1i+u24Jj3uVnvN/ipTgk638D5gINFG2QcY+lTlo80lR9XToSlOfw6nD
         T6fg==
X-Gm-Message-State: ABy/qLYUlgurQTDXN4PDJoqgTtk3DLXT+RJ0uh6gwhsOeWeQW6cacXY4
        Yh7veI+SKekXf5aeTtwF564xOpGEmlU=
X-Google-Smtp-Source: APBJJlGPBrC+4NpRUL/jdnWZgBzb4KGDJ7nOVPgI2jEFz73XoaSGm8C+p8RRw8LNRdeG0Ils1kr+UA==
X-Received: by 2002:a17:90a:db17:b0:262:ffd2:ced with SMTP id g23-20020a17090adb1700b00262ffd20cedmr9485431pjv.0.1689570759975;
        Sun, 16 Jul 2023 22:12:39 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090a49c600b00263cca08d95sm4088967pjm.55.2023.07.16.22.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 22:12:39 -0700 (PDT)
Date:   Mon, 17 Jul 2023 10:42:31 +0530
Message-Id: <87ttu3nmtc.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 1/2] iomap: fix a regression for partial write errors
In-Reply-To: <20230714085124.548920-1-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> When write* wrote some data it should return the amount of written data
> and not the error code that caused it to stop.  Fix a recent regression
> in iomap_file_buffered_write that caused it to return the errno instead.
>

Agreed. Reviewed the change and it looks right to me. 
Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> Fixes: 219580eea1ee ("iomap: update ki_pos in iomap_file_buffered_write")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

In case anyone wanted to see before and after test failures output of

./runltp -f syscalls -s writev07 -d /mnt1/test

<without this patch>
tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
writev07.c:50: TINFO: starting test with initial file offset: 0
writev07.c:73: TINFO: got EFAULT
writev07.c:78: TFAIL: file was written to
writev07.c:84: TPASS: offset stayed unchanged
writev07.c:50: TINFO: starting test with initial file offset: 65
writev07.c:73: TINFO: got EFAULT
writev07.c:78: TFAIL: file was written to
writev07.c:84: TPASS: offset stayed unchanged
writev07.c:50: TINFO: starting test with initial file offset: 4096
writev07.c:73: TINFO: got EFAULT
writev07.c:80: TPASS: file stayed untouched
writev07.c:84: TPASS: offset stayed unchanged
writev07.c:50: TINFO: starting test with initial file offset: 4097
writev07.c:73: TINFO: got EFAULT
writev07.c:80: TPASS: file stayed untouched
writev07.c:84: TPASS: offset stayed unchanged

Summary:
passed   6
failed   2
broken   0
skipped  0
warnings 0


<with this patch>
tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
writev07.c:50: TINFO: starting test with initial file offset: 0
writev07.c:94: TINFO: writev() has written 64 bytes
writev07.c:105: TPASS: file has expected content
writev07.c:116: TPASS: offset at 64 as expected
writev07.c:50: TINFO: starting test with initial file offset: 65
writev07.c:94: TINFO: writev() has written 64 bytes
writev07.c:105: TPASS: file has expected content
writev07.c:116: TPASS: offset at 129 as expected
writev07.c:50: TINFO: starting test with initial file offset: 4096
writev07.c:94: TINFO: writev() has written 64 bytes
writev07.c:105: TPASS: file has expected content
writev07.c:116: TPASS: offset at 4160 as expected
writev07.c:50: TINFO: starting test with initial file offset: 4097
writev07.c:94: TINFO: writev() has written 64 bytes
writev07.c:105: TPASS: file has expected content
writev07.c:116: TPASS: offset at 4161 as expected

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0



>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index adb92cdb24b009..7cc9f7274883a5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -872,7 +872,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.processed = iomap_write_iter(&iter, i);
>  
> -	if (unlikely(ret < 0))
> +	if (unlikely(iter.pos == iocb->ki_pos))
>  		return ret;
>  	ret = iter.pos - iocb->ki_pos;
>  	iocb->ki_pos += ret;
> -- 
> 2.39.2

-ritesh
