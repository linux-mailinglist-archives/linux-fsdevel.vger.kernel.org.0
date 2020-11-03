Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430F02A50EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 21:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgKCUeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 15:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgKCUeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:34:04 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD2C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 12:34:04 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id a65so14191173qkg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 12:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G+SSR15DQBKvTxVOsp2F9KH9mXyMA3FXaccfbx5+qsc=;
        b=a9akMtOvXnI1aPgTwLWjBbWXrE6S11GNXigbN319ZDzSc0nSPqn5xQ8U7MRnj0YMFt
         SScBaNHumqJq4it5hWAkYzL4QorOgY1B9RvPzkxTHL5K7YMVGCLD1H745jtu4ewbeFEk
         dZZpBKler5NKNH5Fu1XcfVwzkfkf7H186AamYEZG63k1KJY8sb5Kkpb96a2N1fp/RgtM
         5RF95wtClgFZgyAvvl2Mx3uHKPOfZs1Sf3av2C6XdSxIIa18sk5/T9hOfNYCDacdz5jM
         OhBUIuqNpqrsxdiXksbBGGDk8GVSdnLsrOh2FGwQWRWIn4LQGQNLV0PMfPY7rLPqLfcI
         Txug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G+SSR15DQBKvTxVOsp2F9KH9mXyMA3FXaccfbx5+qsc=;
        b=WbTSMV9IZAhhCfyuEoECk/xRFj0JlbxWXXY2XVNDF4NjovqdNnJUNJCKWDhlw+0H0k
         T1vP1qxl+f3+tCMxu3nw6BIOuvdbE9iueSoBqKzQIZvW3qttQ0MIggF0qUab7PsNay/B
         bofJfbr8FUUVg+ebbTZMC/M0E/cVqy421zBKQtAviwTox2BB4RW3LB2MUKXHy9+4/Mg0
         Tix7arD+xJdd3qPkno5VDmQZQhMmFJd0LARJdStZHnGPUtnMW1ZA7PJ+c+6DlLNgQCV7
         SOLePpEI/E1xKu9KrSRpOWs6EDrXQs2WpMHUzNhO3ykOLYD8baZeY8EL025mIWt9VGNr
         Aq4Q==
X-Gm-Message-State: AOAM533qBbazrYVjT6yfe18sT9ix4oVLEv7AF3DYf8zAsK6nQtAVsLE1
        mptjMV+nVvSuwCYeLstqC811/H5j6ObsBwfG
X-Google-Smtp-Source: ABdhPJypJXrMtRql366HHfGVWlLvnlz+j0JsBxVa46ljIJQP1sTloI4GggvVtEu69Ce+4t6K5glzmA==
X-Received: by 2002:a37:88c:: with SMTP id 134mr21149173qki.17.1604435643272;
        Tue, 03 Nov 2020 12:34:03 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 82sm11167619qke.130.2020.11.03.12.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:34:02 -0800 (PST)
Subject: Re: [PATCH v9 34/41] btrfs: support dev-replace in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <aa19bede48b24e48c10503604fd95e14557b7cb2.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dce20a26-b1bb-0b73-34e0-75b0d419b000@toxicpanda.com>
Date:   Tue, 3 Nov 2020 15:34:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <aa19bede48b24e48c10503604fd95e14557b7cb2.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This is 4/4 patch to implement device-replace on ZONED mode.
> 
> Even after the copying is done, the write pointers of the source device and
> the destination device may not be synchronized. For example, when the last
> allocated extent is freed before device-replace process, the extent is not
> copied, leaving a hole there.
> 
> This patch synchronize the write pointers by writing zeros to the
> destination device.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
