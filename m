Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D35F71BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiJFXZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiJFXZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:25:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC81A025D
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 16:25:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 70so2982041pjo.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZygdtQl3rMbRdr0w7DkWhiBa9Z/ADOW5Xl5z6vw76/M=;
        b=mCQ7z+1sm6CPEVtpHP2AtNHhVfoTZVPVZDgNCg9GLx3hI+hkwyYAZZXvN93sXLoMYe
         md9rMPaTRGTg3j7egudLHDiRPem/o5w4nMWPvN+8ymzky56qBBbJwfcoct0jxQIVImUX
         DUBmAcEt+5VV6gX09rs3kG8BuhRJYawP57tGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZygdtQl3rMbRdr0w7DkWhiBa9Z/ADOW5Xl5z6vw76/M=;
        b=7t+ruhJzXLcDqhQ0yVdvJaGrNRtcWHudkHWlB+M/UOEIpwa9OMoNtjXRBHmFGRNE2U
         +YgT7OaByHrsenpBGn5pYHfqJt8ryAXm8hxu0USKOJovnSCQytQZvsqZlt836MW0p7hq
         ComgL9H0iTtyKHIlTnTzH9WeGCkViix2c0OiC7tfmiWY4cpPZUxpEOfef0VmllVytUS+
         6085nFj6wnVIC0oWDTjPQmNmMwxaepZoAMukuNk8+IGaV1+6ci8dGTSxYKCqH4pqIH0H
         l8c1CxCrD+A9iX4U9i0RVJmZBXQV/d1ehJKKVolqBls6xndNovC66af+Kf+1iMJ89l7M
         ZajA==
X-Gm-Message-State: ACrzQf1WOkZy7x7PLZOwMMWRSaV02Pu71mdDoXzVG7aXnump9xyNLE8q
        2l647RvcdYGEuKdPDtEGrYjVzwqg2hi+8FLw
X-Google-Smtp-Source: AMsMyM6qxU/L9aMpEr/lJy/8m9/mq139FUyqoAlJHW0DO2A/kU8trV0M01fDLHjg0R39Pb2BAZA3kQ==
X-Received: by 2002:a17:90b:1c0a:b0:20a:7393:d8e9 with SMTP id oc10-20020a17090b1c0a00b0020a7393d8e9mr12748478pjb.188.1665098724550;
        Thu, 06 Oct 2022 16:25:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7958f000000b0053dea60f3c8sm172734pfj.87.2022.10.06.16.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:25:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gpiccoli@igalia.com
Cc:     Kees Cook <keescook@chromium.org>, ardb@kernel.org,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        Tony Luck <tony.luck@intel.com>, kernel-dev@igalia.com,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH 0/8] Some pstore improvements
Date:   Thu,  6 Oct 2022 16:24:52 -0700
Message-Id: <166509868540.1834775.12982405101524535051.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006224212.569555-1-gpiccoli@igalia.com>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 6 Oct 2022 19:42:04 -0300, Guilherme G. Piccoli wrote:
> overall. Most of them are minors, but the implicit conversion thing
> is a bit more "relevant" in a sense it's more invasive and would fit
> more as a "fix".
> 
> The code is based on v6.0, and it was tested with multiple compression
> algorithms (zstd, deflate, lz4, lzo, 842) and two backends (ramoops and
> efi_pstore) - I've used a QEMU UEFI guest and Steam Deck for this goal.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/8] pstore: Improve error reporting in case of backend overlap
      https://git.kernel.org/kees/c/55dbe25ee4c8
[2/8] pstore: Expose kmsg_bytes as a module parameter
      https://git.kernel.org/kees/c/1af13c2b6324
[3/8] pstore: Inform unregistered backend names as well
      https://git.kernel.org/kees/c/a4f92789f799

-- 
Kees Cook

