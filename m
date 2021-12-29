Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C721F480FA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Dec 2021 05:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhL2EnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 23:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbhL2EnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 23:43:20 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52488C06173F
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 20:43:20 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id bp39so17657809qtb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 20:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Qn/qIc+IdWDrpF18flmXoRQQTkgxgsIUgH+1qRMEjCs=;
        b=bvUGWX9ch70TIOYOJbYXzTJsTo8ENXlnLLGJcL59Chnr6M93j9Ou55hjCg1XoQhL7C
         QeJMm4Zzw/9fGH15jcHgb/xp9mhVYcJFoYGY4Z1WEP1JHB2eNgY8vkUvj3cFZaSGHWfV
         GhYtp1GpjpdoQm2n0hxNsIIHaTKH9uLQOJiAYBUBnamKgUmkfn34KJ2QwXcOsiEd6E/m
         IAgDOiLbAmP54IkNg24jy0SdZDYP/0bTPKn/0VllmOkX01O2DyCP/lHXEUYOP1cCBecb
         OdBafXccM/gJJYoMpomHrV53NCx0+VwyueHraP99xhkEX14DMnPgww7jzftxidkyFKOO
         2/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Qn/qIc+IdWDrpF18flmXoRQQTkgxgsIUgH+1qRMEjCs=;
        b=cQjUQMPC+zzQowgTLqK/9qeQCKgHRK/2jyBKaDT2cfNuNXlPETRXYwzapCgwXJu/J0
         UuJsBoo8uXaWlvV8CYKNBT4hqm4vLMPr56VPHMGjOIHRv9EXQN3eVePrvfI75nL3gGAX
         bBDZ0csc/23GARpo7a1inoQXWNmEsjJuy5eTJ2L+D6uwyCOJfrrOCohApvlPYrKZ7JKd
         l9sXDjfh/MnhQyxjYp+dUjE6XUOtiHhtWLf/jIS0WcKeAGsu/x5xL2ATgGHp88Um4y2E
         vQUKqJYxbl2FqUzAx+5jaNKQnYF8GrxgT28QrlbZRspdivOgqCl4RGaTZo8lJSuyXeei
         0P9g==
X-Gm-Message-State: AOAM530unwrvXbo+9QZLT5WCIonrLtzCp1+wfYS2sNcYjns2iTeIdN9t
        ADpG2HphnqXhs7eAqJhRbQYfJuEZSwLPzp8upu8=
X-Google-Smtp-Source: ABdhPJyzMVqpzBDJbMwvoSTMwboacqpy5DyVLAnWb9Vf3sZg3kDOLsvds95rrxVQnhxv/+Gebvv01r4A6hCsnZgQi4c=
X-Received: by 2002:a05:622a:ca:: with SMTP id p10mr21266702qtw.89.1640752999156;
 Tue, 28 Dec 2021 20:43:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:4e83:0:0:0:0:0 with HTTP; Tue, 28 Dec 2021 20:43:18
 -0800 (PST)
Reply-To: jw257243@gmail.com
From:   Ahmad Massoud <hervedodzi@gmail.com>
Date:   Wed, 29 Dec 2021 05:43:18 +0100
Message-ID: <CAG7OqbLsLPcQ6PD_YfFKgjYt_TyOZh+8V_c-BvCojsHRdtMaZg@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Peace be unto you.

Myself, Ahmad Massoud, from Afghanistan, a politician and government
official working with the ministry of finance before the Talibans took
control of Afghanistan. I plead for your help to receive and secure my
luggage in your country.

I want to send out my digital safe box containing my life savings, two
million six hundred thousand dollars and some of my very important
documents through diplomatic delivery from Afghanistan to your country
for security reasons and for investment in your country.
Unfortunately, I cannot send the money through bank because the
Talibans has taken control of all the institutions in afghanistan. we
are under imminent threat from massacres and targeted executions of
government officials since the Talibans returned to power in our
country and I have been in hiding to avoid the risk of deadly
reprisals by the Talibans as I wait for paperwork to evacuate with my
family.

I hope to hear from you through email [ jw257243@gmail.com ] for my
safety because the Talibans are tracking calls to find out our exact
location in Kabul. For the delivery to your country, please send me
your full name, address and telephone number.

I look forward to hearing from you.

Ahmad Massoud.
