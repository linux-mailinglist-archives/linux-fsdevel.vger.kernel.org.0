Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1277E6A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 18:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbjHPQkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245029AbjHPQkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:40:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038FBE4C;
        Wed, 16 Aug 2023 09:40:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bba48b0bd2so45618035ad.3;
        Wed, 16 Aug 2023 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692204018; x=1692808818;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpXtmiRdtXtrnVuj+yOd5/ldcPOOd3KtSDr9PtSjjpQ=;
        b=NHB1Kirnobegb/kcu1DT8SxfH2r9i3kA/FMl1eEpCEgUxQUt6tXQ3PTBnk/DbE0h/y
         k/ZNiyyMfYKu5iTilr1EU8FSbFxzeU5OfyatpKMQwc1kSUSXGYbHbYx0U1PpF5fF1Vkc
         CubvRnJIP7rkjbLGISOReUrbh5/24BRmOnjQNTpW4K9VCRo4oVsxdN2PRcWxPg8Wpi3U
         luAJ2/VSvnKT4I5hKRjI5GH0zodIBP7J5AWrsZbP5+cHlplgMaUD7kJ6chqyhmVotlLF
         ofNmHf7tQks0vnVFDJdObvsqj09zODg9xZzzVXc8MY6muLp5Re/Oe41w8j/lQlJWOP+W
         CvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204018; x=1692808818;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lpXtmiRdtXtrnVuj+yOd5/ldcPOOd3KtSDr9PtSjjpQ=;
        b=JyaILBQD35uITBT9OUCvU3sv2DGsNCviB4SjzIb3fohMElbwoe/G4t+W6BBSj7fmGk
         2dZ6TTy/bmf8B1MSR+Zu+vlJi71OavQTotcYHwJmVG/Do/2E1FjoYD4yU+Gh+raQh2OL
         fB0AfZw3VV6nh3yXg6m4vHoPxm8IF79ypN5xU+QOq6k7V7b0+Osc/RFaoMw0w1aaE3iI
         AdloyUWK0aoQUDzXx3/irCak9j+bBG5Lrd4gr40TGQlFTXMCfE4dLn8Jn9sdRA43Z4FY
         l//NyCn6Y7yfvNnAkDsqxcCgDDqkg3rCb0fO9boOH4XqEpRKMnkcqsmtPiDkPMcLkEJf
         nEUg==
X-Gm-Message-State: AOJu0Yw1+i4oeYi1D9nPAcvxzo0dCWeatgvrHTeFjyj0lw6tfpIZ7o98
        xMbqmnDMET5+y6GETbcQuaQ=
X-Google-Smtp-Source: AGHT+IFgmpqQTjnDicZXCXdWpUiVCZFVQJb0ZW+wO3g3PcrODJcTxoXS67BKCpC9Y/ka1nbYpEwtbQ==
X-Received: by 2002:a17:902:ef89:b0:1bb:25bd:d09c with SMTP id iz9-20020a170902ef8900b001bb25bdd09cmr2188237plb.1.1692204018320;
        Wed, 16 Aug 2023 09:40:18 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902789800b001b8b1f6619asm13375124pll.75.2023.08.16.09.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:40:17 -0700 (PDT)
Message-ID: <a1c9e590-2d42-23bc-bdf7-3f3c784284b5@gmail.com>
Date:   Wed, 16 Aug 2023 22:10:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
From:   Manas Ghandat <ghandatmanas@gmail.com>
Subject: [PATCH 0/1 ] fs: Warming in __brelse
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I was working on the following syzbot bug:

https://syzkaller.appspot.com/bug?extid=ce3af36144a13b018cc7

Upon debugging I found that in this case the buffer_head is having count 
0 and then when __brelse is called it tries to free it. A simple 
solution to this problem would be to remove the warn call. SInce in any 
case the buffers only get freed if the count is present and consequently 
the pointers are also set to null. Additionally we could add a check in 
the has_bh_in_lru to also consider the counter.

Link : 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/buffer.c?id=d192f5382581d972c4ae1b4d72e0b59b34cadeb9#n1509

