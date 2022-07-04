Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3B5653D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGDLiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 07:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiGDLh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:37:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C251275A
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jul 2022 04:36:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so1639336wrd.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jul 2022 04:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKBXFXotED+1B6HSUGwFJyKmmy7t6L5/nnjdgGUAKlQ=;
        b=GchmpI00QpgNnXPViV6O1v1u0F8sqA2pYV/cmhjXgilUzmxqputunPj9kcvX8y0JLC
         BpDbb+GL/1bygv5SU05WXap65417/i/IXvnNDOkhv79FGrB+PTfB5uRuVWSU0/jBJ4me
         MoTMjxYmbR5gg+7zrb9sAWn3eGh6RUaIRWeNLMifSXbfB9ySbYKY+QL89oyW0xfWalxI
         ZRcnYlRlQdrOx7i7c+wRMUoWjM1cz2b8Y3UQdcfUlWhUhZxhA/fxKcW3HvEKz8nLdvn9
         37NC0pbJL3n5XNm8NpJfXHxqUweivGk0tSFaiYu2nAr+BxrvIYdt1iwmlPs2IMSP25+9
         xxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKBXFXotED+1B6HSUGwFJyKmmy7t6L5/nnjdgGUAKlQ=;
        b=ULulXjJO4hR6lfPPF7k0kW46AskVIV07gweO0K0xf4sYgL/lm3qOzkRw/yMtgJHslS
         9ijgPklDe9qjmyOUrF7ln0Q8o+PplkzZRmAmbIr3thWl055bZCaAvGamhJV5BrQW4j5c
         duuFzYQRawBCK0wWyWCLR1MpGLd582q7fchXWsiQzp1V9C+8GdLTdYT/Pcctq3dqjbQL
         toI8tictyoqowp5nUZUk8OHvj6VZutvfM0C+lrosNLWC1woYmvuUuB3F2CE/fNergIuZ
         NTyE/mxrYD27B2YeEWIhFz4ENs8mjWTjpVHs8VM5zJ5aSveX1c3LpATr7PyDozarav/T
         6lkQ==
X-Gm-Message-State: AJIora/bHQBgTycz+cl+kfOh3oiuxVzmNjEL6Y0dXU9yhtDEEhUfJ+zh
        ZtfPjlJLn7PB6nF4t5Q0qOvOvqOgpJHxJtPV
X-Google-Smtp-Source: AGRyM1v7SuvpBPTmFFNywaDGZaClkX0cqYJPP32wQi/aQNebSh9M5YVFubXkbTKAoYfCuR9nCHZjYQ==
X-Received: by 2002:adf:d215:0:b0:21d:689f:7eb0 with SMTP id j21-20020adfd215000000b0021d689f7eb0mr5986598wrh.542.1656934617719;
        Mon, 04 Jul 2022 04:36:57 -0700 (PDT)
Received: from blindfold.localnet ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0020fcaba73bcsm30279765wri.104.2022.07.04.04.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 04:36:57 -0700 (PDT)
From:   Richard Weinberger <richard@sigma-star.at>
To:     alpss@penguingang.at
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Subject: [ANNOUNCE] Alpine Linux Persistence and Storage Summit 2022
Date:   Mon, 04 Jul 2022 13:36:56 +0200
Message-ID: <1778345.CLbsiaQdQ3@somecomputer>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We proudly announce the fifth Alpine Linux Persistence and Storage Summit
(ALPSS), which will be held October 11th to 14th at the Lizumerhuette [1]
[2] in Austria.

The goal of this conference is to discuss the hot topics in Linux storage
and file systems, such as persistent memory, NVMe, zoned storage, and I/O
scheduling in a cool and relaxed setting with spectacular views in the
Austrian alps.

We plan to have a small selection of short and to the point talks with
lots of room for discussion in small groups, as well as ample downtime
to enjoy the surrounding.

Attendance is free except for the accommodation and food at the lodge [3],
but the number of seats is strictly limited.  If you are interested in
attending please reserve a seat by mailing your favorite topic(s) to:

	alpss-pc@penguingang.at

If you are interested in giving a short and crisp talk please also send
an abstract to the same address.

The Lizumerhuette is an Alpine Society lodge in a high alpine environment.
A hike of approximately 2 hours is required to the lodge, and no other
accommodations are available within walking distance.

Due to the ongoing COVID-19 pandemic special rules including travel
restrictions, mask and vaccination mandates may be in place in October.
Please check the travel restrictions [4] carefully for international
travel.  We very strongly recommend all attendees to be vaccinated
against COVID-19 and will provide you with updates as needed.

Thank you on behalf of the program committee:

    Christoph Hellwig
    Johannes Thumshirn
    Richard Weinberger

[1] http://www.tyrol.com/things-to-do/sports/hiking/refuge-huts/a-lizumer-hut
[2] https://www.glungezer.at/l-i-z-u-m-e-r-h-%C3%BC-t-t-e/
[3] approx. EUR 40-60 per person and night, depending on the room
    category
[4] https://www.austria.info/en/service-and-facts/coronavirus-information



