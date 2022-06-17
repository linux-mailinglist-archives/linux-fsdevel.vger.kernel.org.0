Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0554FFF4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 00:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiFQWay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 18:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiFQWax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:30:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDCF62107
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 15:30:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a17so3006219pls.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qqceZ6RsqnxU2R5hj4YA6mRU/J9KvvtRqR3ud6arQTA=;
        b=gy8hYBJ05Vitcc7C+prlSZfAWP4tQw6H/M+CGoJU9G5/5ug7YbJ94DfimLhojbikqu
         QtsBiT3/0RA/fyQJ6b6dCPScIK+E6mcl/+HTmzG7xoO0AP/yOkFQARaY9lxmDXtsw2BU
         PU1nR9efhtgireGhrkR5k1sqCQiczxn1BMPNh2K0nS4nR1fOlWDsPaC94RVQKmmjT88Z
         Z0KnqpoJ3JLXGJjJouElZ1in6bevOlDoc1CkphTEYWeIYjxtN5nTw7tZTOhRQwMeQ2HH
         /oPMsCw4gPQpQKXf9/a1soT36JZTbWkRD7ElwSPeB3w5NO17jeB8x7LQw8t5UujvbDrX
         Bu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qqceZ6RsqnxU2R5hj4YA6mRU/J9KvvtRqR3ud6arQTA=;
        b=ik3vWgJ3nmda+qN/zs6NX9C7o1hVuqhvK8Sx5LV3P2/ABmMpD25aP9CRyO3KHcSC8/
         CYjsdiacuXLy0mNSsOIMOQomwZeTm86AcACFweLLwn/Weig5zCnprEDkqp8KMO+k9KsE
         vn/4t9YGGJ9e5UIWUMr/9wCyC/T5sQpkSmUSxwAdjbWy9W23vA8kfc30973oidmE3/Ul
         4L+W6KK7TIXOMjtxBD/mn2qwKDYZfIwSIDY/Vj48P11C3z/wjZk3fQ4Bc322iAFK7/DJ
         0Uuh/U71srBhTG224kSVUKXvbc443l0Tf/e/BuR9AHqVQ30OV5s5GPmgSFU+TPzmSJ5y
         fGqA==
X-Gm-Message-State: AJIora95c1bN3mSBT+T12NFTVYRv3V0ChcPLq6b3LWSqSMBz9AJDpz4M
        z0g2BaUbAPyxs/mWVFqRtR4JfQ==
X-Google-Smtp-Source: AGRyM1tzdO835HEOxWy77ZKGyiyqm7C6MQAMlTxhRReGk0rZnJ7Fv/Omlrq0T6OZhQUiHA5wegmNDw==
X-Received: by 2002:a17:903:2308:b0:167:6bfe:a800 with SMTP id d8-20020a170903230800b001676bfea800mr11539522plh.100.1655505051575;
        Fri, 17 Jun 2022 15:30:51 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f70200b001622c377c3esm4040835plo.117.2022.06.17.15.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 15:30:50 -0700 (PDT)
Message-ID: <8fb435a4-269d-9675-9a44-d37605c84314@kernel.dk>
Date:   Fri, 17 Jun 2022 16:30:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC][PATCHES] iov_iter stuff
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/22 10:08 PM, Al Viro wrote:
> 	Rebased to -rc1 and reordered.  Sits in vfs.git #work.iov_iter,
> individual patches in followups
> 
> 1/9: No need of likely/unlikely on calls of check_copy_size()
> 	not just in uio.h; the thing is inlined and it has unlikely on
> all paths leading to return false
> 
> 2/9: btrfs_direct_write(): cleaner way to handle generic_write_sync() suppression
> 	new flag for iomap_dio_rw(), telling it to suppress generic_write_sync()
> 
> 3/9: struct file: use anonymous union member for rcuhead and llist
> 	"f_u" might have been an amusing name, but... we expect anon unions to
> work.
> 
> 4/9: iocb: delay evaluation of IS_SYNC(...) until we want to check IOCB_DSYNC
> 	makes iocb_flags() much cheaper, and it's easier to keep track of
> the places where it can change.
> 
> 5/9: keep iocb_flags() result cached in struct file
> 	that, along with the previous commit, reduces the overhead of
> new_sync_{read,write}().  struct file doesn't grow - we can keep that
> thing in the same anon union where rcuhead and llist live; that field
> gets used only before ->f_count reaches zero while the other two are
> used only after ->f_count has reached zero.
> 
> 6/9: copy_page_{to,from}_iter(): switch iovec variants to generic
> 	kmap_local_page() allows that.  And it kills quite a bit of
> code.
> 
> 7/9: new iov_iter flavour - ITER_UBUF
> 	iovec analogue, with single segment.  That case is fairly common and it
> can be handled with less overhead than full-blown iovec.
> 
> 8/9: switch new_sync_{read,write}() to ITER_UBUF
> 	... and this is why it is so common.  Further reduction of overhead
> for new_sync_{read,write}().
> 
> 9/9: iov_iter_bvec_advance(): don't bother with bvec_iter
> 	AFAICS, variant similar to what we do for iovec/kvec generates better
> code.  Needs profiling, obviously.

Al, looks good to me from inspection, and I ported stuffed this on top
of -git and my 5.20 branch, and did my send/recv/recvmsg io_uring change
on top and see a noticeable reduction there too for some benchmarking.
Feel free to add:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to the series.

Side note - of my initial series I played with, I still have this one
leftover that I do utilize for io_uring:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.20/io_uring-iter&id=a59f5c21a6eeb9506163c20aff4846dbec159f47

Doesn't make sense standalone, but I have it as a prep patch.

Can I consider your work.iov_iter stable at this point, or are you still
planning rebasing?

-- 
Jens Axboe

