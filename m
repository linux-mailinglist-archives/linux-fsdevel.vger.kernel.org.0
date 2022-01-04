Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD50484366
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiADOb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 09:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229808AbiADObZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641306685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSbFiIkCa7pMhGDthWmAfMNT0dx4lGgrz3BAfDoZH5c=;
        b=JnEIsbCTr22Sa5c6cNYIhBUQ62oGMMX6jMl/cLMplqh0yvDk/5RtQx09Hk7ZdQB9K3edaE
        Z0GkrYVN33Pr+IGratkg4TbMngLrDjwuXFaPVkXhAP4dAre857JA4EwkQVDTfvP8Kp8Jy4
        BvrGyB5bxdK+upTw5enAjyIiIilNA/Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-N5yEjGjWOL-u4Uq2aksM7Q-1; Tue, 04 Jan 2022 09:31:23 -0500
X-MC-Unique: N5yEjGjWOL-u4Uq2aksM7Q-1
Received: by mail-wm1-f69.google.com with SMTP id d4-20020a05600c34c400b00345d5d47d54so364953wmq.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jan 2022 06:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=PSbFiIkCa7pMhGDthWmAfMNT0dx4lGgrz3BAfDoZH5c=;
        b=tXGqr4O4e1hsca++oFdGBpqiY62gQvb9uLpTuCdGxTGjf59YvMVqba2iC+85+SlDlJ
         jmLXpfi+S2GjB8R17g0GI+OxF+00UEJX1uEiRzw0YA3YXdr1tzymET39BHf5Unm6aTd1
         Fvtq+hGrVF1zBotR0PCCmgQ8x6sOl6lWx6uQlcWWkmxUk6sqmM4mmzoXDF8R0Wcf751B
         PDV5hbgXv4G7v5H7kDMd/SsGDTC4BNYAlY2bcfLRhSwZXNsDmc8Z/k2MUCPQwBqgORqR
         QiLFQ2/JgjBJn7HKAOaioRS/BNxZTnD1Yr7jawiLLMQNs5g99AyK1oimtUpdR720lubG
         1Ttw==
X-Gm-Message-State: AOAM533hTZMjvINQjWJr0arbew+BxpphwvJzQHf8EXrG+nhqZCU+U9dq
        vw//9NTb99FPPGCbQBeFYHdYiQn3ToaWpM5YqE16oVnYsg6O9+hVJLf5NuT7VR1TjTpUlnooiiN
        OCNAeKfIiQOviO19fw2wiIWElnw==
X-Received: by 2002:a1c:2b42:: with SMTP id r63mr35437023wmr.80.1641306682491;
        Tue, 04 Jan 2022 06:31:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoD394cIAvWOPJzX1c3qieoiNBQSBerEgc05mgXT5JV6oRQFZPfL/TP84Ze3JTIZi6PiROVQ==
X-Received: by 2002:a1c:2b42:: with SMTP id r63mr35437000wmr.80.1641306682335;
        Tue, 04 Jan 2022 06:31:22 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62bd.dip0.t-ipconnect.de. [91.12.98.189])
        by smtp.gmail.com with ESMTPSA id a2sm43078904wri.17.2022.01.04.06.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 06:31:21 -0800 (PST)
Message-ID: <10ec73d4-6658-4f60-abe1-84ece53ca373@redhat.com>
Date:   Tue, 4 Jan 2022 15:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: remove Xen tmem leftovers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211224062246.1258487-1-hch@lst.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.12.21 07:22, Christoph Hellwig wrote:
> Hi all,
> 
> since the remove of the Xen tmem driver in 2019, the cleancache hooks are
> entirely unused, as are large parts of frontswap.  This series against
> linux-next (with the folio changes included) removes cleancaches, and cuts
> down frontswap to the bits actually used by zswap.
> 

Just out of curiosity, why was tmem removed from Linux (or even Xen?).
Do you have any information?

Happy to see this cleanup.

-- 
Thanks,

David / dhildenb

