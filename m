Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECB6CB31B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 03:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjC1BUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 21:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjC1BUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:20:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C32D46
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 18:20:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso13612231pjb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679966405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTKn3ezwLKadGvS6IyVa6gt2k+m9ZpFw+PSLXIs3AhA=;
        b=FdOE+vS0msQfoSn06Ley+HZ4p/bPUAm1aOACuwvsXXtvdRSUM/Aa/6IlvxhuB2h4j/
         /SCWIQEhLVh88Mv0MG0qCaOQ2hFhbKm4myas3NogQ5Og6Mr71yYO1FCB1R+YQqmB7rdV
         ex1MtZEHDltDqv4H+14//mdgoOqDDeqbV98CmV//LAfm3hcNsP+c9NNS8QCkg+FPmCR3
         IeOLokhP9YPNJDBNipa5jzw251/3oIxvYiiNx1/a9871vgq3xJGj/uvXC4D29vz8+xHo
         ZQlhsqf93F4ktl6OtGAtGJsxnrbLOSockvEZ3e0Dyq5Zj1TJHtDn0GEI5p8JMVMV9XFZ
         BVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679966405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTKn3ezwLKadGvS6IyVa6gt2k+m9ZpFw+PSLXIs3AhA=;
        b=ncl5E4Krb2m4YqjoVoGAGpa8SSSWqEiO5wHGkkct7i/jOQgMDwY4DUIrhhvYbXKHAj
         BA0xSkyBDFvdMbo/3lSVyAk9HHiwe8BbCLU6U+D9Vfy0jBGRuCnIR4k4L/ISpf+BhrvR
         izCFSspISqO6214d30TFMbUdjM8v4BB9fbyzxCb7nH7oUDIo8IsSCHDoUxZf8wBwJVrc
         bA+qpubreOuTI18e1+NtB1jH5PgJsLxkW+YQeBAIgoIWXNYVdT09qUrffhcBAPIzEe1D
         CpA7JcYRdE7oaKn9gKG85vyvHQzoHZMWEgoMWxeiS/uNbEsQv9GAUoThkF4hGRCJoLzH
         hPrg==
X-Gm-Message-State: AAQBX9cJ3MZKj3Dt9a8tpKlSiZ3qeP463K3xwb0Y0ftdnBrXjJili7kd
        QNpZ0jrwKB5HTb/ggu4/VRF4z1xDgXamWLeX6zZpew==
X-Google-Smtp-Source: AKy350aBCl4pD8FlAe/yS1chOsnfqh6bvz1MhRNqbyYUkhhb+vOT8X9lk/SAq5exX7ACxdoHJYg5bw==
X-Received: by 2002:a17:903:32cd:b0:196:8d96:dc6b with SMTP id i13-20020a17090332cd00b001968d96dc6bmr12435991plr.2.1679966404900;
        Mon, 27 Mar 2023 18:20:04 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709028f8800b001a053b7e892sm19745916plo.195.2023.03.27.18.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 18:20:04 -0700 (PDT)
Message-ID: <90ff3f64-2263-b004-e91a-2a8185266291@kernel.dk>
Date:   Mon, 27 Mar 2023 19:20:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] iov_iter: import single vector iovecs as ITER_UBUF
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
References: <20230327232713.313974-1-axboe@kernel.dk>
 <20230327232713.313974-4-axboe@kernel.dk> <20230328000811.GJ3390869@ZenIV>
 <20230328002509.GK3390869@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230328002509.GK3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/27/23 6:25 PM, Al Viro wrote:
> On Tue, Mar 28, 2023 at 01:08:11AM +0100, Al Viro wrote:
>> On Mon, Mar 27, 2023 at 05:27:13PM -0600, Jens Axboe wrote:
>>> Add a special case to __import_iovec(), which imports a single segment
>>> iovec as an ITER_UBUF rather than an ITER_IOVEC. ITER_UBUF is cheaper
>>> to iterate than ITER_IOVEC, and for a single segment iovec, there's no
>>> point in using a segmented iterator.
>>
>> Won't that enforce the "single-segment readv() is always identical to
>> read()"?  We'd been through that before - some of infinibarf drvivers
>> have two different command sets, one reached via read(), another - via
>> readv().  It's a userland ABI.  Misdesigned one, but that's infinibarf
>> for you.
>>
>> Does anyone really need this particular microoptimization?
> 
> static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
> {
>         struct qib_filedata *fp = iocb->ki_filp->private_data;
> 	struct qib_ctxtdata *rcd = ctxt_fp(iocb->ki_filp);
> 	struct qib_user_sdma_queue *pq = fp->pq;
> 
> 	if (!iter_is_iovec(from) || !from->nr_segs || !pq)
> 		return -EINVAL;
> 
> 	return qib_user_sdma_writev(rcd, pq, from->iov, from->nr_segs);
> }
> 
> Hit this with single-segment writev() and you've got yourself -EINVAL.
> Sure, that could be adjusted for (check for user_backed_iter(), then
> if it's ubuf form an iovec and pass that to qib_user_sdma_writev()),
> but that's a clear regression.
> 
> Found by simple grepping for iter_is_iovec()...

Looks like there are a few of those, in fact. Guess we need to do
an iter->user_backed check for these.

-- 
Jens Axboe


