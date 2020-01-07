Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEDE132C6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgAGRDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:03:10 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:42964 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgAGRDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:03:10 -0500
Received: by mail-io1-f53.google.com with SMTP id n11so29021iom.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 09:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yuCPGN5ltIi9ToyvfT1B3Z6meGbkDm5bTI9RM16HMkE=;
        b=APnBX3ximAuUIBEX8AS2/wvamE1ubhqqBZ35sIxAgsPOFrL+BKe4onVJgFGlUw8I1c
         SdoZd7YXYjIyCgQp+yjME3Hx3vmy62nST5v7xHnhMOfaELWASv3RbpgKBjCHHlb2Sb+H
         tFZzexpa4gk2JeTo4geqQrpugmuU+26zTI/lbgFiyVWD/RtYH/PHF9tjEGxNvDtAqNPn
         8PXKQ7IvcaTinwdDieVmLdnUdpPaywsYtaxpGxgfw/7Kxd+JgN3JB8n7vTstfTPRf2J2
         wZJlKDhIwPGbSp65yY5mIV7TpNwB2vCPp/WSsKzuYR5CD3igyPVw7XlylS6fqqNXsSy8
         2x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yuCPGN5ltIi9ToyvfT1B3Z6meGbkDm5bTI9RM16HMkE=;
        b=ul1WRXzLiRJ3Pl8gTSCZG7md7vkX3dR4x/NqVyv4/tSMoMYX1zw4x6y6ReAONiueLk
         MbQVRzL7lJaQd1FWg47IuBPK0T0xclgVAASHa2GemoojP9dXYFbEhQ1Cmrz3SwrTG203
         eEEuzkRrC018b+YoK/dsqgrGYZJDrvdEGtoYBdKbb1pD8VF6gClAa5l6DP431JpggNwN
         b2OYSwzd/CEwHAtEFqkSdatD7n2NjMu4htAkhVTSEGDT2DW+rWWpLpG++qe2aqtsqROT
         1TJ5GsnG/pyI1ZK7sdqG3N7ZJDVztA9kNMBXI5j6F0VNld+CwJrA/emFa3CPE7e2seSd
         q55Q==
X-Gm-Message-State: APjAAAWzs0ucgb6Q1wpZRW18t4WtiFTrmC3PM5Fngl9I6uEaQ06r8JDM
        /PDojPHUtfD3I5RXD+unL3Mb5A==
X-Google-Smtp-Source: APXvYqzdB+ofu0kVmJA44d34y3Pv+AEzKmUy2lLY6HIJ2JwrL+bA8fuo94EBafrNKvx8AapBOFLwlA==
X-Received: by 2002:a6b:7201:: with SMTP id n1mr64850957ioc.37.1578416589140;
        Tue, 07 Jan 2020 09:03:09 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 75sm48079ila.61.2020.01.07.09.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 09:03:08 -0800 (PST)
Subject: Re: [PATCH -next] io_uring: Remove unnecessary null check
To:     YueHaibing <yuehaibing@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200107142244.41260-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4373ff3f-686c-8e82-af5c-8225ae16da41@kernel.dk>
Date:   Tue, 7 Jan 2020 10:03:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107142244.41260-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/7/20 7:22 AM, YueHaibing wrote:
> Null check kfree is redundant, so remove it.
> This is detected by coccinelle.

Applied, thanks.

-- 
Jens Axboe

