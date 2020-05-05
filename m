Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680741C5D4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgEEQUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgEEQUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:20:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E7C061A0F;
        Tue,  5 May 2020 09:20:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so2994609wmc.5;
        Tue, 05 May 2020 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xZiPHuUkDPMdsn/Ebr3eeNfvMuqrl5jGDJ67bY+HcSE=;
        b=NrEpin8kfj14i9LXN8uqMicDU6nuzoBGo6QjQQdchqbBlgjSVz/Cczx/dWT9JIb7kT
         3+mAVMk3NRkFeFp1n7vbcEWnrEZJkAHF4VmgVb/KK/rImbiKw8gSc6x7G6UEimCi0PXG
         EKA+QMVnrJr4Vwiy8fM5Au2VecJebWBKDs9zutt/DQY5rqt6sOMOA3zkXGw+GbU1r3JY
         KG7T9PXsEU6TuHa08KqaeoH6b+8B4PHiZXDOGYgme6ROhp2O8U1rD9A/P4sJb1TSEdgT
         fgwPEn436gAcMLCgJOfBt+XVVZSZ+LjfO9TPD+WrgFIeH1SGovXTQhrfgoF3MK5yoR1I
         ZajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xZiPHuUkDPMdsn/Ebr3eeNfvMuqrl5jGDJ67bY+HcSE=;
        b=t1tRZcSrwV0huIdwBJ9AzYEaIt3GpBLoedbLQAX6S2JidKRAWfEyfs90kNHHAlOy95
         2CaD/+HbG99sv/62e7o4+xT7RwN0+MmGsN2gkhCe+bsIDhwa1mGzpTPA3DDLzo+VAh/N
         xVUakk0mLcMfGbejvkvgFdRQ56u9lrqbMOd8G0l6rfux5sikeDc+MRXCgihDuqnVHYTK
         XoPfarnV/6LqssoEX9El31gFcDBMjZETN5f1AP69KjZjUyuELizSmzl1CYSqnE+cW7/N
         lGk4QA77Dl16zYhy9bclElt9VXTWOGvquWKa/i5dq2cziWco6YrPN1gUBGoOEyPvZGgJ
         C25A==
X-Gm-Message-State: AGi0Puaalsidxm1AEwrDzgHmVngC7UHFWI/Qtykm+7fnvTpYAJHa0Gad
        kJi3x7O/OG2lmog+jPgFV+okezFj
X-Google-Smtp-Source: APiQypK3CCYLzi8IpNvGyfY0+V/bINqhoyEegRwbaWuvsDnzcAy9glAgbm0SXbCNDk5pcfL4yS89xA==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr4750719wmk.68.1588695621667;
        Tue, 05 May 2020 09:20:21 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id c128sm1612871wma.42.2020.05.05.09.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:20:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 0/7] fanotify events on child with name info
Date:   Tue,  5 May 2020 19:20:07 +0300
Message-Id: <20200505162014.10352-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

In the v3 posting of the name info patches [1] I dropped the
FAN_REPORT_NAME patches as agreed to defer them to next cycle.

Following is remainder of the series to complement the FAN_DIR_MODIFY
patches that were merged to v5.7-rc1.

The v3 patches are available on my github branch fanotify_name [2].
Same branch names for LTP tests [3], man page draft [4] and a demo [5].

Patches 1-4 are cleanup and minor re-factoring in prep for the name
info patches.

Patch 5 adds the FAN_REPORT_NAME flag and the new event reporting format
combined of FAN_EVENT_INFO_TYPE_DFID_NAME and FAN_EVENT_INFO_TYPE_FID
info records, but provides not much added value beyond inotify.

Patches 6-7 add the new capability of filesystem/mount watch with events
including name info.

I have made an API decision that stems from consolidating the
implementation with fsnotify_parent() that requires your approval -
A filesystem/mount mark with FAN_REPORT_NAME behaves as if all the
directories and inodes are marked.  This results in user getting all
relevant events in two flavors - one with both info records and one with just
FAN_EVENT_INFO_TYPE_FID.  I have tries several approaches to work around this
bizarrity, but in the end I decided that would be the lesser evil and that
bizarre behavior is at least easy to document.

Let me know what you think.
Thanks,
Amir.

Main changes since v2:
- FAN_DIR_MODIFY patches have been merged
- A few more clean patches
- More text about the motivation (in "report parent fid + name" patch)
- Reduce code duplication with fsnotify_parent()

[1] https://lore.kernel.org/linux-fsdevel/20200319151022.31456-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/fanotify_name
[3] https://github.com/amir73il/ltp/commits/fanotify_name
[4] https://github.com/amir73il/man-pages/commits/fanotify_name
[5] https://github.com/amir73il/inotify-tools/commits/fanotify_name

Amir Goldstein (7):
  fanotify: create overflow event type
  fanotify: break up fanotify_alloc_event()
  fanotify: generalize the handling of extra event flags
  fanotify: distinguish between fid encode error and null fid
  fanotify: report parent fid + name for events on children
  fsnotify: send event "on child" to sb/mount marks
  fanotify: report events "on child" with name info to sb/mount marks

 fs/notify/fanotify/fanotify.c      | 213 +++++++++++++++++------------
 fs/notify/fanotify/fanotify.h      |  18 ++-
 fs/notify/fanotify/fanotify_user.c |  46 +++++--
 fs/notify/fsnotify.c               |  38 ++++-
 include/linux/fanotify.h           |   2 +-
 include/linux/fsnotify_backend.h   |  23 +++-
 include/uapi/linux/fanotify.h      |   4 +
 7 files changed, 231 insertions(+), 113 deletions(-)

-- 
2.17.1

