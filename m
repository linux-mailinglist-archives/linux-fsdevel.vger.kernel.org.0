Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41725AC7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgIBOEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgIBODk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:03:40 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D545C06124F
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2020 07:02:52 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d190so5878441iof.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2020 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ku7e+DesYlsL/c7k5HJw65rc3jrpfmGqzPu51jyJxJY=;
        b=DEE5OKKGh1r8VHsSbRDOHXyr0EY/JZmo9R9NjqSjJKawRaCP4hU7gd7TYcJP/9YZM7
         f9ePonEEbp/l91A6T4zFQxTQLDeZxmy0LMYDoRrMahsz8WSo30cFpFYAnwscMWxFdIlp
         oD8CXLDbgxFmE3UimYbtHYWaCjvm1HLjDP1Jf/oc196Q0dgg3xrDzjQ3BN32QyrfzGEu
         BAA+ZfhsIf58ZQsISLcJD7bVqjEF28U7NRblbSxZYn9AOlHAjsBMyhDBaU/uxguqX2OT
         X2fZVbjEQa6505uyiqaXXm9chdV79wx7RHjRntV/V2w1d3oytjJ926JWuLbQ8ZonRWBw
         7Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ku7e+DesYlsL/c7k5HJw65rc3jrpfmGqzPu51jyJxJY=;
        b=Juj5vlIvtBAT+jb3DSO5QHwc1aKL39KaTHc2BqMA9lMedWZnF3TMM0fDzPnP7rACJH
         gIIJzNPwBDSsKikXSN2ZtKdlNVj+aB0YQPw1pXxVBruS6lK+GmSpyEqN/UX9vktn6FZn
         5PeZRKZxGEndGVFQQaiHrVP/v6PJH3n+fLGpAEzyglPBWhvfkyUH7SscYA4Y4pntK470
         onrdzKgP21qX3BJQTJwjv+Gpiny7ry0Uz5RjEacagQhjY258FBXQe6kLaPpQbNWubL40
         yoyVQYNxP35AKgmNdmReSkYppxOXOSurhc7bU89cuECApjF/d28vBUbhQ/xXYMsXMiXy
         aK6w==
X-Gm-Message-State: AOAM533O6VeP/qBtgSEQ0THtgg01hMLH6TQLjA6/pGTvuEpQi0deiSPY
        n1VDEjkNcw98WOwhGlpopxp6h2sVSZX2aZsj
X-Google-Smtp-Source: ABdhPJxFrZXWesZv0xLmVsuUB1MDZ450c11yMQmgXL3dPEcVh+WgJjGeEIGPOaG+O49/dxLkaoYMdQ==
X-Received: by 2002:a05:6602:2043:: with SMTP id z3mr3472576iod.93.1599055371125;
        Wed, 02 Sep 2020 07:02:51 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s10sm616030ilo.53.2020.09.02.07.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 07:02:50 -0700 (PDT)
Subject: Re: remove revalidate_disk()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200901155748.2884-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <78d5ab8a-4387-7bfb-6e25-07fd6c1ddc10@kernel.dk>
Date:   Wed, 2 Sep 2020 08:02:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/20 9:57 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes the revalidate_disk() function, which has been a
> really odd duck in the last years.  The prime reason why most people
> use it is because it propagates a size change from the gendisk to
> the block_device structure.  But it also calls into the rather ill
> defined ->revalidate_disk method which is rather useless for the
> callers.  So this adds a new helper to just propagate the size, and
> cleans up all kinds of mess around this area.  Follow on patches
> will eventuall kill of ->revalidate_disk entirely, but ther are a lot
> more patches needed for that.

Applied, thanks.

-- 
Jens Axboe

