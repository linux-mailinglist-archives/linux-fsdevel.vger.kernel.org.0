Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146106A6547
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 03:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCACGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 21:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCACGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:06:38 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C4F36461;
        Tue, 28 Feb 2023 18:06:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p20so11247553plw.13;
        Tue, 28 Feb 2023 18:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677636395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDXpMPJh/Z2J5rlZzm59CNNEz409rvNJPJl6e9WZfsc=;
        b=D1T7io8IYGIKl9EtEsH4K/ys8aAtGSaur2lCczYQmtxw6u7Wdj44pDKT2CzC1cCsGr
         nC4Yu+2Sgpf+p/adsWCQkUVfFQigBGCebiOuf6biTcpsLjGszp3w53GgcgFkJFIM4flh
         iOosdbuD7QNLY7earcPq0jXeCn5S/srp6lWFPVJg5XjebltcmSPLmw3xjUZRZsfLtxAH
         zXkWia+8YepDoJZ2swL1beQwfQ6vHriRRqd5UmOdpeO7REZo1Nq+MXMI34VfLmviMIYA
         vznCS0jzFGy9kQpcfbt7plJw+LLGeFj2kQ4dWA5VjKi7hF6J4TlVszFdsjiMf+CVyVix
         3RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677636395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDXpMPJh/Z2J5rlZzm59CNNEz409rvNJPJl6e9WZfsc=;
        b=cafhmx1zt9CjH4w8Xu+FGJxHEaki5gAkJjXSxFNV3U2t0tgrOZKqDQA4tp4bad5fcd
         WtvgdQQbbx9G1proGelB/pnZZ9QlueiSqrz74CjUWNyXFzH/VmB4huX9nkwFo8vwlFt1
         gxZg60NJNQ6p7kkA+OQyyTN+vPm85unlgdj/tXq6ZNpZsby8VthdQI4eBsU8TIXgvzfc
         +SK1KcyaLDZFfd915NAdN3qzs9/R/oa4m8+nQkjiNpCD9ajt9tz9nUsr0AWcwkGwtdPM
         WK1RRTeNmvektFIii85fdNK02Y7+dUkLlvIz11jtE4EnHtg5QgY19jndkQ/8b6iJOr8v
         gopQ==
X-Gm-Message-State: AO0yUKVAvIGQxkXtBk/tmpskryMjKEyIIVciNlVfehArMq2X2G3TTc+e
        5uSwnTcFHqZOL6AnSUN5/CU=
X-Google-Smtp-Source: AK7set+7b3oV8KgUWH+qKZqKH02Oit6WbEUHfZYV2ViPss2MBCNZvZz20b49HrOheG6FUGqlFNRaQA==
X-Received: by 2002:a17:90b:4a85:b0:234:9715:fe9a with SMTP id lp5-20020a17090b4a8500b002349715fe9amr5166286pjb.43.1677636395478;
        Tue, 28 Feb 2023 18:06:35 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-27.three.co.id. [180.214.232.27])
        by smtp.gmail.com with ESMTPSA id gn21-20020a17090ac79500b0022c0a05229fsm6772363pjb.41.2023.02.28.18.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 18:06:34 -0800 (PST)
Message-ID: <ac60affc-ac5c-2ee7-c1a6-9be39e7b43c9@gmail.com>
Date:   Wed, 1 Mar 2023 09:06:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v1 2/2] Documentation: btrfs: Document the influence
 of wq_cpu_set to thread_pool option
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
 <20230226162639.20559-3-ammarfaizi2@gnuweeb.org> <Y/wSXlp3vTEA6eo3@debian.me>
 <Y/x/oD+byOu092fF@biznet-home.integral.gnuweeb.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y/x/oD+byOu092fF@biznet-home.integral.gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/23 17:02, Ammar Faizi wrote:
> On Mon, Feb 27, 2023 at 09:15:58AM +0700, Bagas Sanjaya wrote:
>> Why will the behavior be introduced in such future version (6.5)?
> 
> It's not like it has been staged for the next merge window. It's still
> in an RFC state. The changes are not trivial and need further review.
> 
> I don't know if it can hit the next merge window. As such, I picked a
> long distance for this proposal. If it ends up going upstream sooner, we
> can change this document.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

