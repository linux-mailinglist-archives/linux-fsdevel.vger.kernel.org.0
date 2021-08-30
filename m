Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674B23FB70A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhH3Nh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 09:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhH3Nh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 09:37:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CFBC061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 06:36:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y144so15580630qkb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=agnGQ75OL15xrB4TvdTAIImo6aucfhxvAPL7IzlpdQ0=;
        b=UZIRkyOD/BiJm1rmhsSB1PHDSAKwe71aEYgpT20q7FRhYg4hf6yLurNR7tprhnn9D/
         y3MlBaFG00RsLEoq/N1Ffj2oMF6fjapDoZ2j9+9X00bh/wCxEOVhOvmrHSCWEb3nQJ2l
         Rr+8UtsxWx78Y/6773kKecpAmCZig36kLLKzNAPvhAIU0+fIXaaNA9kqdMvLEGJizEaO
         G30Tq1kClnPTO5FQfHKi3CjO1kBRu3lfQP4bGElSWUhVXeYQl4gegkgz551odqRg8iEc
         8dQrn07Y582rJcwHcNjcCfQyyROFoONwEXk4ncIAEnOVn3SbKkcKvkoz6AMdm79veS6G
         P/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=agnGQ75OL15xrB4TvdTAIImo6aucfhxvAPL7IzlpdQ0=;
        b=BqFqLlXtWeEKSGDjAcEghPyPPa8A2w9fsjtIqhNNm3He1hsNg7l2g9jDLKV9rJeuT8
         hYRaD5p/96urJL6Fp6XAUkhaj1qf1yIYqcQatCLB7yK9BxvrqT2tdzcYu6I66SzKovHd
         yc/f+VpNoHht7LtOICQ2ZA7ptyBNQsXlbAjYtvDJY2T5lTuUfUGMwkm9/8+kG7yOqHS7
         BBC0SyUS7jwycowno0ilrZcS2F0LycJiz7kN5eMelcDcHQRDYewbvQGhVj6M2jBYslwg
         Gz7GwSax7a0PiXqTu7j+TqaSkbWFLMBgKrYNuCY4sycQPZvJJGqrg1SnV6nqPVOLJ3yx
         2Vdw==
X-Gm-Message-State: AOAM530NQOUv9tnIsRuX+i9ydAQQtYYF0ZF2zpHh8GksSKyBB2eb967c
        PSfwhnq1EprNOG7ukzJB6HMMxG8Dzx2HtQ==
X-Google-Smtp-Source: ABdhPJxDC4XrH9DGwSmSrgnTJRuk+sqyorDAkdH437mzdcRK3lyzo5+sJrv+LcH6WD0zbXddGh872A==
X-Received: by 2002:a05:620a:cd0:: with SMTP id b16mr23006228qkj.136.1630330591427;
        Mon, 30 Aug 2021 06:36:31 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a15sm8491087qtp.19.2021.08.30.06.36.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 06:36:30 -0700 (PDT)
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Subject: [CFP] File systems MC for Plumbers
Message-ID: <b7569879-e74a-0ae6-76fd-0564ead595ba@toxicpanda.com>
Date:   Mon, 30 Aug 2021 09:36:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Just an FYI we are hosting a File Systems MC for plumbers in a few 
weeks.  We have a few topics accepted but have room for a few more if 
anybody is attending and interested in submitting proposals.  You can 
submit a proposal here

https://linuxplumbersconf.org/event/11/abstracts/

Just click on the "Submit new proposal" at the bottom and make sure to 
select the "Filesystem MC" in the track.  Thanks,

Josef
