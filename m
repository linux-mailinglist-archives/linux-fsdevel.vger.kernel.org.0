Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA26A38F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 03:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjB0Cnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 21:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjB0CnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:43:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9F5AD0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 18:43:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF39E60CF7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 02:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571DBC43443
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 02:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677465770;
        bh=okDk3OnhUbMub4Qy+aNHwjzFuxr4m5wmTAvIMld9FhM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ueh1ZSOPwHoSx/tK5NBhqmgYrfiwqf95vPCyRQfDCLTsJd5KTx6GMFoxSEpv6LfSR
         zM5eUT29F3wB/8kyperxgn3PylJy53DBvfIbrCgXn1+UXZ4RV8xJsGJudE03d9fERb
         jV7hABj6rzXTnTU/lXSXMI1LyQdnlPwVGDbzgQ1Fty5xbMMsK3nAtmWdReGTmUlVYk
         o084TzrYcposFBz0G11BgdwPIOlKCeXRBGGpdsfkWRDDRX/0FXq72/5SXcvwY22SpX
         88dJwibsNwQuxt7VYR2nocK2HO4vx83YFoXwB7bTIaDNnJt3XH1+mvmYofyLQEmqYS
         kmTZw/P15cx6A==
Received: by mail-ot1-f43.google.com with SMTP id v1-20020a9d6041000000b0068d4a8a8d2dso2802668otj.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 18:42:50 -0800 (PST)
X-Gm-Message-State: AO0yUKVJrvsPfUrR6iV4+/3O7XlFd+2SLMiI/MxW5RiVvz5qXACkxBqU
        5o54UYyHTHuu21yDI2a4jXuggbNgAERfz6NUTz4=
X-Google-Smtp-Source: AK7set9iDmir80/ulO/QemG8VGtTBlC9xKWCVvfIclKa5yV6WvpXfGt5ROVbwXHd/9HKBar1DgZDtvleTPWeTjVzHro=
X-Received: by 2002:a05:6830:3083:b0:68d:bb30:1cfb with SMTP id
 g3-20020a056830308300b0068dbb301cfbmr4036494ots.7.1677465769450; Sun, 26 Feb
 2023 18:42:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:67ca:0:b0:4c2:5d59:8c51 with HTTP; Sun, 26 Feb 2023
 18:42:48 -0800 (PST)
In-Reply-To: <TYAPR04MB2272FCA531495222A6BAFAF980AF9@TYAPR04MB2272.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316E45B7AB55F18F472503481A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd-PV1o5-npdx7GNnj2ffMNjus5tbuQYtUbfzJHdaDuQ+w@mail.gmail.com> <TYAPR04MB2272FCA531495222A6BAFAF980AF9@TYAPR04MB2272.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 27 Feb 2023 11:42:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-PSRQZB8vcqB1CB-EOGE6fjgU96=rXas04bKUHC0WBbA@mail.gmail.com>
Message-ID: <CAKYAXd-PSRQZB8vcqB1CB-EOGE6fjgU96=rXas04bKUHC0WBbA@mail.gmail.com>
Subject: Re: [PATCH 2/3] exfat: don't print error log in normal case
To:     "Andy.Wu@sony.com" <Andy.Wu@sony.com>
Cc:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
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

2023-02-27 11:20 GMT+09:00, Andy.Wu@sony.com <Andy.Wu@sony.com>:
> Hi Namjae:
Hi Andy,
>
>> > +	if (hint_clu == sbi->num_clusters) {
>> >  		hint_clu = EXFAT_FIRST_CLUSTER;
>> >  		p_chain->flags = ALLOC_FAT_CHAIN;
>> >  	}
> This is normal case, so let exfat rewind to the first cluster.
>
>> > +	/* check cluster validation */
>> > +	if (!is_valid_cluster(sbi, hint_clu)) {
>> > +		exfat_err(sb, "hint_cluster is invalid (%u)", hint_clu);
>> > +		ret = -EIO;
>> There is no problem with allocation when invalid hint clu.
>> It is right to handle it as before instead returning -EIO.
> We think all other case are real error case, so, error print and return
> EIO.
Why ?

> May I confirm is there any normal case in here?
Could you please explain more ? I can't understand what you are saying.
>
> Best Regards
> Andy Wu
>
>
