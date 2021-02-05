Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B731046A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 06:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhBEFPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 00:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhBEFPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:15:17 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B4C0613D6;
        Thu,  4 Feb 2021 21:14:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t25so3741081pga.2;
        Thu, 04 Feb 2021 21:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isAWi8fPFjx/Ia6vXx2PX1r2zn0C8sAhYqdeRsuMtFk=;
        b=fFJH6JVTJMZtDTQTqhuO+kUxFtysj5pj7pv67cRwM84IwNBZZoznS2jndwX9NERJcm
         05Fk2U/hCO3CtAggNTJamvNwYiC5dT0yLdALYPPB7VeHGEA2ZVF2oSrZF35nkrtdLPVG
         1+swgpGkthotoLFB1QxJYUf352ZWg7oME4Jd6wjcQTZ3BAsxBTvS42xwDRQsXR0UEgqE
         puE/tMj24Ixa5thE2gvSsMdRqJUrDn19xGyHv4mXZ4H5l+mvW9/hoo0VKjyUp8+Ek9k6
         zqxjU6LzE9GMN8rZ+cpFtBAQMwHMGGc0EMu0jSBR3SNgePrCvdku3DRq6i6CkFdHY7iz
         F94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isAWi8fPFjx/Ia6vXx2PX1r2zn0C8sAhYqdeRsuMtFk=;
        b=gNJIQtRw6w78h3wxlI66AXSZbEz98sKqFj8LdhlEAdopnkojzOF+BdDl/84ICkiOKE
         sgLyTwTft/hZQrL2aIICGS0PkJO+L8/jItmuDaA48Su2W0D7d4SFHzPOa3e/sY/FL36B
         7C7m/IoYzw9Z9AB5QkPpXcEYvuB7/8B5lwQLzG/aHNBtbog86uh/NCipC7XyZahd0wZk
         vRtjyhr5Cry7mn9GtkIvQq0mNnFbBaW1KcI4nDywtLFanICVXdg6p9xadVITzQUWNdEz
         S1JHiE7omZM8Y2yYOz83iw8ylmojplW80D9sfg+kS4t+ZMtjZIBVdBRarf4St/hz+XyV
         Klgg==
X-Gm-Message-State: AOAM532fKHJELixlfrPIWC5ovS4YwXyqy3cHpV0+1u7wbU9ExMZJjmQB
        T4RLdToTLer0zX1vf16G+RKn2B7mbpjWRA==
X-Google-Smtp-Source: ABdhPJyPJN1eq8IK9B+chVbYtlC/k0J1hkZtR1N18+z5sTro9aqq5YJxh6P6Bcq5Kb6lLyby9KhETA==
X-Received: by 2002:a62:1a06:0:b029:1bc:21e:ed47 with SMTP id a6-20020a621a060000b02901bc021eed47mr2706707pfa.40.1612502076839;
        Thu, 04 Feb 2021 21:14:36 -0800 (PST)
Received: from amypc-samantha.home ([47.145.126.51])
        by smtp.gmail.com with ESMTPSA id v126sm5905000pfv.163.2021.02.04.21.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 21:14:36 -0800 (PST)
From:   Amy Parker <enbyamy@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Amy Parker <enbyamy@gmail.com>
Subject: [PATCH v2 0/3] fs/efs: Follow kernel style guide
Date:   Thu,  4 Feb 2021 21:14:26 -0800
Message-Id: <20210205051429.553657-1-enbyamy@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As the EFS driver is old and non-maintained, many kernel style guide
rules have not been followed, and their violations have not been
noticed. This patchset corrects those violations.

v2:
 - Corrected commit message line breaking

v1:
 - Fixed brace styling
 - Corrected C keyword spacing
 - Corrected line breakage for C keywords

Amy Parker (3):
  fs/efs: Use correct brace styling for statements
  fs/efs: Correct spacing after C keywords
  fs/efs: Fix line breakage for C keywords

 fs/efs/inode.c | 36 ++++++++++++++++++++++--------------
 fs/efs/namei.c |  2 +-
 fs/efs/super.c | 25 +++++++++++--------------
 3 files changed, 34 insertions(+), 29 deletions(-)

-- 
2.29.2

