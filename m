Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2150464B439
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiLML3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 06:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiLML3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:29:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB19167F3;
        Tue, 13 Dec 2022 03:29:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 698B2B81180;
        Tue, 13 Dec 2022 11:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4EFC433D2;
        Tue, 13 Dec 2022 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670930974;
        bh=qcFwa0Z+MZhDxAOTfhUcmqeVk7pGBVKWCDqcR1ISkyI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=JtmQbVHTgeIZpM4n6lzNmmIdruFQYs+964BH7USfAIoVMXjwEiV4QQngoc7cyjv3l
         wcYueHXPnXPQFZUAmYhuFUT8Vi1XdGQKBCoKNrp9i/FY5nDwpn6jHlVqw90GOUsQxD
         tomQTTkxzJTuR0GPvKAOWnZVG6q+qgCr/SBHagfF+oQNouAPOH5wA9b/faTeIUNjdr
         NqrhHFOeOpPOkT85Ej2CpBCMSbtDNiw6RmtE03ZIH5zVpdseefqvGLnz4G68ORPQ41
         J3twkbhsEcy1I2ydHqUzTPjWr/ph7RdtevOyo2bxM+jj1Aco+EU5i+dOfEd22qiMYC
         oUIfdihfszHPw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1441d7d40c6so12122758fac.8;
        Tue, 13 Dec 2022 03:29:34 -0800 (PST)
X-Gm-Message-State: ANoB5pkH4XUT8BzTbuzyBwifOiJyqsRMh9CjiDHFACZnJyMWvtenH1h1
        l2PMfKeMbe1oedU41pK/1303/fqznWJOmh/vzd0=
X-Google-Smtp-Source: AA0mqf5b7gsunJYTFCQBbNlA4HCwX3Arb7VZ5T3lNAv67HXfMeH3V0YgiWj1HO6mOZqbGKTs7Sq4UbMRwWvb/mxxme8=
X-Received: by 2002:a05:6870:b13:b0:141:828c:12b5 with SMTP id
 lh19-20020a0568700b1300b00141828c12b5mr227053oab.8.1670930973271; Tue, 13 Dec
 2022 03:29:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Tue, 13 Dec 2022 03:29:32
 -0800 (PST)
In-Reply-To: <PUZPR04MB6316B3802565F2A09DD0D47A81E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316B3802565F2A09DD0D47A81E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 13 Dec 2022 20:29:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8D=VMrRunbdEhoDhMD_UDeOYwPe9axcp-imH4DMM92-Q@mail.gmail.com>
Message-ID: <CAKYAXd8D=VMrRunbdEhoDhMD_UDeOYwPe9axcp-imH4DMM92-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] exfat: code optimizations
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

2022-12-13 11:36 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> This patchset is some minor code optimizations, no functional changes.
Applied, Thanks for your patches!
>
> Changes for v2:
>   - [6/7] [7/7] Fix return value type of exfat_sector_to_cluster()
>
> Yuezhang Mo (7):
>   exfat: remove call ilog2() from exfat_readdir()
>   exfat: remove unneeded codes from __exfat_rename()
>   exfat: remove unnecessary arguments from exfat_find_dir_entry()
>   exfat: remove argument 'size' from exfat_truncate()
>   exfat: remove i_size_write() from __exfat_truncate()
>   exfat: fix overflow in sector and cluster conversion
>   exfat: reuse exfat_find_location() to simplify exfat_get_dentry_set()
>
>  fs/exfat/dir.c      | 38 +++++++++++++++-----------------------
>  fs/exfat/exfat_fs.h | 19 ++++++++++++-------
>  fs/exfat/file.c     | 12 +++++-------
>  fs/exfat/inode.c    |  4 ++--
>  fs/exfat/namei.c    | 19 +++----------------
>  5 files changed, 37 insertions(+), 55 deletions(-)
>
> --
> 2.25.1
>
