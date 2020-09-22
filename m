Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7D2744BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIVOww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgIVOwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:52:51 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A576C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:52:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so19252723qke.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wq2ep8kyyAaceAMTO8vS1FECLN+yU4v/NlnEE5L3HO8=;
        b=H5EzjZfDHg6IGsj38HoYFULQq0932Su4lpaE12ToAKNdSTPX/UPVvzQT+lmBJYLNQA
         Oyxe45p+HXRccc7NXr5vqfm9oCGIzeQvLxATb22DLoFCiy7+IYZmY4Nbj0cjMeP2Tuhj
         9YtlWUr0akLLS4aKZLvWxq6iKB6B7yV9bePhwJ/ZWkbzewnGFe19blRC2PiTYC5MXBLD
         HRQyewMdU0u+dWx7tQmhu95SStu3DRxnnW0DiTIrYxi+w8sq/yY6h1j7UqsGzE3e7yXv
         sA3RFcZUQNXUOmKupEF6i8Xf7PauxEJ2YMoMxNJB8zfCAFabp01fSGpE2X5/OrxuC+9v
         GaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wq2ep8kyyAaceAMTO8vS1FECLN+yU4v/NlnEE5L3HO8=;
        b=AFomC5/lhmg9HnH7OSn1+RwnjYjUuDz6lIEWqV1/ShiBzAlX9A53AdugJ2y3wzojyw
         1xleOR8MJLmqLMw7d1rSnsqjh0liKJ8+6zwhirdsiKvCzfuDzaKENYZwwzKax6FVbQFV
         PI9V0Wfyf+L0bIawsuAnflLkD3iAMA5mFfLXrH4peX11+y7OkL+CiNqrqnPrb3/tKkEv
         HDuPN0oa4l7WcAKh/0QkjJ0DzcehCMXjKc/YQzS/hxNaz7fZrb8lrCY/t+3QccaALB2M
         WPtGj1DeOfBV9TQNbve9fleXvD8bs6xcM9K1MW/4xHEA4hc3yuCl/pdTzJ8tlVATfZQB
         GJ5w==
X-Gm-Message-State: AOAM531PmyLYxh0KzT43w9WqWtoCGE6pkXUGiHvIpWq7cE4AsR7IsqCy
        8aWXUMWUyFcIe2Z7YVnsPtcLMg==
X-Google-Smtp-Source: ABdhPJwyIY/vjb5Yvb2tPmNHzOh7jU4Ia9Y8fSam+1bNpK5SHOi4zItdY2Ah6ccqqvYmK/1raRdzCg==
X-Received: by 2002:a37:9a91:: with SMTP id c139mr3032369qke.233.1600786370591;
        Tue, 22 Sep 2020 07:52:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p28sm13131567qta.88.2020.09.22.07.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:52:49 -0700 (PDT)
Subject: Re: [PATCH 12/15] btrfs: Remove dio_sem
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-13-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6f36e438-4603-5fdc-e5ad-32fc8d07cfc1@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:52:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-13-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> dio_sem can be eliminated because all DIO synchronization is performed
> through inode->i_rwsem now.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
