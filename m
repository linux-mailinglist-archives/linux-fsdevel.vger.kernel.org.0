Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31403B4EDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jun 2021 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFZORO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Jun 2021 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFZORN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:17:13 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E8C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jun 2021 07:14:51 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so4731015otq.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jun 2021 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=h1iys2zhTUfZKqgl+2GSB5RYBG6awOc9H1skFEIzgMU=;
        b=Tq/b1f+6d82snuqTexQfL7E7KnaGypRBOjs3gpEShaTG63lx+CNsAiofdjMkwHJ4b7
         5Aicxo364xNIrlVulD/l6strqRV2JkBIvfPxefjV9enqskeONcZ0EwE2BnltdKlTPqcR
         CnMGJ4FMfA6uR4EhC93ve3LZAHroFhztsGxO2KztYi9iGzh0PQV//l9aRPgw++ZnZ0/j
         p6yULxrodDhXQBzMeYDU/jOyBUk3GapNyHFVWzTObB/EL9lIuqiqdOFWbCDP57A2M6qZ
         FbLFe465HwzJTCY5IYpzDMaS02HVIKTnpanOHjvOA2Y1ISdInuWAjpIKgPxzIiXSevYC
         GTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h1iys2zhTUfZKqgl+2GSB5RYBG6awOc9H1skFEIzgMU=;
        b=t/J4k5ya/eCIzPTUaIyazj76HkhzuVjqPxVFasqQg88SE83P7ip7N2SHFW5tscFepl
         BD9aZfUfdOekQ+6gfayi0sSezUkSPC3yPsZ8ycBF25S1mAenoymiPDjTlHqInOvwgkC1
         0bzcI9TV1RaqviovTbxUB0a2OczPEnFZVJCH3Rsw0OOhjOJyZlB7+GcjDTEhIAeOf/GO
         cbbT2Epubywygdf9B0eiFDNVTytWR6YPWCihk2nNsylHLOYIF4/KZwcb/Nacgjx+/ANq
         aTbSkqG2oMYZYb5+shnlQrJElXoDjju9zZNrq927nMgwze8X5Koff8Q6reFHpXABeJK+
         AF5w==
X-Gm-Message-State: AOAM532a+S7XDbyB78L+h9BFItngrEXpl+38/QTrgxO8wPS4mxa2yY+M
        h0WY/iVJkjgl92zQYmf70QR/I3GhbUkQiG1dL5YPadLxUFs/g8Ic
X-Google-Smtp-Source: ABdhPJxgwaxKZWTTaQTZJxgKjByM9BGCVEs4Cl8L8PJm058dF3i4UbAS5gnnRW+IepGwhIZdvGj7sXdqiGzK74KCrqQ=
X-Received: by 2002:a05:6830:1dd5:: with SMTP id a21mr13825543otj.180.1624716890713;
 Sat, 26 Jun 2021 07:14:50 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sat, 26 Jun 2021 10:14:40 -0400
Message-ID: <CAOg9mSR9CM-DV1eqL58HM+m_6fbwgU7KFs3Sab0=A7BOvqoPYQ@mail.gmail.com>
Subject: [GIT PULL] orangefs: an adjustment and a fix...
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.13-ofs2

for you to fetch changes up to 1815bba0a5c935d60f0fa180873d9152feb29d09:

  orangefs: fix orangefs df output. (2021-06-25 12:00:04 -0400)

----------------------------------------------------------------
Orangefs: and adjustment and a fix

If it is not too late for these... the readahead adjustment
was suggested by Matthew Wilcox and looks like how I should
have written it in the first place... the "df fix" was
suggested by Walt Ligon, some Orangefs users have been complaining
about whacky df output...

----------------------------------------------------------------
Mike Marshall (2):
      orangefs: readahead adjustment
      orangefs: fix orangefs df output.

 fs/orangefs/inode.c | 6 +++---
 fs/orangefs/super.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
