Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC6773979A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 08:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjFVGrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 02:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFVGrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5E3B4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 23:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F40AC6175A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 06:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57892C433C9
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 06:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687416464;
        bh=qJS7ojEm2l696WrlNKlBfecZk912Hrb0gjYA6GBL2t4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=RXS7zHmFc64M2iIc8sR2jIL2zhjEuqZ5l4H3q/gnWGol2WSVh50bHiUtoYuI0ED6V
         Kxby6QzBCfTtlRnOsicmb+WK2z/3+NC9QgRZ8uDgFCmzzl5GsrMhcYijQXri1pwYeH
         tbCLj122yVf0eBLmKLhVCQzjovh7R56noHNbc/lwgVEq3f7/iKTEPesIjMF4WtrTDN
         tPdU82XVCDqihkStHOWoiU0xevR4eucb0XnYkzIQh6jhXv3Y4v8ZVxh1IPjSteyTZ4
         WTlUQd1Y6f0hFP52fkVKHKIO1976G4Hd1f70X4yxmd1Znnt+Ji7RPnaNIHBInSgww4
         M3F1bV2phF5kg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1aa0d354a8aso4278558fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 23:47:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDzNEhIuHkUKWHkBqCAfpJLxlP5Ubco5POPHER5iiPKe8c24iGig
        kZHOYNweeRVie+xprHmsKtrO2BbTHpIQ1Sf3BVo=
X-Google-Smtp-Source: ACHHUZ4fbeJKZutjY4dv+INsg13KdNOlBIhGpbkng6ZfUHuq2feW5/W4EnOKw0vlINoLUmrsAHsSsqN9u/bm9DqL66U=
X-Received: by 2002:a05:6870:e14a:b0:1ad:2fd4:7e8 with SMTP id
 z10-20020a056870e14a00b001ad2fd407e8mr1204430oaa.29.1687416463502; Wed, 21
 Jun 2023 23:47:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5e18:0:b0:4df:6fd3:a469 with HTTP; Wed, 21 Jun 2023
 23:47:43 -0700 (PDT)
In-Reply-To: <PUZPR04MB6316DB8A8CB6107D56716EBC815BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316DB8A8CB6107D56716EBC815BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 22 Jun 2023 15:47:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9ubktMNDdXPBDjRyUeGARMjMR5Hq+vwwCUbhwUmNURtQ@mail.gmail.com>
Message-ID: <CAKYAXd9ubktMNDdXPBDjRyUeGARMjMR5Hq+vwwCUbhwUmNURtQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] exfat: get file size from DataLength
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-06-15 12:29 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> From the exFAT specification, the file size should get from 'DataLength'
> of Stream Extension Directory Entry, not 'ValidDataLength'.
>
> Without this patch set, 'DataLength' is always same with 'ValidDataLength'
> and get file size from 'ValidDataLength'. But if the file is created by
> other
> exFAT implementation and 'DataLength' is different from 'ValidDataLength',
> this exFAT implementation will not be compatible.
>
> Yuezhang Mo (2):
>   exfat: change to get file size from DataLength
>   exfat: do not zeroed the extended part
Hi Yuezhang,

First, Thank you so much for your work.
Have you ever run xfstests against exfat included this changes ?

Thanks!

>
>  fs/exfat/exfat_fs.h |   2 +
>  fs/exfat/file.c     | 212 +++++++++++++++++++++++++++++++++++++++++++-
>  fs/exfat/inode.c    | 108 +++++++++++++++++++---
>  fs/exfat/namei.c    |   7 +-
>  4 files changed, 310 insertions(+), 19 deletions(-)
>
