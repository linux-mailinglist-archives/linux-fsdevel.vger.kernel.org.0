Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6201D414FCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 20:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhIVS0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbhIVS0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:26:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21DFC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 11:25:19 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w17so3618756qta.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DFfC8uZYlFBWW1UWZ2UiC/X/t9KDJzyVw9sPCj3Xpck=;
        b=E8N9/SnsC6+JfA3xYPMbpZMq4zU9zRRBdWJUZTXJAdPHCm4CtE//CWUuOeCVS+VyxU
         jfbwidWQLerh5mg4Tn7WBVLXc9HEhwAvAGkQ8pBGm6EG/JA0giFvBYAnEydnDdqIyHz6
         DLAV8ig+s1zAS6OatRPew+oD7rkJh8LHXAqxhKuOpy/iTSKToX0hCRH6Xm40O687ogVp
         gNIfAIkgNZVxzKgMddI+9TWPnHX/j2Ew/e1YVvW2uEn17tu1KdVVLC+bQZY0tNItqTzr
         G48mBHGJzhfO/sW8fwJlZY7QPX9fZ6gw1QxI2RC+OWo2ieN5Qv5wXKE0oqr4/+PGM62P
         gPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=DFfC8uZYlFBWW1UWZ2UiC/X/t9KDJzyVw9sPCj3Xpck=;
        b=OR4EHffBROMdHcuRYdp5j5qifT2HkSb4PlLb3lHWfLl3YB+FUj2R0CX8KEtf27gpvT
         N0Vy5E7VrFHGMjvCF3DSad4nlWM9WPK1oJnwGQsZnSTGzsiAQS/Zy6TcFLQbDJqDaY9g
         VsUH/SW/nG8EPd9SdHiR0XRoUeXsN1CvOgQPeCx8Nn0H/XhzcJdOX8TPutJrG/RYiW6O
         8tvJfM7UID2CydHkHejPEvvWKb8yUBXiWiGlDo5TrMHoRWaiF80cT09Jdu3o2l+i1Lcz
         ZYej97p3HTusywXRZheDHdVdpssxpgEJBpfXAIT8Sxb7sK9E/ZljmPEIzyjeGub1T/Bu
         gyOg==
X-Gm-Message-State: AOAM5301+uKaKCC462DOUsgYYmybMtHtCjPeaJTQkoP9EWgbWKvlK0aA
        72Qd2RwaQBSyBXvcNnvILWR4ZA04I/qikBfK4ic=
X-Google-Smtp-Source: ABdhPJxpuBZ9MOAhUHP6CwY2XBffSmoBxsaHYjCd04Uvyzwz0jN0AkqzMaj3XYQkj/KZBFMVNlsO8zpzeZYsjQ0kqFM=
X-Received: by 2002:ac8:1e93:: with SMTP id c19mr686398qtm.55.1632335119027;
 Wed, 22 Sep 2021 11:25:19 -0700 (PDT)
MIME-Version: 1.0
Reply-To: bfkabiruwahid@gmail.com
Sender: wbook84@gmail.com
Received: by 2002:ac8:a86:0:0:0:0:0 with HTTP; Wed, 22 Sep 2021 11:25:18 -0700 (PDT)
From:   MR KABIRU WAHID <bfkabiruwahid@gmail.com>
Date:   Wed, 22 Sep 2021 11:25:18 -0700
X-Google-Sender-Auth: tRF_NOE-dZ4XPyyHhi281lYIGpU
Message-ID: <CA+zrZqYxXtQySwG5qLPQbFwMcJ_7Cr+hD8AuJ=G8rTvNchdRRw@mail.gmail.com>
Subject: REPLY ME IMMEDIATELY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Sir, I know this email might come to you as a surprise coming
from one you haven=E2=80=99t meant before. I am Mr.Kabiru Wahid, a bank
manager with ADB BANK and a personal banker to Mr. Salla Khatif an
Egyptian who happened to be a Food supply contractor attached to the
former Afghanistan government before they were overthrown by the
Taliban government.Mr.Salla Khatif have a deposit of huge sum with our
bank but passed away with all his family on the 16th of May 2017
trying to escape from Kandahar Afghanistan.


The said sum can be used for an investment if you are interested, all
details relating to the funds are in my position, I will present you
as his Next-of-Kin because there is none, and will furnish you with
more details upon your response to this email:kabiruwahidy47@gmail.com
Regards,
Mr.Kabiru Wahid.
