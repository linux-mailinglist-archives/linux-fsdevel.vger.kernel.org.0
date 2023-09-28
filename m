Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F577B14A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjI1HU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 03:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjI1HUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:20:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288321B7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 00:08:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ae3d4c136fso311374766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695884923; x=1696489723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9ZZj3TAdF6y14okvt65IiCzK1Vza5vldoP+r4B9cog=;
        b=p3eRYj5u/SkQXj92Xz4xa/J176M+BrQzTZDj4HsjZ7rmhTjQPCHPkKWUlxcAltx91I
         JtWaD3F3k3/jaHZL7NS+1H9DJ+TM3on2Yfm5E4sxvk20TVlfli8xMxgXJ1NoVJjSZT6H
         KisURZ/nFqzjkUIP1jdjTySmsHomatDhyWUDwm5uiozIzYdIX6OSGdn6luP5maw8ivgI
         hvRnvKKV9FuxmM4z/eJyePuPsHJHFWhHvVVwadcNSNu/UW/fROtvV3NstC8bJHQH18CK
         hTPj26PdwvGJQmlIWOeQSXe2vFpTWjmSbKKvwC2IgsbehOdHim34a/9GyziwGqDRTsbM
         bOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695884923; x=1696489723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9ZZj3TAdF6y14okvt65IiCzK1Vza5vldoP+r4B9cog=;
        b=Wvzg3m3Gt8G4el/zhqAHcqIaSsupGE3Az90bC6SPUKIbZjUT0h/0DFwZNbrvWue54F
         zLMkjnif4lN7VvkH77hhdbDG3mghQTPSQry6bc/Lu6i1X2rN+7d81tQbZ81yW7ZLjAw3
         J6qJO+CbU/ShKOiUjL/sm7fCui/c1JhST+LVEXUTaOTt0CgZjj1Sw/urJn7LxVi0aBk4
         K8cf9Rv+oHlcaBiGoDi9gQ62WGGEkPjHDrP+qpS/k8gI8Z/G4dlXBE8ywNGpGrZ/Ky2a
         00y1oVv+Euc4M32MhIjZG38oxLH1+ofOkY3pbhr8G0Vf2Htm6cn6j2ZQOmaH91M2rkrf
         0OPg==
X-Gm-Message-State: AOJu0Ywrg3aSQszxHAofIyJat1ZR4iHT8a0HbZo8Z1LEBWfac+8A0iP7
        iMBMrIXgVT0/GDyT51yyZ0cDYQ==
X-Google-Smtp-Source: AGHT+IGjmO8swOrlBRgmG5ozpGdpo+al+7OO0vi3ugc6H0lMHgw63E8AxoBnONq6N34uVI/NZSIVVA==
X-Received: by 2002:a17:906:105d:b0:9ae:5868:c8c9 with SMTP id j29-20020a170906105d00b009ae5868c8c9mr360119ejj.0.1695884923518;
        Thu, 28 Sep 2023 00:08:43 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id r26-20020a17090638da00b009ae3d711fd9sm10362745ejd.69.2023.09.28.00.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:08:42 -0700 (PDT)
Message-ID: <fb6c8786-5308-412e-9d87-dac6fd35aa32@kernel.dk>
Date:   Thu, 28 Sep 2023 01:08:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ovl: punt write aio completion to workqueue
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20230928064636.487317-1-amir73il@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230928064636.487317-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/28/23 12:46 AM, Amir Goldstein wrote:
> I did not want to add an overlayfs specific workqueue for those
> completions, because, as I'd mentioned before, I intend to move this
> stacked file io infrastructure to common vfs code.
> 
> I figured it's fine for overlayfs (or any stacked filesystem) to use its
> own s_dio_done_wq for its own private needs.
> 
> Please help me reassure that I got this right.

Looks like you're creating it lazily as well, so probably fine to use
the same wq rather than setup something new.

>  		ret = -ENOMEM;
>  		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
>  		if (!aio_req)

Unrelated to this patch, but is this safe? You're allocating an aio_req
from within the ->write_iter() handler, yet it's GFP_KERNEL? Seems like
that should at least be GFP_NOFS, no?

That aside, punting to a workqueue is a very heavy handed solution to
the problem. Maybe it's the only one you have, didn't look too closely
at it, but it's definitely not going to increase your performance...

-- 
Jens Axboe

