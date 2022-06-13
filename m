Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068E054A157
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351957AbiFMV37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 17:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352791AbiFMV25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:28:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3D2E07
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 14:22:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cx11so6769122pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=De70A128M136BzcvUcDhFvWwtReZNa93TwdWArPgNw0=;
        b=wMhSJPuYIysiFwTN0rrpT3P9RK3mKPf/aUbDCs2PEUQJWku7YD57LLGZE58wmDZrAr
         OEJfJz50T181/f6I0fCF7BCxiM2g5aiiufxhqIjQo4BBlhmh6+kS9D7wUFsHYhmt8+Av
         cPRUO1F1tQ9KOMD0zYmhZdMTbxqxs/V6F2DT8qZv3jSqdXHMwZEowWjrDwYUu7RgpcA2
         dPLZFSNQfA7omcbet+DMlaIQRA2r/kXrpP/JuoL9RW/Dhwy81iguXw0f9NsTuqpa+lgo
         gZz8xcTlcsA2Q+OxolRv2BEHk6RNnHIe6Gqq3p5NuAgB9Gu3Dfjwyk24NGhs6ZW0M17B
         n5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=De70A128M136BzcvUcDhFvWwtReZNa93TwdWArPgNw0=;
        b=t9PDpjVdvrlidFMFpmejIRckbyqMUbakRy74EVe3EnY95Y+wSUwRDS5whKVTuJpeu/
         CFc6uQPmkviThPm+U+im/GJ29cIEwXZAhfIdebOCMZUjvrtN8FSNbMiw/CRO0KYpuoH+
         OLIJwFgLWcv6WB7WQjW6InYQFxqFb6+EJe3fqFz2OC+Iu7K1GjI8aHqx/gJuT44o3y+s
         grlvuBF2gY00Cu4qcywC2M3PeE336Wyca7sNQB1rAkYx3iDbtMXOQuohJEXXgLz//ABV
         OY4p0ohLtZfAz0b1W0d4Dnr4+te2NKIUlUGuihYUSh/cXmTnZ2RjlrWMnoAzy+kKtykB
         L4iA==
X-Gm-Message-State: AJIora8GwxthD2FT1YL8hrUoBYQEKqRlSnhga0ZiykDaTKNkBA1WCfV+
        bqPXeDoSqhaskJ00ck9T/09qgg==
X-Google-Smtp-Source: AGRyM1sPSnFY+821fUYw3RfnTBageuTpEriPGizdyessVR1YgznLprR3pLTNMc9iVpLL2eNsdqp13A==
X-Received: by 2002:a17:902:d48b:b0:167:770b:67d with SMTP id c11-20020a170902d48b00b00167770b067dmr901304plg.162.1655155339407;
        Mon, 13 Jun 2022 14:22:19 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b0015e9d4a5d27sm5605697plb.23.2022.06.13.14.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:22:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     kbusch@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     bvanassche@acm.org, ebiggers@kernel.org,
        damien.lemoal@opensource.wdc.com, Kernel-team@fb.com,
        pankydev8@gmail.com, kbusch@kernel.org,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
Subject: Re: [PATCHv6 00/11] direct-io dma alignment
Message-Id: <165515533813.6829.11794160430022485799.b4-ty@kernel.dk>
Date:   Mon, 13 Jun 2022 15:22:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 10 Jun 2022 12:58:19 -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The previous version is available here:
> 
>   https://lore.kernel.org/linux-block/Yp4qQRI5awiycml1@kbusch-mbp.dhcp.thefacebook.com/T/#m0a93b6392038aad6144e066fb5ada2cbf316f78e
> 
> Changes from the previous are all trivial changes:
> 
> [...]

Applied, thanks!

[01/11] block: fix infinite loop for invalid zone append
        commit: 1180b55c93f6b060ad930db151fe6d2b425f9215
[02/11] block/bio: remove duplicate append pages code
        commit: 7a2b81b95a89e578343b1c944ddd64d1b14ee49a
[03/11] block: export dma_alignment attribute
        commit: 5f507439f051daaa1e3273ff536afda3ad1f1505
[04/11] block: introduce bdev_dma_alignment helper
        commit: 24b10a6e0bc22619535b0ed982b7735910981661
[05/11] block: add a helper function for dio alignment
        commit: 8a39418810a65f0bcbe559261ef011fe0e298eeb
[06/11] block/merge: count bytes instead of sectors
        commit: 4ff782f24a4cad4b033d0f4f6e38cd50e0d463b0
[07/11] block/bounce: count bytes instead of sectors
        commit: 4b5310470e72d77c9b52f8544b98aa8cf77d956f
[08/11] iov: introduce iov_iter_aligned
        commit: ab7c0c3abb2e5fa15655e4b87bb7b937ca7e18c3
[09/11] block: introduce bdev_iter_is_aligned helper
        commit: 72230944b7a53280c1f351a0d5cafed12732ec21
[10/11] block: relax direct io memory alignment
        commit: 84f970d415ef4d048e664ac308792eb93d0152fc
[11/11] iomap: add support for dma aligned direct-io
        commit: 40e11e7a6cc74f11b5ca23ceefec7c84af5c4c73

Best regards,
-- 
Jens Axboe


