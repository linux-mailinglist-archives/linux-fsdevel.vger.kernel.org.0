Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747BB74CCA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 08:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjGJGKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 02:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGJGKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:10:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F7D129;
        Sun,  9 Jul 2023 23:10:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98e39784a85so1025211366b.1;
        Sun, 09 Jul 2023 23:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688969440; x=1691561440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLTUVpDUrCdQ0Mh9V452LJhSttkDbQuVjJuiw5M94EM=;
        b=rrqf0vLe63238HBXYxc9MbUtq9PE0OwcLwvS83zt0Ua72s9Yox1nlmtiMqXhVloXWB
         qNGJ+0vSZiHf/VEeI7LsepUphkiF7JdKVpk9/UZl3a91apK3ocDgLolYXMwTFWzy81lN
         kpi9h2Uev82N5eIe9Mrg7l6sBjne/Q7R4u53wRM2JTs07iofv4lt+CZc7Ct3K/K2Vwlv
         gsLIWL0cMJftioj5TzPnMH7WkF/zg8O/Mvuir65/dR4mUEFFScFtjMBs5voN5ISCIlVN
         5WehgfVtIL7rrh494c+4J8ICjbGJ34Pq7m0tymrfF7CaGX76IoQFT8eV9OZQCkZIu5rQ
         ylQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688969440; x=1691561440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLTUVpDUrCdQ0Mh9V452LJhSttkDbQuVjJuiw5M94EM=;
        b=Cj+BkWgNkOXTaa12m9wDBN6gCJa5Pst2XL6qZCP2m/MZgCc5unrOEdhlQcPWW2e0WO
         9Uug4HE9bbWdmo/ob9fC+V3xjy9aUpHqmjflSkHApfEkIipb4OfrZ4o0/TpC1oN9vG4U
         ZaNDkX3oCAdCiaCL0h+RzalUA+qPurGBdVKtsdDAj1ai8qP7BQr2rtnR+IdE8grU6eq2
         aZurtzEvxkBd7BCoKeFvvhw5yWrUaJeLzYbArhEkwKLf6BQfx85r2fgqbaurL12nFMYX
         EZ9+Do2JnZ1GNqgeni20e4VupDami0HRoqb5MWBbxvlhJYJb9sLDvNP0UzF48gt/ggTO
         ZWRw==
X-Gm-Message-State: ABy/qLZEuugP9jXa3+9RasaQYpIbR4ictoWxXIXGkY2Vr1Loyk72VT6p
        RAOywHTo0ORwjPcLFEic7GdpYmz3f0RgIkFIHvo=
X-Google-Smtp-Source: APBJJlG8WySmNViWhWLOy/pzqrFUtn6w3LYifEj/AYQ5vGB3qAzzF9DLE0yHc2K5DJABsZjmg7oSnuFlKl7y1jcjo78=
X-Received: by 2002:a17:907:da9:b0:992:74e0:6f76 with SMTP id
 go41-20020a1709070da900b0099274e06f76mr18128543ejc.4.1688969440668; Sun, 09
 Jul 2023 23:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_4D921A8D1F69E70C85C28875DC829E28EC09@qq.com> <63c6f039-4b33-cdfc-1e49-fc9fc35d513e@web.de>
In-Reply-To: <63c6f039-4b33-cdfc-1e49-fc9fc35d513e@web.de>
Sender: cl1ntlov3@gmail.com
X-Google-Sender-Delegation: cl1ntlov3@gmail.com
From:   linke li <lilinke99@gmail.com>
Date:   Mon, 10 Jul 2023 14:10:29 +0800
X-Google-Sender-Auth: pHqwLt7ft6InGgiUU7y9kioNch0
Message-ID: <CAKdjhyD8U4vd=DhNqkZvCFiNnH=47e7=HdrWHe1YRuTxx6NspA@mail.gmail.com>
Subject: Re: [PATCH] isofs: fix undefined behavior in iso_date()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Linke Li <lilinke99@foxmail.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Markus,

Thank you for your valuable feedback, I apologize for my typo in the
description.

> How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

I agree with that.
