Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397B1678F6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 05:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjAXEmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 23:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjAXEmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 23:42:51 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12D47EEA
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 20:42:49 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so35948570ejc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 20:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBBydtjTCNoLHoaikk4MVmH3r+okeVfzKA/E+1BXIiM=;
        b=Zd1NkRWJIZy4svhXohwWuIpqZzJ15qCm3xvoUCSGKytDZOsn+LVb8LarRG5FZRoTJ4
         9hSWe+hYRF2k+KndqGPy9/t3JmUIgcGTojP0yf8asFDHcJQVmEQAvhyjmlYVlcgCoCm/
         GkN8/9tzZzI7YQjhvD5jNnj6sMxX7BKygD1GVpZvguC5I4pbcFbn+A325txefBrnouSR
         TdxR3GQYgef2AuhQ2ROF9LIZtSoquVcXvPxYnY6V00Sox3/Sqem/71wCDniVSaeNkCAZ
         upgDeI4DYXZrI1lU2VtewyBTb/3nbYonlpEy0wLzYHYi6kX5kZkskw111hMXZkn1HtXH
         LRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBBydtjTCNoLHoaikk4MVmH3r+okeVfzKA/E+1BXIiM=;
        b=rqoQjtEUxqhqV5MwhRWljznErauFPdpbQezzoGmRsF/jtdHrqKYrsNqJDJhqXu7QRY
         yeIh2QFVKRos7U+VeIea6X/wZKZAl4rMrpvtM0/nZ4d+mf5YEGKmPmiWHwfrMnX8vJwh
         fN6hbFx2IXpxyOGZ/DWjgkC08tvG/eHZj5oh23QQ1NrDrSqXAUFvkYoSEVxOS9p4PlRX
         ZAdJ/3frWWLL6HRrr58WibXc6uXTcV7z9IrHfPQhFz5w3uJyvTmuL4bCCeQDx7cJ7Q9+
         VMw/ZKOg+MZHzO+a1e7xil+A3C1YiU7r2i5zZ6Ccb27iK7wQhru0vZRq1HDDpe1+JKvW
         qb5g==
X-Gm-Message-State: AFqh2kob7a/5Ro+TcnATHiL0ES7ism4BZBn3BiN/FWg8uq6/D/zMkHJJ
        pNAlCK6GRsD050VyTGufjxzwNtoFMNMpiUBJXPk=
X-Google-Smtp-Source: AMrXdXuEbM6FGzJHzJxADUDZUQYPF1MUQULNkHIE49+dOOcN3hpAPzpBNxElybecM0kEHUrAnF2NjEaKRKbaN8whr10=
X-Received: by 2002:a17:906:d143:b0:7c0:f7b0:fbbb with SMTP id
 br3-20020a170906d14300b007c0f7b0fbbbmr3411424ejb.266.1674535368135; Mon, 23
 Jan 2023 20:42:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a98:a90c:0:b0:188:44ec:d33 with HTTP; Mon, 23 Jan 2023
 20:42:47 -0800 (PST)
Reply-To: lisaarobet@gmail.com
From:   Lisa <grace778robert@gmail.com>
Date:   Tue, 24 Jan 2023 04:42:47 +0000
Message-ID: <CAOEYtR9Axjb3N+LhWxwpTuVTLZmeejWOjocsDj+yzS78Z6xWeA@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Dear

How are you doing today?
Please tell me do you receive my Request?
