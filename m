Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB4A1CB3B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEHPmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 11:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgEHPmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 11:42:52 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0103C05BD43
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 08:42:52 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id w6so1823375ilg.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsc0r+5+ZjurzhOSjY4Y4lgMibKJ6WxK1U7G5gxIfG8=;
        b=XZ7DQiFAjFR4nQHlDaw40CKmYcpLCFegUPvkAfGrjAmgtNZ+5fzyq0iHzJtEkfdMbS
         IvD/tgUQJNjMCaOy1OqPw6s2ABZjbZiWoVWwwIF9azyhPPFbOE20HP7thOwa0acqLhdq
         PHpex97hM8yoMtRN0ehacCJ2d+4Fm49T63zz0XvXrrEmTuyHFwMElTYqShxoeZrnXt3f
         /YEh09jMp9ZiCYMx49Ds+b2J9I4Ui60C0gzy0ectvVelokPU/sK/J/VG82TyxNOtv8RG
         7PDZjeIUn8D2OLeMsiqUtxDR9zFue8V6D8qbR6SUVKmbr0ib1OyCN3Y2z3GmkOI/+bOP
         TTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsc0r+5+ZjurzhOSjY4Y4lgMibKJ6WxK1U7G5gxIfG8=;
        b=J/srs855gofC6c6fObxpl/NMxvcFQDmHA2plYzb46NvlN23LeKjiu8tMKLHDj/vWen
         x5TWB5jHcnxtuCUKFh8xP1kkFn1a+Dn+1c43PLWbGpyb+VQvxw54YRAJB7+RHCgA+x8u
         E5dtjeTysbr6HsJAirtYqu5PYTZMzkJ4H38PdbxzrA9xSrzTpknovVjEpGZHFY4qBCBo
         A3lzseBOF2zXnMqzSdihFyy7STP7aPmfFKT8wDSZe4VAvXvXquEKvPlclX7nKt5ZRx0H
         UFbGTrfvSRlceNto5zCd0gHFP/mywibVwfDhom2Vadt/q3Wyt1gSLp5Dj6GMJibG3teV
         yecg==
X-Gm-Message-State: AGi0PuYMx1MnEz5UagnqNU017DwdWEuKgYpyuSmx7A/DKaUEVE5eNncj
        b0ILLhEvUAxhygDknR5ymGh5u0A+icw=
X-Google-Smtp-Source: APiQypLHAanSroDF/FH4Tm79CLceEZR7JGIioYNd3m0MytZ6QPPskUL2RZ+Ia2VRaJRuFv64YDjc0Q==
X-Received: by 2002:a92:89d5:: with SMTP id w82mr3393607ilk.153.1588952571841;
        Fri, 08 May 2020 08:42:51 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o22sm818896iow.25.2020.05.08.08.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:51 -0700 (PDT)
Subject: Re: [PATCH] hfs: stop using ioctl_by_bdev
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200508081828.590158-1-hch@lst.de>
 <20200508081828.590158-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b1629593-587f-476d-a534-9336cb9e6d43@kernel.dk>
Date:   Fri, 8 May 2020 09:42:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508081828.590158-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/8/20 2:18 AM, Christoph Hellwig wrote:
> Instead just call the CDROM layer functionality directly.

Applied, thanks.

-- 
Jens Axboe

