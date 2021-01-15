Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF36F2F885D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAOWV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 17:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOWV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:21:29 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE703C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:20:48 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c1so7209704qtc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 14:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zxbJ3C2Wh7iG6P8iLG/G4N3xjaagWOAu/Q6gR+krxvs=;
        b=z8z0DHvDg+mqcJIvmS2VHAz3PhgyVD1R/uO6LFpEUWhOzrWOLhFahBDe8e4+xRmmMf
         FImQIInpaoZxhYrNXteHjWKnyajjGfZ7Ueumwr9WQSP2Wgwr2NzePiBS5J79S2yArBrD
         VZMv4kWwrPmjjV+9pThTf3XtB4nsIZ1jgJTqxQWpKdaPTatlSN23kQx9FevsUI42+JZ6
         3ZYyIlvN3Mf+X197FECaKP9nQoB9I2xXevf1/fw5Ra+SsJ/VZuA20lt5DyyPcJOoZzlO
         Sm1nqJ3gj89JRp/znuGfwfdmp8mi8wxspSgeSwq06UqdfusPRuMb5vjZWVug4q360VLL
         MZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zxbJ3C2Wh7iG6P8iLG/G4N3xjaagWOAu/Q6gR+krxvs=;
        b=WYEL2xUbz06aRdQo213dEbwb3TxGtr3Py6oJ1JGCCUA5vWdlRIbT1YFc557hrOmYBa
         /8cgRqhOGPa7IHJiYox76N0jII1ruBeyqm/t9sfYE6AO42aUZDnJ/B3C4c7awrfTMys+
         EAznBoqkGAYrG1kV48Bv9F4euIxklN2FVaMl9lSfGXjbvocIF648b1xPRk+zW6ZAYFCW
         oqPvlCfwr5fROKBjvwjjIQUxWDm7TX7qJrmo/t0eMqiz5c8TLxEv4mgkusWlqWBg0aW8
         47KKaToga++Z3gZz9rLWGBNTLuuyFKg+JXtkKiSbLhGW22BNHwVsfNR2qQtKWOVTdLnD
         3Dxw==
X-Gm-Message-State: AOAM533sSr/ejV+7zk0dkLFcYi9TgvQVDf+8scdE+ZWVQAl9mV+C3GL3
        GOGeBCb5UnLodB3WJ7AbQXrDx8jIk5bSf8EP
X-Google-Smtp-Source: ABdhPJz3m+/27qVjnWSz5OwhE5Au9c/12sCQBx5hV8ktKYqfs4bswD7MjwFYIP+HXR+qGd8psuUHPg==
X-Received: by 2002:aed:3ac1:: with SMTP id o59mr9631789qte.203.1610749248081;
        Fri, 15 Jan 2021 14:20:48 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11e1::105d? ([2620:10d:c091:480::1:cc17])
        by smtp.gmail.com with ESMTPSA id v47sm1035361qtb.42.2021.01.15.14.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 14:20:47 -0800 (PST)
Subject: Re: [PATCH v12 04/41] btrfs: use regular SB location on emulated
 zoned mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <30ac9e674289d206ec9299228d38cd7d03cd16c4.1610693037.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <13285359-e64c-a2db-1d9d-20b523e0c510@toxicpanda.com>
Date:   Fri, 15 Jan 2021 17:20:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <30ac9e674289d206ec9299228d38cd7d03cd16c4.1610693037.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/15/21 1:53 AM, Naohiro Aota wrote:
> The zoned btrfs puts a superblock at the beginning of SB logging zones
> if the zone is conventional. This difference causes a chicken-and-egg
> problem for emulated zoned mode. Since the device is a regular
> (non-zoned) device, we cannot know if the btrfs is regular or emulated
> zoned while we read the superblock. But, to load proper superblock, we
> need to see if it is emulated zoned or not.
> 
> We place the SBs at the same location as the regular btrfs on emulated
> zoned mode to solve the problem. It is possible because it's ensured
> that all the SB locations are at a conventional zone on emulated zoned
> mode.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Ok so in emulated mode we simply won't be able to test the SB logging stuff.  I 
think this is an OK trade-off,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
