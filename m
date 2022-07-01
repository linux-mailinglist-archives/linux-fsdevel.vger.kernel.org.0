Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3740563BC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 23:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiGAVbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 17:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGAVbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:31:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A96427D2
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 14:30:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so7658749pjj.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ANX4Aj1RHifKikA05B+uMeZTWKbW4DbKzSJP03NMwOE=;
        b=kdp+n/+JlIrulU9wpxKpZIdz4yd8MT1eLqKP1e6waHTd9jNI1mG4j9LaG8unbOE1Jg
         uESAq33Z6BGNSrPia8odgQLMIP9kM/114+svr0NOma9Pe2leHQmGmZRXtITqgqKhf3eK
         NKxtpamITDv77lSBhlbWdRHiNHWlR2Mrd8GhAFXK/cKOsd7UBD1QlxJDVZK4AvIBhr+7
         HhGz/lvOMew0K3xyuJGPAHEsqKKjByGhfuprv5+IG3crjHewJZKrvM3KsqJaUcv+xPaD
         PgbYyTGjXsMNfRP4YR/of8IrG/lSuWwsjU7ZgoYcVSUUkugkUf4suEN/73axCM59Umk/
         EL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ANX4Aj1RHifKikA05B+uMeZTWKbW4DbKzSJP03NMwOE=;
        b=q+4VBQ5lG9r9qhFVN+TVvq0R2c64rr0uOsO6++vmnBHn87C+gthn1bqsaehsbH1cqP
         v1Dtf2GxyQEP+NjPwHT1wLRydgN7/EWwWufmZqL4nzZLkF16Mz+z8VCIDeC9eBJ1Dr8N
         OyvQwel2+/pO+DOBuKjhKaE3iFHZmtx5SdkVyX9iFEAaclSUViC/HqUNdUAS0IldlbsG
         wNW4z8pJTpAtWJjamyVJoyIY/pnKDSdwzYYuX52xK9VvsBaikKGa51I76gMJr+yx9cL3
         X1g0XfS0G8meojiVZhD7cq/1edmSZAqg8iOJa8+YDROb3trTn0Q6TZjABXNYP8j0Tw05
         NbJQ==
X-Gm-Message-State: AJIora8Ckvdh7hDfkjqJVXMfH4ECAIejcAM19zoNcJNNK9fmTnWPsYIR
        UwMMxjvMQ3msuoFQaAVmnefQGw==
X-Google-Smtp-Source: AGRyM1t8GQlW6cuL1oApVK3CzzSTFrQkoonNg2vGsLTjSLAXUSJ4/3wnAcrSq5Uqo2SVzESbN0YgSA==
X-Received: by 2002:a17:90b:1644:b0:1ec:e6d4:7931 with SMTP id il4-20020a17090b164400b001ece6d47931mr20369729pjb.105.1656711058236;
        Fri, 01 Jul 2022 14:30:58 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ay23-20020a056a00301700b0051baeb06c0bsm10105852pfb.168.2022.07.01.14.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 14:30:57 -0700 (PDT)
Message-ID: <0197eded-b93f-6aff-aefe-b6a85dd8d953@kernel.dk>
Date:   Fri, 1 Jul 2022 15:30:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk> <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV> <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yr8xmNMEOJke6NOx@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/1/22 11:40 AM, Al Viro wrote:
> On Thu, Jun 30, 2022 at 08:07:24PM -0600, Keith Busch wrote:
>> On Thu, Jun 30, 2022 at 11:39:36PM +0100, Al Viro wrote:
>>> On Thu, Jun 30, 2022 at 11:11:27PM +0100, Al Viro wrote:
>>>
>>>> ... and the first half of that thing conflicts with "block: relax direct
>>>> io memory alignment" in -next...
>>>
>>> BTW, looking at that commit - are you sure that bio_put_pages() on failure
>>> exit will do the right thing?  We have grabbed a bunch of page references;
>>> the amount if DIV_ROUND_UP(offset + size, PAGE_SIZE).  And that's before
>>> your
>>>                 size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
>>
>> Thanks for the catch, it does look like a page reference could get leaked here.
>>
>>> in there.  IMO the following would be more obviously correct:
>>>         size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
>>>         if (unlikely(size <= 0))
>>>                 return size ? size : -EFAULT;
>>>
>>> 	nr_pages = DIV_ROUND_UP(size + offset, PAGE_SIZE);
>>> 	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
>>>
>>>         for (left = size, i = 0; left > 0; left -= len, i++) {
>>> ...
>>>                 if (ret) {
>>> 			while (i < nr_pages)
>>> 				put_page(pages[i++]);
>>>                         return ret;
>>>                 }
>>> ...
>>>
>>> and get rid of bio_put_pages() entirely.  Objections?
>>
>>
>> I think that makes sense. I'll give your idea a test run tomorrow.
> 
> See vfs.git#block-fixes, along with #work.iov_iter_get_pages-3 in there.
> Seems to work here...
> 
> If you are OK with #block-fixes (it's one commit on top of
> bf8d08532bc1 "iomap: add support for dma aligned direct-io" in
> block.git), the easiest way to deal with the conflicts would be
> to have that branch pulled into block.git.  Jens, would you be
> OK with that in terms of tree topology?  Provided that patch
> itself looks sane to you, of course...

I'm fine with that approach. Don't have too much time to look into this
stuff just yet, but looks like you and Keith are getting it sorted out.
I'll check in on emails later this weekend and we can get it pulled in
at that point when you guys deem it ready to check/pull.

-- 
Jens Axboe

