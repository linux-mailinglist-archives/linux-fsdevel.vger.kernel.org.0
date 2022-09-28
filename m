Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F95EDFC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiI1PIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiI1PHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:07:42 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B16B0890;
        Wed, 28 Sep 2022 08:07:07 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id bq9so20282922wrb.4;
        Wed, 28 Sep 2022 08:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qREYIWjuGjLGDeO/dgifyqQc1nhCGZnGcZ9iHgJIHrM=;
        b=3FPbnQNvQH1QOFRPk1fHaETYNCQF/b1fykyp12/VZPRI79+YXanPxeJ7vP160rrTtb
         f4VlpkSGJMzjqcj56ddkp1I4oRvh9L0UDeewNHPU+YyJSOQKTQ5PZ2+IizAjcKlcy2zp
         MlUchM8rScLrcMKJCUy6dFrWEGIRL904vUcTAxpv8rwBH77tSI1A5YwqgrnhhPSRogOq
         wD+sPQXSjuRUfMkShi7pMy7++3PicEAShc11K+Xg997yvrwAAlSwWXNqFKDFpjUt/6im
         Pj++84oLZk8Yd6+gTqV78WRLwF+JmxHnN1NsIlgnm2rBvzuji+WcKKDUiX/HB3gX8CHT
         6ysw==
X-Gm-Message-State: ACrzQf2N8271h57ZQAQzcGx7qauukAF9bHFjOc4wHakyG4ItHLO19F8U
        CKqcllBrvbiS6o2yIlCRCwbMg0qaKhg=
X-Google-Smtp-Source: AMsMyM5FFV4aX5J6YjdrDCbVIvl3V6P8/lD53lGFfc9W3f5bjY3hHbBprT2F7AKvWApQc2n4Pf+ISQ==
X-Received: by 2002:a05:6000:1acf:b0:22b:36ad:28e with SMTP id i15-20020a0560001acf00b0022b36ad028emr20180294wry.314.1664377619666;
        Wed, 28 Sep 2022 08:06:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f4-20020adfe904000000b0022ac38fb20asm4355010wrm.111.2022.09.28.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:06:59 -0700 (PDT)
Date:   Wed, 28 Sep 2022 15:06:57 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
        live-patching@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 00/27] Rust support
Message-ID: <YzRjEc9zQbHeWPFL@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-1-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:31PM +0200, Miguel Ojeda wrote:
> 
> Miguel Ojeda (22):
>   rust: import upstream `alloc` crate

I cannot find this patch in my inbox. That's probably filtered out by
the mailing list since it is too big.

I've gone to GitHub to take a look at the commit
753dece88d70a23b015e01674a662e683235c08f in the `rust-next` branch. It
looks good to me, so feel free to add

    Reviewed-by: Wei Liu <wei.liu@kernel.org>

to that patch.

Thanks,
Wei.
