Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542C526335D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgIIRC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgIIPrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:47:15 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E42C061377
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 07:19:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so3346668ioo.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CmblY2ylsYjWHFktEYRzj6RVW7MJd9inxZj+0AXmUk4=;
        b=Lk6/SwLGNkoc/Vmb1jUQAmwDs73O+dRP/R0g5tuhROvzrh/Xnk8DRAR5mGdwWdArJz
         vZCH3IiSyp1vbwdoaXo4+xF/vLonCfcw4VZgLReFRUaGo3f7hb0+XfH/U5M63xTrGc22
         26LIBp/6IjlkQstor6j4UKXSkN6kKDWyMBce3lqAev9u8mrhaOpzClEhtubcQJ1N1AKL
         Bj+8yJal2FyQTOENoLhAPKKLy+gnutm0ri7C3yCxOFxibH/o76jkYvTf7nZgV4gV/Scw
         1qqlDnuzC9qe2G7lwQzLfbhNXl5GB2CT1bhNa3mbs9Et/qsEY41x23JZo7JgkmMdxKUJ
         dd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CmblY2ylsYjWHFktEYRzj6RVW7MJd9inxZj+0AXmUk4=;
        b=IDxYHAmAt+OJcDvMvAyzZU0jbP8pO9iUFL9leVYLFA606aF9z912Pf6uMkx+dttcIa
         NwUOHpfb4JwHksLCP9azVmo/j/JM79PCd6oHJsU0VTmtUnjqx48uAO86Xtnq8nSFpP0y
         om5eAm2jskbZqhlmyXf7auygm7vdiWroNQdXovbwXTZbf9ezQycWBkyXI2IiTvj5xFCk
         thyj/8zzBjNxdsIscVrC6Fldemmm8amfylWAWJO4O5DG+R+h2ByLJDm0/0jGd9CYh6NJ
         t+89E2QaCSZxONpQVDlQrgtCX1/AxxQ/CIj0PO3aSE8pka9187451+gp3MylM87Es9Nq
         1zkw==
X-Gm-Message-State: AOAM53116uVoBKTpViXvI1DS9E4sbGvC/Jq7NMxPbbQR26uLUBpqlV/3
        DtZoN17IavtCeRQ9F6Nao+iXZA==
X-Google-Smtp-Source: ABdhPJz8z7+J9CHtH1Rzw4Ej3kaYLD5DXx+Zu82Roro2EA5WfFs49suUa42wQSyVizXaM4N2MkzHhw==
X-Received: by 2002:a02:ca0e:: with SMTP id i14mr4357841jak.65.1599661149424;
        Wed, 09 Sep 2020 07:19:09 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r8sm1200756iot.51.2020.09.09.07.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:19:08 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/1] block: Set same_page to false in
 __bio_try_merge_page if ret is false
To:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-block@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
References: <bfee107c7d1075cab6ec297afbd3ace68955b836.1599620898.git.riteshh@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a90e9ab8-93b5-8ea0-97fb-2d5ea90196b1@kernel.dk>
Date:   Wed, 9 Sep 2020 08:19:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bfee107c7d1075cab6ec297afbd3ace68955b836.1599620898.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/8/20 9:14 PM, Ritesh Harjani wrote:
> If we hit the UINT_MAX limit of bio->bi_iter.bi_size and so we are anyway
> not merging this page in this bio, then it make sense to make same_page
> also as false before returning.
> 
> Without this patch, we hit below WARNING in iomap.
> This mostly happens with very large memory system and / or after tweaking
> vm dirty threshold params to delay writeback of dirty data.
> 
> WARNING: CPU: 18 PID: 5130 at fs/iomap/buffered-io.c:74 iomap_page_release+0x120/0x150
>  CPU: 18 PID: 5130 Comm: fio Kdump: loaded Tainted: G        W         5.8.0-rc3 #6
>  Call Trace:
>   __remove_mapping+0x154/0x320 (unreliable)
>   iomap_releasepage+0x80/0x180
>   try_to_release_page+0x94/0xe0
>   invalidate_inode_page+0xc8/0x110
>   invalidate_mapping_pages+0x1dc/0x540
>   generic_fadvise+0x3c8/0x450
>   xfs_file_fadvise+0x2c/0xe0 [xfs]
>   vfs_fadvise+0x3c/0x60
>   ksys_fadvise64_64+0x68/0xe0
>   sys_fadvise64+0x28/0x40
>   system_call_exception+0xf8/0x1c0
>   system_call_common+0xf0/0x278

Applied, thanks.

-- 
Jens Axboe

