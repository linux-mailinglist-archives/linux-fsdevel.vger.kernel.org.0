Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A0472E799
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbjFMPsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbjFMPsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:48:22 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC619A
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 08:48:21 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33bcc8f0d21so3739215ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686671300; x=1689263300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSrctI8rg8I7twHK6Nil4YKzI1pYE/l9OdmquxynZq4=;
        b=1IxMrX8EdCYYXT8z4R8g5xqadrCypUsYWgg41u3N/dlybwXZJu7zAUDrBeN4GL449o
         +8RfTGMi6r5QikoO/a1XC8JEDxdc4ILd/eIp3FOAFEcyMBjAKLVIAkG6aaCp1B/0GAh5
         h4DCxWuoSl72Xf9hJ3tYHUmZxuCN11luuhQkBuupPRWrUiybaDDE83+lfAmhfszwQVZC
         tYqtRCdXcBg8+M/hPoMUyTQcoGw2bipRmg3f7WRV2QYo7ekDRaCHO+HWJdf5M1zAQKRy
         wsaurWEurnvuCie8fqVMgUxsHgVftMVS9XSbnCorlXIG/gNuD/libC/nNCKEBg/dxtq/
         JoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686671300; x=1689263300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSrctI8rg8I7twHK6Nil4YKzI1pYE/l9OdmquxynZq4=;
        b=TFOa8HB25/NLn3M9ZgydIueZMsiCrfwZga6h6t39pDlUQq3jctXjDh8aFQRUVWnPnL
         Kp0rR1XmjhwjgqX0tCKRJ/BcPrC9TFKOkJbnbMwMUZ6hJtKuNrisXV9Sd1xMk9EVJjDZ
         +vDyJaTS3L7EjyWsih598Q56o8bnBThlQeGWSrNFUgfoYkb887T0jrNtYdIQmLjTsVLy
         1U/V9sBeJM5zQi4U7dS6FGD9X7Z7daMPifwEZB7uhNUZcUqBLKNlV6wJd75o3/Ed/6FZ
         A/CPQr7JdeORDfM5bWoagd1GEDOBHCXRZjw9hSG33XPoOh3gG175OPTd67/21RnfnaOb
         g0cA==
X-Gm-Message-State: AC+VfDz5X84kppRQQ648caqt43htxEdASPRmL1T0ooZgOh4UuGl8vD4q
        y7JefJke7YUjYoWQWLscnow9bw==
X-Google-Smtp-Source: ACHHUZ5StGBwUyOjFSA4oiFTpuXR+sgEyx4jlxweuyIJg1gEkVnyybc/DjDXsTvbpm397ZVPBanKkQ==
X-Received: by 2002:a05:6602:1789:b0:777:b456:abbe with SMTP id y9-20020a056602178900b00777b456abbemr7180557iox.0.1686671300719;
        Tue, 13 Jun 2023 08:48:20 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h24-20020a02cd38000000b004145ebbf193sm3468444jaq.51.2023.06.13.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 08:48:20 -0700 (PDT)
Message-ID: <491da795-e9e0-1d84-558b-df09063228cb@kernel.dk>
Date:   Tue, 13 Jun 2023 09:48:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] block: Fix dio_bio_alloc() to set BIO_PAGE_PINNED
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org
References: <545463.1686601473@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <545463.1686601473@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/23 2:24 PM, David Howells wrote:
>     
> Fix dio_bio_alloc() to set BIO_PAGE_PINNED, not BIO_PAGE_REFFED, so that
> the bio code unpins the pinned pages rather than putting a ref on them.
> 
> The issue was causing:
> 
>         WARNING: CPU: 6 PID: 2220 at mm/gup.c:76 try_get_folio
> 
> This can be caused by creating a file on a loopback UDF filesystem, opening
> it O_DIRECT and making two writes to it from the same source buffer.

What is this against?

-- 
Jens Axboe


