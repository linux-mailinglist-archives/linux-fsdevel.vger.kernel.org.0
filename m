Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1F0544999
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 13:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiFILCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 07:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiFILCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:02:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A693E23162
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 04:02:47 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y187so21538464pgd.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eA2rSMTUFSewTOnPsmOrnE6HCmgRpXaUuyafBR4ipFo=;
        b=PhF2l/vtHVZjCKAqz4OpktNX8yi0juQT7/9mlOjaRI+WJ/8mFLlvmrChupswhPlMoa
         bc7vMTDPOhZSuBdmsu8Ao+uRlmChD/jUJbcP2miIjzmjYzQ9L3TWeewo4w8AdkVg1o6p
         4Y0jslyAC5Xw0nkFpxZEl70DVxJkswiTrwXxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eA2rSMTUFSewTOnPsmOrnE6HCmgRpXaUuyafBR4ipFo=;
        b=z20UHpohRsJdQxdQR+p92DU2ML4i94pZfvs9+lp//i024IGG/zKUssHjzZpkp9vf/a
         5MtNgEYDmDzlvMVyS3iIhPEqW84omR6XKtvfKCvbOVeJVR/kw/IFtbm2lGhM2JZQxUwR
         BtZrZRLkz8pplIq6MIZLoq7YER4KAhbxeTIfL8A7AhuTItXi6IC7Is1yC4lnmmmCGmY5
         LUxg881Ym8dc/9K2l99DMNDlLJtmPVvKW55k0XSOenBvKWQCqwzwYr32EMY6XibaMETt
         1jPQc6v4TqeMlA8OnR8rTTI+GUyo92IdSCmjOB7OwGbBXx+/+FtNcwKlnVgYJJ+Sa9fW
         c9kw==
X-Gm-Message-State: AOAM533zip0DRobeo0HMS6BdOHD9ns8ccgKWohen4bWyWWF7BKLQR89N
        mYwY1BsP8rMB5Ml47qnSVJBq6w==
X-Google-Smtp-Source: ABdhPJyRD8M4C4AIWlnMkoCdrxA428zPc/65lMrKv7boT8iwH7ATo4M+sNcCYcjeZm4RCxc0iZEi5Q==
X-Received: by 2002:a63:8242:0:b0:3fe:3601:747f with SMTP id w63-20020a638242000000b003fe3601747fmr6713986pgd.314.1654772567192;
        Thu, 09 Jun 2022 04:02:47 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:1572:8d44:6d26:109d])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709027fc100b00163f2f9f07csm194145plb.48.2022.06.09.04.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:02:46 -0700 (PDT)
Date:   Thu, 9 Jun 2022 20:02:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <YqHTUdeZ8H0Lnf8E@google.com>
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
 <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com>
 <YqEKapKLBgKEXGBg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqEKapKLBgKEXGBg@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (22/06/08 13:45), Minchan Kim wrote:
> 
> I am trying to understand the problem. AFAIK, the mapping_area was
> static allocation per cpu so in zs_cpu_down, we never free the
> mapping_area itself. Then, why do we need to reinitialize the local
> lock again?

Well... Something zero-s out that memory. NULL deref in strcmp() in
lockdep points at NULL ->name. So I'm merely testing my theories here.
If it's not area lock then it's pool->migrate_lock?
