Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4B53125E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiEWPoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 11:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiEWPoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 11:44:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE611278
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:44:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so17933996pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=OnJGMGtupJB+0hktg+k458KAkFV0Gh5QiTDIaqMXHPU=;
        b=PjnHX3/bH3zvgBdC5LDX4nlZAfMazalNW5s6WbEDPGXB0lxcTCkazUwkbj6tvMHtuj
         OolraEI1LOkNK2v3m5MqhhI8ihKpmpnNsSqs2AxQRxau6Op2CIBFbCgO79j8gEnSrYFv
         K4FA/mSiMIOqCECS6EhXvR3+pWRUBambXlzGuJ7IcWUrQ4jsocQS82lLKGFCpy3RpQpC
         /KJBTRwJShIH55D9g5RXL78pLK5DlT0cfeb0jLdGRypjHvd05WK675/aQumSX5VRapZ5
         Rls0RtvXgEa5itmtC7/u52B3JbMtPItKUzX6TTzLWVa4pNCmZNwrBidFaVcIIcgPbVvx
         cxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=OnJGMGtupJB+0hktg+k458KAkFV0Gh5QiTDIaqMXHPU=;
        b=wOZxSYZSHUC7yL9mPx1kc57f09qtw2xkSfsR+l2u4D2K+VdSqW2zk+lANn/M4e2f9B
         vSAlflCiFqnAISzCvGNPTdKD1Z1CXLRJ7nUXLXd9KMR4Ql9Z7Bw91iaOkCbE0NPpNcau
         YMekzJsYWMxhHvAviDJ5zZwdCxEx8RDKlr/TYT7ddsua+N1q69LWxhSN0zYhIKLJyXO6
         L1QeXh0G+mGhfck3lpAlWs+JFPliPr6YzKlEu/AJuT/uRLy5P+QAO/L/VKqh9OR6Xni+
         PQDetd/8rmVcspOqFBG8xaX1jWl1io6BA+SU0vfh3W/mdZOq7KU1SgUTALQSiGJtmfjU
         BLWg==
X-Gm-Message-State: AOAM532QMiKLZgssE5RVcK5reSXhUFV1AoJSJkbwA/bDK4C7Iv3ib/Fd
        jiyrUfX0SoCGMAJmXmLkZao2+w==
X-Google-Smtp-Source: ABdhPJxFj4oFN/XBUAFYV2KO4oMpk0hoLG8pEVbutk5suhBu+FxRL9C7zgKBqFvDMipj1+6Z/GtoDg==
X-Received: by 2002:a17:90b:3708:b0:1df:56ac:65c6 with SMTP id mg8-20020a17090b370800b001df56ac65c6mr27551570pjb.23.1653320654338;
        Mon, 23 May 2022 08:44:14 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b00161455d8029sm5345765plx.12.2022.05.23.08.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:44:13 -0700 (PDT)
Message-ID: <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk>
Date:   Mon, 23 May 2022 09:44:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
 <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
 <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
 <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
 <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
In-Reply-To: <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/22 9:12 AM, Jens Axboe wrote:
>> Current branch pushed to #new.iov_iter (at the moment; will rename
>> back to work.iov_iter once it gets more or less stable).
> 
> Sounds good, I'll see what I need to rebase.

On the previous branch, ran a few quick numbers. dd from /dev/zero to
/dev/null, with /dev/zero using ->read() as it does by default:

32      260MB/sec
1k      6.6GB/sec
4k      17.9GB/sec
16k     28.8GB/sec

now comment out ->read() so it uses ->read_iter() instead:

32      259MB/sec
1k      6.6GB/sec
4k      18.0GB/sec
16k	28.6GB/sec

which are roughly identical, all things considered. Just a sanity check,
but looks good from a performance POV in this basic test.

Now let's do ->read_iter() but make iov_iter_zero() copy from the zero
page instead:

32      250MB/sec
1k      7.7GB/sec
4k      28.8GB/sec
16k	71.2GB/sec

Looks like it's a tad slower for 32-bytes, considerably better for 1k,
and massively better at page size and above. This is on an Intel 12900K,
so recent CPU. Let's try cacheline and above:

Size	Method			BW		
64	copy_from_zero()	508MB/sec
128	copy_from_zero()	1.0GB/sec
64	clear_user()		513MB/sec
128	clear_user()		1.0GB/sec

Something like the below may make sense to do, the wins at bigger sizes
is substantial and that gets me the best of both worlds. If we really
care, we could move the check earlier and not have it per-segment. I
doubt it matters in practice, though.

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e93fcfcf2176..f4b80ef446b9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1049,12 +1049,19 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 	return bytes;
 }
 
+static unsigned long copy_from_zero(void __user *buf, size_t len)
+{
+	if (len >= 128)
+		return copy_to_user(buf, page_address(ZERO_PAGE(0)), len);
+	return clear_user(buf, len);
+}
+
 size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_zero(bytes, i);
 	iterate_and_advance(i, bytes, base, len, count,
-		clear_user(base, len),
+		copy_from_zero(base, len),
 		memset(base, 0, len)
 	)
 

-- 
Jens Axboe

