Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684AE207722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404563AbgFXPQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404511AbgFXPQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:16:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A8BC061795
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:16:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y18so1179588plr.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TVX/MV1cRkugdklQX2owAo6W7k+5NFqvXnOlDA4kvRY=;
        b=yGzNNUiU0zB4ia/e/BRLyub6jOMkcwxNBtVbxa2YAtqv9bXPxUetSHNyXmsHenrYHt
         cjkFgPmkRZp/X2yNr2u9mju+xed5eYUhQk4Kpx+jH0CGmR61y8a9ouWVJug5DZ7A+Qlv
         DJD/L8PQC/W42O0m9N96kcj4qg7p6UcD14f7MiBpKvVmmzYFuDReGBcXd8RNy518wKPV
         wNXnls0RdYt9lZQO/MEmeg8HOax7edYnC7etow2AGG1sgeWTIFjKemddtFXoz8u+vQRr
         Ma2eSMXnN6YljqXWa7Q+47mtbUe6tyaeYSy4XLkUoOPj471841XsJUywEBTvACE5vQ1m
         8c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TVX/MV1cRkugdklQX2owAo6W7k+5NFqvXnOlDA4kvRY=;
        b=kniptmQ3SVVoBkaU2iWQfvJ1P1ki94591VTGjUU0QySKxRs9OYMnBjfkbfhfB2ERUi
         4+OUyUk1tK28UoFk76u2IKS86+IJxLHhRkDSVaVNtJqbzHsef3/7SVF+I3CTd+zk5G97
         5aV2h36dAqcLJEQP7heByeBjOpk2aNmu1ZaS4GaMEZNEEj31cajpKNgKpjrgxhMdcD8k
         /pMMv/Glggem3hdA8IPeEQqIzmSQRUiVwzqbI3bn+wtEThdrzsE851tCfhEeXdx02oMb
         R4CCEsWbFRnFLZwchIyngOFsIqcq8/04wdH5SAipK3azi3yM7dgvtv8+JtdKq4NqkEe6
         z1Bw==
X-Gm-Message-State: AOAM530PnzMe40Zz7NswvaqVWjQjgaDprVGX4VDJ0dgZqOwrgjTxHJRj
        MxJKErx53m0FaQhLwf6Zkfg+3w==
X-Google-Smtp-Source: ABdhPJycIgQsbIB02Wur2mBRtNGc1PyURqcruMtrpODXrvsCtMYEKd4KNUN/T13UfMqBLSg/gfKfEQ==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr17314674plo.276.1593011798114;
        Wed, 24 Jun 2020 08:16:38 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n15sm3158702pgs.25.2020.06.24.08.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:16:37 -0700 (PDT)
Subject: Re: move block bits out of fs.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200620071644.463185-1-hch@lst.de>
 <c2fba635-b2ce-a2b5-772b-4bfcb9b43453@kernel.dk>
 <20200624151211.GA17344@lst.de>
 <216bcea4-a38d-8a64-bc0f-be61b2f26e79@kernel.dk>
 <20200624151454.GB17344@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <989cafe3-ddfd-8b0c-2bad-412eb3a20ee0@kernel.dk>
Date:   Wed, 24 Jun 2020 09:16:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624151454.GB17344@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/24/20 9:14 AM, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 09:14:11AM -0600, Jens Axboe wrote:
>> On 6/24/20 9:12 AM, Christoph Hellwig wrote:
>>> On Wed, Jun 24, 2020 at 09:09:42AM -0600, Jens Axboe wrote:
>>>> Applied for 5.9 - I kept this in a separate topic branch, fwiw. There's the
>>>> potential for some annoying issues with this, so would rather have it in
>>>> a branch we can modify easily, if we need to.
>>>
>>> Hmm, I have a bunch of things building on top of this pending, so that
>>> branch split will be interesting to handle.
>>
>> We can stuff it in for-5.9/block, but then I'd rather just rebase that
>> on 5.8-rc2 now since it's still early days. If we don't, we already
>> have conflicts...
> 
> I'll happily rebase.  rc1 also has funny ext4 warnings which are
> pretty annoying.

Done, pushed it out.

-- 
Jens Axboe

