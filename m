Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2DA1FED9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgFRI30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 04:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgFRI3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:29:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5801EC06174E
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 01:29:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y20so4709280wmi.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q/FhG+4cBdMoXf+y+JoOK5WqKhNWLzcZaVPlv+0EOe4=;
        b=Xs4ICteQ1OPmSSoWv+jtCE98IOKG6iUHTGtRho8Me7cN06JumB9ydwmlKrqn1S4jKD
         8WN8oRkVeQUavOMZCftsP3ZK6Agva1sK8Thz6guwGDcabS2RbXFZyXSq3T+KKIowWwK1
         zgrSgAcoH9ajA7uT8mhB/YjSuv/NpGE6+ZQLr26YOxTlFvrYxiKP1B5ud8uitLl9jyXd
         +9g26EsyvRxDPrkH0owAeaOcfWcane+aUms66fX5GOAH24rVouMx3jRvOFWz/wGxrLpa
         j/W6Doa6aHOGhix8AB17eEj6QBJ9yxk6S5j8mAoPp3nbDznge7/5oOQ0AjOxptijVler
         nCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/FhG+4cBdMoXf+y+JoOK5WqKhNWLzcZaVPlv+0EOe4=;
        b=MugeC+6tVLxMT0fjtrr0eBx28yCu9xAl49WUo5a/oOuKTqaJ2Fa0mPrqYOZ48XiTnJ
         PCSWGf6Ek04x1kyczmakxsV2h+pzVOu88pCAPw24gPV/+xL15RZTBH+zGwR796LSk21I
         RJavkvv49nlpGDHF4Nd7TNLbiN5uTWfFyw5cW+5uvTYWvXfORPwMNQ49kfVubBJPgHvG
         dga3IdeUXiwq2WMobIcb7AcBm46TD+TsFU9FBqlxPiSe+jHkh2IWqSaUMe6FbeDNPqrt
         hgHx6TzrcN8XOXqp4eLnKIhk6ss0djBKNB9a7cxSVCaCIaSwcson87U6jlxlweNK7JH+
         EzDg==
X-Gm-Message-State: AOAM532cgNTd05AEO9TUjOsjmXV6RXXHeIktld4ku0irT7HpoOmMJ6SI
        vIW1PqdMIOkVbGbGEpGAijRoqQ==
X-Google-Smtp-Source: ABdhPJy6DprN2pld8KJjwF0/B20ZndrUjmASu/OhSh3Fi3eGeCKWfhPJoh31NyS9wZTAiEQ4W4TVGQ==
X-Received: by 2002:a1c:6346:: with SMTP id x67mr2074199wmb.139.1592468963125;
        Thu, 18 Jun 2020 01:29:23 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id c16sm2612482wrx.4.2020.06.18.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:29:22 -0700 (PDT)
From:   "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Date:   Thu, 18 Jun 2020 10:29:21 +0200
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com
Subject: Re: [PATCH 0/3] zone-append support in aio and io-uring
Message-ID: <20200618082921.zyc37cod2uhabd4e@mpHalley.local>
References: <CGME20200617172653epcas5p488de50090415eb802e62acc0e23d8812@epcas5p4.samsung.com>
 <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
 <20200618065634.GB24943@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200618065634.GB24943@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.06.2020 23:56, Christoph Hellwig wrote:
>On Wed, Jun 17, 2020 at 10:53:36PM +0530, Kanchan Joshi wrote:
>> This patchset enables issuing zone-append using aio and io-uring direct-io interface.
>>
>> For aio, this introduces opcode IOCB_CMD_ZONE_APPEND. Application uses start LBA
>> of the zone to issue append. On completion 'res2' field is used to return
>> zone-relative offset.
>>
>> For io-uring, this introduces three opcodes: IORING_OP_ZONE_APPEND/APPENDV/APPENDV_FIXED.
>> Since io_uring does not have aio-like res2, cqe->flags are repurposed to return zone-relative offset
>
>And what exactly are the semantics supposed to be?  Remember the
>unix file abstractions does not know about zones at all.
>
>I really don't think squeezing low-level not quite block storage
>protocol details into the Linux read/write path is a good idea.
>
>What could be a useful addition is a way for O_APPEND/RWF_APPEND writes
>to report where they actually wrote, as that comes close to Zone Append
>while still making sense at our usual abstraction level for file I/O.

Makes sense. We will look into this for a V2.

Thanks,
Javier
