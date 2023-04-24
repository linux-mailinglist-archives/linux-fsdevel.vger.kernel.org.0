Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87AE6E70BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 03:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjDSB2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 21:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDSB2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:28:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6086183
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 18:28:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51b914ffe71so245424a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 18:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681867708; x=1684459708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fORvDtycGEYAP00Go8Gr75NbmrQRJi6legeNyHFvVc4=;
        b=LrmAEIyGSJiRmmpboUhhQgqPcY35ao1RN/OmUVmJ2+dtZKoCNZbb8NLxueipM+G5cL
         7Z8Nwal6Jz63ieQNUvv003Q/cAVuE98OeSDB3Ay0Doy0h7oKAWn5SO9oU40wJCf0tbCQ
         BQ42zZnn0Cg/VQDTeWslhL7Wd8s61avskpFcinz3IKJk+gNlExkijnMyMDYHJlhUHd5M
         8IVAzrRyL0O2Bazz7z+f5qoE6nxJXJFFSe3jLE/4Y/nctAfi6fljhWgSEFtC2xGzhK5C
         mIW0MC0YJkbwEU94y4kb1t2bC6NCGfVeKEG9Yso2dAk27EpJOXvZk/aks8gm/9xAtK5z
         hsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681867708; x=1684459708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fORvDtycGEYAP00Go8Gr75NbmrQRJi6legeNyHFvVc4=;
        b=dNFrxUntHvQcEZT1NfPzGMpvdBKuRvM04I0jNqUrx6q+UlY8klFuECfEkEWTVWm6F5
         nwz3gby+/okHR/Ocl+GDpKinD7MUOVT+mlIJT0vVSiDtzr6NNUx3BNYcbAJpWkk6329K
         V3I0K2YtYUoTjs3dSWYG3WINty1bZVavsMXd/la+eaOrwCZK1twMd3QV/dVRhAq8QGcX
         XluiB0OsrUiNvcSh3Se74j4iLsV21LuV9r9mFPOpclUwBRrHkw05w7USbuybeCC2l61F
         /ImKsMsLk/O3JNhaO/gsEuqwXRcQ2ju/kpiillmj3BIosJgW2GgkufBWv367mbRKU5+O
         OZwQ==
X-Gm-Message-State: AAQBX9fe65OqUR20ok5LYf6HRmoTmHntmVckGyVs/DwjxRaVLr4hObHx
        4v9/G25pmSzE3EvfcGSVKGPLcuUbOlul9XFGrcw=
X-Google-Smtp-Source: AKy350ZW2i/ZFxByFt235VEJD3loFwfTTKFlgazg6SB7eTiGwpib5QWAwouBg+e5G+DCGghYaT9aug==
X-Received: by 2002:a17:902:dad1:b0:1a1:956d:2281 with SMTP id q17-20020a170902dad100b001a1956d2281mr19890233plx.3.1681867708384;
        Tue, 18 Apr 2023 18:28:28 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709027c1800b001a50ede5086sm10206660pll.51.2023.04.18.18.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 18:28:28 -0700 (PDT)
Message-ID: <b09e799e-9d9f-ae22-1f09-babd6521b11d@kernel.dk>
Date:   Tue, 18 Apr 2023 19:28:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] fs: add FMODE_DIO_PARALLEL_WRITE flag
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Dharmendra Singh <dsingh@ddn.com>
References: <20230307172015.54911-2-axboe@kernel.dk>
 <20230412134057.381941-1-bschubert@ddn.com>
 <CAJfpegt_ZCVodOhQCzF9OqKnCr65mKax0Gu4OTN8M51zP+8TcA@mail.gmail.com>
 <ZDjggMCGautPUDpW@infradead.org> <20230414153612.GB360881@frogsfrogsfrogs>
 <cfeade24-81fc-ab73-1fd9-89f12a402486@kernel.dk>
 <CAJfpegvv-SPJRjWrR_+JY-H=xmYq0pnTfAtj-N8kG7AnQvWd=w@mail.gmail.com>
 <e4855cfa-3683-f12c-e865-6e5c4d0e5602@ddn.com>
 <20230418221300.GT3223426@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230418221300.GT3223426@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/23 4:13?PM, Dave Chinner wrote:
>>> Without first attempting to answer those questions, I'd be reluctant
>>> to add  FMODE_DIO_PARALLEL_WRITE to fuse.
> 
> I'd tag it with this anyway - for the majority of apps that are
> doing concurrent DIO within EOF, shared locking is big win. If
> there's a corner case that apps trigger that is slow, deal with them
> when they are reported....

Agree, the common/fast case will be fine, which is really the most
important part.

-- 
Jens Axboe

