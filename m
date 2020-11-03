Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F362A49EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgKCPcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgKCPcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:32:24 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFFEC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:32:23 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 12so11088113qkl.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 07:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZxnXLf7sJ0xkjjSNcmBC2OBmDjq/tyI0zR1blQeODc0=;
        b=qjyumjThmmi1ab3jOoBqxuRaykrcqsoj3yDp6IEd1Lie2vHcuBvTPVtMUZU9uNjLkJ
         y0bbc1AfpljfH3NxFd6jc4x1Zcc9HExk+tYAV3/ozTe81hBjAyyiolfcopytSDX/qDah
         OgqpWXeEm1fOnF7Ra8xBQpp71nScAnyY4skZtwIZHzAD7DLX3KYPmaZyX9H+EwdkX3Ml
         T3/JQvkHz44Y50mnNpT6abFeiLIUJoRUd+vezyLn5yLIWM4sbLyQyakc3sFVZnKwLK3T
         sJDIuzPEuKwbIiI1H1lEylobjUXXpZWaHBINVvYuFqfnK4xq9WHUppVhGwr5d/KAOc8H
         gCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZxnXLf7sJ0xkjjSNcmBC2OBmDjq/tyI0zR1blQeODc0=;
        b=h9Snm/2ZyCxp8RAEWgc4RS7J2kUeBxZ6GaT74m0oB0lzvnWKHvtZdTe/hjUT8Aksv7
         vF2hRbKzBjNPErxA0DMT7x6DX2ObXANaoDMsy8ZAIxZ00ceIK2uX3XKJ76Dv+xxB9A0G
         dJzCN2R5o5rQRbV/WCAaA2xMn5RsteuUmkmBq3TZ8k536BMwmG5osnLAx/Oc14vH45qq
         nTycZansI428pJvoinZhy9yVuovTv+PB1IiZ6ELo/5e5bisuNVr5NSz1e4ANASQPjtj8
         D3JVQ/4FHSNfzUiFL9RI6lEDbAbRQoxabDe3Gda8NLWlSNT5GkQqI36fAClECtJyePLv
         jDFw==
X-Gm-Message-State: AOAM530tKAufIjDJ2aGCq6JTJuqn0Lnk3Zhn2kOfyyvWaVA9yQ49FaOQ
        cjITdD8/OEbhRXmZlDUI6WXB5tqOM26tWMBk
X-Google-Smtp-Source: ABdhPJxziVJaNrqG+tdSPa8tVAI4mqiw52WQVnNW/XPvpfKWGs8Ek9q7P6IKaYBOlqpQ41bdvQHTiw==
X-Received: by 2002:a05:620a:b13:: with SMTP id t19mr19188744qkg.3.1604417542469;
        Tue, 03 Nov 2020 07:32:22 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k145sm10218012qke.79.2020.11.03.07.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 07:32:21 -0800 (PST)
Subject: Re: [PATCH v9 24/41] btrfs: extend btrfs_rmap_block for specifying a
 device
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <3ee4958e7ebcc06973ed2d7c84a9cf9240d6e7d7.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d1636237-79d2-e13a-060f-6a9a6764da4c@toxicpanda.com>
Date:   Tue, 3 Nov 2020 10:32:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3ee4958e7ebcc06973ed2d7c84a9cf9240d6e7d7.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> btrfs_rmap_block currently reverse-maps the physical addresses on all
> devices to the corresponding logical addresses.
> 
> This commit extends the function to match to a specified device. The old
> functionality of querying all devices is left intact by specifying NULL as
> target device.
> 
> We pass block_device instead of btrfs_device to __btrfs_rmap_block. This
> function is intended to reverse-map the result of bio, which only have
> block_device.
> 
> This commit also exports the function for later use.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Since there's only one caller of btrfs_rmap_block() in this file, and the rest 
are for tests, you might as well just make btrfs_rmap_block() exported with the 
device, and switch the existing callers to use NULL for the device.  Thanks,

Josef
