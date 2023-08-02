Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA13376D480
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjHBRBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjHBRBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:01:17 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CB173A
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:01:14 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7748ca56133so68181839f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690995674; x=1691600474;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFGXYWabYJ39ryOSt07GiPvsIReEz56NrabUnE8L4Ak=;
        b=qKuBqdJiHqr6O/uCq34uUGplnagg32QEnnT7tVTR++zzLIRY18ttqWdvU6rjhbD1if
         /UHsoE1Sq/PidUUn203n2FdVs2aM0SW97UBkXki6U4UFo6LltbmCJVd9Ni2nA8Ga3THx
         P40HQ0lnwyQHQWyce+aUy73pBhGsqbTYdhkklyeA7DNeNMlwmqTvHB8a9jF7Dj6xbLq/
         nGeozVq2jI1zbQ5+hltIYgaPcl+lRyoLdTkjvp4MKGVZSn2leAlJeGOSX+nZohVqoOzb
         huoCwYZA9ssmtoibtJF3L6ZMW5x42pU7Hy/4joQg3a4HV9Hcy3C0cedYw1iI1PItLpYE
         RQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690995674; x=1691600474;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFGXYWabYJ39ryOSt07GiPvsIReEz56NrabUnE8L4Ak=;
        b=MG80pgb+suTzOGDTaAURej4lV/wL9iwjeuIK7WAI3tf6riGmhk/dmFyNJFvDblaxH4
         BzYBImrIkGnq8hnkgQh2V6CuKeXHs6hmDgi5FrIS0OHbS9ih6rPh1WudXjmYPSowQhyk
         AUeiIic49kAYSOXpAaX7/vCs63VDfa4QfvtqNMbOt+DvOJAC2k+XVpbbyZtq9yQNSDNK
         5ZEVrS8issjnd4lIBSF2fpnc/xHa8/M1dxDUPn873A5jJjDfr7+CpF/Yca1XGKgXQDLF
         YPoTLD7YfBBrrkZH5GsXgdJPhwYngHxKae4FgmNtdF5EHUg8LC2vksiNgqYTXVUNCqmE
         jm8g==
X-Gm-Message-State: ABy/qLZdapCNHxfgibzun6lCunjxYXfXiCdIh340OT/GKje/jwcbj4TH
        yuXHX2CMbNsAuI8lgtU6nxkjcg==
X-Google-Smtp-Source: APBJJlGoBM+fZubbdkemaN8DGpH/3h22QjA5dqB1SpPWUIX9A/yAxK2isUCXEkOjt6abU7fGYa9eug==
X-Received: by 2002:a92:d38d:0:b0:348:ec3f:fce1 with SMTP id o13-20020a92d38d000000b00348ec3ffce1mr12250281ilo.0.1690995674030;
        Wed, 02 Aug 2023 10:01:14 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y8-20020a02a388000000b0042b46224650sm4345106jak.91.2023.08.02.10.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 10:01:13 -0700 (PDT)
Message-ID: <a2a6e445-1cbd-1c28-af60-3e449f9673ea@kernel.dk>
Date:   Wed, 2 Aug 2023 11:01:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [axboe-block:xfs-async-dio] [fs] f9f8b03900:
 stress-ng.msg.ops_per_sec 29.3% improvement
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
References: <202308022138.a9932885-oliver.sang@intel.com>
 <029f3c86-c206-0ad5-9c42-04ea0b683367@kernel.dk>
