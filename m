Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D9681DDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 23:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjA3WPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 17:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjA3WPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:15:46 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F128D21
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 14:15:44 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e2so2305472iot.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpRPgXbzyPldfryxFZ4ysKITNhIghKFBROqanj/f/Sk=;
        b=Rimt7EyQJHAERbMyCMmnlRKfnzUd6ivIuLZcpvfDAKKf1XtrAzyKZgGyH4SsI1VCFl
         y71zP0cpkkZADufU3KMqa/2ZG7kemElm2dlXFsHsQwBCYQdp9/LMEKIABfWkxUUL24fs
         nOyHaogacUTLL2qE3KxiNjWzUgstTBfVOGGxj1ot6sSbvHczG4x2gEc06S02JBVFQqw/
         Zk3AjJ6WbeoqERAzuBWIbsxeQKQs2RwDjQsb6pWpRLl6lHoMSOdPV/+Xz+yX9n9BFKuA
         +q6AWSjEehghz28No7wOXPpAhkJQIqEVkeiyYYwlAzeLcE2jfwoVSl+BSXAQkNUkoEnX
         jnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpRPgXbzyPldfryxFZ4ysKITNhIghKFBROqanj/f/Sk=;
        b=aaBHK4AOAL9D943wSBBhR0eQ+kgs5q8pHvetQz7jdDgocjcic9e8TGbwa2mqrt1KWz
         Jm+WVcHt+fi55/H8kHwhkLzBeXPEs/qFRN/UyPMbcwQZ1KfaZOBI18w9BGtuRUGMnhcL
         KU6CvGmcn2eIT09R4+/KBLXB4Awd1cgbfWRw5EgqLgcbypAr76mwaMIm9Ki6TkRchpo8
         toryX1CDixwg7Pp5Lymj78JJ+qPikaDf3IOQGbRZFhARa6h75LmtKUlj73HyZuqHKUjd
         WevvbgQIvfm+h3IfSLINjFQyzsVtpUqAxrlxAjXYJ5bvybULzBDwkEV0ppA+orIPePJM
         yvzA==
X-Gm-Message-State: AO0yUKUK0QJlfDRK93XCCACgpBofJmxUitshz4//V6xk7VfHYD8RIHnM
        ixGNfgAS6lx2sKaaP/GrmHx11g==
X-Google-Smtp-Source: AK7set/tqTtKUOkSBhdUWbUnjfzdSsFonAnOVZ3meWLdw53puoZxOKpLq8oYEyvusW9O1BKkg3hUeQ==
X-Received: by 2002:a5d:9d11:0:b0:718:2fa2:6648 with SMTP id j17-20020a5d9d11000000b007182fa26648mr1422084ioj.2.1675116944142;
        Mon, 30 Jan 2023 14:15:44 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q22-20020a5d8516000000b0071db3975335sm1082375ion.12.2023.01.30.14.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 14:15:43 -0800 (PST)
Message-ID: <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
Date:   Mon, 30 Jan 2023 15:15:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
 <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <3520518.1675116740@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3520518.1675116740@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/30/23 3:12 PM, David Howells wrote:
> John Hubbard <jhubbard@nvidia.com> wrote:
> 
>> This is something that we say when adding pin_user_pages_fast(),
>> yes. I doubt that I can quickly find the email thread, but we
>> measured it and weren't immediately able to come up with a way
>> to make it faster.
> 
> percpu counters maybe - add them up at the point of viewing?

They are percpu, see my last email. But for every 108 changes (on
my system), they will do two atomic_long_adds(). So not very
useful for anything but low frequency modifications.

-- 
Jens Axboe


