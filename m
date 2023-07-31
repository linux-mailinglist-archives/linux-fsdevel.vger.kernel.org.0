Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4737690EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 10:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGaI6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 04:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGaI6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:58:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66D910EB
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 01:57:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc0d39b52cso4672775ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690793843; x=1691398643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuwhHyvpV7mCdYVnxq8DGnmHx4Ln2A/2WcUIukP+Dsw=;
        b=CJASY2b8SKkjElJkkRK7GTF8ia29CVtQkp/jRRP7fuq1TTsu/xZQxyfxMF251y8OrJ
         9xwg+XVW9WN723TlRl39dCsdxnX9oGHneWa5DIsSupnC40KS2tzai4UCtMS72o/Bxbit
         BUv7KWyxNkgDxgs4h6Ulf2KAD4sYQVpkaFjU5xyc+MC4IBfKlWQ/VfMpnmjKPedTozhR
         aNMMLW8lS6ta5+p2NP9GBtbXv6mijDqXZXI77EqvIxHc/rG4jppypzTB7w7Y0d38FrYC
         Vs77wdwHUja/Ot9Sc0flHZVqCqniwHCz6Dq+ApAOqH98MqJa89eLpqHjEgkk8Klm8C5l
         IfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793843; x=1691398643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kuwhHyvpV7mCdYVnxq8DGnmHx4Ln2A/2WcUIukP+Dsw=;
        b=U6hCzyLayf/c2eofwdgVDW0337oIKRdGi75IjdYlCVNKSo9clfM7uYEEPHi8a2D20m
         nhcji6msHmW2zLJJ0i7LAj1M6NoL19xV6GJYT66m8W4eEhQv0Z93Eac8cueTrot22lQc
         Rf19ME7aYp1knV6fjAZlkUaMgr913uTy+hpnEil+8afyz4x+4tG59BLzOaqeZSWzN6lq
         JpcU1TBYXGM02JVlTQW0qFkG7tNyKI3vMwKAkixAIMP56KnWeZfavbogdMjiKaz9vdgg
         ycAW3O27nNGoeiTq9jiesudYvLzkr57s77SZ72n9tUhD5/veW1PoF/4S8RdFNj7AC7Gd
         g0hg==
X-Gm-Message-State: ABy/qLZS3hTcb47SX1z8wvuftmoYbxDJV5QSROI89YLMLpZTUcKuUKmY
        LilC089ypezkUqEOQHRhqXsSMBYmdGuiPEYis5Q=
X-Google-Smtp-Source: APBJJlEdQLPjJTn4bkJwJpULG5y++EpNITmSn6o21Tsw3UFkQMB78T2d2LFV7W1iEksfkb7CpOn5RQ==
X-Received: by 2002:a17:902:e551:b0:1bb:a125:f831 with SMTP id n17-20020a170902e55100b001bba125f831mr11138198plf.58.1690793843150;
        Mon, 31 Jul 2023 01:57:23 -0700 (PDT)
Received: from [10.90.34.137] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001bba7aab826sm8019511plb.163.2023.07.31.01.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:57:22 -0700 (PDT)
Message-ID: <5ab4b867-e149-ab92-8a48-b05d14c52550@bytedance.com>
Date:   Mon, 31 Jul 2023 16:57:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [bug report] maple_tree: make mas_validate_gaps() to check
 metadata
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org
References: <757b8578-63ae-49cd-8b25-d0abb91ca996@moroto.mountain>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <757b8578-63ae-49cd-8b25-d0abb91ca996@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/7/31 14:34, Dan Carpenter 写道:
> Hello Peng Zhang,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch d126b5d9410f: "maple_tree: make mas_validate_gaps() to
> check metadata" from Jul 11, 2023, leads to the following Smatch
> complaint:
> 
>      tools/testing/radix-tree/../../../lib/maple_tree.c:6989 mas_validate_gaps()
>      warn: variable dereferenced before check 'gaps' (see line 6983)
> 
> tools/testing/radix-tree/../../../lib/maple_tree.c
>    6982	
>    6983			if (gaps[offset] != max_gap) {
>                              ^^^^^
> Dereferenced.
> 
>    6984				pr_err("gap %p[%u] is not the largest gap %lu\n",
>    6985				       node, offset, max_gap);
>    6986				MT_BUG_ON(mas->tree, 1);
>    6987			}
>    6988	
>    6989			MT_BUG_ON(mas->tree, !gaps);
>                                               ^^^^^
> Checked too late.  This is pointless as well.  Just delete this line.
Since this is a validator, it is only used for testing, so it will not
have any impact on normal functionality. I'm not going to delete this
line, will move it before dereferencing. Thank you for your report.

Thanks,
Peng
> 
>    6990			for (i++ ; i < mt_slot_count(mte); i++) {
>    6991				if (gaps[i] != 0) {
> 
> regards,
> dan carpenter
