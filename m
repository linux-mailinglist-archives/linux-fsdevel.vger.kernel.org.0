Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2B16EEAF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 01:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjDYX0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 19:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjDYX0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 19:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD59B23E;
        Tue, 25 Apr 2023 16:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB94862B2B;
        Tue, 25 Apr 2023 23:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CCFC433EF;
        Tue, 25 Apr 2023 23:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682465175;
        bh=kg/GDcaxGtedEdK/31xsULRKjGbkE/fA/VSjba8K0qg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZSr4NO32T0z7QuauArYo01VjtsujMYeOIO/gUxMH/0LnSi6INuywSfr0B7HwskG/T
         zCZt92cGJjuiPgXA5e4z2UfjrMl9w7fHH59IQRrVmETm2ohY3P4ReMKNXNjAGt9rmj
         I3vgZx1TT1OFLNdadSa18mZ/5Pr9QpT7VzeT9Khql0JPdUNxun/s6pABuaCATrGPIJ
         a+Xl3X5sMu29Uy8mShdHI84rfCLpi42yK8//6DDdVVVAKaIz6qgNsfS4y0N09vYImJ
         s9taSbh8WLO8ZfKK7Ar5Js2o/1TEXfufUAv+RTwCtRX0dg32KiSBre5VOQzPzKtw9W
         K/++rM6c9enjg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-38e7ce73ca0so3531942b6e.2;
        Tue, 25 Apr 2023 16:26:15 -0700 (PDT)
X-Gm-Message-State: AAQBX9c9r7lFee37AlCZcwujRwZ0M9GZoBRmsh3Z/Xi6Dzgb7GhorkRG
        iSj5/Hb1nZnURkVO7R3bCW/4JBAT5IXBtssSOVA=
X-Google-Smtp-Source: AKy350ap7BF8JmpHTOc3QTKJbb27R9E8hHFS1IMx/4qyXR3VnVMJ4/DbRHRfMvZ6tISdDt+ypSAvPwZeK5+bz0LivhM=
X-Received: by 2002:a05:6808:2005:b0:38e:2cca:12d8 with SMTP id
 q5-20020a056808200500b0038e2cca12d8mr11114900oiw.14.1682465174321; Tue, 25
 Apr 2023 16:26:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5a51:0:b0:4d3:d9bf:b562 with HTTP; Tue, 25 Apr 2023
 16:26:13 -0700 (PDT)
In-Reply-To: <20230425193226.37544-1-frank.li@vivo.com>
References: <20230405084635.74680-1-frank.li@vivo.com> <20230425193226.37544-1-frank.li@vivo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 26 Apr 2023 08:26:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-wC6vUNkABTJYxux8jOW78cKJPZNJQcZ2Dd_fbHOA7Mw@mail.gmail.com>
Message-ID: <CAKYAXd-wC6vUNkABTJYxux8jOW78cKJPZNJQcZ2Dd_fbHOA7Mw@mail.gmail.com>
Subject: Re: [PATCH] exfat: add sysfs interface
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-04-26 4:32 GMT+09:00, Yangtao Li <frank.li@vivo.com>:
> ping.....
There is no explanation as to why this parameter is needed.
>
> Thx,
> Yangtao
>
