Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4994BBD30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 17:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbiBRQPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 11:15:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiBRQPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:15:34 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A12B2E3E
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 08:15:16 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id c18so5583801ioc.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qWMpF7raOj8BVgLSwxE6N8xfeTMyRc3jlMQt3XZTb/Q=;
        b=cVDsvk13PER+8/C+glX1jr0iFEn+/YdKItnMY2h6ih54AETiXBhUZP/QdQapgrpssn
         sxZWcdpbYkCZpYi/BlgGznFK7NmSIcjrJs4PGMbFt4QFaEcpHZBlRwsdnrZcLaqHuWWx
         6nCZrVgF7LoNLo16HORGYuXV2ZURrVWEugIKKz1ZiJa9/JmKSF6KMVtxWdipCodxmnCz
         Q0QqBgCEltJNpdI5aiegfQNysjPrrXvZ0ngyAKLf6+e1uQmXCdD/b+xDi6zxspquB8fB
         KXNU8fQnsRmrlki0OP+1EZfpiHY8z2LOGEXOUzuVhoB29xRArc/PAR+7hlR/squgIKw+
         j/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qWMpF7raOj8BVgLSwxE6N8xfeTMyRc3jlMQt3XZTb/Q=;
        b=Igjq0LxA7IN0sqJdZ/lSE8Ddotpw9jgWsydgm5sh7+Tzz6pnDeIKczbMgdwXKj9qX8
         LOwzYrhjXqVq5id4x5Jhdpzqjp+qFz1X57993hAf9qDVKGHEnLpcrapi0EVeMSewWsi5
         TkZTqB1UuNLis/CGvqgstDpJpzluCnllZveQucoXpI6AJuQiAl6WzI/aRRw3xDMTPjEr
         AAVgxZDqGjSdzph7Uf3E8S3qUfQmM9Bvhp+1VQkljmq2JidAIqEANQrSn74tBMIdeK8n
         w8oWJ/4Mp10biUhgPFH+kvR3NHXrIijnrvATnftJeXFwG9GGmQkUpO0Z/5RLrieThT3p
         M3Ew==
X-Gm-Message-State: AOAM530ysKa01J45aL0UWC7+6HfBj03F3Aq4Clea53E0HcUJefjP6ITd
        XuNdg5jy/JEMXF1Zzh5i6Hz3/sWiuFiCEQ==
X-Google-Smtp-Source: ABdhPJznRFMzQDAyGIgaJlH35YCnK/ivRBbFWmLPN+d/dPKxDRvdhLuORDY+Kcclwlg50DF9Kmmv3w==
X-Received: by 2002:a05:6638:4189:b0:314:5435:76a1 with SMTP id az9-20020a056638418900b00314543576a1mr5631166jab.263.1645200915428;
        Fri, 18 Feb 2022 08:15:15 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k10sm3654846ilu.63.2022.02.18.08.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 08:15:14 -0800 (PST)
Message-ID: <539953d3-bc83-0b6d-24b3-214f6cdaeb65@kernel.dk>
Date:   Fri, 18 Feb 2022 09:15:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 0/2] io-uring: Make statx api stable
Content-Language: en-US
To:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Cc:     viro@zeniv.linux.org.uk
References: <20220215180328.2320199-1-shr@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220215180328.2320199-1-shr@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/15/22 11:03 AM, Stefan Roesch wrote:
> One of the key architectual tenets of io-uring is to keep the
> parameters for io-uring stable. After the call has been submitted,
> its value can be changed.  Unfortunaltely this is not the case for
> the current statx implementation.
> 
> Patches:
>  Patch 1: fs: replace const char* parameter in vfs_statx and do_statx with
>           struct filename
>    Create filename object outside of do_statx and vfs_statx, so io-uring
>    can create the filename object during the prepare phase
> 
>  Patch 2: io-uring: Copy path name during prepare stage for statx
>    Create and store filename object during prepare phase
> 
> 
> There is also a patch for the liburing libray to add a new test case. This
> patch makes sure that the api is stable.
>   "liburing: add test for stable statx api"
> 
> The patch has been tested with the liburing test suite and fstests.

Al, are you happy with this version?

-- 
Jens Axboe