In-Reply-To: <029f3c86-c206-0ad5-9c42-04ea0b683367@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/23 10:38?AM, Jens Axboe wrote:
> On 8/2/23 7:52?AM, kernel test robot wrote:
>>
>> hi, Jens Axboe,
>>
>> though all results in below formal report are improvement, Fengwei (CCed)
>> checked on another Intel(R) Xeon(R) Gold 6336Y CPU @ 2.40GHz (Ice Lake)
>> (sorry, since this machine doesn't belong to our team, we cannot intergrate
>> the results in our report, only can heads-up you here), and found ~30%
>> stress-ng.msg.ops_per_sec regression.
>>
>> but by disable the TRACEPOINT, the regression will disappear.
>>
>> Fengwei also tried to remove following section from the patch:
>> @@ -351,7 +361,8 @@ enum rw_hint {
>>  	{ IOCB_WRITE,		"WRITE" }, \
>>  	{ IOCB_WAITQ,		"WAITQ" }, \
>>  	{ IOCB_NOIO,		"NOIO" }, \
>> -	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }
>> +	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
>> +	{ IOCB_DIO_DEFER,	"DIO_DEFER" }
>>
>> the regression is also gone.
>>
>> Fengwei also mentioned to us that his understanding is this code update changed
>> the data section layout of the kernel. Otherwise, it's hard to explain the
>> regression/improvement this commit could bring.
>>
>> these information and below formal report FYI.
> 
> Very funky. I ran this on my 256 thread box, and removing the
> IOCB_DIO_DEFER (which is now IOCB_CALLER_COMP) trace point definition, I
> get:
> 
> stress-ng: metrc: [4148] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
> stress-ng: metrc: [4148]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
> stress-ng: metrc: [4148] msg           1626997107     60.61    171.63   4003.65  26845470.19      389673.05
> 
> and with it being the way it is in the branch:
> 
> stress-ng: metrc: [3678] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
> stress-ng: metrc: [3678]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
> stress-ng: metrc: [3678] msg           1287795248     61.25    140.26   3755.50  21025449.92      330563.24
> 
> which is about a -21% bogo ops drop. Then I got a bit suspicious since
> the previous strings fit in 64 bytes, and now they don't, and I simply
> shortened the names so they still fit, as per below patch. With that,
> the regression there is reclaimed.
> 
> That's as far as I've gotten yet, but I'm guessing we end up placing it
> differently, maybe now overlapping with data that is dirtied? I didn't
> profile it very much, just for an overview, and there's really nothing
> to observe there. The task and system is clearly more idle when the
> regression hits.

Better variant here. I did confirm via System.map that layout
drastically changes when we use more than 64 bytes of string data. I'm
suspecting your test is sensitive to this and it may not mean more than
the fact that this test is a bit fragile like that, but let me know how
it works for you with the below.


diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1e6dbe309d52..487ef4ae7267 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -353,20 +353,24 @@ enum rw_hint {
  */
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
 
-/* for use in trace events */
+/*
+ * For use in trace events - keep the text sizes descriptions small, as it
+ * seems layout drastically changes if we have more than 64 bytes of total
+ * text in here.
+ */
 #define TRACE_IOCB_STRINGS \
-	{ IOCB_HIPRI,		"HIPRI" }, \
+	{ IOCB_HIPRI,		"PRI" }, \
 	{ IOCB_DSYNC,		"DSYNC" }, \
 	{ IOCB_SYNC,		"SYNC" }, \
-	{ IOCB_NOWAIT,		"NOWAIT" }, \
-	{ IOCB_APPEND,		"APPEND" }, \
-	{ IOCB_EVENTFD,		"EVENTFD"}, \
+	{ IOCB_NOWAIT,		"NWAIT" }, \
+	{ IOCB_APPEND,		"APND" }, \
+	{ IOCB_EVENTFD,		"EVFD"}, \
 	{ IOCB_DIRECT,		"DIRECT" }, \
 	{ IOCB_WRITE,		"WRITE" }, \
 	{ IOCB_WAITQ,		"WAITQ" }, \
 	{ IOCB_NOIO,		"NOIO" }, \
-	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
-	{ IOCB_DIO_CALLER_COMP,	"CALLER_COMP" }
+	{ IOCB_ALLOC_CACHE,	"ACACHE" }, \
+	{ IOCB_DIO_CALLER_COMP,	"CCOMP" }
 
 struct kiocb {
 	struct file		*ki_filp;
 

-- 
Jens Axboe

