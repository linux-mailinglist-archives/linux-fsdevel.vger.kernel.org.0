Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC270D39E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 08:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjEWGIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 02:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEWGIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 02:08:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1D10C;
        Mon, 22 May 2023 23:08:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae3a5dfa42so48838745ad.0;
        Mon, 22 May 2023 23:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684822118; x=1687414118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VD2NgqcZRGGkn3zZ0rm+CVjM7qWx3oRiSvs0S669pNg=;
        b=X/YpLW2vAC2Hl35lGL1TaWkJI8riIDWIIOsHjGi1oTVPmp2DvvXQAd+hKHRY4OP/K6
         538YR277Mf1WyxOgZQXhbt6KWQw8GKbtTQkTyzwO7hVYNMes5AkbnZRo2kjSTgMKxkFj
         +AMkMpG4oUNjYQh0epqP7LJDi+ogORP6cjmFcanl58d+yTnIbC/aQDYNOhydZhPUXxLw
         CSsr2Im8/e40kJ02RDD1m2u5OPlvPv4Lr95UhMrt0cEPRqvVMaq7YINHRGyfrCzJUHpG
         bZuqzDYe6EuISXglPbizWoTkFK2ZnwzSSNcpwkyaSWbH7vheoqkCvKMIOD9Vkl8bFtWn
         Xymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684822118; x=1687414118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VD2NgqcZRGGkn3zZ0rm+CVjM7qWx3oRiSvs0S669pNg=;
        b=V68lMvYc9uEIqu75zoLfBrfE/Fp7LXxsfsdYnfj/DB4HMX2tB94AWZYqIxH6yQ5dPk
         2BFoXNKSuyRQB5wBWWdoh+scRYqpuKslRKS4wZCL2fQ+Mn6C/SIW7CgwHpkOeCBQmq2d
         5EOH6FE8P9hBAa26fgPa2/0Gvy9NwrzOXtupAPIxROf+xJpv3EKH2/uqBkrnZxIsUajf
         +7JySvt9sAtJ9WBnFxRtgQPWkrCNAwxvzW9A1jgvVbWVE3lir89YN61IycgpB2/Awf8x
         HmyLTN+q/uTHaMvPKsPjcS6aS54kfaagKRNaRvSEjsLOHJK+fY8HSeOcTzuiHVVjEH69
         6Mgw==
X-Gm-Message-State: AC+VfDx3nXoYbmJgJmNner1ce48JY+1vBv1UmMltKuqrMY6exu+qbh7T
        M+zgZcsRRxULuZYdwhQsgmFIwGKfLRc=
X-Google-Smtp-Source: ACHHUZ4Re4MPQH5TgNZeGn6nxPZBW6jCrkNdY6dqjmYEynVdIl8jZ2BK7fz2RlAjm+2R3PREVyKKQQ==
X-Received: by 2002:a17:902:ea8a:b0:1ae:2b95:7125 with SMTP id x10-20020a170902ea8a00b001ae2b957125mr11543487plb.63.1684822117737;
        Mon, 22 May 2023 23:08:37 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-59.three.co.id. [116.206.12.59])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b001ab39cd875csm5930111plb.133.2023.05.22.23.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 23:08:37 -0700 (PDT)
Message-ID: <89b7cfee-164a-470e-c375-73b109fdf214@gmail.com>
Date:   Tue, 23 May 2023 13:08:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel NULL
 pointer dereference in xfs_extent_free_diff_items in v6.4-rc3
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, heng.su@intel.com,
        dchinner@redhat.com, lkp@intel.com
References: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com> <ZGsOH5D5vLTLWzoB@debian.me>
 <20230522160525.GB11620@frogsfrogsfrogs>
 <aa3fcf2f-013b-358f-e2d3-205e40b6908a@leemhuis.info>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <aa3fcf2f-013b-358f-e2d3-205e40b6908a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/23 00:05, Linux regression tracking (Thorsten Leemhuis) wrote:
> Darrick, sorry for the trouble. Bagas recently out of the blue started
> to help with adding regressions to the tracking. That's great, but OTOH
> it means that it's likely time to write a few things up that are obvious
> to some of us and myself.
> 
> Bagas, please for the foreseeable future don't add regressions found by
> syzkaller to the regression tracking, unless some well known developer
> actually looked into the issue and indicated that it's something that
> needs to be fixed.
> 
> Syzbot is great. But it occasionally does odd things or goes of the
> rails. And in can easily find problems that didn't happen in an earlier
> version, but are unlikely to be encountered by users in practice (aka
> "in the wild"). And we normally don't consider those regressions that
> needs to be fixed.
> 

Oops, at the moment I didn't know how to distinguish true regressions
and issues found by the bot, so I thought that both are regressions.

Thanks for the tip!

-- 
An old man doll... just what I always wanted! - Clara

