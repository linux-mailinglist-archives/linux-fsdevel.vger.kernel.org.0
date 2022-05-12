Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9D5258B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 01:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355136AbiELXsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 19:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiELXsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 19:48:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF5880F8
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 16:48:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q76so5945869pgq.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vw3sQUpaieTMoTDcrILIHVgb1aLkRaenBNEtTnBNXys=;
        b=Pz6+uT/TOgZQkn8jdZjeMNQne+A85AjgfGq4gqor3r+UyOgCioYHj5ta6kaanBhaTw
         wAuOZ5DNSQKkmCViGuUnbTjQ7k4NFmUM6RRqrvqGAeh0xxlx4Eo48jkJdDEHb0lZOtYT
         4e6QyqhI0XC3j58/HrE7jRCQW6SK9tvHHOZWs6YU6QHucGVQJH+wmtUjLIxi/oSbXJTO
         nqLy2F7rRZQZQnt6xHzmA+OzY2+P0HX3r0ccYLjsHLeH0DmwQ2RYedB2FqbUWSop7o9F
         81KW2R/NC/zV/6dbh25gMBpt325nFAOPmqw4FC/MFL5TXxbqkGgA0SnPp4vzWY4O9KJg
         s51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vw3sQUpaieTMoTDcrILIHVgb1aLkRaenBNEtTnBNXys=;
        b=eGUNTVe9hmt4E3jLOYOqPu/jt/VN/kMFGrajKQSnEKuzz2kSeeJzSiIMCU0wE9LwX0
         vxz69jrXwVNMsvqJKOF8ixGvcpG7Fk0EH5sSifNQ5vUP9wPGP0TcG1iISQI5MfLctlEF
         XQfcqZJIVqg0TXmBWOtg9vZLLJlFXQESeoObdH3EWzmYLyE3y8bxJYD8Ck2taJJiWlVD
         4alj3dL3GWueGHd7rg3KCZosgXxhFf8bynRPkkfvQKtJf0FfDmT6tsusvENvSCxndarm
         H87G++h3WIM8W/H0HpmdxeQdqoQtIbmPmyZcAMfrgdkDZn0vS3XXOCb9/tyzWECPomPk
         JJog==
X-Gm-Message-State: AOAM532USZEIisGkTLmAwfraIgab6FzAJ2lSpXDkrAfaOxrbTIQMKToL
        600tLxZ86Nh4DErGPwr/tVmeQA==
X-Google-Smtp-Source: ABdhPJxwk1qWnTYjkN8+NK/UUZumYODUolTYhZmVJgwS/nIhdmBp2fQZQYiMSYCcRe/a4dh1KJ06fQ==
X-Received: by 2002:a63:e841:0:b0:3c6:afc0:2259 with SMTP id a1-20020a63e841000000b003c6afc02259mr1654460pgk.47.1652399289651;
        Thu, 12 May 2022 16:48:09 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k1-20020a637b41000000b003dafe6e72ffsm257295pgn.88.2022.05.12.16.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:48:09 -0700 (PDT)
Message-ID: <c9d4df4e-f31d-1b6c-0d63-d1f2bf40929b@kernel.dk>
Date:   Thu, 12 May 2022 17:48:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC][PATCH] get rid of the remnants of 'batched' fget/fput stuff
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
References: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
 <Yn2Xr5NlqVUzBQLG@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yn2Xr5NlqVUzBQLG@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/22 5:26 PM, Al Viro wrote:
> Hadn't been used since 62906e89e63b "io_uring: remove file batch-get
> optimisation", should've been killed back then...

I'm pretty sure this has been sent out before, forget from whom. So it's
not like it hasn't been suggested or posted... In case it matters:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

