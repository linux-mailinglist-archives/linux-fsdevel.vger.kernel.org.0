Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1945A22E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbiHZIWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 04:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbiHZIWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:22:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16862D4F5C;
        Fri, 26 Aug 2022 01:22:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c16-20020a17090aa61000b001fb3286d9f7so7110651pjq.1;
        Fri, 26 Aug 2022 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fbBxa9mjs9/LeuC1VMhijkCQf3EzJL3oe0B8rWAVysQ=;
        b=ljneAyibOjyTC05FF6LRfcf4yjqy4gzmq8rkiD/zwxZA/iHd4zBVAWAhkVRJ7V8pr+
         f04/6gZ4lNPXteJyUUR6WV0ZSB3xd8+yvpSx1lDjW71Nn5u/2aYiCb2B9IJnev/S5AAQ
         ynWLnSRupPEDX05rNFTnb7a/DWOeFxiYRih5x34K3fBDn2gJvb3CmTc7cBnzuKeiIl5x
         SqdKLvHUGkogPH0/ZKnHJUPIQ7Y4GwJkZpvhXYHZxB8aGPBo6bvu3E8/jKyz/PVz78Id
         GJ/1ngJlzLd+KotOBKUrXz+92/SC5Uf3Ix9/VMaAK9raZe8E4PIGkPPkVRAyIDCTpnfX
         Ci2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fbBxa9mjs9/LeuC1VMhijkCQf3EzJL3oe0B8rWAVysQ=;
        b=TgzkcNixo37PXvy6PALP+iTL+ow6HBrrFyKXXIM9b4VrKTox9hn4A/m1Uog+EVSF0f
         E5CrFC6Dy9gUB4kjJQAUdz/VX6vyMgQ36Y0CBlJrIJLBid3cDO2zG9e8NeWIYcvKqvDp
         rl9Xcoe6I9tuL+OVllgGg09+eS7xHdlxvDcjehEXPnx07phnltrCBtucLw2t1UjDWL51
         BzjxkhNNa/8rv1UYkZcfV6Te4E0JkzXIR0PUJmfDUiePojuBrPou8hMiYF45lPSulAuF
         ko0P7HE1AdYB37qH3GWKQ+67AP/Id18ixt2n7iD78r0pR8tKLmXQtr5z1GWKhN4lqtNQ
         N50A==
X-Gm-Message-State: ACgBeo2mJFn2nA6clQpjcHv+nJ8to1loZB3fNYSjmm3/B9f49ZuaOdFa
        HteMgxy3oqVwu8STF9aj9lI=
X-Google-Smtp-Source: AA6agR6iJyn0D0eTSc4C3/t2P0r0WATvM3cuFa/W+c4RXrwLlHoQREeqpitVd1G27l3pppCEmhjjTg==
X-Received: by 2002:a17:90a:8415:b0:1fa:ae71:560d with SMTP id j21-20020a17090a841500b001faae71560dmr3230337pjn.191.1661502134566;
        Fri, 26 Aug 2022 01:22:14 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-73.three.co.id. [223.255.225.73])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b0016dbb878f8asm949476plf.82.2022.08.26.01.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:22:14 -0700 (PDT)
Message-ID: <e819de52-9b35-a698-0b45-80a9b063cf0c@gmail.com>
Date:   Fri, 26 Aug 2022 15:22:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 4/4] mm: add documentation of the new ioctl on pagemap
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
 <20220826064535.1941190-5-usama.anjum@collabora.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220826064535.1941190-5-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/26/22 13:45, Muhammad Usama Anjum wrote:
>  The soft-dirty is a bit on a PTE which helps to track which pages a task
> -writes to. In order to do this tracking one should
> +writes to.
> +
> +Using Proc FS
> +-------------
> +
> +In order to do this tracking one should
>  
>    1. Clear soft-dirty bits from the task's PTEs.
>  
> @@ -20,6 +25,41 @@ writes to. In order to do this tracking one should
>       64-bit qword is the soft-dirty one. If set, the respective PTE was
>       written to since step 1.
>  
> +Using IOCTL
> +-----------
> +
> +The IOCTL on the ``/proc/PID/pagemap`` can be can be used to find the dirty pages
> +atomically. The following commands are supported::
> +
> +	MEMWATCH_SD_GET
> +		Get the page offsets which are soft dirty.
> +
> +	MEMWATCH_SD_CLEAR
> +		Clear the pages which are soft dirty.
> +
> +	MEMWATCH_SD_GET_AND_CLEAR
> +		Get and clear the pages which are soft dirty.
> +

Definition lists are enough, no need to use code block.

> +The struct :c:type:`pagemap_sd_args` is used as the argument. In this struct:
> +
> +  1. The range is specified through start and len. The len argument need not be
> +     the multiple of the page size, but since the information is returned for the
> +     whole pages, len is effectively rounded up to the next multiple of the page
> +     size.
> +
> +  2. The output buffer and size is specified in vec and vec_len. The offsets of
> +     the dirty pages from start are returned in vec. The ioctl returns when the
> +     whole range has been searched or vec is completely filled. The whole range
> +     isn't cleared if vec fills up completely.
> +
> +  3. The flags can be specified in flags field. Currently only one flag,
> +     PAGEMAP_SD_NO_REUSED_REGIONS is supported which can be specified to ignore
> +     the VMA dirty flags for better performance. This flag shows only those pages
> +     dirty which have been written to by the user. All new allocations aren't returned
> +     to be dirty.
> +
> +Explanation
> +-----------
>  
>  Internally, to do this tracking, the writable bit is cleared from PTEs
>  when the soft-dirty bit is cleared. So, after this, when the task tries to

I'd like to see identifier keywords (such as filename, function and variable name)
are consistently formatted either with inline code (``identifier``) or no
formatting (all or nothing).

-- 
An old man doll... just what I always wanted! - Clara
