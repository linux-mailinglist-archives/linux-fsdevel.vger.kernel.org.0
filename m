Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5756C5F8A63
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJIJdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 05:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJIJdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:33:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CB2B1CF;
        Sun,  9 Oct 2022 02:33:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x59so12302385ede.7;
        Sun, 09 Oct 2022 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM1SogZHsHwwBQI3iIbZedPPqwmTQ+KRvC2VAQyUbPA=;
        b=Of+z6LhARiAntBoz9T7hEugcQmN5BzMj0e6bKs/9mrHrhlN/Re7047RhkIxQQlNTw6
         PJLwIpTY1Ue8qLxe9FdzycNVaUXP4dWLt+q1tpujXCVluj6RLOY3Xo2BtBR3/SbgW/ej
         to9DNxa+sQo8MbgBndHvwR53D+7IjVKY6nAWvgIqendz7zHCinzlNrVaIE4SY9omMYyA
         jmb0QbZ2Em6ZW9ylyWJWd0FdgFAsEGoE0y05alVBH+O4YJKBt0FPJ4h1cEkrA/b5bhn9
         PH0rbwzQzhC6wOwv9zELV9aiCliiarXcgPteaqy4Da+3Jj00N5HmQ5ZMZ1Tb3IYRc66+
         EjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SM1SogZHsHwwBQI3iIbZedPPqwmTQ+KRvC2VAQyUbPA=;
        b=la+IH82Ej/mZp0LZnI5TQx702DQkEYiw2ZtGW1++qVFKjbwH1/L5f0KDVsBS/epw1l
         b21iwxkeSXm8crkOFZ16m1iSpw3W+YXhhNBp+YFNEZEmNBzzLq8fwmhsRrZbS7/O3aSK
         j3Iph3m2uDbCXI7+XHIuK5NmLweFjkOmXxU1FPdNV8pPuTHpSsbXVo5Nw0oOIhlMPi2o
         M6BLfgBe1UYBd9MxAVHRhD8XYQNfKHZQYjPGxQ/3349V5jna6HvZuKKSnjwJYMHXSypo
         kxFyOBg9Wn8L7GQVaMk3zI/t3lmOw+vc1lNXBLLozVOMs9EgL8qvRMVMykLoYAi/megZ
         qpcQ==
X-Gm-Message-State: ACrzQf32vGgEoYHKZ0MQu9CvxYk+Bd1n4RxPH+lD0ek9yHbOnSOoKqri
        DfR/MqMbXkwknat49FxeOt4HHMxaszE=
X-Google-Smtp-Source: AMsMyM51AHV3UF1r/gaSTuMo5hWYAWm+HElEtGRuP7LZ/V0dv9ZpuQvpVQbq9hXDXszQXUFgRaeZ8g==
X-Received: by 2002:a05:6402:3552:b0:45c:e4c:e6db with SMTP id f18-20020a056402355200b0045c0e4ce6dbmr801153edd.403.1665307989080;
        Sun, 09 Oct 2022 02:33:09 -0700 (PDT)
Received: from masalkhi.. (p5ddb3af6.dip0.t-ipconnect.de. [93.219.58.246])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906415a00b0078116c361d9sm3861013ejk.10.2022.10.09.02.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:33:08 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: RE: A field in files_struct has been used without initialization
Date:   Sun,  9 Oct 2022 11:33:06 +0200
Message-Id: <20221009093306.24598-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
In-Reply-To: <Y0B6+0MLZI/nv1aC@ZenIV>
References: <Y0B6+0MLZI/nv1aC@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Al Viro

> close_on_exec_init is an array, and this assignment stores the address
> of its first (and only) element into newf->fdtab.close_on_exec.  So it's
> basically
>      newf->fdtab.close_on_exec = &newf->close_on_exec_init[0];
>
> ->fdtab and ->close_on_exec_init are to be used only if we need no more than
> BITS_PER_LONG descriptors.  It's common enough to make avoiding a separate
> allocation (and separate cacheline on following the pointer chain) worth
> the trouble
> ...
> ...

Fascinating, thank you for this very informative response. I have learned a
lot from it.
