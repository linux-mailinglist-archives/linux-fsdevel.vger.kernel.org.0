Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891DF620ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 09:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiKHIA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 03:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiKHIA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:00:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4557266C;
        Tue,  8 Nov 2022 00:00:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BFB6DCE182D;
        Tue,  8 Nov 2022 08:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0896C433D7;
        Tue,  8 Nov 2022 08:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667894450;
        bh=WS7VySlUdeH9Vo/Jrl2Tr9JnjBxYq5+stEtO8WAKYbc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=DHpRakWEwcdzJQp3GYA+jzD/U477wP8wgEiCqZ1wsHF2PymZcIUJGvMISuRGCbKUZ
         42SbwdqMyNYRv6YjYxJCCoCo3gR+0k16GT/6Ag5RE+wrW0/z9xy+X/p+YV5bLoy/Yu
         l4ROWhjmQ5m1YXofNrcqKeegcFy4lHf4YQqEWnO+4ZLJJ4L2YscxtJ3jKr5skIS8Lf
         wQtfKHslzs+YT0YvATfk/8qJvvU0Su6Jl6XMcys/WFHC4pvGKctGj22vASm+eHbxQN
         LiXydSiNy8xiJo+J73/tPfDzHSdv40gQ/6sAQSKyJznvsblAjm/ariz7bZxXkQn+Es
         TNUvDWzeFpMIw==
Received: by mail-oi1-f174.google.com with SMTP id l127so14754683oia.8;
        Tue, 08 Nov 2022 00:00:50 -0800 (PST)
X-Gm-Message-State: ACrzQf1Dlza+Hjws2iA8T3MoBwPZep6xuLpxeN+te5i98Q6t9DC83JP+
        RqptuFOTTOJK/jl6Ad38faqjgNuv5p8rEWO/Xn8=
X-Google-Smtp-Source: AMsMyM6TF6dbu46z3WDE6URZqLxsjb5VejW3FvBICzcB4QNM/eouppBvOnZ7fjDdFevaBfbRuAtji1BmSYElQSb0qbY=
X-Received: by 2002:a54:4789:0:b0:359:f549:99ff with SMTP id
 o9-20020a544789000000b00359f54999ffmr28015428oic.257.1667894449963; Tue, 08
 Nov 2022 00:00:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Tue, 8 Nov 2022 00:00:49
 -0800 (PST)
In-Reply-To: <PUZPR04MB6316A41FC40A84059E60BAB481399@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316A41FC40A84059E60BAB481399@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 8 Nov 2022 17:00:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9JjNKvLKzFJKaZs5FOAVrL4dzsnzUC=JHYEn1j8jdZDw@mail.gmail.com>
Message-ID: <CAKYAXd9JjNKvLKzFJKaZs5FOAVrL4dzsnzUC=JHYEn1j8jdZDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] exfat: hint the empty entry which at the end of
 cluster chain
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-11-02 16:11 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> After traversing all directory entries, hint the empty directory
> entry no matter whether or not there are enough empty directory
> entries.
>
> After this commit, hint the empty directory entries like this:
>
> 1. Hint the deleted directory entries if enough;
> 2. Hint the deleted and unused directory entries which at the
>    end of the cluster chain no matter whether enough or not(Add
>    by this commit);
> 3. If no any empty directory entries, hint the empty directory
>    entries in the new cluster(Add by this commit).
>
> This avoids repeated traversal of directory entries, reduces CPU
> usage, and improves the performance of creating files and
> directories(especially on low-performance CPUs).
>
> Test create 5000 files in a class 4 SD card on imx6q-sabrelite
> with:
>
> for ((i=0;i<5;i++)); do
>    sync
>    time (for ((j=1;j<=1000;j++)); do touch file$((i*1000+j)); done)
> done
>
> The more files, the more performance improvements.
>
>             Before   After    Improvement
>    1~1000   25.360s  22.168s  14.40%
> 1001~2000   38.242s  28.72ss  33.15%
> 2001~3000   49.134s  35.037s  40.23%
> 3001~4000   62.042s  41.624s  49.05%
> 4001~5000   73.629s  46.772s  57.42%
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Applied. Thanks for your patch!
