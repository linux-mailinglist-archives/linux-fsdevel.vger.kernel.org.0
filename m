Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3321695414
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 23:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBMWvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 17:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBMWvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:51:13 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA320D0F;
        Mon, 13 Feb 2023 14:51:11 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-169ba826189so17005236fac.2;
        Mon, 13 Feb 2023 14:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FsatTFWXRdJIuW3SF/iX7w9zhDBWHPHpOd+0025ImH0=;
        b=bTkJ3BZ14tUNyIxBp59LfJAbornDrAcIoLngy8XTVz2lxRJ/OZ0mCr6ZkhB7wX1sHf
         Wy6gfYGezApM4czU4lyKx+QqWdLAF+L4ciAhTuJLJJw/Y+L2jYNRrFBGNyCv6pnSYi0g
         dTaf3cy9U2usSikKhUh1RG9ROU3AxZIbHqgnjI1euLBI/nVTE+AC3rSNSrNcBnhN/ZE6
         oIhuRyhzKABlvCz+vk3JmRk76SGqE78lbIncpQfsKCulgCdgubRcZQ8GnFARJ85LLqqv
         t6uRoDYHcklrlF2jivrroHyZbVIOrOaHmCE6yyigGt+hjWx41XPz7voTkr8bWfEzwh+c
         Ht+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsatTFWXRdJIuW3SF/iX7w9zhDBWHPHpOd+0025ImH0=;
        b=LcXhqWvROd15s07tYgB4zvNoCqJBPBg2c178cteKVWzaY3nzf7iSNQgZw1DPvxicQF
         v38fG6zifQr/KmkpHXdVNBKCiAx4hZX5TFLNnwWHorrZz9Hfmy9H2PxDPvotbGCBlfdH
         cAEhcXetaOrDvGWuoMiKlYO+tf37BdsQw+yU3P/TExWPdrssqw1ZdbIGyfYwLmASqLpy
         /orizgUsAtY1/kTnwLC+F1CmSbPIk2fKA9B2Qn6IWeCHz+fnVOmSBZC0aPoYbLt9/rZl
         eWSWEM6bVUQMYg4JDYkiVNUGr+QNiw8SBvaV1ULmCa9gz0fGqLUPWdfvG3EzWE5P9lk1
         F2wg==
X-Gm-Message-State: AO0yUKXYs4XX/937n0b0aGcPnC8wfSn/ygUzEKvCnlSYCGfa9pszmV7x
        guEjV8ESCJreUVt693mJWJY=
X-Google-Smtp-Source: AK7set81Q2BgXeRF1I+Dgu8PwM/ReqG2xiHmjF2/f1EZbTQB2ESWESvN+lBGb/IiCjoVVxqMqF2mZA==
X-Received: by 2002:a05:6870:ac20:b0:16e:1c26:9baa with SMTP id kw32-20020a056870ac2000b0016e1c269baamr1832309oab.35.1676328670290;
        Mon, 13 Feb 2023 14:51:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1-20020a056870a54100b0015f83e16a10sm5231370oal.44.2023.02.13.14.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 14:51:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <55e2bef1-e8b5-3475-21df-487bddb47f5b@roeck-us.net>
Date:   Mon, 13 Feb 2023 14:51:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v13 03/12] splice: Do splice read from a buffered file
 without using ITER_PIPE
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230213180632.GA368628@roeck-us.net>
 <20230209102954.528942-1-dhowells@redhat.com>
 <20230209102954.528942-4-dhowells@redhat.com>
 <2416073.1676328192@warthog.procyon.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2416073.1676328192@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/13/23 14:43, David Howells wrote:
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> [    4.660118] PC is at 0x0
>> [    4.660248] LR is at filemap_read_folio+0x17/0x4e
> 
> Do you know what the filesystem is that's being read from?
> 
> I think the problem is that there are a few filesystems/drivers that call
> generic_file_splice_read() but don't have a ->read_folio().  Now most of these
> can be made to call direct_splice_read() instead, leaving just coda, overlayfs
> and shmem.
> 
> Coda and overlayfs can be made to pass the request down a layer.  I'm about to
> look into shmem.
> 

Both are initrd.

Guenter

