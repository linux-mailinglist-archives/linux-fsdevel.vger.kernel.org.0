Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A855BF23D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 02:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiIUAiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 20:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiIUAhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:37:47 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F31462D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 17:36:29 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id bu4so1762230uab.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 17:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=Iv5uBfF5M9kU491T8bKcKlilZnpuX7sv/dttBGICVbg=;
        b=XQUfKVS7AVkMBFYtdXBkZ43nrRak6fW5FydJTYlP8FIg5bIeD9rg5ltejFXZ4Op4WB
         /kvvEyylojZ/AkUy4oTVryDh/ZNxaKKcbwnSOZ6yhtWZF1aIYyEmmaEg+PjtCwxgroWn
         GTXU0KHLmMEA+oNj4xiRmcFzcIaIwS/LvTFI5tWzynBKwpxEOxqTbryVbyyIVpqjl8y/
         3LM8J3OZLrdD3p9ukRtrl59tUWZuesujopuhvF+TwdGeirvOw+VLzlOSYUb8QNTfXHWV
         cv14reh3/Mh5O81Td1pyqKSMRoXnt7Ou1+I+4MJkPUkRmfzq4ngz7FZ7WqlitAQ2L67L
         JSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Iv5uBfF5M9kU491T8bKcKlilZnpuX7sv/dttBGICVbg=;
        b=JO1Kk8BVTVaT5bSwS7Te+dCi/Vz4wEdzLJKbWmlJ4TBmv6UeuT2WiWR9Eipo4673Kd
         ccLcwwwWyqA6HJZUuN8DVgk8adqcZSoOV5ifRmSsd1snyHlrAD1QOPhxWoPJzRDwSr2K
         aagYTi69ccfqIcuxhgfcrxTucWBDq2PyYmCP1CYxPXwyoaouelhCyR70MCUXhj73ZaJ8
         rKX5pkmqPdrUWmXWxqnYurYZpD1IXU/KA27+yZ8kxHji+E5y8ps4nhn//E+HZV4yqmmi
         iB6SyJr/5QDVpSnPouKy12yeIt0GIixthwJ3RShrd/tP8X1izxJ6VqqJeMpoqAId4NvM
         lvvQ==
X-Gm-Message-State: ACrzQf2zVVrIQD/hnTuaEL8IQ9mRM+u//i3V+iwt5YD5wLVDcPqDexhF
        +//JOKs5Y1pBAXwnPToq6zppT/X1ZikSICvZDug=
X-Google-Smtp-Source: AMsMyM6lY4K/CL/dtw1o/VDBdMWEJE8XeGv7ctnWxlt03xIqEUQpLDKMhmQ64BQbHciuOrtT4R/QoG2eI0dOnCAtnos=
X-Received: by 2002:ab0:5992:0:b0:3be:fbae:c964 with SMTP id
 g18-20020ab05992000000b003befbaec964mr7368662uad.15.1663720588131; Tue, 20
 Sep 2022 17:36:28 -0700 (PDT)
MIME-Version: 1.0
Sender: tanrobe22@gmail.com
Received: by 2002:a05:612c:71d:b0:2f2:9fb4:9fc0 with HTTP; Tue, 20 Sep 2022
 17:36:27 -0700 (PDT)
From:   Hassan Abdul <mimihassan972@gmail.com>
Date:   Wed, 21 Sep 2022 01:36:27 +0100
X-Google-Sender-Auth: J8k06qg_bhZ2teFiES3RfBFC1XU
Message-ID: <CAGL4=ZMWkiqaWiW5YD46qRibjOw8rFx5G_ULYK+6mPn6OROcbg@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,MONEY_FRAUD_3,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello
I'm "Mrs Mimi Hassan." married to Mr. Abdul Muhammad ( an
International Contractor and Oil Merchant/ jointly in Exposition of
Agro  Equipment) who died in  Burkina Faso attack, and i was diagnosed
of cancer, about 2 years ago,and my husband informed me that he
deposited the sum of (22.3Million USD Only) with a company) in
OUAGADOUGOU BURKINA FASO.I want you to help me to use this money  for
a charity project before I pass on, for the Poor, Less-privileged and
ORPHANAGES in your country.  Please kindly respond quickly for further
details.
thanks
Mrs Mimi Hassan Abdul Muhammad
