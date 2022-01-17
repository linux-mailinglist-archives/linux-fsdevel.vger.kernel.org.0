Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56D490AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 15:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiAQO6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 09:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiAQO6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:58:32 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04850C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 06:58:32 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s22so23738710oie.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 06:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=i+j824UcBodVo3CNdwZcWn2XCk2uTYdhyy7Y79Vjqi8=;
        b=dqKW01WJm4Th7OWr4ZP2XCeTmRuEq63iWEji8iC6az97QLF1A68zfo32B7REESxUSv
         QT825aM8K7FDd3G0oHPEENm8R1Edr+EudF6GoMbdruUenokwIhqti/ujHTojnA9J7sVW
         o3Wdp0lCuCsE1PwENlPYPY+NZ7X0deDlGSj6STMDfpZF8KXEEywYHszhmFlSvkQ7mqrV
         pBwjyECcX3ZgllgKbOH9yYfMXHzJarE6yilY4JjWbEgX+25q6BVwnvrieutQUPgJhwkZ
         dEL0eI7jFhJjChDI57y2mHwokvKTTp6n9h6ulNGm0bnjIofBfFPVGJvSCry1C5OoUCAZ
         CPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i+j824UcBodVo3CNdwZcWn2XCk2uTYdhyy7Y79Vjqi8=;
        b=m0XKZZ8xRMBiPLGHvNNvOepovS4ekZtW1wuxeMS0JIebsYanduokFIUhTJb4eNwG7F
         abCP8+KlZ3xQr2DE3e/BoYznF0GyrPXxzshOKTIZsxYKOUlxHTxklgw+IoQXT0YKp2qj
         XDLX746fF8crH4jb7JnsjVqwksoAH1sQmK1ZgFTPoJMMkcX/J4lwytS8YZN46beWkX1J
         ymVFvAHOSX+6WxuwtDKLcdn/QPq8B7rHrhkT0zdMo2K+QkcR9qaGxViWqkHN73gFsWcm
         YbRYJBlr3Djq3OaC4+QzLivNpA+ldTUykmRBt0MlROeNKWuZKK4hhMGb9AF5BKVYgdqh
         J4nw==
X-Gm-Message-State: AOAM531Te6Ep4hC0uqDVyDhi+RaIu1K9qQef/l2HPte2HXFBg0tFhxrZ
        qy2R7+29L/9qSLpJphvs804vW2h7IFnn4DYh4WO9KEs/Gxt1LA==
X-Google-Smtp-Source: ABdhPJz9UJRhK7448V4iaco6LN6flf82lMFr17mk3KgF2Y0aIaWn5yTsxZa8gfB7+onhYLU5WMZ4jMgdiEf7AqOTIkM=
X-Received: by 2002:a05:6808:90e:: with SMTP id w14mr17903473oih.135.1642431511401;
 Mon, 17 Jan 2022 06:58:31 -0800 (PST)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 17 Jan 2022 09:58:20 -0500
Message-ID: <CAOg9mSQ6pvuOTOoTkzwwsYmrVLOO8kYrEJ0fOWDE+ewec_1Svg@mail.gmail.com>
Subject: [GIT PULL] orangefs: fixes for 5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

  Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.17-ofs-1

for you to fetch changes up to 40a74870b2d1d3d44e13b3b73c6571dd34f5614d:

  orangefs: Fix the size of a memory allocation in
orangefs_bufmap_alloc() (2021-12-31 14:37:43 -0500)

----------------------------------------------------------------
orangefs: two fixes

  Fix the size of a memory allocation in orangefs_bufmap_alloc()
  Christophe JAILLET

  use default_groups in kobj_type
  Greg KH

----------------------------------------------------------------
Christophe JAILLET (1):
      orangefs: Fix the size of a memory allocation in orangefs_bufmap_alloc()

Greg Kroah-Hartman (1):
      orangefs: use default_groups in kobj_type

 fs/orangefs/orangefs-bufmap.c |  7 +++----
 fs/orangefs/orangefs-sysfs.c  | 21 ++++++++++++++-------
 2 files changed, 17 insertions(+), 11 deletions(-)
