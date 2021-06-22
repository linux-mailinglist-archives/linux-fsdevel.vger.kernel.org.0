Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8433B0F95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 23:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFVVqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVVqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:46:32 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CBCC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 14:44:16 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i189so899662ioa.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I1nEL+YNqhH7g1sQ7Yvch5EFl+YJNf83pqmjTmgPvzk=;
        b=XOyD7rlfBCBP7hLU8eA31SI9L53d3KL5XForcVJszbf3pbdwkuvMPnFp2xJSSK126X
         90Ky/XMGk1QO/F5gfDxQyX8mLun/xEM/RjQYFVoEmsRHMiSv2pFcJrCpSDuAfCzP+wxm
         rt/wlwAWMGkyYDb57WZ/UDCwnRuP9hCgQsL/IPATBPraKhkI9CazRFN0pDQkJ+npO12c
         VgRcfqsmd4X7WfArSy1D0n53LGN7dyXWN9FPsE894PbvtF7n1OwlAGi2NKOBP8DxxujF
         EVgeLmLizmWF42bdbu+C6GR3UPou4HhXuiTcSzb++dXDpdHu5lPnSwu5sWxee2rRzbVj
         VRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I1nEL+YNqhH7g1sQ7Yvch5EFl+YJNf83pqmjTmgPvzk=;
        b=ZY3SCemt1jQFkc1nsYN70wpc069P8LSWFMktxVkZ39x205lXcXVr3RPvLIN+eynGfk
         iPJ5fCupevtWYVK9rIekgSDxJtf+CPi8YWZGtLEENRFqZFoSpP781gg0mFTXVNxtE4Uj
         gAahoPlfT/y0NUUAayCRbr19S1vcxp7BBmpZJTzQ6MZByReR1N3sUQxb1UvmQ7EZQO0v
         JpIJERT6wtcJJDk72u8Ujy6fk0bJh5eo21uFLwgquM3/1pEbeFa7Xs9wRYwAjX6z8+Cd
         s16XdE0EN0Lf8Rud4WmDeWOe7eacNt83/OMsTSTrn9CCnFbaxqRu+Q1a6TuP2VsW3vXe
         62Ig==
X-Gm-Message-State: AOAM530Rqi7OiB9E2ZcNWKTF122K9NWerGScBXn6PllK61tzutxtSfSf
        rBHjRYSVbVb7rEzjslcEktlrIA==
X-Google-Smtp-Source: ABdhPJwkP6filk6npKHvxkKwUTd00FmoiI1ssbk3PGfRqap2miTvwz4I2lwR7XCETWn4ZcksfEyz3w==
X-Received: by 2002:a05:6638:12c1:: with SMTP id v1mr5708992jas.97.1624398255238;
        Tue, 22 Jun 2021 14:44:15 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id x11sm8669383ilg.59.2021.06.22.14.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:44:14 -0700 (PDT)
Subject: Re: [PATCH] vfs: explicitly include fileattr.h dependency
To:     Keith Busch <kbusch@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210622194300.2617430-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d2b8f73-5121-2cbf-387b-28b020828627@kernel.dk>
Date:   Tue, 22 Jun 2021 15:44:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210622194300.2617430-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/21 1:43 PM, Keith Busch wrote:
> linux/fileattr.h has an implicit requirement that linux/fs.h be included
> first. Make that dependency explicit.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

