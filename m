Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4BA3BD7DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhGFNjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhGFNjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:39:31 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C76C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jul 2021 06:36:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso1464828oty.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jul 2021 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=VU4GuSrcLVR1oaPWhgvWx1PGyv3oIGqtTnseI6W5etA=;
        b=PfNrLdrdIQd00IB/fKTKaaI8AZdzIWHisfmVHplsDUj73SFbSXLLFUSNlom6hxWElH
         iusbD8H6slfsZVk2Cc12QQZIi5rcSs1wgl4omm53Yu9epwTZndNLloWA2hGhP6QuxImt
         l0UsDXQQ1pSKDx0dXxms5Fvl0IRJm1ggJOXuB0pgpFJZFnr/t3E9oSQq7FFsk3kD1M+A
         CadygBuEJZTIrVRxSbxq6DWjZxSSpB/pE6ZQQcrKEB+BaPf2A7wm3r+eH0dueRlxDygk
         hLY5uMLgIb+KoON5hB7xRj1m4JbcuIu+y9YHXZggHI3ebFtP8xnx/QOBk1j9whgH2jx1
         /Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VU4GuSrcLVR1oaPWhgvWx1PGyv3oIGqtTnseI6W5etA=;
        b=rpHkPknP98TmiJsrdqbkx1EvkGsOHugaS768tTk9jo5G1q4ao2oMJ77xkJdEZF7KrS
         JnKZO8TamalmWxvgAjEYZ9XXgp3+mAMiKwneWazmnFt+pXlFPkzzjqoGI8/2paf+zbqw
         ULI+Dc4JKoLhjaIjJIZl39bL4+WeiNIGYQnzaFn1nnbsZr7Fh/P7akUgvIrDP7UTTvBF
         JArOZKje93EtiTBZOyMYmM+2qNmPIEQqCLXt44UzNVJ79BaqCkwWQME9JoygK1ayJX++
         YeNGHHKUYZ1i5ZJoAd9gu/VEv0dbfcxiSrw4C6gQqTbs8m7HI0vBcOUt4TmteErkclRj
         Mf3w==
X-Gm-Message-State: AOAM532K9tIB83KxhAI0Kh1meTgLPlDiFgig63g2z0AYdLis1QimU+Ut
        oWsyekPkWJFlFCs/OAQP8/6a40r7+PqPyBpUCIkyha2+CUv84zfz
X-Google-Smtp-Source: ABdhPJx98R3sN5yKeL8FC5BGRGzaDglxyqf8nzsGJ9AYbBEMy3N5UgsNNwNOhYUf6cR9XMOxraN9Y6lxNK+0HyjLGYM=
X-Received: by 2002:a9d:6c53:: with SMTP id g19mr14945058otq.352.1625578611556;
 Tue, 06 Jul 2021 06:36:51 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 6 Jul 2021 09:36:40 -0400
Message-ID: <CAOg9mSQwkp=dHCkE4crvPrMkSxu8ZCO=vamnBuhmzT3GRARnSg@mail.gmail.com>
Subject: [GIT PULL] orangefs: an adjustment and a fix...
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.14-ofs1

for you to fetch changes up to 0fdec1b3c9fbb5e856a40db5993c9eaf91c74a83:

  orangefs: fix orangefs df output. (2021-06-28 08:40:08 -0400)

----------------------------------------------------------------
Orangefs: and adjustment and a fix

The readahead adjustment was suggested by Matthew Wilcox and looks like
how I should have written it in the first place... the "df fix" was
suggested by Walt Ligon, some Orangefs users have been complaining
about whacky df output...

----------------------------------------------------------------
Mike Marshall (2):
      orangefs: readahead adjustment
      orangefs: fix orangefs df output.

 fs/orangefs/inode.c | 7 +++----
 fs/orangefs/super.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)
