Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451A874A228
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 18:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGFQ0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjGFQ0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:26:38 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9B10F5
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 09:26:36 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34577a22c7cso741345ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688660796; x=1691252796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsUQiinDQbgs1GWC6x88zZ62UTNshdq3ifdf5wffGck=;
        b=FN0aM49NSkNhOMms1+7NZw0wJlPcATTOWjUIc+nNdMqL7TeysiAX8gXgAr7TERX8v8
         9tu5RtbVaTIO9f+1O+aGbR5sOIcif1gtjX9Oo/6RUj6VQKhugOtyOl/kRtYZjEY24X/g
         ViXEVBVWBYS7Av7ReprwqE0g5WGMzsLXHd+3lDfF9csV0+EDKx0IuMNxneGue6LZrHzT
         9joGEnWA8nzWVxD1ZbYr/GFwOhvwchkZL0rgBADvjq5vlTHjAEBj4L1Cpo38ULC25MUB
         ibTp7dNvjZCVWBmtLKPPjozOZ1cedwBRlhTGxoixwD5ZkTGyQ+C3snRnXyBmzeEjzlRQ
         2I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688660796; x=1691252796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsUQiinDQbgs1GWC6x88zZ62UTNshdq3ifdf5wffGck=;
        b=R7vlBpkeOUCXQzAFwuMK2LS+36D2oIGQBNOp354daKEkmEUCT6QBYeKYKpCoE0Y4WI
         gq1JVInvFyyclzCE+aTadJGb/8Xgc/aEb/ebHkvhf1O2CX//7moI0FYHhWur9ZJBWCcu
         Zf0q6s61V39lbUXizxBd5gu4VO9KVZu+xBc8RkajwZMqM0hcgAqjZsK4z7DEv5Apvi1M
         Zf6Z502/oS1zmQJQbZb1wklgxNcoMeKaSxxB/U7PmaoxE+f+f9u/sNdXbR5oce2Q0m7v
         Uk0qgUBgLNyckHwH7BCnulw8XGi1BqO37DKpQhc2qnqc7MKI/O/gdWIvrFW0sp4Um6xX
         mSwQ==
X-Gm-Message-State: ABy/qLZGerXtREhT7DXaXRycsW9YyptXjPrQtdrpf1N1jBourx2EVs9W
        Vk+K5ky0QHTvQ6xlZQE7Hcl4hQ==
X-Google-Smtp-Source: APBJJlG19lT5NjfnCu4VGDwOcKgkeaoTxH2wv/dSelvO8UX8aLJXZVc1dSRWK+cnH4BcIOHxcM2aZQ==
X-Received: by 2002:a92:c688:0:b0:346:3173:2374 with SMTP id o8-20020a92c688000000b0034631732374mr3181024ilg.0.1688660796002;
        Thu, 06 Jul 2023 09:26:36 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m14-20020a924b0e000000b0033e62b47a49sm617857ilg.41.2023.07.06.09.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 09:26:35 -0700 (PDT)
Message-ID: <48d69cae-902a-a746-e73b-a5b8fdf694b4@kernel.dk>
Date:   Thu, 6 Jul 2023 10:26:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
 <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
 <ZJzXs6C8G2SL10vq@dread.disaster.area>
 <d6546c44-04db-cbca-1523-a914670a607f@kernel.dk>
 <20230629-fragen-dennoch-fb5265aaba23@brauner>
 <20230629153108.wyn32bvaxmztnakl@moria.home.lan>
 <20230630-aufwiegen-ausrollen-e240052c0aaa@brauner>
 <20230706152059.smhy7jdbim4qlr6f@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230706152059.smhy7jdbim4qlr6f@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/6/23 9:20?AM, Kent Overstreet wrote:
>> My earlier mail clearly said that io_uring can be changed by Jens pretty
>> quickly to not cause such test failures.
> 
> Jens posted a fix that didn't actually fix anything, and after that it
> seemed neither of you were interested in actually fixing this. So
> based on that, maybe we need to consider switching fstests back to AIO
> just so we can get work done...

Yeah let's keep misrepresenting... I already showed how to hit this
easily with aio, and you said you'd fix aio. But nothing really happened
there, unsurprisingly.

You do what you want, as per usual these threads just turn into an
unproductive (and waste of time) shit show. Muted on my end from now on.

-- 
Jens Axboe

