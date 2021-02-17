Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC8A31D53C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 07:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhBQGE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 01:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhBQGD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:03:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B79DC061574;
        Tue, 16 Feb 2021 22:03:18 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d15so6864319plh.4;
        Tue, 16 Feb 2021 22:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHw6vm1AqKtBc55asTK4A1TUwUAkAjxtXR85iRepLUo=;
        b=b+pzg/0CGxtGBxoBgPGZ+NdPIS7rLgfy6dHhYLejT0viowoopgcC4UgAfqxHb2Vaka
         i7+Pt92cTg/bhrY4KMeMmgqeGOgUcoxJ5HhZ4tIm1O4wEYPSBzbjo1L+xms7Ajg7ar4x
         FakWFJtqiUHV05Xfqq58L9Uqbb72YtaWZQohEwgPI6dWW7BzOZItjUg8niy7h9YRnMw2
         weXtiTUWvttZz1tmWEfKisr5HYxXHgXlbUQ33RDpgOH4/YUT6AJrLqqFwuEKT1bNxxmi
         EUn0aSioPEtZuRVavBzlJwIzvCGg24Qt9oA7kdcjAbLQIpUcYDmSQPBRffF5FVPQuYog
         n04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHw6vm1AqKtBc55asTK4A1TUwUAkAjxtXR85iRepLUo=;
        b=qf0OHJVIAgHRloURe0UCU7vsuN3Gtw26wRVZrUqMiNazREsicQMnGyydDWiVtHQL7Y
         /5pgFj+i1g82kWUcVHOUzxmZDfZl6wF5IuqkdAQMx0M60/QBQHkcxARqHoCa37cs1DFC
         HbnWDgA9Gf7yZ6z6qEflf2z++7k5HhbjrAXYy0l3bEBFlokeKpcTCK70girg7NaEWfYM
         y9HgFmTmuumntVQmaI7HW/x5RChL+T1y4AgTJMz1AxWuWNH+bR/zfOs7ZCS+gFFuRFlj
         HLB8yGCJWmiDT41Q77Pc/s8NyZ5rfQROlFn5LTUWtuEGuduflHSWX1HBmdMAqHL1kbJD
         v/uQ==
X-Gm-Message-State: AOAM531904MejPpMpJybU6/D7UGwH/QIJbyDm2kthW35SKphab5TA0tO
        dKpR/wbCMmn4sHhAy4+ZzmkdEWNxm2gQag==
X-Google-Smtp-Source: ABdhPJyQpWLcWvGQNtESGk+efT3ZjsF7UAwB0sTrBoc34ISWDQGWwjLW71YXl3plxbYxaOv3mnZwtg==
X-Received: by 2002:a17:902:f686:b029:de:18c7:41f8 with SMTP id l6-20020a170902f686b02900de18c741f8mr1088130plg.65.1613541797408;
        Tue, 16 Feb 2021 22:03:17 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id x73sm861769pfd.185.2021.02.16.22.03.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 22:03:17 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v3 0/1] Add FITRIM ioctl support for exFAT filesystem
Date:   Wed, 17 Feb 2021 15:03:04 +0900
Message-Id: <20210217060305.190898-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is for adding FITRIM ioctl functionality to exFAT filesystem.
To do that, add generic ioctl function and FITRIM handler.

Changelog
=========
v2->v3:
- Remove unnecessary local variable
- Merge all changes to a single patch

v1->v2:
- Change variable declaration order as reverse tree style.
- Return -EOPNOTSUPP from sb_issue_discard() just as it is.
- Remove cond_resched() in while loop.
- Move ioctl related code into it's helper function.

Hyeongseok Kim (1):
  exfat: add support ioctl and FITRIM function

 fs/exfat/balloc.c   | 81 +++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/dir.c      |  5 +++
 fs/exfat/exfat_fs.h |  4 +++
 fs/exfat/file.c     | 53 +++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+)

-- 
2.27.0.83.g0313f36

