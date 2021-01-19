Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77A42FBE47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 18:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbhASRth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 12:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389453AbhASPBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:01:45 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B899C061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 07:01:05 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e17so4716649qto.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 07:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vn5Y0TrG3Ui6LBbbxvYnxl2nn5t3OepGIypDVq8V4YM=;
        b=pVUDC5WiZM6Lp8yH89xT1k/YpP/3TyrwAZ15/iuWX8RBRpjlf+jFHDFgLTMtLU49SW
         kEgj71/8gTx8uUrcUqv22pjWXvmAkk4+JJZsk/LNpOAvMGyURf5ntpntikem4UAdkJmG
         qDOyNrfgyoTi6CRDwvwFDajSm8kWtjdnUlLRIqDQEpqlUC7OINwQ6kVz/aldXxJjQoP5
         MYUKt/PXULwtUE7UtG7pCk3dYIcLp50Gn7OBfoEA7a8X+HS5qin3yAo+UQVY1bXrt2Uf
         4/dAwPqazua4LeUKIitWS+j1v7XvAyJz/3HiR12eJJa0QTCjoU3WExHuF4czyxSiqnRH
         2paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vn5Y0TrG3Ui6LBbbxvYnxl2nn5t3OepGIypDVq8V4YM=;
        b=sc4NVOmDXwqlGoQdq5XczOUWzh/QLg4ZVAijKBZGtZs6cWqy4PrWe7QBR+sW9rOMOX
         90Fi8Y0mFKh7RS4rXsYlR0A6ml83xwU2SkcnAC/fXXKoT0REyGlMXotA6FwX6E+WQxE+
         8Yydy9KW5Wa2OtK+MIOM88VL9Kordd2tMH70VHJSnPPWzKNDDh/t4b2pHwzv9tZXi/TO
         4xN9FyrqMBhtfOlpnxqX0Y5Kdus8J3bUE5T1/jHBblr2HbzNK7+l0eEWNQ42sd8v3hFb
         gekWNi4y3nPWhs/mJmZxwC3/PpOBHXtJFn9SJ3juuKs80A3tAto6mgOzWxgHI4je6ZyM
         UEBA==
X-Gm-Message-State: AOAM532fh4KC/h99UVcKNjBDHNtXmb+pxKNDwqpmvDVj/RDPCjnTpGWF
        a5CcBimLDMZ1hYtnp1iI6g7EEA==
X-Google-Smtp-Source: ABdhPJw9hzTjA0HJ6VQUPwDH9drSNqii0WFZZyVd4uYqJRq1euvOSRi+J16/swjVIXriRDU/RjWmOQ==
X-Received: by 2002:ac8:6f07:: with SMTP id g7mr4493450qtv.308.1611068464463;
        Tue, 19 Jan 2021 07:01:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::117a? ([2620:10d:c091:480::1:150f])
        by smtp.gmail.com with ESMTPSA id w91sm6339412qte.83.2021.01.19.07.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 07:01:03 -0800 (PST)
Subject: Re: [RFC PATCH 00/37] block: introduce bio_init_fields()
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        dsterba@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        rpeterso@redhat.com, agruenba@redhat.com, darrick.wong@oracle.com,
        shaggy@kernel.org, damien.lemoal@wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, tj@kernel.org, osandov@fb.com, bvanassche@acm.org,
        gustavo@embeddedor.com, asml.silence@gmail.com,
        jefflexu@linux.alibaba.com
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6eab7373-3c7f-fccf-8a6f-b02519258d23@toxicpanda.com>
Date:   Tue, 19 Jan 2021 10:00:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/19/21 12:05 AM, Chaitanya Kulkarni wrote:
> Hi,
> 
> This is a *compile only RFC* which adds a generic helper to initialize
> the various fields of the bio that is repeated all the places in
> file-systems, block layer, and drivers.
> 
> The new helper allows callers to initialize various members such as
> bdev, sector, private, end io callback, io priority, and write hints.
> 
> The objective of this RFC is to only start a discussion, this it not
> completely tested at all.

It would help to know what you're trying to accomplish here.  I'd echo Mike's 
comments about how it makes it annoying to update things in the future.  In 
addition, there's so many fields that I'm not going to remember what each one is 
without having to look it up, which makes it annoying to use and to review.  If 
it's simply to make sure fields are initialized then you could add debug sanity 
checks to submit_bio().  If it's to clean up duplication, well I'd argue that 
the duplication is much clearer than positional arguments in a giant function 
call.  If you are wanting to change a particular part of the bio to be 
initialized properly, like Dennis's work to make sure the bi_blkg was 
initialized at bi_bdev set time, then a more targeted patch series with a 
specific intent will be more useful and more successful.  Thanks,

Josef
