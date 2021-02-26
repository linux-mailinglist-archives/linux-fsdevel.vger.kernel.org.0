Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D64326968
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 22:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhBZV04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 16:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBZV0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:26:53 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686DC061574;
        Fri, 26 Feb 2021 13:26:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k66so8944810wmf.1;
        Fri, 26 Feb 2021 13:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WtfPlX43FY10uur2tSwLAOsOecSUXbzQq7gDehGeFQk=;
        b=C1f+rfQEmJIcXY/fWrA0CizUUxPGSklId6ZGan2XVBY51iXtn6IvRUtmyvGfUlFTq2
         ShMYwk0MRyKmdy2+Q/6yzId/XYgv1djCYfhVSADvpaDYXT9Su9skLbeAonU6htnuNoad
         GOAi5sbItXzPpy1+07iY7T2lvVIrgiakORLvRqIXVpGMiAUD7VNnYImh1DSHZPprQaz0
         nCxC+rBtbk27ZX2G113tZww3lOJHeVzOuuzoGW3V1YRYRFkGjbS8CENnaQP27TNDtcR/
         uaSXb/YCefTzCYWYEqPbib+RzWqBxTmNT3JgQWXl1S1fCWgFoJRwMFRNdn1pLtkhvXAs
         DL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WtfPlX43FY10uur2tSwLAOsOecSUXbzQq7gDehGeFQk=;
        b=uJz0+dLnmtQwjB5gsfNBImS0h6skm6ndqQ93WtywRLnDKaGgOlhB2bIthvAuLEiCSK
         2wjsbMQcqOpfU+Jcj8Kb5a/JWqVpqwEO42PAY/xD7A6QnwPuoDRJ7JWxgH4IFTNXrWy5
         5IHGRfrBEaY2QW6a18migi8V4YtrqmDwgWysa0cYxWlLmjDl1EM3Pb2VFFP/QbN7y+Uf
         YdfL6KlaSYlc1kDam8Qii8u8GHSYK4IqCnjMBQIsFr60rgIv9a1vC55TDgbDXnuGH4K6
         gCsK9w27E/aFq6UeF+kl4GBD3RIsTx4uxfh8pjKwAt1VHOXvnZNSC3tFWKN/GxC41k2/
         OBUQ==
X-Gm-Message-State: AOAM533felkZWJ1y1+82/9jXr8P9SHVzomBUpddfKQI3Ls3DTqvmmJL3
        w9fz4QgzDwELvamQ69mYNfLRuE57Snzi3A==
X-Google-Smtp-Source: ABdhPJxTzfmIPyTFwFH1G03DQSgJUsasDwqPaNA8iZQ8pV+jSew9oUhcqYy/ycCyIQUj298aV0CZdw==
X-Received: by 2002:a1c:7c14:: with SMTP id x20mr4440175wmc.17.1614374766631;
        Fri, 26 Feb 2021 13:26:06 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id u4sm6756453wrm.24.2021.02.26.13.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 13:26:05 -0800 (PST)
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
To:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
References: <20210222102456.6692-1-lhenriques@suse.de>
 <20210224142307.7284-1-lhenriques@suse.de>
 <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
 <YDd6EMpvZhHq6ncM@suse.de> <fd5d0d24-35e3-6097-31a9-029475308f15@gmail.com>
 <CAOQ4uxiVxEwvgFhdHGWLpdCk==NcGXgu52r_mXA+ebbLp_XPzQ@mail.gmail.com>
 <abf61760-2099-634a-7519-2138bb75e41b@gmail.com>
 <5da210ecdf9d01552f1f69f928ce68747a68bf08.camel@kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <7469f0a9-216e-599c-e926-bbb5e6142d13@gmail.com>
Date:   Fri, 26 Feb 2021 22:26:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <5da210ecdf9d01552f1f69f928ce68747a68bf08.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jeff,

On 2/26/21 2:59 PM, Jeff Layton wrote:
> Here's a link that should work. I'm probably breaking the rules a bit as
> a subscriber, but hopefully Jon won't mind too much. FWIW, I've found it
> to be worthwhile to subscribe to LWN if you're doing a lot of kernel
> development:
> 
>      https://lwn.net/SubscriberLink/846403/0fd639403e629cab/

Thanks!  (I already received the link privately some minutes before from 
various people.)

It seems that he considers it fair use :)

[[
Where is it appropriate to post a subscriber link?

Almost anywhere. Private mail, messages to project mailing lists, and 
blog entries are all appropriate. As long as people do not use 
subscriber links as a way to defeat our attempts to gain subscribers, we 
are happy to see them shared.
]]
<https://lwn.net/op/FAQ.lwn#site>

Cheers,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
