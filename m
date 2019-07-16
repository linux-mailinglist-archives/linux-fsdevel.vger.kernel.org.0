Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE8D6AD89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 19:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfGPRRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 13:17:45 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39812 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfGPRRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:17:45 -0400
Received: by mail-yw1-f66.google.com with SMTP id x74so9223168ywx.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ibrFW2qdN0PRf9ggy0I5K9Bcxozlbtq1WdVax9N8pkE=;
        b=pDk9Cgk8hVDzEHJWBFA6wQf0eYlRctwtU9vfR+IEJZmwSycZOhPX+bR1euUoRhY+Kw
         NAcTb3HB3XgcElwi/0WOrVddSpxIgZkOvwPdosoyvk979tHDb039vfPkXPGdRYR/AFEx
         ROZzjrNpfBxlsQineYA1ZgLfT7IdZgXEQ8oA6P0GoP+Cz7j5xqDkgXV316noKkmU9Pwk
         AMGSmnuOQQghTeDXAb9o/Xm0lJWECrkf7JybtbZiXSM8jfWFE5njti/LaYh+3Mi+dHLu
         mmvc1VI2TcP7DB6dz9hC+uPkVObQrSEg8iLUXfJLbWmRnmJjNcOsiZ+cz3DgHrUv3eC+
         a4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ibrFW2qdN0PRf9ggy0I5K9Bcxozlbtq1WdVax9N8pkE=;
        b=LiP+JcZzCRf7lTR3LjyWL/3EDEj7LMmg05e9xpQ1XeSKUREzmw1UA/IgyWE64iAni1
         xQvIoelZOfz2OMAOLVLUxNuBeXidPT1exHZBuYiwDajDtLXZgWwKvQKCd1dqtIgZq1AT
         oDvMbmun+BM0InKBtzJOKL8wlTcMixC+X3Pq+vfM45zuBrW2yupSPOu7SyOTbmexKuDi
         KMRtHcyKZBsmfYNqqdlPXff7frJCteixqGJ8N/vMkDaK1eVU0CNs7eT1L8eflbwECA2x
         S+5CkX/UMlAoNjv9pO3IpozFWx23u2cWSzvkVajSFjZIqzfB2aX6R0BdsPe/OKsBJ1fs
         bBYg==
X-Gm-Message-State: APjAAAVgYr0dwhVppwviyH0mQ3u2OPNOpRGEgICvy3bOcLh5kSxH5Q6T
        3PdicreMVcVJU2GtFmnJ6dZtc9P/XfZu2a4V0FxSAhman3w=
X-Google-Smtp-Source: APXvYqwy2Dh5tshvDeYEn9+gba5Hs6v7Qz+UnzZ+/wY3c61qHmhPJYZC29I3lBlpjJqtGQ7MzENovUJtjNPXRC2E2UI=
X-Received: by 2002:a81:5cc:: with SMTP id 195mr20825552ywf.348.1563297464469;
 Tue, 16 Jul 2019 10:17:44 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 16 Jul 2019 13:17:33 -0400
Message-ID: <CAOg9mSRq3h=vT1ZXMrZNn3_0gWtYSEPOUv=NyY9Ukhgi_Xa68A@mail.gmail.com>
Subject: [GIT PULL] orangefs: two small fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 0ecfebd2b52404ae0c54a878c872bb93363ada36:

  Linux 5.2 (2019-07-07 15:41:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.3-ofs1

for you to fetch changes up to e65682b55956e9fbf8a88f303a48e7c1430ffe15:

  orangefs: eliminate needless variable assignments (2019-07-11 12:53:02 -0400)

----------------------------------------------------------------
orangefs: This simple pull request is just a fix for an
Unused Value that colin.king@canonical.com sent me and a
related fix I added.

----------------------------------------------------------------
Colin Ian King (1):
      orangefs: remove redundant assignment to variable buffer_index

Mike Marshall (1):
      orangefs: eliminate needless variable assignments

 fs/orangefs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
