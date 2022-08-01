Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634A586662
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiHAIcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiHAIcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:32:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C7426D6
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 01:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02D82B80E87
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 08:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E59C433D7
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 08:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659342720;
        bh=73vMDWSV5Z9d/qgY60SyUX0RRFbosfWh2QN3Uh4s+IY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=n24e33PnPkiHPXrRSfFfIc6y889AMmVU8MORV7+CEnCjM2Ytw9OmJaWX3L3ubK1tC
         NLb3xduQA494cqGxeU+KJjb9YD/AblmYmjNqGWLvs8FoHgHwbdAcKV9MtgdP3uAuT8
         6Q6Usi+GhbDaQhKYL6m2Kdm7vyr9ecGdZUaNHPcqpzsptwJeexEFxqHV5jOChWXUPV
         o/fGH6wIk9dBBVArjg9aOGrVO3d4A9JW3HlAwwr8QmFD/mEz3Kb5lkg/CjE4airm/b
         lW1csYnytuy6PqObD+3xynv9xzqm4aMIj+73AnPTwOujHFJGMOnMq8AyDDsq8bKhZ/
         4fBU1fb2D5+mQ==
Received: by mail-oi1-f178.google.com with SMTP id r13so12347319oie.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 01:32:00 -0700 (PDT)
X-Gm-Message-State: AJIora8B7KgVjasbnNGD84LXKHDR9zv9nqQL0SLMm6GwDUIVnKtiYbqq
        0XRiH8IQYEkWrq/+ukS/L1DXrsdzJt9vAo/ulsw=
X-Google-Smtp-Source: AGRyM1sPsDAmxcnPemXuL5syt2H9U+OiY7s7Sa8Qdr8rMiVVhWNmL59as0ADnPv5cWVt6M7vKRaiQkbR4NryL/6U744=
X-Received: by 2002:a05:6808:13c5:b0:33a:ff74:bf11 with SMTP id
 d5-20020a05680813c500b0033aff74bf11mr6088327oiw.257.1659342719992; Mon, 01
 Aug 2022 01:31:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6839:41a4:0:0:0:0 with HTTP; Mon, 1 Aug 2022 01:31:59
 -0700 (PDT)
In-Reply-To: <20220731162427.16362-1-pvorel@suse.cz>
References: <20220731162427.16362-1-pvorel@suse.cz>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 1 Aug 2022 17:31:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_1XG+9sDnXd89UuZ7UypbqkqN2ETqpqCNG7zQy628jHQ@mail.gmail.com>
Message-ID: <CAKYAXd_1XG+9sDnXd89UuZ7UypbqkqN2ETqpqCNG7zQy628jHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add Namjae's exfat git tree
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Petr Vorel <petr.vorel@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-08-01 1:24 GMT+09:00, Petr Vorel <pvorel@suse.cz>:
> From: Petr Vorel <petr.vorel@gmail.com>
>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Applied, Thanks for your work!
