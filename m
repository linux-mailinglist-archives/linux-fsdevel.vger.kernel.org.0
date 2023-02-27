Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28896A3BB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 08:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjB0Hc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 02:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Hc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:32:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFEE1ABC7
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 23:32:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C9A260C88
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 07:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063CFC433EF
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 07:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677483144;
        bh=FY7f2JcVWkvhD9Ur1O3+uW5KBV+4zUC4d8dlEl7AgX0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eWmiNRknRr8Coy3vneo/3Fa/B+ym6t1R5EAj8OpjpLN7uzpE/J0SZxbRGOOuOesuo
         34rr1PefCSq7MJgSSg9BfGX8dxEc65rcbgGkh8iMyVAFnIb4j6EC/YkJM3YaWE24EZ
         4/M0xJPYF6O5weMaku0zfoFpBrS7IxuRnlLdd+UVorOzl/Kdeb/GG3gwMx6rwO1rZH
         vIZOo69Bon/laqCejaZ+7FPGv22/jmZrFulHIj+1fagsxWavvxWjwUYt54H45Imyur
         DT+DChbqEjECtwofuLg2FTA3xj4FcQbMJ3vuEg/YcDAwbnpPh0iV7kavb1fGCw9wst
         ZLjlyafi5LGWQ==
Received: by mail-oi1-f171.google.com with SMTP id s41so3678206oiw.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 23:32:23 -0800 (PST)
X-Gm-Message-State: AO0yUKVp0q1ifw/OlGoqoVFMp5EeIQZqYjiwnCVrEP3W16Pdu/PWr80z
        2V+vwwhc0ZtOQeEGpdHWgbFgoVvofZW1cr0kPuU=
X-Google-Smtp-Source: AK7set+ppsgmClf3gSqLkIlXDlrufckMvQWg3D1m6B6P/WjsKPG7EoXyYX2waA4QZXXmYAhELNtyeHzcfHbb1ig+pgk=
X-Received: by 2002:a05:6808:118:b0:384:33df:4dfc with SMTP id
 b24-20020a056808011800b0038433df4dfcmr561927oie.11.1677483143131; Sun, 26 Feb
 2023 23:32:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:67ca:0:b0:4c2:5d59:8c51 with HTTP; Sun, 26 Feb 2023
 23:32:22 -0800 (PST)
In-Reply-To: <PUZPR04MB63165E432B3DC7B119AB91D181AF9@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316E45B7AB55F18F472503481A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd-PV1o5-npdx7GNnj2ffMNjus5tbuQYtUbfzJHdaDuQ+w@mail.gmail.com>
 <TYAPR04MB2272FCA531495222A6BAFAF980AF9@TYAPR04MB2272.apcprd04.prod.outlook.com>
 <CAKYAXd-PSRQZB8vcqB1CB-EOGE6fjgU96=rXas04bKUHC0WBbA@mail.gmail.com> <PUZPR04MB63165E432B3DC7B119AB91D181AF9@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 27 Feb 2023 16:32:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-V9QMiLm=sBYDDtjYdXzJh7GGEx=YmcBrMquuVL1_Zzw@mail.gmail.com>
Message-ID: <CAKYAXd-V9QMiLm=sBYDDtjYdXzJh7GGEx=YmcBrMquuVL1_Zzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] exfat: don't print error log in normal case
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
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

2023-02-27 13:07 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> Hi Namjae,
>
>> >
>> >> > +	if (hint_clu == sbi->num_clusters) {
>> >> >  		hint_clu = EXFAT_FIRST_CLUSTER;
>> >> >  		p_chain->flags = ALLOC_FAT_CHAIN;
>> >> >  	}
>> > This is normal case, so let exfat rewind to the first cluster.
>> >
>> >> > +	/* check cluster validation */
>> >> > +	if (!is_valid_cluster(sbi, hint_clu)) {
>> >> > +		exfat_err(sb, "hint_cluster is invalid (%u)", hint_clu);
>> >> > +		ret = -EIO;
>> >> There is no problem with allocation when invalid hint clu.
>> >> It is right to handle it as before instead returning -EIO.
>> > We think all other case are real error case, so, error print and
>> > return EIO.
>> Why ?
>>
>> > May I confirm is there any normal case in here?
>> Could you please explain more ? I can't understand what you are saying.
>> >
>
> `hint_clu` has the following cases.
>
> 1. Create a new cluster chain: `hint_clu == EXFAT_EOF_CLUSTER`
> 2. Append a new cluster to a cluster chain: `hint_clu = last_clu + 1`
>   2.1 ` hint_clu == sbi-> num_clusters`
>   2.2 `EXFAT_FIRST_CLUTER <= hint_clu < sbi-> num_clusters`
>
> This commit splits case 2 to 2.1 and 2.2, and handles case 2.1 before
> calling is_valid_cluster().
> So is_valid_cluster() is always true, even removing the check of
> is_valid_cluster() is fine.
>
> But considering that this check can find bugs in future code updates, we
> keep this check and return -EIO.
> If not returned EIO and continue, bug may not be revealed.
As I said on previous mail, We print warning message for this before
rewinding.  There is absolutely no reason to return an error...
>
