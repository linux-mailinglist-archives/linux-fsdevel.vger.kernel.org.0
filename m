Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B58609DC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJXJRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 05:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiJXJQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:16:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE7F6BD5B;
        Mon, 24 Oct 2022 02:16:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 4so2047277pli.0;
        Mon, 24 Oct 2022 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/yVDeHDr6plsnqVZvkYJdff2G0m4diaoqxuNVZA5+c=;
        b=eTEnkDQFquLaewz9opAXVByCnvraNIOH6pchFMfkKEeqQuchnJpVHxznarX776cTCI
         6ICUW/7rETyp1to8sUH5UjmHpjR99daPR79eL7tsKOcZbiHG6f2KBloyIXqg1cHCYQwt
         DT2HNM6Uq6MO91QSGvaVdTqDgj+MjqB8d3XGEXpKe93KUreJXJabE9ufDFR9unXG+R/W
         CvV0YhizY3KavfwDnGGr+FaWcevpd1S8X29nWG2cak5C2lDgPAkopvcqr2o6JdGoek94
         s9d2ZUgXMJzNGCWcURJKXbqqbI2PNNOZ8cQ2lZtS3IoAdgHKUZm3BiOJBSD8rSt8NBXG
         RFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/yVDeHDr6plsnqVZvkYJdff2G0m4diaoqxuNVZA5+c=;
        b=fUQQ+37I69drqtrJ6ln1Zwxo+Urdd5ECCeVVk/DHrRG8TzviIyGT/L8TgprFufTV5Z
         aUkM3ovp6naMWPDpENqEr8WKxLgy0YmR8Iv8r7T0cnxMA8D0j/Qx4c+SCcvgZHYIBV54
         RbhaIsDy/aHpqkbIb9HCYQrzjGifG7hgNvcHt3peuzz6jZhAXyPlWPrDlTCHlOuHyJA5
         4K4C40KZh1Xq01U3nZfm/cP4Eh2ZER+DVvcOu4Pz5vIznHfnNTkProJgwJlCApvg3XVg
         IC0aMZNCNJvYilT9IuLZGwEAbtfnbkbn/74pHfqaKmVryYHDJ44f3qd1+b33RhN5nF1m
         Qc/w==
X-Gm-Message-State: ACrzQf0Ot689lzatOvdL8ONIc111qtShQ7cOhncBQresVXWRW73eQ+yv
        lESR9t9fKImX0Ra7FIcBGVy13Aw39is=
X-Google-Smtp-Source: AMsMyM4Nw7S+Rp9uPLWUSmzcTizdNVIle6xOqPE1jyLiydS2NRGHPzaBh5wmmM4OBfwDXwMCMExC+Q==
X-Received: by 2002:a17:902:a611:b0:186:9ba2:148b with SMTP id u17-20020a170902a61100b001869ba2148bmr7503932plq.164.1666602991392;
        Mon, 24 Oct 2022 02:16:31 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-6.three.co.id. [116.206.28.6])
        by smtp.gmail.com with ESMTPSA id p29-20020a631e5d000000b00461b85e5ad6sm16803504pgm.19.2022.10.24.02.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 02:16:31 -0700 (PDT)
Message-ID: <2edcbc94-e29a-b8ab-e320-ee52788471c8@gmail.com>
Date:   Mon, 24 Oct 2022 16:16:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] unicode: mkutf8data: Add compound malloc function
To:     Li kunyu <kunyu@nfschina.com>
Cc:     krisman@collabora.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Y1ZFLO98zNoAgniW@debian.me>
 <20221024082619.178940-1-kunyu@nfschina.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221024082619.178940-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/24/22 15:26, Li kunyu wrote:
> 
> I send the 1/2 and 2/2 patches separately, and divide the two functions and related modifications in the 2/2 patch into two patches.
> 

No, not that way.

Here's the recipe for submitting patch series (a set of two or more patches),
assuming that you do the work on a branch which is based on mainline (master):

1. First, create directory which to store the patches.
2. Determine the base commit for your branch. Most of the times `git merge-base
   master <your branch>` can be used, but sometimes you need to determine that
   manually by seeing the commit log with `git log`.
3. Generate the patch series (preferably with cover letter) by `git format-patch
   -o <directory> --cover-letter --base=<base commit> <base commit>`. You can
   now write the description about the series in the cover letter (which will
   be 0000-cover-letter.patch).
4. Find the maintainers which will review your series with
   `scripts/get_maintainer.pl /path/to/directory/*.patch`. Ignore your email
   address if it exists.
5. Send the series with `git send-email <--to and/or --cc maintainers>
   /path/to/directory/*.patch`. All patches will be sent as reply to the
   cover letter.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

