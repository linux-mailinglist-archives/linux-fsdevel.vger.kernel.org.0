Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E52F530724
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 03:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiEWB3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 21:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351899AbiEWB3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 21:29:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A898738DBF
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 18:28:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so12362760pfb.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 18:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=3YSSgmSKRe7bmBsva+2psUhh5z0r1ZAyNtlMAJ0gr3Y=;
        b=yR6JBR5DE7vQ1IjyxFdF/WodmHWwiym1l0yyNIs4dj2CrX0nZwpkXqXvzI/x5hmqpZ
         7yuiYFy4ZQek5eqIlTnOAWapQgYdSRvCLbrYcAQyEPHUgAduw9QGj940W99jG2cme63d
         Qvmr2BlgWxRmwZnrGjfsX6MgUaQnJBKSim+3gnmeXRxveSQsgieITNMr9EtbhxJLYot0
         1fzEbesJoR7ZA2g7LkKmzSe445pPrbRXAmVa7jynIme1dP8RRLLW/M8TiNog7sVz9DtC
         5L7eVWiP+1EWoWIf3wLoLV3SuTYKLusCiGxoZaXxZxqfBg9AWLGvBKdn9slBPNpSMV9U
         bFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=3YSSgmSKRe7bmBsva+2psUhh5z0r1ZAyNtlMAJ0gr3Y=;
        b=GedORT26KRUjmJ7nbWwRlq6Id/prEMP41cGPsVZ6Lz8Gpbir5v447pHNrYSdd2Et+O
         cehzza2pvIy2auP6ER5/wEnSrEvoIP0JqThi1Fpg0BTDpvgPSBOgB1ltdO8/lx9P6YAN
         GftUapFdmggD5pvF3AHrVPgdewxEp/uPrZJt22zzOJYR3NrUm9lPGsM8Wa5dBICu3Lb3
         ThfOBh5WTq9meHQ1ImXVLRzC2dMEm7m96c3MBGsR8JYQxV8NIDZyojLHaaj7X/82umQY
         25vUx+DLEyrr4NFBoCyVe3Q+v/FLiJLUmMHD87ZE89kcTznNP8P/DFBOYx3dUqgCwiJu
         qWWA==
X-Gm-Message-State: AOAM530+T8Id2rp+a1tK1BAvFcNOLwsNmAMpRrfFanK8T4Hh4q9m1zpD
        PpYolBjJK/MlKHEcOVG4Ad4Q+C0BaOKsoQ==
X-Google-Smtp-Source: ABdhPJyQjC67j+T8ZD4X5J46WNWibxxwLmDDiontZGBmxhwrGqiUs3b91ob9/ZkYGh/+Nx2eHruoxw==
X-Received: by 2002:a63:81c7:0:b0:3f9:f00e:71dc with SMTP id t190-20020a6381c7000000b003f9f00e71dcmr7896431pgd.592.1653269334966;
        Sun, 22 May 2022 18:28:54 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902c64100b0015e8d4eb295sm3690665pls.223.2022.05.22.18.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 18:28:54 -0700 (PDT)
Message-ID: <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
Date:   Sun, 22 May 2022 19:28:53 -0600
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
References: <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
In-Reply-To: <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/22 7:22 PM, Jens Axboe wrote:
> On 5/22/22 6:42 PM, Al Viro wrote:
>> On Sun, May 22, 2022 at 02:03:35PM -0600, Jens Axboe wrote:
>>
>>> Right, I'm saying it's not _immediately_ clear which cases are what when
>>> reading the code.
>>>
>>>> up a while ago.  And no, turning that into indirect calls ended up with
>>>> arseloads of overhead, more's the pity...
>>>
>>> It's a shame, since indirect calls make for nicer code, but it's always
>>> been slower and these days even more so.
>>>
>>>> Anyway, at the moment I have something that builds; hadn't tried to
>>>> boot it yet.
>>>
>>> Nice!
>>
>> Boots and survives LTP and xfstests...  Current variant is in
>> vfs.git#work.iov_iter (head should be at 27fa77a9829c).  I have *not*
>> looked into the code generation in primitives; the likely/unlikely on
>> those cascades of ifs need rethinking.
> 
> I noticed too. Haven't fiddled much in iov_iter.c, but for uio.h I had
> the below. iov_iter.c is a worse "offender" though, with 53 unlikely and
> 22 likely annotations...

Here it is...


diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6570b688ed39..52baa3c89505 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -163,19 +163,17 @@ static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, true)))
-		return 0;
-	else
+	if (check_copy_size(addr, bytes, true))
 		return _copy_to_iter(addr, bytes, i);
+	return 0;
 }
 
 static __always_inline __must_check
 size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, false)))
-		return 0;
-	else
+	if (check_copy_size(addr, bytes, false))
 		return _copy_from_iter(addr, bytes, i);
+	return 0;
 }
 
 static __always_inline __must_check
@@ -191,10 +189,9 @@ bool copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 static __always_inline __must_check
 size_t copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(!check_copy_size(addr, bytes, false)))
-		return 0;
-	else
+	if (check_copy_size(addr, bytes, false))
 		return _copy_from_iter_nocache(addr, bytes, i);
+	return 0;
 }
 
 static __always_inline __must_check

-- 
Jens Axboe

