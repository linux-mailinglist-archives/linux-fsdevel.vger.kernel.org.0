Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9153EEB5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 22:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfKDVq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 16:46:26 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37549 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbfKDVq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:46:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id z24so7834355pgu.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2019 13:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RKxr/z5Z+XCc3j/WLz6LF458INM7dnLvQiGuRgdea6I=;
        b=aUeePDR4M3K0hR7Q/iY4hBk2QT31NbRREwi99q6z/u/H7pYqS80kMgv8cfnvtshvAv
         VkJMotphwEiRP9kA7IZ4WieHSR5kijvuyO7V0Wq4QIfiPjshpuOvK8o2ZrydNAwfQdfE
         OinYsra052NUoIMic9pUp++YgcScLmujdziWX1C+Al6yNoWfEZ4SKAmpuwGIyP95/E2O
         vsMq9BacQ3oZyG9cCe2xyk2VvnpF/cqSuIZydpVueZTsqCkDC0jVqWq/MNxmHWgtxQ1x
         oXk0ys7HrLlD+ZF3R3qe3p7Bsdyvw+gNuuzAEUdV+2SGbShHAqHGkM/vkCF6XzCa+mlL
         Ndkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RKxr/z5Z+XCc3j/WLz6LF458INM7dnLvQiGuRgdea6I=;
        b=gT8+vZyBbDnvbO2TDxG4fA3UIyLAiiZETZCKewGgXqqZlH3Mb0uJKTwdp/3F7sJ1oO
         DZPT5MyynKeMPgjt2ZnRz6Nda5XquHteMSxLPEva6AwkcM84PYTXjVdvOxlDG7BTfo/r
         /YqCYK+zwy5u8BbSu5p3mJaRGJI3s5B3GOEPe9s5q0kQdS+WVAou0gas5BrmRD2JcMIU
         iv7RrdqmH2R3IT7fpwhh5rRvlMFrlCmYJmCCzJrXp0oE6F6L97HkLDZRZTWCEoZ0nfRo
         jWO0BmI5JFNvTnvPVTnpA5fgRqTlE54bnVaaR9I4f27ozOZ8CJZu+1IIACynPVmVRn2S
         mR2w==
X-Gm-Message-State: APjAAAWdbEoqw+I8655pKC3lh20uNo2QSi54LEIoDjxiGFSgi35BfVk9
        BemEis20EFUGhGjzrjy5HQmoSQ==
X-Google-Smtp-Source: APXvYqwuRMT5lNvuPuITVIvesrzmLt7bbeQv2zTddIBYVppkD8brZ4Ux1AopMTxEtLhaeVJ3FtMRQQ==
X-Received: by 2002:aa7:980c:: with SMTP id e12mr33717564pfl.165.1572903985750;
        Mon, 04 Nov 2019 13:46:25 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id i126sm18547901pfc.29.2019.11.04.13.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:46:25 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] MAINTAINERS: update io_uring entry
Message-ID: <efa17e7d-b33a-c032-1a90-c150d1632ab8@kernel.dk>
Date:   Mon, 4 Nov 2019 14:46:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We now have a list that's appropriate for both kernel and userspace
discussions on io_uring usage and development, add that to the
MAINTAINERS entry.

Also add the io-wq files.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..7afb25707098 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8562,12 +8562,13 @@ F:	include/linux/iova.h
 
 IO_URING
 M:	Jens Axboe <axboe@kernel.dk>
-L:	linux-block@vger.kernel.org
-L:	linux-fsdevel@vger.kernel.org
+L:	io-uring@vger.kernel.org
 T:	git git://git.kernel.dk/linux-block
 T:	git git://git.kernel.dk/liburing
 S:	Maintained
 F:	fs/io_uring.c
+F:	fs/io-wq.c
+F:	fs/io-wq.h
 F:	include/uapi/linux/io_uring.h
 
 IPMI SUBSYSTEM

-- 
Jens Axboe

