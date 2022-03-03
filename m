Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D0D4CC500
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 19:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiCCSVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 13:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiCCSVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:21:41 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947041A39D5
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 10:20:55 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id bc10so5350296qtb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Mar 2022 10:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lOWE+vv2CjWtv52sjslTIrPdvLmSb134lQ2+RFnBpR4=;
        b=MhTJyU01QczY/LwLvmt7UrfJTjMWAk74YIHpljwbr+nP4WseipiqGLvr/6dRm1EEsI
         kjy5IGnkDBvSOYouoXh0goSyxYLGU7wOhbzL5IPnrhsvI/SMOVRf5YeFuZdoBheFfCGD
         +9Mwymg1Att9JIl/+rO5+9pvcMleOWimuUvN/i5qwPwj7AQ0yvx7GtumaqRC3eG4RDVG
         81FYrYTEumIcSXDf9VWmt1aFD3NxP0QDCDWbctEggl7FMyqdi7wD0bb0taqpx2Q0fE/p
         jAnJGQU58B55jYH6DBSD5NdkjdUxsfLLUAiyrfBSJGVya4sysunyhR+jVXSyucl5CN04
         33CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lOWE+vv2CjWtv52sjslTIrPdvLmSb134lQ2+RFnBpR4=;
        b=d5vzWq+eUgdcx/0eR164kak7nyzFPJLOvjmE0p/Py3KGtt7dzGwQr2rHu+KY8R/v84
         lAPE+zQ25LbcOEOT3kuFXKAzI3EwvKXq2LgfE+5L+5iIbQj+X4oM/bbr8w/uNUXOuzd/
         wLr75sdAGNaY722qXOxIZl355qB0wbiMz2VVy/4Um29YFeaDYLWq8ERbtT6DB2EzEG3i
         7OyGY/JRuxmFA6/mkpnyZM1AEakf1XIQVbpCOTjYMOD7z3IAsOqVTfWvCdxq0WbEdgrt
         raiiQrYw8mAQLosPZM8QIgRjcjZtz5IS1NWCRskbDHezctUZM8kTqh0v0UIHUf6+rjnq
         cBww==
X-Gm-Message-State: AOAM530FlbCVinu1BTqCNzksyf6+7OIBjJp5gXDuNWd+hLZugJGxzS/u
        qAv3ipZTDy4RMe+zHdcUJik50w==
X-Google-Smtp-Source: ABdhPJzm5iGlfQVNOahtI+69DmjFphyvsKWFCsPrYX9EScs1/xOKAbe5P0ZblV3BNmFPqXylz02wAA==
X-Received: by 2002:ac8:5d89:0:b0:2df:f357:c681 with SMTP id d9-20020ac85d89000000b002dff357c681mr21790120qtx.475.1646331652660;
        Thu, 03 Mar 2022 10:20:52 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:42f0:6600:189c:9f41:ca51:5672])
        by smtp.gmail.com with ESMTPSA id b137-20020ae9eb8f000000b00648f9736ab0sm1346633qkg.124.2022.03.03.10.20.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2022 10:20:51 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
Date:   Thu, 3 Mar 2022 10:20:46 -0800
Cc:     linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        "Viacheslav A. Dubeyko" <viacheslav.dubeyko@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4EC44EB-4869-4825-B720-455BFA3118AF@dubeyko.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 2, 2022, at 4:56 PM, Luis Chamberlain <mcgrof@kernel.org> =
wrote:
>=20
> Thinking proactively about LSFMM, regarding just Zone storage..
>=20
> I'd like to propose a BoF for Zoned Storage. The point of it is
> to address the existing point points we have and take advantage of
> having folks in the room we can likely settle on things faster which
> otherwise would take years.
>=20
> I'll throw at least one topic out:
>=20
>  * Raw access for zone append for microbenchmarks:
>  	- are we really happy with the status quo?
> 	- if not what outlets do we have?
>=20
> I think the nvme passthrogh stuff deserves it's own shared
> discussion though and should not make it part of the BoF.
>=20
>  Luis

I am working on zone-aware file system. So, I would be really happy to =
participate.

Thanks,
Slava.

