Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31603792500
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjIEQAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbjIEDXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:23:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B01CC6
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 20:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E7ABB81084
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 03:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2478C433CA
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 03:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693884192;
        bh=wyhGCdHNnsIOSH/0juopa12g3QWnsWxZJ3JsbKlciZ0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=al4enE3Wuzl5o5V7hzU8TD1CtDhRmQA+qnWjiSrNRi8KfFhqL4VRD+j6StYG6oa0l
         GJnT68xmNP4rUDEvzSsUxRLbxeF+FFeQFwEUX88V9hOBksO+prM48hiQ9Jb+ByC8K8
         91uBAWCuGQsHt8u8qgBz0IWsZ5VwzOC8Y9/NY7GbyrW66NHZoWmVh48uo25K5qOD6x
         KDrz6ECfVK6kfPu7K12LK4ybqzLBxIpalP5RmSFcr89udMNDD6Is7vefu+fiEU6VBx
         yvg+Mtv0PGKhKhJ5keKv7GaXPrOZLwlQBJZB3ISfa8yLfCHkdd2fBxUtNv5YMVIZeo
         rBlOLmxvn6WZA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1cc61f514baso1091057fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 20:23:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YxtLpmKET2gYIbwoRb6vXFcbPGWX7ssnlpUQZsmGmnhhbts+aLX
        4HINpAWFcnAm7wXj/lzXsx8SCJzYZKrbO5Ku9PU=
X-Google-Smtp-Source: AGHT+IH1fqr+CXFaLe1o/EnVOo+XI4+f8ETfAuJVF82HC4pc4/DklMaQLy7MMFuHnpWwxGPVjeWOg+rUSrTP0PkA25k=
X-Received: by 2002:a05:6870:6587:b0:1bb:8cc2:8c3e with SMTP id
 fp7-20020a056870658700b001bb8cc28c3emr13072538oab.15.1693884191963; Mon, 04
 Sep 2023 20:23:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:298:0:b0:4f6:2c4a:5156 with HTTP; Mon, 4 Sep 2023
 20:23:10 -0700 (PDT)
In-Reply-To: <PUZPR04MB6316F8ABA8D791886D45435C81E7A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316F8ABA8D791886D45435C81E7A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 5 Sep 2023 12:23:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_4s-dW2gT7dX2=rYedXrMRaw4y3JEzomgKqhgwhWQkNA@mail.gmail.com>
Message-ID: <CAKYAXd_4s-dW2gT7dX2=rYedXrMRaw4y3JEzomgKqhgwhWQkNA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] exfat: support zero-size directory
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

2023-08-29 13:50 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> Yuezhang Mo (2):
>   exfat: support handle zero-size directory
>   exfat: support create zero-size directory
>
>  fs/exfat/dir.c      | 12 ++++++------
>  fs/exfat/exfat_fs.h |  2 ++
>  fs/exfat/namei.c    | 36 +++++++++++++++++++++++++++---------
>  fs/exfat/super.c    |  7 +++++++
>  4 files changed, 42 insertions(+), 15 deletions(-)
Applied them to #dev branch, Thanks for your patch!
>
> --
> 2.25.1
>
