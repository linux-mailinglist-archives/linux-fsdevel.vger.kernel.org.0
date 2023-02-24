Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E685E6A1D31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 15:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBXOFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 09:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBXOFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:05:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15E56510
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 06:04:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB258618E8
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 14:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34095C433D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677247495;
        bh=seP5xxJbE3CXlmNxeb3saP7qbwjJaMrdZp53k/MJh4o=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QL6TC2GuXLvSJSOfptqkZAvucqG7C2L5fLId/dMsHa/57xnp52Nu5kX4L/qJ5l9kA
         4od4Sha1WJEchxk7xsvP9VDGAKLwfz9IHMe3nbkbj4wMj0qAcF8g0xjTrk4Hmmd0s4
         ReXF8QAtRLtRqFFwfbtgDGGaCJ2tyFHnkw6RMf6qxeZbMbetpdvNmocZy+6QmRYOKG
         RR5oXvp07tXp3vJhNAWSUQytnYe/5Ql3sftJrLRhhxJDcPsm+N7mI7H4Kno5CSFbVb
         94q6TP9/nRFmFchp9MXhOuMwYJ2EGjaZP8R/qoAzQaFK6/3difSbN9Az7Mlra8snK2
         kHd+FxQd/Mytg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-17227cba608so16996375fac.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 06:04:55 -0800 (PST)
X-Gm-Message-State: AO0yUKWc0M1Wz+qaLh0+p4azHJcdrAmTw1LbhYFv24a6va/wHD/tD8Q6
        yZ88EAh7IfwLdX15lQOqu4otQInDWSdrdOfvsZo=
X-Google-Smtp-Source: AK7set9+NKZR2gl5W+mIIkJiSW/aAEsCv5diKhrAZitYm4DU85Y8I1QWDID0dAOMMOgjuSKQ0zy5tLRluwxHF4hdy5I=
X-Received: by 2002:a05:6870:5a99:b0:172:59d4:26dd with SMTP id
 dt25-20020a0568705a9900b0017259d426ddmr893371oab.11.1677247494290; Fri, 24
 Feb 2023 06:04:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:355:0:b0:4a5:1048:434b with HTTP; Fri, 24 Feb 2023
 06:04:53 -0800 (PST)
In-Reply-To: <PUZPR04MB6316E45B7AB55F18F472503481A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316E45B7AB55F18F472503481A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 24 Feb 2023 23:04:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-PV1o5-npdx7GNnj2ffMNjus5tbuQYtUbfzJHdaDuQ+w@mail.gmail.com>
Message-ID: <CAKYAXd-PV1o5-npdx7GNnj2ffMNjus5tbuQYtUbfzJHdaDuQ+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] exfat: don't print error log in normal case
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-02-21 16:34 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> When allocating a new cluster, exFAT first allocates from the
> next cluster of the last cluster of the file. If the last cluster
> of the file is the last cluster of the volume, allocate from the
> first cluster. This is a normal case, but the following error log
> will be printed. It makes users confused, so this commit removes
> the error log.
>
> [1960905.181545] exFAT-fs (sdb1): hint_cluster is invalid (262130)
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> ---
>  fs/exfat/fatent.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
> index 65a8c9fb072c..b4ca533acaa9 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -342,14 +342,18 @@ int exfat_alloc_cluster(struct inode *inode, unsigned
> int num_alloc,
>  		}
>  	}
>
> -	/* check cluster validation */
> -	if (!is_valid_cluster(sbi, hint_clu)) {
> -		exfat_err(sb, "hint_cluster is invalid (%u)",
> -			hint_clu);
> +	if (hint_clu == sbi->num_clusters) {
>  		hint_clu = EXFAT_FIRST_CLUSTER;
>  		p_chain->flags = ALLOC_FAT_CHAIN;
>  	}
>
> +	/* check cluster validation */
> +	if (!is_valid_cluster(sbi, hint_clu)) {
> +		exfat_err(sb, "hint_cluster is invalid (%u)", hint_clu);
> +		ret = -EIO;
There is no problem with allocation when invalid hint clu.
It is right to handle it as before instead returning -EIO.
In other words, after change exfat_err() to exfat_warn(),
It would be better to update print to avoid misunderstanding.
i.e. it will rewind to the first cluster rather than simply hint clu
invalid.

Thanks.
> +		goto unlock;
> +	}
> +
>  	p_chain->dir = EXFAT_EOF_CLUSTER;
>
>  	while ((new_clu = exfat_find_free_bitmap(sb, hint_clu)) !=
> --
> 2.25.1
>
>
