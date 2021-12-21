Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F85047BF2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 12:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhLUL5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 06:57:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59184 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhLUL5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:57:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5653D6151F;
        Tue, 21 Dec 2021 11:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AEEC36AE8;
        Tue, 21 Dec 2021 11:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640087821;
        bh=PvJu+glLvFW6CVRQORJ70/y1VPHuZO/5RdoE7KSeqEA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WIqaL56VlkqhcmysbpJSDImKtgjQJKjCpv368f81h5HSmlrr7GjcqQyHBI7KML0gi
         CG4Jz/3aDxoqtSrTMS4Zf+8nI70FRPIsPE02Fk5ZKJp6rkSyB1I9i0WHXkAWV0KK2H
         IOBeioC80b1Q/agSkY1rOY/hrlxsgwxWF5J08PgKVZZquxmbYepDETwvqHmkHg0c6K
         qYoParBLxAwvKpPTjrk4UeLLARlmqrd1uwYeCKqdv7sK8ZrhEWMB8uhfsOHBHF/d/m
         NcK68QMom7DkUfod1hsUINqwWF9qY+rsXwvrhM0+jLWvj0R4wlmlTkFWmxjwJ+mYTj
         mQeeiGdkn9JyA==
Received: by mail-ot1-f46.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so16332924otg.4;
        Tue, 21 Dec 2021 03:57:01 -0800 (PST)
X-Gm-Message-State: AOAM531ntIgpiuwBAAFDewprlH0SNLOe5nd+Howtzy30OlOOPKPGAHX5
        VyzF9dMUNOuAa4uFodrGRMiiQp8Bh7evpeTe83A=
X-Google-Smtp-Source: ABdhPJzMRDrZLqh7fzHJPUTbbLdwboTNC0y/Pf5TgKPKHR/LOeHAvQqQMxdbo1WTLOpd98DQgoWRJ+0ZaBoItYoUa/E=
X-Received: by 2002:a9d:43:: with SMTP id 61mr1896665ota.18.1640087821010;
 Tue, 21 Dec 2021 03:57:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:428a:0:0:0:0:0 with HTTP; Tue, 21 Dec 2021 03:57:00
 -0800 (PST)
In-Reply-To: <HK2PR04MB3891563FC310AE5E70896932817B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB3891563FC310AE5E70896932817B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 21 Dec 2021 20:57:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8i5NgSfQH6T8a7ST3P5nvMqf4VJees=5RjVKWL=vK_3Q@mail.gmail.com>
Message-ID: <CAKYAXd8i5NgSfQH6T8a7ST3P5nvMqf4VJees=5RjVKWL=vK_3Q@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix missing REQ_SYNC in exfat_update_bhs()
To:     Yuezhang.Mo@sony.com
Cc:     sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-12-20 10:52 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> If 'dirsync' is enabled, all directory updates within the
> filesystem should be done synchronously. exfat_update_bh()
> does as this, but exfat_update_bhs() does not.
>
> Signed-off-by: Yuezhang.Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy.Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama, Wataru <wataru.aoyama@sony.com>
> Reviewed-by: Kobayashi, Kento <Kento.A.Kobayashi@sony.com>
Applied, Thanks for your patch.
