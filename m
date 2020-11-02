Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD422A30A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 17:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgKBQ5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 11:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgKBQ5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:57:54 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66707C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 08:57:54 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id r8so9627703qtp.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 08:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XdkbBYk76P5xCeArjTYzsjZMzLTxaLPfvDpQ81WJTRE=;
        b=izksLapj2SCVymtfdwKAnNw9aYDVTHRXCeWcXWxDAtMwfvynpbDA6OvYGYtZZeWBYN
         vAvq6Ov5IxswQACsAmjsnyEbDyyC4W/EJ7KSmTRyqvBflA/cmWgSX6UpTBQxbIrRK6S4
         PXPMUX6xnSar/f/gfAJ/4viMx35P7iqlQYYie7Rr+vsbtaHeHGV5tnkh2qdmQpxworvI
         rE+b80EV/TxyzVQjEB2yl8B9voMB1Pd+UtkH1pbVvkiKwbLnNzh0GOGjs2TwQbcCk0qf
         +kT+LPFSq/VanSN4m49DYDT58WVmw0ls0EhnWYyW8V6dKj6SqbiTVOmeS5vCbgQ8n6G1
         kOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XdkbBYk76P5xCeArjTYzsjZMzLTxaLPfvDpQ81WJTRE=;
        b=qAbiO+juPK8VMQbghk9x6qvthoaliIq8uJLlq79joyidUlQDSe/gH86osXlUkbC+A9
         b05EhTUyAojX7E1hIYabqQcF25EAbMPmO6PINhvlmSyGwSnSXKgpZeN0Tp0ogD/nALK7
         LvRyWUc7Chqz3FRfnQTZPF8PNGUZ6IyhLOcMBO9mkkRfhSJpvrzQNPH14/KPY6S1WEWa
         EQj0HwKTNPjvLLpWyroyYZVoLLrODHnz14ep05IeyJuyNXZTVq+WsMt2a/iYEDrdkkyI
         Mkug3pITIxsyXeZzqH5tpqUwFUUtcv+vuYRX+BDwtnKJ2IDvwe0Swyt8TZtNRO3VzBrP
         0Qug==
X-Gm-Message-State: AOAM532wNJQ6wvioASsD6B1YsQRvZ7NL50pvoRqvn9ADmEWOjR0wIrUh
        XFc03VZTWYw5MBN8BsuMNHOMmNC6H3mDaA==
X-Google-Smtp-Source: ABdhPJz8/89JWhdJdHT8xj7BkwgaI0beWHxei2ZPfBZRZZdxv+U5CGcADATlEiCiZA9Ppf72Nh/f0Q==
X-Received: by 2002:ac8:5901:: with SMTP id 1mr15060096qty.173.1604336273288;
        Mon, 02 Nov 2020 08:57:53 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d9::116a? ([2620:10d:c091:480::1:f39e])
        by smtp.gmail.com with ESMTPSA id 29sm8514928qks.28.2020.11.02.08.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:57:51 -0800 (PST)
Subject: Re: [PATCH v9 06/41] btrfs: introduce max_zone_append_size
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <066af35477cd9dd3a096128df4aef3b583e93f52.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <58761e4e-c2f1-afc5-24cb-32445e8623e2@toxicpanda.com>
Date:   Mon, 2 Nov 2020 11:57:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <066af35477cd9dd3a096128df4aef3b583e93f52.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> The zone append write command has a maximum IO size restriction it
> accepts. This is because a zone append write command cannot be split, as
> we ask the device to place the data into a specific target zone and the
> device responds with the actual written location of the data.
> 
> Introduce max_zone_append_size to zone_info and fs_info to track the
> value, so we can limit all I/O to a zoned block device that we want to
> write using the zone append command to the device's limits.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
