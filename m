Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD854BE234
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 18:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359120AbiBUNeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 08:34:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359147AbiBUNd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:33:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B192C205D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 05:33:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p14-20020a05600c1d8e00b0037f881182a8so1386303wms.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=GDWnkOJzqMdm2G+AJy69mA7h+y4NYcty/dAHVLHePO2VWWW+0ZlVZ5yK4OpOxYH2HX
         2kOq1sCaeQLnZJYNg/Yn2PpB3/fRgxOi1XAXCqMgzm7AL5qzYhnv+Fqb3hzxhtci+uKM
         ocW+Ay47aPjn/iM82x7VVpofdKZH/3preJg3yOxuodsbPQ/rg76ZnHDsOXt0qJEU4bHb
         oUYCBWgbwjDKaNo1sRVPl4tdE+QBMlWtYLpF06GvXFD0jdz3CkSv0DeJep6gRvi7wUnl
         oAP8SR3NO6eK38bYuht6vFEW1N9SNagKWMwnbYhuIfxxldKDMmsoU5q1YraCrKHiMGIU
         wTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=RFkSFnA1O3sIGDOHWOXCJbNc42rDAOQO6hnmsRQ4hwJhvvZPExrolGxOHSJQ88gNyf
         2jK6SB4CsFU6YSoAT/mJjBoK+IMeglwrpk2M8VNtUXzwp5PJFzqbuBXTCsGiZyO0zfhC
         LKwdgJo3hCGcfQar6jhAz9kpIoUtMt7R3NUCGz4MeWC5pd48mEpKrRmO69NPWEhSmr54
         7MoaRrkIFfNix07UjvdkecZost3DxiUSuLh6T/m0U5xcna4CqfwpIrIG2zEtj/lExv0N
         OcSiFZtgMyR6DOStgp+KCVy6KjrU9DRROkphTVvWB31iGC+2WUoFrx//wYvRlagQE6K5
         659Q==
X-Gm-Message-State: AOAM532iG7cXL2RIQdHrj6Evy7tBCGS7WsIpTIRG3WOGBPn70ynjDtnB
        lacNvN3Ku1RVbt32qO53ALc=
X-Google-Smtp-Source: ABdhPJzKMVZrV0CNUCz3qlMQB014AW8RDI1KZKZIaidwBLJVDrKMQw3IRwjwftivBGuNRIzMkwPZTQ==
X-Received: by 2002:a05:600c:1d1b:b0:37b:f8cc:2f71 with SMTP id l27-20020a05600c1d1b00b0037bf8cc2f71mr21240387wms.74.1645450409323;
        Mon, 21 Feb 2022 05:33:29 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id b15sm50129805wri.96.2022.02.21.05.33.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 21 Feb 2022 05:33:27 -0800 (PST)
Message-ID: <621394a7.1c69fb81.ddc97.2ada@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <briankevin154@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Mon, 21 Feb 2022 17:33:20 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com=20
