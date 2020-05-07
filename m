Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B701C8460
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 10:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGIJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgEGIJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 04:09:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF94FC061A10;
        Thu,  7 May 2020 01:09:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so5691877wmh.0;
        Thu, 07 May 2020 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject;
        bh=jR1MZCjF38fWU+LxN71+jSE3FlhaVfIor4D/ei15y1Y=;
        b=GDik42E9/CMfBOEH7A5APUlBaFgXK9fgGaZnLqOfjsYhO7Ofiiay5IskUw81oO0ccg
         3RnsVZVLWrPtrDwqBkvyvHdYqg++mbkKyusMRtXGhozx74Q56d/gvh1stUXQswST/OO5
         koJ+W5h7xueUX2EblrkwgJRUMGcfg0dX0Bfpw9cxEgEMdXEKVLvzSmDHBtB+7OhoPD22
         r/LF5VS5XSMEFIg5r5IMt8jVh6aJSXLTZC4C1TeSNw4q3oAuV6YGOARdMtNiYe3TfhR2
         FIb8KAnrnNH86bh5u3HEVvE/PZk5mgI/9KZQRGMvWrUUIWKmGcdtqijc63st5ZZd7/1o
         phug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject;
        bh=jR1MZCjF38fWU+LxN71+jSE3FlhaVfIor4D/ei15y1Y=;
        b=CfI+kWRpXEqaYK2o/QgjEw6Wc5mIoUxxjPxsNk/U2z35PFmBanXdXlKaTjc6sqhVdi
         mU/Y3k3Ac2TkvQPYJjGCde52oTEvSQMBQN3X+uJ8V9ZOaTJnGwV+8IJjsLr+EYTOnmqg
         qzdWiP7VbLQQAYnucq2adT4K9QrImgLDVG6XgVq0+13Gys0R3pf7K4wPDKWwyUqgTGsQ
         VhKGPlolg0WrPuf1DzxRj3Bxqli5fKjEj20omoXUjvwARswi9TU+gJFgsvlCZbGEpoAs
         YZvcOkxHHUc6ncvIDr21DzUxuEPZFJoMttFgUN6PqaLATAxm942Pp6lD1wRcHRVvO9Ji
         JHxQ==
X-Gm-Message-State: AGi0PuZ6HgOAwHsJ3EemlSjy5Y76tD1ZLJrukEwAKaLkDyw1HvUyueoQ
        Roe4Dg25vB4xG1jd6AeraNU=
X-Google-Smtp-Source: APiQypIr+/fOnkEuUmvqzkfzh++ZPowJLOM0HDYBoLfy0LUOKnVVyVOAdzg75FsOKeAeZdxRhs/TvA==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr4715275wmj.63.1588838970544;
        Thu, 07 May 2020 01:09:30 -0700 (PDT)
Received: from dumbo ([2a01:230:2::ec6])
        by smtp.gmail.com with ESMTPSA id l15sm6576877wmi.48.2020.05.07.01.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 01:09:29 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jWbaw-0004TJ-FJ; Thu, 07 May 2020 10:09:26 +0200
Message-Id: <20200507080456.069724962@linux.com>
User-Agent: quilt/0.65
Date:   Thu, 07 May 2020 10:04:56 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
        viro@zeniv.linux.org.uk, tytso@mit.edu, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] hibernate: restrict writes to the snapshot device
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear maintainers,

  here I'm proposing an improvement to [0] which aimed to quickly solve
a regression. The aim is to complete [1] with regards of uswsusp needs,
at the time not considered.

Kind regards,
Domenico

[0] https://lore.kernel.org/linux-pm/20200304170646.GA31552@dumbo/
[1] https://lore.kernel.org/linux-fsdevel/156588514105.111054.13645634739408399209.stgit@magnolia/

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
