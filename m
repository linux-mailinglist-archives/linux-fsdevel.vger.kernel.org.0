Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6D7B4B11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 06:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjJBEwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 00:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJBEwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 00:52:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00953C9
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 21:52:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c60f1a2652so18703325ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Oct 2023 21:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696222344; x=1696827144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgZc1gl8r9gpj8F7Au1ygxE46XZZIEmRRHjiEVQPVBA=;
        b=TL+HoLMvWBDopW0IXzRldKSynFlSpTg0Bg1mJ4trFQJilvADyqdIfpRRV0VZlwLXh7
         Sc3dCxRRCOZNIcawLY8aBmEyTDR2cFz2FbiIyc6/IMFfBa4+V6f9HlTQog0wfwISkkfI
         iZc749P+OsQk+I8lQnLhnH63D7kTF5iSkptB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696222344; x=1696827144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgZc1gl8r9gpj8F7Au1ygxE46XZZIEmRRHjiEVQPVBA=;
        b=HXpTMYrsNI9WSeMN1euh7T4/jLIiaMUir+7rPom9aIW2Y22c9vl6L2E0HzpY67hTQb
         I6LfZlekRsz9EapVYr+YnqhA9UYn3zKwcU5Hkk8ef6aSgn5vyL3UzwItdkKGYwjQVbnd
         68ES4O61AWSdn3GSZXJswRD6JU0FDz6nTWSATtc0iz717kV8Vu+dwT2LezTiQkgggaph
         WaK5idV3lmbgtsKf9J2i9qwd3jepXZAB1JmhidRwqkDH+6VS3wtE+BdJkty5lsgzmvEt
         OyBr7ww0a+mN/adU57SHv2DFUSyu2wa7AZ5/jVFnI8+A92qCZhcXBylJxJTg8kzISv6F
         rTLQ==
X-Gm-Message-State: AOJu0Yxy2JJk3Lb3I2oaa2bBAmEl9H20T6eF5b0KWqWABfA3R8eo1eT9
        SYu0qNXCfpV8gRY5Gj0Y0b97Lg==
X-Google-Smtp-Source: AGHT+IEoCHeBBwDUL5/duEukBlE8ayroCrMSrtJAST1F9vN+5909TzVhFCg4Lq92qLJoTTJZW7Qzsg==
X-Received: by 2002:a17:902:e54a:b0:1c5:6f4d:d6dd with SMTP id n10-20020a170902e54a00b001c56f4dd6ddmr18858004plf.24.1696222344309;
        Sun, 01 Oct 2023 21:52:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d31200b001b03a1a3151sm9883404plc.70.2023.10.01.21.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 21:52:23 -0700 (PDT)
Date:   Sun, 1 Oct 2023 21:52:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 df964ce9ef9fea10cf131bf6bad8658fde7956f6
Message-ID: <202310012150.72AAB06FAD@keescook>
References: <202309301308.d22sJdaF-lkp@intel.com>
 <202309301403.82201B0A@keescook>
 <20231002032239.t7ghpigbq5jy3ng7@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002032239.t7ghpigbq5jy3ng7@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 01, 2023 at 11:22:39PM -0400, Kent Overstreet wrote:
> I'm not leaping at the chance to reorganize my fundamental data
> structures for this.

Yeah, understood. Thanks for taking a look at it!

> Can we get such an escape hatch?

Sure, please use unsafe_memcpy(), and include a comment on how the sizing
has been bounds checked, etc.

-- 
Kees Cook
