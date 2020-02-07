Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED31552DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 08:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgBGHWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 02:22:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33030 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGHWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:22:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so677074pgk.0;
        Thu, 06 Feb 2020 23:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nmzbdbheHnMaWDPCmLrpqSuNwo33dHsSoSoy5YyYwM=;
        b=AaAL+l83QI85UuIoZ1kC5flbtXie45z5c0MXrQ5smNfuNNTIMXlpJBEP0B7hnma/rw
         lFwwB47Wd5lplteiQ6D72pOU+foZzRh1fBucRMGAYJzU8SvR/57bTvVqVrXZgvKtqmJh
         hDMU9hlvwbbsm7gMJGMDQjFJIxcUkyCjbgYM5dcQc1DcOi7z5pU1kPVGHBF4VWiTjiLq
         2ra6bqtMQFgnDkXQGC+7AS+mdp3UWhugldc9AHkQQH8ltddrievQAE1GzdOM3uWQb1n7
         3c1XCKcsad4owQlh2dsboaE+vU2pF3ddZr6ZM2K06B/QyjWfLSsu7RBBbWtN9F9jrBCo
         9Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nmzbdbheHnMaWDPCmLrpqSuNwo33dHsSoSoy5YyYwM=;
        b=kUZSXJbRm7aghplogySWLDHmzseXuktwTRaFfDxQ+YVlr0bv2VUafRtXT24g7tp2ii
         afy4Stud7m4X1l5omhiyeDfLpWzafcmMMikylBVmc/LapIfuGJtLt25QbIVZsGngLo4z
         6u1xFqQF6S/lqMoYvunMr1VJ6dfyiQ/aIjjZzGF8KA0MwwAHVQxPIrkG+B2XLGxsU4Gp
         /naEuwECMXhCOTp2sePNK6uhUjcWtm0jacLjSOJZzji0pliW7yW+HNVbB9XhN+TWeAgV
         2tHAevxkQAFd1X3o6T8uG08Q8AVVaUpcyhANmfyCRe7u1qYCv1prbqOhzOItuFdZyTjF
         RfnQ==
X-Gm-Message-State: APjAAAV1dyBtYUTh4IZu4S7YzAsf3nxtKamhFzoFvVG7e5Gp/d2dcKYK
        ynXM7+e5sUQoD5oas60koiU=
X-Google-Smtp-Source: APXvYqzz7H44XZXtYwGpFa8jSSuYPRjLQ10eQfXLUPfxbIo9oWFQOVlFnQE1iXssNDQGkzy2M/lhfg==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr8691972pfi.25.1581060166212;
        Thu, 06 Feb 2020 23:22:46 -0800 (PST)
Received: from localhost.localdomain ([2408:821a:3c17:470:6d92:2bc5:fbc9:5826])
        by smtp.gmail.com with ESMTPSA id g72sm1760633pfb.11.2020.02.06.23.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 23:22:45 -0800 (PST)
From:   youling257 <youling257@gmail.com>
To:     arnd@arndb.de
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        youling257 <youling257@gmail.com>
Subject: Re: [PATCH v2 20/27] compat_ioctl: simplify the implementation
Date:   Fri,  7 Feb 2020 15:22:10 +0800
Message-Id: <20200207072210.10134-1-youling257@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20191217221708.3730997-21-arnd@arndb.de>
References: <20191217221708.3730997-21-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch cause a problem on 64bit kernel 32bit userspace.
My 32bit Androidx86 userspace run on 64bit mainline kernel, this patch caused some app not detect root permission.
