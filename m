Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF606113D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJ1OAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 10:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJ1OAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:00:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7F053033;
        Fri, 28 Oct 2022 07:00:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b11so4772102pjp.2;
        Fri, 28 Oct 2022 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Qdg5JQ7jRUVPiQSfa/lnoZs8xU+IO+CeBX2ZEGSnLE=;
        b=lqmAJcTIp2+lm06nHfSbdtp9KvQqW3/KRJChj6Y9ol+fsPbgMP4niyu8xDUOnO5F/k
         c/O9Srp8Ib4CUJJouEhJgthrp+IxhePnRblIm8EaYXkAWDEFh77hniGXwMTt2tY4dAH8
         ZyqfXB2ekw8OXp3b5edPpHSFeNmrJBPKwENnf3TeUR+0/y0Yv7Ers5GcxnuA1tTodZ75
         rLJ8GHZi2atguUKeQ7+22Rb2TwUqGSEEdFLQkHew1lR1ONqbadHXSjtz43ROs8K1ZbXR
         74wKbkspRBsYwALRCPcxbqYFqKLeSV0QPIubCmG8jiVfCIA+RjsxQJyvOcOgw8fwGe9A
         NexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qdg5JQ7jRUVPiQSfa/lnoZs8xU+IO+CeBX2ZEGSnLE=;
        b=lpADhJPebzU8oxUPp1A/9Ry+BubHAEogQdLgB5zr7akBdh46bEUffobY0Whu4LNrEx
         UGEyiTaZXqEFcroCImXztYHQUpADSvVWq9YzcQxOuWdhw2OQY1BtE1ALrIEe14kbjOqT
         DOeoCDBxYG76Xvmm0KPIU9iM3exyFc6w1ENyqYx6ZTgWce9ai3uOjVDzcaSTpUF7abTx
         fOGKe7maUrFwIasnN5ylDZzKHTeln7hrZDQ0ffPEc+QUOI/RamJmu/z3JL6YroYCZtA3
         4vQT+1npE8ib+qCATYtACeaQCmq0/82vobqInuRDEkEmIO7vFbiD+rJyFZS+GlpaCmRg
         XaYg==
X-Gm-Message-State: ACrzQf3eEASYdJNjsdOFyROIdv80e/KG0WCOXuubDhttKS5/iTUoveEB
        D9R1/OTiUETIQWuH70Y/PzE=
X-Google-Smtp-Source: AMsMyM4ida+A+ZnEWS1fy9FKWnWafErnFrEadIPuVwLRE0h27lTjO6iZao57TIUMM5AmHgOHs7mm0g==
X-Received: by 2002:a17:90a:2bc9:b0:212:8210:c92d with SMTP id n9-20020a17090a2bc900b002128210c92dmr16555151pje.38.1666965604593;
        Fri, 28 Oct 2022 07:00:04 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id p6-20020aa79e86000000b005629b6a8b53sm2978500pfq.15.2022.10.28.07.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:00:04 -0700 (PDT)
Message-ID: <550dfefc-ceab-385f-8b2c-69b21cd29166@gmail.com>
Date:   Fri, 28 Oct 2022 20:59:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 13/15] fcntl: remove FASYNC_MAGIC
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <4729b484174431a57b6bca139fe659f0e27b7e1a.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <4729b484174431a57b6bca139fe659f0e27b7e1a.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/27/22 05:43, наб wrote:
> We have largely moved away from this approach,
> and we have better debugging instrumentation nowadays: kill it
> 

Again, see [1].

[1]: https://lore.kernel.org/linux-doc/80c998ec-435f-158c-9b45-4e6844f7861b@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

