Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8BC5E5893
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 04:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIVCaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 22:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiIVCaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:30:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CFD5C357
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 19:30:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d24so7479419pls.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 19:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=6RwGBqc6lTnE7JnqV8OurSGJbwt84FPwXV3SLopRoPY=;
        b=x2HwAqVZD+z4C81oJd8Mao2bwiUx320Us4SBHRBWDStYqKIpQSa0EfdfZ3fJV3taov
         UhiqB99Xgoz77b8C1DxPgFKbAl3fYWZMIHkYqXFt8YRJqdcRmIKQnB7CLz+Hlscf/Zvx
         BhFWxW4dqGP5x0jA4PWwmIyERpkbfgfrFe9OSWmsQ3K5nVlR4d7PwAn7Kd7SnvGLO77x
         lmLNmDYJBzT7KRHqUmpGNMX9KhCMRs/EDjzkdOeTE8+IqM/jRCQuNWDxmAetQe8xHDMN
         sqpuSNRi9YR01Y0vCbpw49DZaGqyWiQiOrHdc4cB6B6mik86psZS2PFiSyjG/RsGU8fM
         R9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=6RwGBqc6lTnE7JnqV8OurSGJbwt84FPwXV3SLopRoPY=;
        b=Fs2OiygOBBXOnEsGhs2UlFC0FAl6ce+i0juet/DtBmJLOFkXIhxsEksISFAiP8pv4v
         usyCsCliHIyqwc8KrdDlQepAzLPSF8T54jfu86rrTFrAMjPBVAW7TmqUVK4rfpB89Ejb
         tylsICXlNioe4d7Slk3t0ESLYuAlpyBqlX5cbV9wZYqz1BrPNbfv+nLog3EvL5dC+NCs
         pFaq4nDddpffO5KjCuVH9BxGy95FYmzCSW/9WhBa6dSsfg7wqcG3oseMxL/Wb3N5vFqX
         ZINczk8MFEn+ki5AV7KNXW6PHbthvvs5S1GHWBqRMZw0i0Y3owiwiIB8MNa4dBMkUQrC
         6gBQ==
X-Gm-Message-State: ACrzQf3wsd+Gkb2Nk3U5p0M0at8nA892ZP5thoAMJIzZ6pOW/EJOt7Mk
        44a1RgaMcFcwBWeAHFqHa8wKBw==
X-Google-Smtp-Source: AMsMyM4tGm+YFHhT0cBVSCmb0eAR8+OFN6qd65oC4gAJts0CdBB2wLTikF/9+gclpSPbsfy5sd5TqA==
X-Received: by 2002:a17:902:d355:b0:176:cd80:5b32 with SMTP id l21-20020a170902d35500b00176cd805b32mr1114681plk.68.1663813812401;
        Wed, 21 Sep 2022 19:30:12 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id 65-20020a621744000000b005289a50e4c2sm2947085pfx.23.2022.09.21.19.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 19:30:11 -0700 (PDT)
Message-ID: <72672db2-7fd4-2912-35bb-174c09a74600@bytedance.com>
Date:   Thu, 22 Sep 2022 10:30:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [Phishing Risk] [External] [PATCH] erofs: clean up .read_folio()
 and .readahead()
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org
References: <20220919092042.14120-1-jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20220919092042.14120-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2022/9/19 17:20, Jingbo Xu 写道:
> The implementation of these two functions in fscache mode is almost the
> same. Extract the same part as a generic helper to remove the code
> duplication.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>   fs/erofs/fscache.c | 210 +++++++++++++++++----------------------------
>   1 file changed, 80 insertions(+), 130 deletions(-)
> 
