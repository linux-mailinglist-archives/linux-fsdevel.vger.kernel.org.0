Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8111B9974
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgD0IKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0IKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:10:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7AFC061A10
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 01:10:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so19412582wrx.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BWFYX7PX5iVsUcqkRSw86/RtX5f51iD1D27rAVa9S5k=;
        b=DkguBcsFj0EPiLpABgT8rwKhoHGfXC4HqjrDIcxCzC0+0m4BwZCxFQWPAH2FMMagvZ
         aBW6P30XZ6aOwyOfyNiBuJ7klTHDbgZo8XUdPiCMQf08pnwW8WgAGS6sKgGw6RiSsJqX
         jP4WPcJrV/j5+q7L6P/pePj7dr7fBhuHh5CC5DMrnzpJGYyDg6p5mDLUOLfCbWYD6kiw
         kdIyZGN+TyFSjeycyhRg1ED+cIQBxHf6W1AhotvuyBgRCd38UmFZ+QCggJccxRAKZny+
         eAz0t+8XaVoJPSl/S+rW+PpOe1/QP7/5db7dNeD3y2hn1+T6yl9oKrzmhdYwnRdEkbb1
         99Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BWFYX7PX5iVsUcqkRSw86/RtX5f51iD1D27rAVa9S5k=;
        b=XaGyu6FHChDv+5eUv61IdrpTc4IWAVDRVG7IM4U41tK8FIONvjV3T7VafmjqFwh2Ij
         WtVQPX1lJlrKvfVnPNyj4dEndFS1So+z1riAepaR6C0BmkjIbgM0z4GL6c7KR6zINkBY
         y+SDg59kPy9lKYsUEfDFOEGJlgFJ/gbd4FLKGP2FdbCtfGwRCU9dnUD9Q5Z1bqjcPHrb
         V5rQwZRMnCWoDk/i0HQrclaRNYMQL+uJhaKNoUzGFVaLO6b2MooEWl/1DxYhRDzu4kOv
         vtivNhzWs8onmpW4nsaD8BH+Cji81gNPkBbRrZzCD5XiKkwtEqwEimBImvgV2DWHnCXc
         cyiw==
X-Gm-Message-State: AGi0PuaxOwj17cGEcV/P77RGXTkiMzEs+J2cqGIxcesvjCKf4nkWaKrz
        36QZqol1kys82XZ5d6mHuN6/Mg==
X-Google-Smtp-Source: APiQypI47heGwKaekAfcdCP9TA3J1BjECdG45lBsaUSpphpeLIcAoPbP2SxOxrxltJF2SerXzSR0ew==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr26528432wrn.18.1587975052322;
        Mon, 27 Apr 2020 01:10:52 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4886:8400:6d4b:554:cd7c:6b19? ([2001:16b8:4886:8400:6d4b:554:cd7c:6b19])
        by smtp.gmail.com with ESMTPSA id r20sm13918576wmh.26.2020.04.27.01.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:10:51 -0700 (PDT)
Subject: Re: [RFC PATCH 5/9] f2fs: use set/clear_fs_page_private
To:     Chao Yu <yuchao0@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-6-guoqing.jiang@cloud.ionos.com>
 <fc48f93d-b705-4770-0fd0-8807b3a74403@huawei.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <665e77ac-2476-ea75-5c61-eb8c2507d1cd@cloud.ionos.com>
Date:   Mon, 27 Apr 2020 10:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fc48f93d-b705-4770-0fd0-8807b3a74403@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 4:22 AM, Chao Yu wrote:
> On 2020/4/27 5:49, Guoqing Jiang wrote:
>> Since the new pair function is introduced, we can call them to clean the
>> code in f2fs.h.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Chao Yu <chao@kernel.org>
>> Cc: linux-f2fs-devel@lists.sourceforge.net
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Acked-by: Chao Yu <yuchao0@huawei.com>
>

Thanks for your review.

Guoqing
