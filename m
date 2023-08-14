Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2592577B08B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 06:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjHNEk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 00:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjHNEjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D02E7E
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 21:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F52662646
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 04:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F602C433C9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 04:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691987971;
        bh=RJ1CY3In1NqrGm9UFeM1VBq/tSbnFk85gEcjHpM3u5k=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=kjexzDa1nheSfsw2Hvns5K1KyCRhDdhmEbpD5X1DmOK71CCmphUIOI8b3SpzLwfG6
         Zozi7IQRLeEd+BoPRLcHS95syqBYLkRH2Gs6VOhI4XwpHb/351+XJ+w4CwFP6zIqPD
         qeQr6pnIBj707X/RoIWlNrCDQZn/T9LCv0GHoowTcSm/kqXhrklf6ZeOU6Mg37iNJE
         YOC8jqx9zv2uPRi4TfRuK6xBV6ui73MEBZUAolPclMOYeqonJtDTSyROdofFKi9E5E
         0FvMhK9XWmZXKzYNpsd649Z/Em5q9guBGWuDVHZ+QiI0nfOMRAw+UdvVG81pPj226S
         u9j6iD6m7SKAw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56d0f4180bbso3015212eaf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 21:39:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YxBH8L7RBPJLrmRx1Rzi6hmJCMilklI7QXKlnOaT9w7l3if9TDX
        VhExG3rZOifDJ+QkhVgGcWWLHeItMPu2m73k5ME=
X-Google-Smtp-Source: AGHT+IEr89rAgMfSwQvtPaZTu7Oy5wMNpeifXTnjCtespicSZqHs4CtZVF+m/dBKf/TTySs12ILyLnK8cWfCfVvNX9M=
X-Received: by 2002:a4a:3c04:0:b0:566:ed69:422d with SMTP id
 d4-20020a4a3c04000000b00566ed69422dmr7191169ooa.7.1691987970717; Sun, 13 Aug
 2023 21:39:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:14c:0:b0:4e8:f6ff:2aab with HTTP; Sun, 13 Aug 2023
 21:39:29 -0700 (PDT)
In-Reply-To: <PUZPR04MB6316007DA330B551F70F08598124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316007DA330B551F70F08598124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 14 Aug 2023 13:39:29 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-bsJYyUi-57_SZbKsZOFwAxLE_qZT2mijj2=NX5ui82w@mail.gmail.com>
Message-ID: <CAKYAXd-bsJYyUi-57_SZbKsZOFwAxLE_qZT2mijj2=NX5ui82w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] exfat: do not zeroed the extended part
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[snip]
> +static int exfat_cont_expand(struct inode *inode, loff_t size)
> +{
> +	if (mapping_writably_mapped(inode->i_mapping))
Could you elaborate why mapping_writably_mapped is used here instead
of comparing new size and old size ?

Thanks.
> +		return exfat_expand_and_zero(inode, size);
> +
> +	return exfat_expand(inode, size);
> +}
> +
>  static bool exfat_allow_set_time(struct exfat_sb_info *sbi, struct inode
> *inode)
>  {
>  	mode_t allow_utime = sbi->options.allow_utime;
> --
> 2.25.1
>
>
