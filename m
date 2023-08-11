Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB97779A09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjHKV6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 17:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjHKV6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:58:40 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49CA2728;
        Fri, 11 Aug 2023 14:58:39 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1bba48b0bd2so17948025ad.3;
        Fri, 11 Aug 2023 14:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791119; x=1692395919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6HRkLM0SkoQZVLyx2qLkyNekZfBcDgxJqKY8rpzcgg=;
        b=QIhRHALdShyYZd7e4W/14wDXMoGCD3wJPtwb4IXfBPe1GtBC4sCTcgG7xh8+3A1NMf
         iIU7whi+uKbp/z0rSk7aJMljwGW3gS5qXT1wQ0Mgp+2faJ7kGXIes4GY/uDQ1Qe0wHuS
         zvtUM/W2BfE8JQzEth8xzV/2OcNuJFxpIhaxLgYPE69VaWRiUfcQ6Cb2yo+aWTQ9fc28
         BsUozRmK4Fn9Hal8vuJ7B9q5DqvYhCOJ/Mw4WPhTVXcBHjY9ZmQZGIvanM4ULwvTqHFx
         2fz2kw9i1svyWD8im7WVE0VtfSnwa7bBOsrPogxjWx8RcaI5zjyeKSCH+B88KR14JGp/
         ZT9g==
X-Gm-Message-State: AOJu0YwSNDlMi+3qNi78syk6fAuscQ0MJDFVvXMOZOECa4Hf1NkrK9r5
        z0Ah5xbQ25hhZNsCFj+JSUQ=
X-Google-Smtp-Source: AGHT+IGwHdIE3Y5YV9a/4Hh9MIcPpfsNQVJE3AlI+jbV6QV1hWBOlM8CNMnC6D2YYbg22mOHJHHRnA==
X-Received: by 2002:a17:902:b907:b0:1b9:de3e:7a59 with SMTP id bf7-20020a170902b90700b001b9de3e7a59mr2960940plb.10.1691791119094;
        Fri, 11 Aug 2023 14:58:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001bda42a216bsm4135429plk.100.2023.08.11.14.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:58:38 -0700 (PDT)
Message-ID: <355bb623-9cd9-fe33-106e-1f091c09fb32@acm.org>
Date:   Fri, 11 Aug 2023 14:58:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 02/11] Add infrastructure for copy offload
 in block and request layer.
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-doc@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
 <20230811105300.15889-3-nj.shetty@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/23 03:52, Nitesh Shetty wrote:
> We expect caller to take a plug and send bio with source information,
> followed by bio with destination information.
> Once the src bio arrives we form a request and wait for destination
> bio. Upon arrival of destination we merge these two bio's and send
> corresponding request down to device driver.

Is the above description up-to-date? In the cover letter there is a 
different description of how copy offloading works.

Thanks,

Bart.
