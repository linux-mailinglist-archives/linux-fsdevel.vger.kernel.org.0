Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFD81E6A93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406503AbgE1TXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406296AbgE1TX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:23:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE6C08C5C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:23:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id c75so60099pga.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0gA7Ac+73j/XnZFQi1m6vn3pC8smRbdUm5Fe8cbDyhk=;
        b=Om+LVat92f7RfQwrzgyYFTaU+jb22Q8KiUAmJI9TaxaK/Z2+G02Sv/9APyzywDHAQn
         Ln7QkPtqftmBgBAB4LCMNXyvhNZcFe8XgdR+LctT7cHTb7V1DqY9dhhRoe985ljMbbmu
         jnAscOpB5boyeZ/+SkqORtmWOqSkQoGaXxGTGvwSDDd1XkBBBQGdLBLlrKaHV2mH2EMx
         P/kfVgurkkRRin6rXHRfXKstHnWkUQmCEWiv4r734Ng8gwmHlxhUggxP37jQ0QixIPnG
         2WV+sl52+rHWgakZ+AFjDeD7H5Vru2/of/jrruf+PyAE9qImbd6R88VyiHjemZDp27+0
         GdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0gA7Ac+73j/XnZFQi1m6vn3pC8smRbdUm5Fe8cbDyhk=;
        b=nIu+EOJ4KuAlOYTpLPAvqiVk/yfx0k41eFpUoG3zo0X5NUPvCfj+CHjEjpZCuiBsvC
         oN8BwvGZXbNhrhnQFJ01HX/d0YcxbUKqq/iZ7XtRHkabif9Darrc8UCIIW12Pn0HNLVx
         7TaWudkImZ13RMxxqRuGpNpkLnNMBYUax5VN8tzBNtdO4ht9rfhKQ3EoAYWH9wkBKR0+
         U1NbesqBqCQPLP2Uh/kofQiEMxo7OOj6meSHXLRt7BadDMFpj7LqqjrEd0oMrsjq/ttJ
         cF9dUjBvsODrZpbZjWKQp/Mq9n8Isjhles8GfozgDpFWb4p3iFH79YO30AkHOLeyWRxG
         NXbw==
X-Gm-Message-State: AOAM530FD8c5zU08a1m+dUjbwgt9IzK2g2VhOtaKvyOQ6uGNifwFaIDj
        mLzn+pjqbv30rUkRhlcWwRda5g==
X-Google-Smtp-Source: ABdhPJxvks363x29yek8RaALXXC0cYu2SwUDsZ1gCb7momK0fY3oVgT+N23LBhPU5BtU9iTGBDhkUg==
X-Received: by 2002:a63:c5a:: with SMTP id 26mr4386530pgm.270.1590693808617;
        Thu, 28 May 2020 12:23:28 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t2sm5089134pgh.89.2020.05.28.12.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:23:28 -0700 (PDT)
Subject: Re: [PATCH 09/12] xfs: flag files as supporting buffered async reads
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-10-axboe@kernel.dk> <20200528175353.GB8204@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d723cd33-2fed-1438-d1ed-b3851edf4b98@kernel.dk>
Date:   Thu, 28 May 2020 13:23:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528175353.GB8204@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/28/20 11:53 AM, Darrick J. Wong wrote:
> On Tue, May 26, 2020 at 01:51:20PM -0600, Jens Axboe wrote:
>> XFS uses generic_file_read_iter(), which already supports this.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Er... I guess that looks ok?  Assuming you've done enough qa on
> io_uring to be able to tell if this breaks anything, since touching the
> mm always feels murky to me:
> 

The mm bits should be fine, haven't seen anything odd in testing.
And it's not like the mm changes are super complicated, I think
they turned out pretty clean and straight forward.

> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks!

-- 
Jens Axboe

