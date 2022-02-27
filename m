Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B524C5F42
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 22:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiB0V6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 16:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiB0V6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:58:54 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E57FBCBC
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 13:58:16 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g21so3009543pfj.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 13:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aXJFJhk1K2hoknGcBZ9kI4Js4QpCOlhkiS6q9yRKYSE=;
        b=tZknqemS/fPOUC/USDG3GaCA0Nodcy6KelVr8Ar/WafdH7GUSBuJ+lb14p7Z6m6dZP
         nz46b7PpESAvZaol7cvFRjqGwnw+JLR8tfgC0lDa7HEEuHI403RO7zne3MCaEolcJ+5R
         UZGsCn9N+2KTKfV/x5ontlHUceiGCb+QRnNC9Ecko0RRkFI3lUb5iud6iaNaexsUVm8T
         Sq/dX09NFmEwr0PyvXFVfQmjJ6W6if7MGQF7P/D/xZxC+2zvMj3wZsYBvmA1Zz9HTBqq
         1HuG2boYwp/XDtUj6wJh/K+hGKU62kPEbzQvopeKHRmxQ+2GgSxXznGhsbQVbS4j80TJ
         o5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aXJFJhk1K2hoknGcBZ9kI4Js4QpCOlhkiS6q9yRKYSE=;
        b=QoXcGeXTUVR6cJjIMUyGH97hCVBEu+Bi35GtxVwtcCUyB5K7ACJ0W9qRQywacgMKZj
         WtGjfNRZBORZcBC7Cfj5rQxrzX2A+NItuGcg4PBnNocIl453IBpHJl4BvBfZoWxK+kKi
         wW44fnGx2978oEjxyUzBZ9vMpQWzQgOEr7qER6oBjJZte2RcY+otuXJZDB4EXiAW5meT
         86pe6VJ8CJKPojkcSF3DKQEQFIbjKR0muqYfhhHjiN1UUyMh0wvJsTKvTeHtICvRRqEK
         jUbfUI8ZateyXMhU7PtNkRFt3mVzbrR6IsAH9DCczwtRUVBd/P5JLnDE9Vk9ESrak33Z
         ktNg==
X-Gm-Message-State: AOAM533IDRmsFE+LjUJD239wx5P7CMtALrpGR0LWuEOl3pSc9s3cbNet
        5SudVuHkdz72b4mPBnap/fkl4A==
X-Google-Smtp-Source: ABdhPJxpRE/n/1CUrpqRACuHUK5ahk4nB13pUI7Ys5UhPY4IircljF5Vov+KiY14lkQ+ra/nf6BogA==
X-Received: by 2002:a63:be0e:0:b0:363:e0be:613f with SMTP id l14-20020a63be0e000000b00363e0be613fmr14676330pgf.448.1645999095872;
        Sun, 27 Feb 2022 13:58:15 -0800 (PST)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id l5-20020a056a0016c500b004f140564a00sm10716550pfc.203.2022.02.27.13.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 13:58:15 -0800 (PST)
Message-ID: <5935986f-bbbf-fa90-2eba-b249ca7e15e1@kernel.dk>
Date:   Sun, 27 Feb 2022 14:58:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/6] block, fs: assert that key paths use iovecs, and
 nothing else
Content-Language: en-US
To:     jhubbard.send.patches@gmail.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
 <20220227093434.2889464-4-jhubbard@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220227093434.2889464-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/block/bio.c b/block/bio.c
> index b15f5466ce08..4679d6539e2d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1167,6 +1167,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>  
> +	WARN_ON_ONCE(!iter_is_iovec(iter));
> +

If these make sense, why aren't they also returning an error?

-- 
Jens Axboe

