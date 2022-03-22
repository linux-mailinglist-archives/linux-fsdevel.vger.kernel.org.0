Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD14E3C5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 11:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiCVKXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 06:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiCVKXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:23:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539C47EB3B
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 03:21:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so1351115wme.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=Pm04dP0+P83KVn44y+vrJDsQ3iwP6pKc5n+Js9E3oKk=;
        b=JjnIVmBbZ0iWaCEDIrbuJrwSZY+Ns9Kk9e9xXurXu0BazfvTjq5zDF3p+tmpVKiPaX
         gK2ypGEdLUsiAAzKPkvxBzqeZStdtEpp8YiQr4ZZwfa2Gxsf7NxLogMSaKxr2xOf4RYT
         u14rm3uFmxGOolrlS8EeC4HRvNwQ+mruJhXqvNrTV2rCA8qCQt3AiPAU59kwjE/8gOtl
         Wx+MxqCUPZmYhuFU8bTAEz1zvcou3XEtCkma10gLAuuP+I+DvfJLgCvQtHWQWutawtUn
         kSRb18uwQnUJPjpNCthG0JUSDwa5dRFWOgfp+czLvU5X2TJuq9ROjiT4/c8WgHCmBa3P
         wa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=Pm04dP0+P83KVn44y+vrJDsQ3iwP6pKc5n+Js9E3oKk=;
        b=cV/q41Z3IAyzzvtZDl6d5UD15RXSvFYwH6USq+TqrvTQzGtusAIwapIgtY6MQK8or1
         09CBiuW+r3e4zvh+jV6Do3+/hWk5d4uZCXOqE/zJCuye92Kl6G4aLx/xANaz8Pm8L0vc
         WJfFQYkzlduTrL1/Fnx2aDE1n954QHu0fWpbgSAwWiBg2qC+rOxzjOkN/rMCdi4Q/QmM
         fQlRj8kuOleqknCzEV1io2U5MM32OtrJgiFb8hMehfRMDRBVWCQMMhRARIfyUcp50ifO
         X5oIP5k4aZNti16svSHy985E0Pg275m7TSCyuFYRLzIlzefCHQDYB+yZOaflsWkw9gOB
         kA8g==
X-Gm-Message-State: AOAM530Z4xXLIIF43S0AS8OpCibZlOZG4GOl5/llzB+75MbQjnZuEbKM
        6zopzHcO3RNVUWGfFzNLKR0=
X-Google-Smtp-Source: ABdhPJy1KeYPOkQL1PGcckLhROc022wazuHhV9Kkt9Jejd/K/CR91BPw3vNaxQt1kvp0Zftkuy5w1Q==
X-Received: by 2002:a05:600c:1d1e:b0:38c:a58f:3037 with SMTP id l30-20020a05600c1d1e00b0038ca58f3037mr3001593wms.200.1647944501948;
        Tue, 22 Mar 2022 03:21:41 -0700 (PDT)
Received: from [192.168.43.30] ([197.211.61.62])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm982753wms.26.2022.03.22.03.21.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 22 Mar 2022 03:21:41 -0700 (PDT)
Message-ID: <6239a335.1c69fb81.2e30.3f3d@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: meine Spende
To:     kehindeomowumi974@gmail.com
From:   kehindeomowumi974@gmail.com
Date:   Tue, 22 Mar 2022 03:21:27 -0700
Reply-To: mariaelisabethschaeffler70@gmail.com
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Gesch=E4ftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, den Rest von 25% in diesem J=
ahr 2021 an Einzelpersonen zu verschenken. Ich habe beschlossen, Ihnen 1.50=
0.000,00 Euro zu spenden. Wenn Sie an meiner Spende interessiert sind, kont=
aktieren Sie mich f=FCr weitere Informationen.


Sie k=F6nnen auch mehr =FCber mich =FCber den unten stehenden Link lesen

https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe

Gesch=E4ftsf=FChrer Wipro Limited

Maria Elisabeth Schaeffler

E-Mail: mariaelisabethschaeffler70@gmail.com
