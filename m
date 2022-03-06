Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB84CED08
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 19:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiCFSHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiCFSHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 13:07:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E048574B2
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 10:06:15 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o26so11740619pgb.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Mar 2022 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3IDySe6/HojQ3jDxfjpKc6zpBwkz5pfcZNFnpj0OwBo=;
        b=ECZvhaTcTYSYuxNQf0dXjupv9p+mdfcNTTw6ViBX4xP0zeXJMhvpwIQK9qTWRQKsVD
         SQtDRh+omkTij3RdK9ud99NHyowBI2gvl+kctfY8m9J7D3ThNlQNDH+yPjn/dzgq2HXm
         2JTWmnVhMWChL+QJMuKarlAx+hNcxWxldBAieo0PZnSkx1O1pSIizg87Z3lyOVDTTuug
         KnXayEwHBgey7lOMeKpKoB9emHN2YgUdy7f3A033WZdOK6lEDPzdtuAFqwcQtULwuojV
         63zGCRF1wVcH1aP3PvwIGNKv5PX7kI8fxhX2v/p71xw3jOuV10Biivx8AejciDrjQqf4
         MiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3IDySe6/HojQ3jDxfjpKc6zpBwkz5pfcZNFnpj0OwBo=;
        b=z6+RcDGsai7SJN2XfxOyUVJMmph0pQvb6/RptcWoDB4TgpRbKjFTAvWXMk2Deym2jY
         iv7YuCMVRcC7ilh4MjT1euXdXm/o+HPUOTROzb8m+2syKxfSmOfNg/F64SboBvEd8y7U
         rt8pQgLDWHVg8kZCXb+pPy4SEalIhyjEIE07n7Zf2eDIf7KkIknLO89mlDMb2Ol+1JNQ
         gk6aGyz0weroD6VZq2v+LZ87GdyfGqJksTh2TYuroCbJUZ+x54sx/+1Fz5iUBbk5w7vL
         EVzv99Bm5ryZ3yzER6+DCKG2gzfvpSFk6MNzUgmY17I6TEiRk0sJWpkuEW88oVrcT/eP
         iM9g==
X-Gm-Message-State: AOAM533/Wqj9gGyYvB0E1cWDXONBdAUUDhdk0YrHhzOvwLbSDvtuikA+
        fsy6Lwowgx3IzamFubAzykIogwLU/Qp3XA==
X-Google-Smtp-Source: ABdhPJzZKQnoFchQw6tzr1OIIZ1uDCy2Ywxdu5LxhrSM3BjvQrLV0Y79FSWzFuuduKBiryJFzTjlfw==
X-Received: by 2002:a63:d74f:0:b0:374:5bda:909d with SMTP id w15-20020a63d74f000000b003745bda909dmr6973383pgi.215.1646589974835;
        Sun, 06 Mar 2022 10:06:14 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm931995pfm.207.2022.03.06.10.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 10:06:14 -0800 (PST)
Message-ID: <f08db783-a665-2df6-5d8e-597aacd1e687@kernel.dk>
Date:   Sun, 6 Mar 2022 11:06:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>, sagi@grimberg.me,
        kbusch@kernel.org, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
 <20220305214056.GO3927073@dread.disaster.area>
 <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
 <20220306180115.GA8777@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220306180115.GA8777@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/6/22 11:01 AM, Christoph Hellwig wrote:
> On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
>> Yes, I think we should kill it. If we retain the inode hint, the f2fs
>> doesn't need a any changes. And it should be safe to make the per-file
>> fcntl hints return EINVAL, which they would on older kernels anyway.
>> Untested, but something like the below.
> 
> I've sent this off to the testing farm this morning, but EINVAL might
> be even better:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/more-hint-removal

I do think EINVAL is better, as it just tells the app it's not available
like we would've done before. With just doing zeroes, that might break
applications that set-and-verify. Of course there's also the risk of
that since we retain inode hints (so they work), but fail file hints.
That's a lesser risk though, and we only know of the inode hints being
used.

-- 
Jens Axboe

