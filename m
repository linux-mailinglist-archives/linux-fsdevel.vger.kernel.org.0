Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8E5F9DF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJJLur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJJLuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:50:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F085A894;
        Mon, 10 Oct 2022 04:50:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a3so16700882wrt.0;
        Mon, 10 Oct 2022 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AV5pUwiXA+PA3Jd/giIxumbszKFu5s2N0TiGrAZugtw=;
        b=d44BYDTufJs42ogPANgNIKRTei3bJOR/4RS3XD0EeYj25A2X6WLpRAPGd3AA98o8OJ
         VnVdqyjJHLmNPw9NM+xFRHhAPD/kDyuDksF/FvDehSL3Hv9rvg4Pv1tSv725eBmZPlXp
         Or7hhMtR3jE5AA8F8/g3kbnIuOCqqgnDFfuDz2/BlOY1xdsgA8vCERkArbHZ20Pg4ZuI
         DYKJizPdobqGsjjajWr3kjORzznaQWhRO58vwTEduzxGXgYPVTZw++u9Uy2LPkSKoH/x
         u9Nl0A08EpuZglLjY5ibAlITvx8HLfJ/8jW6JChQBNgL3SurOcH5tVjB2URh/7v9DObh
         kJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV5pUwiXA+PA3Jd/giIxumbszKFu5s2N0TiGrAZugtw=;
        b=c1cq2X1aNmMoyCCa2DjVlHX1Y13iV39iizmzZq4znv3dda2pD1lLpWF6fwLEGCqUCo
         v7VSKb7+3FDGkdqWKnVG4Fg+bVrO4RYDJd1qP48M0z+tL+G4N6uueoYDhsBTOFhc36PU
         TkgOuXgFKxTB0Gtthxo42PWkEL3AJtEb8K7Xy98OahvjYjvLhXeePtc6ILxX54PD7ITu
         UXnCbrqvpAsJDqW/XVr8xcLklX0Y2hjfEpJlphyIwBtFLj6fDW+Ya8JOanIgW9k06Gl7
         5Pyr23/DDoTCDiWwnLpmGzBZxXxvkXORpeZTLgtEjD1XIIiaYaCI5NDwDW/9cZkEwh8p
         GwOA==
X-Gm-Message-State: ACrzQf2t+R2/e377cCc4DPOX3JBEyB726I2CGIjHh5eRW42Y7QG/XbAm
        8WO4m+TLRb5f/K4CSue1BNDWGAty60LWJw==
X-Google-Smtp-Source: AMsMyM4xRBN4MZsrdGwinGZRaEM70/3RYMhGzkKcAD3VtJxeVyY5G0Lf1ViHWa+4wBiXVCFdvHR9LA==
X-Received: by 2002:a05:6000:1244:b0:22e:4d39:a0e3 with SMTP id j4-20020a056000124400b0022e4d39a0e3mr10745854wrx.509.1665402643675;
        Mon, 10 Oct 2022 04:50:43 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id m4-20020adfe0c4000000b0022cdf2179b2sm8889001wri.68.2022.10.10.04.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:50:43 -0700 (PDT)
Message-ID: <d67639e4-565f-e30a-eef8-da28fc5bca8d@gmail.com>
Date:   Mon, 10 Oct 2022 12:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/4] fs/ntfs3: Fix and rename hidedotfiles mount option
Content-Language: pt-PT
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <536f13a9-0890-7e69-65e9-5fe1a30e04ef@gmail.com>
 <CAKBF=ps4CUA3crkzUUn8J-0WC-6bGb3Z9PPugzebTajGJ+=rSA@mail.gmail.com>
From:   Daniel Pinto <danielpinto52@gmail.com>
In-Reply-To: <CAKBF=ps4CUA3crkzUUn8J-0WC-6bGb3Z9PPugzebTajGJ+=rSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Às 09:08 de 09/10/22, Kari Argillander escreveu:
> On Fri, 7 Oct 2022 at 15:32, Daniel Pinto <danielpinto52@gmail.com> wrote:
>>
>> The current implementation of the hidedotfiles has some problems, namely:
>>  - there is a bug where enabling it actually disables it and vice versa
>>  - it only works when creating files, not when moving or renaming them
>>  - is is not listed in the enabled options list by the mount command
>>  - its name differs from the equivalent hide_dot_files mount option
>>    used by NTFS-3G, making it incompatible with it for no reason
>>
>> This series of patches tries to fix those problems.
> 
> While you are fixing this can you also make patch to add documentation
> for this mount option. I also think we really should not make new mount
> option names so I would vote hide_dot_files name as you did. We still have
> time for this change as this is not yet in upstream.
> 

I have submitted a v2 of the patch which includes a commit with the
documentation.

>> Daniel Pinto (4):
>>   fs/ntfs3: fix hidedotfiles mount option by reversing behaviour
>>   fs/ntfs3: make hidedotfiles mount option work when renaming files
>>   fs/ntfs3: add hidedotfiles to the list of enabled mount options
>>   fs/ntfs3: rename hidedotfiles mount option to hide_dot_files
>>
>>  fs/ntfs3/frecord.c | 9 +++++++++
>>  fs/ntfs3/inode.c   | 2 +-
>>  fs/ntfs3/super.c   | 6 ++++--
>>  3 files changed, 14 insertions(+), 3 deletions(-)
>>
> 
