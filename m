Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028DC68E07F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 19:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjBGSth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 13:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBGStg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:49:36 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8700218B
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 10:49:34 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w13so6423829ilv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 10:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBmufrIpKjI+8mvdDvPBth0aa6lZWSixeneHNMXKRKo=;
        b=U2nW/kDHyjhF94YUCuaOOTrEUZ/r/LxWEAN0Rkyku8k9pghGOiQC9GB5Ajw8KBX/Zd
         oiE/P6iV7zENMWEHN5BIjUB6ZsTzIhbgyIxepZ0UpYViCZqLx7nTUeTEv4+yWGkM7Uxy
         FCmdoZ1C8kOjcGnwCuHp4Rm0t6FnclnPwbkT48MES5BmtU/QyJBUp8YCGE6i41yU/fmJ
         TVAe0zTK6uovFg2incYacWOlDH1hWk3qcNViESwSJqe4NeWD0kmtKI/7m49bFoYweQKw
         yNLmEoHVxL14TV9B4uAIC/8CRwkOGdzB1OYtWm/af4w3YGJVONeCuE/4K9kKmzugKMmN
         sq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBmufrIpKjI+8mvdDvPBth0aa6lZWSixeneHNMXKRKo=;
        b=YR5zVx4vLcKRtrRIT88PEL279TK9f/OMnWCGYB8ljq+Y1SzFy4z3IQD/a7hLhS5mYp
         AvZyyyV5v1+9SENfSb3Tor7UfvWekIKdHRyjsYtnHn3TZ2GDABDtE+72BRJsVa4VG4u/
         r4OH+XpfLJVbc5F4ywNkYi0ibJDjaYkhYdGHHnEIVjWn4KRYFAP7gx02/p62QUeqn0aW
         HE+RExC02cXBcEIb1GH6815BsOnlzViRamcnhTiPrdkfOSpXJec03OYPTIPsqGhtLjsM
         Dwzx+/WWUqRdKIsqUJE/PiohQsITBTbc+EUhR0pYXbQcG31ZpW8RA7Z+LMVA/Lu+ZdWo
         pEEg==
X-Gm-Message-State: AO0yUKXaRmbIy5olk/lkYK1zqKFFY9nyuS4c9J8xYh7xdjZLvRITfcaH
        85d9YXcUdRbqzePWrb52FVTc2w==
X-Google-Smtp-Source: AK7set/tAwL3lb3yurbCeVjSHYgxs8++6eMI/PGkEJvuzZ9KDObbhzYc4+Q7jZiXFnMbLg+UqBjBKg==
X-Received: by 2002:a05:6e02:1b88:b0:313:c5a4:9888 with SMTP id h8-20020a056e021b8800b00313c5a49888mr4759540ili.0.1675795773811;
        Tue, 07 Feb 2023 10:49:33 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f20-20020a056638119400b003a60da2bf58sm4559086jas.39.2023.02.07.10.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:49:33 -0800 (PST)
Message-ID: <88fcfd5a-cf73-f417-cea6-eed5094d71ed@kernel.dk>
Date:   Tue, 7 Feb 2023 11:49:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v12 00/10] iov_iter: Improve page extraction (pin or just
 list)
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230207171305.3716974-1-dhowells@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230207171305.3716974-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/7/23 10:12 AM, David Howells wrote:
> Hi Jens, Al, Christoph,
> 
> Here are patches to provide support for extracting pages from an iov_iter
> and to use this in the extraction functions in the block layer bio code.
> 
> The patches make the following changes:
> 
>  (1) Change generic_file_splice_read() to load up an ITER_BVEC iterator
>      with sufficient pages and use that rather than using an ITER_PIPE.
>      This avoids a problem[2] when __iomap_dio_rw() calls iov_iter_revert()
>      to shorten an iterator when it races with truncation.  The reversion
>      causes the pipe iterator to prematurely release the pages it was
>      retaining - despite the read still being in progress.  This caused
>      memory corruption.
> 
>  (2) Remove ITER_PIPE and its paraphernalia as generic_file_splice_read()
>      was the only user.
> 
>  (3) Add a function, iov_iter_extract_pages() to replace
>      iov_iter_get_pages*() that gets refs, pins or just lists the pages as
>      appropriate to the iterator type.
> 
>      Add a function, iov_iter_extract_will_pin() that will indicate from
>      the iterator type how the cleanup is to be performed, returning true
>      if the pages will need unpinning, false otherwise.
> 
>  (4) Make the bio struct carry a pair of flags to indicate the cleanup
>      mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (indicating
>      FOLL_GET was used) and BIO_PAGE_PINNED (indicating FOLL_PIN was used)
>      is added.
> 
>      BIO_PAGE_REFFED will go away, but at the moment fs/direct-io.c sets it
>      and this series does not fully address that file.
> 
>  (5) Add a function, bio_release_page(), to release a page appropriately to
>      the cleanup mode indicated by the BIO_PAGE_* flags.
> 
>  (6) Make the iter-to-bio code use iov_iter_extract_pages() to retain the
>      pages appropriately and clean them up later.
> 
>  (7) Fix bio_flagged() so that it doesn't prevent a gcc optimisation.

I've updated the for-6.3/iov-extract branch and the for-next branch. This
isn't done to bypass any review, just so we can get some more testing on
this (and because the old one is known broken).

-- 
Jens Axboe


