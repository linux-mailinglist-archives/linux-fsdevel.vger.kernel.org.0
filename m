Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332835241A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 02:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349744AbiELAme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 20:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349743AbiELAm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 20:42:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AFD52B23
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 17:42:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d17so3460837plg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 17:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gFm8ANriKARMVjpPPjQGjlWZ/8qBunZGtCTbeOK8GgI=;
        b=j86eZrqGE1jwmbYnSS3q1vuPj3wF3ZQQASK3+SATFzI6RvaovdrygDR1Ab+VEKB4TY
         fzXeYiTYuOKiwTd8Jz+WHDS37skG62DO/rkPjFd2wyCjUJzQAMR12bFSVRQLwzpV7Ref
         MFO7OJ+O8SSQmN6tPLCLx8eoyXmPCOQ/NYlef/nYUBXzlkFp81DN0Axd5cGHWwBtw+vR
         Zqj7GrV3ING0X8lH+FtLnqP45evYWb77kdx8ieE5f2cq9dpmeNeyOmcC6fWuiRg10Ncx
         Vkf2Xb8b4FbyBuYWrvQzgt1WRICfPehqXLkQdNdCauHrN1ri7xa9n/zT7jcdp7nZmVCP
         kOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gFm8ANriKARMVjpPPjQGjlWZ/8qBunZGtCTbeOK8GgI=;
        b=BJyVwb14lH//nrjqMo007K9QTEh8RwNWV21X4cEdZpUTRxhzjvTJuEd8g1hewe69bM
         f5fzH0gha+fFxEDYFP8h625J+xXxrUm5Za0hhXHdbNpBKNhoa6KLzCUOVD0yz9SZ3mnk
         wNInnOWGT2fKIeicUBu99w4DELmbS5iZX+WSTrCo1ULHz060qbg35LsSIYfwlO3HT3QI
         9AbdGmR+/v8LfISAWFujk19VhtLWkTKE59jYDmqaXBU9N/fOlLVpwNMVMsgcs6xKQ1t4
         o0AhZ5yXahZe7oEPwwzVzKurCVek38eEP4eLIt0LtuNhpymVVHhCIEh6yXI6fGrKcS46
         Y7+A==
X-Gm-Message-State: AOAM532NSbUe9du+dc7vXrs/N3IagGSQlfjzEvd+0HKS9dElb05B/DbF
        4K3Yk3r7oY1YAeBy/VMf258HVA==
X-Google-Smtp-Source: ABdhPJyRgMEBhGPBBW/egh/Ysz1zITG5YZxSFBc1M8titYCDOgpRAv9n9vkq+7EuUaRTm15kds8akA==
X-Received: by 2002:a17:90b:4ad1:b0:1dc:96fa:69aa with SMTP id mh17-20020a17090b4ad100b001dc96fa69aamr7993588pjb.189.1652316141968;
        Wed, 11 May 2022 17:42:21 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x40-20020a056a000be800b0051082ab4de0sm2334450pfu.44.2022.05.11.17.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 17:42:20 -0700 (PDT)
Message-ID: <cdcd5596-9eaa-a7cb-eeaf-6269394627c9@kernel.dk>
Date:   Wed, 11 May 2022 18:42:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] vfs: move fdput() to right place in
 ksys_sync_file_range()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        linux-fsdevel@vger.kernel.org
References: <20220511154503.28365-1-cgxu519@mykernel.net>
 <YnvbhmRUxPxWU2S3@casper.infradead.org> <YnwIDpkIBem+MeeC@gmail.com>
 <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
 <YnxUwQve8D39zxBz@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YnxUwQve8D39zxBz@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/22 6:28 PM, Al Viro wrote:
> On Wed, May 11, 2022 at 09:43:46PM +0000, Al Viro wrote:
> 
>> 3) ovl_aio_put() is hard to follow (and some of the callers are poking
>> where they shouldn't), no idea if it's correct.  struct fd is manually
>> constructed there, anyway.
> 
> Speaking of poking in the internals:
> 
> SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>                 u32, min_complete, u32, flags, const void __user *, argp,
>                 size_t, argsz)
> {
> ...
>         struct fd f;
> ...
>         if (flags & IORING_ENTER_REGISTERED_RING) {
>                 struct io_uring_task *tctx = current->io_uring;
> 
>                 if (!tctx || fd >= IO_RINGFD_REG_MAX)
>                         return -EINVAL;
>                 fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
>                 f.file = tctx->registered_rings[fd];
>                 if (unlikely(!f.file))
>                         return -EBADF;
>         } else {
>                 f = fdget(fd);
>                 if (unlikely(!f.file))
>                         return -EBADF;
>         }
> ...
> a bunch of accesses to f.file
> ...
>         if (!(flags & IORING_ENTER_REGISTERED_RING))
>                 fdput(f);
> 
> Note that f.flags is left uninitialized in the first case; it doesn't
> break since we have fdput(f) (which does look at f.flags) done only
> in the case where we don't have IORING_ENTER_REGISTERED_RING in flags
> and since flags remains unchanged since the first if.  But it would
> be just as easy to set f.flags to 0 and use fdput() in both cases...
> 
> Jens, do you have any objections against the following?  Easier to
> follow that way...

No, I think that looks fine. If you need it for other changes:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

(or let me know if you want me to take it).

-- 
Jens Axboe

