Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E524CB66F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 06:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiCCFdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 00:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiCCFdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 00:33:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46085BF7C
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 21:32:30 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a8so8242267ejc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 21:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=k9DbjsP6WFNC+J4h8QcCzs1r9xuRRjUa93Fq1rh5ZEc=;
        b=Ip4+xxEH96Rb3KW8imBuBrwksfok+Q97maRk61mNQg4j458U4UmXvVawyCy+BEWRzg
         8QIItgRRo5vbUkTesi3yEHQsFVdOYA2+zTKdkegxqxCRwYuP7eDNx88mLOQPyeqniCmz
         ginPbDemJbV4lY3Zao2qNqvqunIYPMxw4aDQ3ykUypC4p3LugoTAdy8A8Qp1jrv3z4hD
         e5RwEXjU7D4ayGB3J0W88+mJmNbKbJSGqvs2Jo8h+XkcyqzsHqLKcVyPt43SVtQUGgjS
         S8FN+OfDBNC9FevXuQf4dy2dldRjNGpXjVFNL4/HBAg3f9qhyfLgP3MIg+pSvuBSdeQF
         VZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=k9DbjsP6WFNC+J4h8QcCzs1r9xuRRjUa93Fq1rh5ZEc=;
        b=1RK4NLKkd2XRwlNKvOPSa02l3ZPo/qeZoMdG/v7RaxS5BmTMlPL430o0zTqQQvoBuH
         7bv7jQ84dsNuGVbggpYeXWzosp3lS6f9VBHy3z0Q5c/V1H6v3Z+cCtrwbHTtPS14wiLn
         idiq6SC6vwSZvzks8Fa4WZXsBjGDmI2ZesKNKNJaX3XmJZG+8IxSHraucwnQrOCkojWu
         GYPqYKTCTSARCmtBNoONhKidm6Grl/eYhizlNR3f3coLIIbLAyIClwLDLdx+9sHabd2T
         N3Le8DPvk3xpd7imveQwKfEe4RLxub8a45SqgWeo6OYJbW1lA4x8giFhkwHac6SAQPkQ
         QoAA==
X-Gm-Message-State: AOAM5306xqIS/PCyj2pBCHZXt5jdZIsydg5shAoIreTBoDQmIPVNQ1lR
        7Ugt5uw+Je6HECUOz9eLFLQbEQ==
X-Google-Smtp-Source: ABdhPJySZq2hp2zctLXxeWvK1heT0o3JqYxQAcom/La5E4F75RO/l0paSjlHETZhZuwU/UC8shWAZA==
X-Received: by 2002:a17:906:a147:b0:6a9:f492:3c4d with SMTP id bu7-20020a170906a14700b006a9f4923c4dmr25378881ejb.131.1646285548820;
        Wed, 02 Mar 2022 21:32:28 -0800 (PST)
Received: from smtpclient.apple (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7dac8000000b0041291913c15sm385062eds.1.2022.03.02.21.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 21:32:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Date:   Thu, 3 Mar 2022 06:32:27 +0100
Message-Id: <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
In-Reply-To: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
X-Mailer: iPhone Mail (19D52)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 3 Mar 2022, at 04.24, Luis Chamberlain <mcgrof@kernel.org> wrote:
>=20
> =EF=BB=BFThinking proactively about LSFMM, regarding just Zone storage..
>=20
> I'd like to propose a BoF for Zoned Storage. The point of it is
> to address the existing point points we have and take advantage of
> having folks in the room we can likely settle on things faster which
> otherwise would take years.
>=20
> I'll throw at least one topic out:
>=20
>  * Raw access for zone append for microbenchmarks:
>      - are we really happy with the status quo?
>    - if not what outlets do we have?
>=20
> I think the nvme passthrogh stuff deserves it's own shared
> discussion though and should not make it part of the BoF.
>=20
>  Luis

Thanks for proposing this, Luis.=20

I=E2=80=99d like to join this discussion too.=20

Thanks,
Javier=20=
