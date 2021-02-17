Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71631D354
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBQAPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhBQAPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:15:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6FAC061574;
        Tue, 16 Feb 2021 16:14:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p21so1682910pgl.12;
        Tue, 16 Feb 2021 16:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qc32xlOCLSRj8vWgOnX/v45Xleynel8RRDhwt6qxKKY=;
        b=GsTDdNzGOyg0DhVou/Lm7oDo18qnNdDPFhWPtnkuKlNcbApVpXPyGFhwMUBqipM0tQ
         GiLrWia8lqZh3F/NjMjr292Lc+rb3BVyUWGi70G1hip79vRZVkp95w3Tn6mWwJDjuVZz
         IRvpwDkoUDYaa8sDWsxY3Lt6mqpAxzMbPvLNhUGR0YEkE/uC5RyTEZbFoBcSHJTxFiy0
         YiDpTBXTXvrSCEdDKwp5Xv1ysJvOYJdXhcWULhivm1LQfB7PGlyjTkv4cOHDrLOjXcIb
         QG5YGrAvi8vSAG+TS+r/shA2L409HzgAORRQOzEtjnn8OeaGDqUIZR1UrdqDfC+JKdj7
         hftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qc32xlOCLSRj8vWgOnX/v45Xleynel8RRDhwt6qxKKY=;
        b=KCvbcKTCuTHpMhB54GCRGZmZKwsFqmvJOBNBjM9VE68xdm35EG8wNGXSY+AxNsjdjD
         U5J3WUoZlfKEdG61CyOlAun/rscwpB0VHChoHZUZqHSDuCYXNmRj34+l31eKksQPaMV9
         SSr76RSmUS8uZqfPU6EFXSozCnMy6OIJpOlo4S4syeAEX4MxJJ8nnRkyj4JtOWNUhSrn
         ln6RGRasp1lW+HoZ9AXpojrXHcOylbMiK9syR6KE52K6KM8ZdykDRLoawjgFOuB7WIAV
         fw+p4ofycazX3yK8RtP9uw681wmdlU65iqQ0tp/4qgqpFPhWT+OV7fWQBSZTks5u3o+v
         wvZA==
X-Gm-Message-State: AOAM533TQj8Jj0yMyh5OeKkze4WYo7J+DQ4zWeCnyK9bTtQJN60z2pdx
        Ksy01KNZLmgqWdFER6g+iDgC2KDDy0iwrA==
X-Google-Smtp-Source: ABdhPJznGTLiudrHRvgt12eYzOzBPoT497qzxyDge4O1My5gEzHFR1cRAaoklwInQBVnrjJg2saq8A==
X-Received: by 2002:a63:587:: with SMTP id 129mr21510837pgf.233.1613520880026;
        Tue, 16 Feb 2021 16:14:40 -0800 (PST)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id c22sm95084pfo.136.2021.02.16.16.14.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 16:14:39 -0800 (PST)
Subject: Re: [PATCH v2 2/2] exfat: add support FITRIM ioctl
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210216223306.47693-1-hyeongseok@gmail.com>
 <20210216223306.47693-3-hyeongseok@gmail.com>
 <BYAPR04MB4965F5734BC7A2363D4C3BCD86879@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Hyeongseok Kim <hyeongseok@gmail.com>
Message-ID: <ab9601c7-fff5-1a83-b401-26812e4daaa2@gmail.com>
Date:   Wed, 17 Feb 2021 09:14:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965F5734BC7A2363D4C3BCD86879@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/21 8:56 AM, Chaitanya Kulkarni wrote:
> On 2/16/21 14:36, Hyeongseok Kim wrote:
>> +static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>> +{
>> +	struct super_block *sb = inode->i_sb;
> Do you really need sb variable ? it is only used once if I'm not wrong.
I got it. You're right.
>> +	struct request_queue *q = bdev_get_queue(sb->s_bdev);
>> +	struct fstrim_range range;
>> +	int ret = 0;
>

