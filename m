Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADA438C432
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhEUJ7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbhEUJ55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:57:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FA4C061374;
        Fri, 21 May 2021 02:54:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o21so19528367iow.13;
        Fri, 21 May 2021 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69oB8MFLDZscaHQtc1gsfahitoPKORHWiL8/2xC8oEw=;
        b=HrHXsqO8M2nlu+nncOl7KgmQD2OzEuuhFtPGbTUdzamqJ9kI/xjBODymDPS6H9FgT0
         AdZOxFuHEXIVykmNjjR/PNvlW7fEM2Eyuv+9AaLkz5QEfp9AC8zDNK+UmvFeKbzfGQ9t
         Ia/gr8oMm14Miox8O+tEaGlufM+6D2dy9ds/u95ZFDsDd2EB/xyK5WzglkPuEi02Fvd9
         +1RMDjPpcVMrLm2BNFZgM+/7TaCx+wdB2h6HoeXHd/niENufifJReLUSxzSld10Tc3oA
         2oBo1LHIVZsgCstuT1DAhOa/krW2FCtJ8QuPutOg/UV1NBMHSYt1+EgyS93KAzQu8jPx
         jwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69oB8MFLDZscaHQtc1gsfahitoPKORHWiL8/2xC8oEw=;
        b=btIPhHBK+BRVW3TMXFnVWQWDFK7Hborsc8Bt3WrMobe/2YsTleXJNKldaO8RcXP0sX
         j+4R9GJlxCdr28esbYhlvPJIZzr0CvjZSbfKR856gHSfeP9Gnt89n3z22vQBXGlGOfmS
         2m5aIymrDGBNbFkdaOdzoI/HXlEZL7yKq4X15HHB347yI/rjaL0P8WwZAEhfKELR0/wY
         QhKQwqRyDgQJAdj9xU1NV6HkCo2TZJx98K2DEmOcfatkzWpy6k3Q2RRuUbOMeA9O8FFT
         GHbm93OFPf5yqPAwLosxVCFbZCBoQQEEAgy4wj+w8pfgMmcUip3IbKemqK7QLj4x6ORd
         wCug==
X-Gm-Message-State: AOAM533J3OkYlOUFEacETMtTaFe4ytwPOCq3xkzY4aoh5xGXlgsI6zDE
        1GNqVjA8sGt94qD8EktsA2dCNQ7BZlrqMyxQpx0=
X-Google-Smtp-Source: ABdhPJxB7eUjXb3Nh0Yoh1cz+0THUZb/RD253dC9XumdU/oScGkHyawPwpkzx2qQkrRxddb44+yLVzh+Ch+Xj1NcACI=
X-Received: by 2002:a02:3505:: with SMTP id k5mr3277378jaa.123.1621590857099;
 Fri, 21 May 2021 02:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com> <20210521024134.1032503-12-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-12-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 12:54:06 +0300
Message-ID: <CAOQ4uxhNm57vGTZ2vGZjyrnLCg8fCA-zE7hFBi6Mu1mHeJyOpw@mail.gmail.com>
Subject: Re: [PATCH 11/11] Documentation: Document the FAN_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  .../admin-guide/filesystem-monitoring.rst     | 52 +++++++++++++++++++
>  Documentation/admin-guide/index.rst           |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
>
> diff --git a/Documentation/admin-guide/filesystem-monitoring.rst b/Documentation/admin-guide/filesystem-monitoring.rst
> new file mode 100644
> index 000000000000..81e632f8e1de
> --- /dev/null
> +++ b/Documentation/admin-guide/filesystem-monitoring.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================
> +File system Monitoring with fanotify
> +====================================
> +
> +fanotify supports the FAN_ERROR mark for file system-wide error
> +reporting.  It is meant to be used by file system health monitoring
> +daemons who listen on that interface and take actions (notify sysadmin,
> +start recovery) when a file system problem is detected by the kernel.
> +
> +By design, A FAN_ERROR notification exposes sufficient information for a
> +monitoring tool to know a problem in the file system has happened.  It
> +doesn't necessarily provide a user space application with semantics to
> +verify an IO operation was successfully executed.  That is outside of
> +scope of this feature. Instead, it is only meant as a framework for
> +early file system problem detection and reporting recovery tools.
> +
> +At the time of this writing, the only file system that emits this
> +FAN_ERROR notifications is ext4.
> +
> +A user space example code is provided at ``samples/fanotify/fs-monitor.c``.
> +
> +Usage
> +=====
> +
> +Notification structure
> +======================
> +
> +A FAN_ERROR Notification has the following format::
> +
> +  [ Notification Metadata (Mandatory) ]
> +  [ Generic Error Record  (Mandatory) ]
> +
> +With the exception of the notification metadata and the generic
> +information, all information records are optional.  Each record type is
> +identified by its unique ``struct fanotify_event_info_header.info_type``.

Out-dated. Unless you decide to add support for optional FID record.

> +
> +Generic error Location

'Location' seems irrelevant?

> +----------------------
> +
> +The Generic error record provides enough information for a file system
> +agnostic tool to learn about a problem in the file system, without
> +requiring any details about the problem.::
> +
> +  struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       int error;
> +       __kernel_fsid_t fsid;
> +       unsigned long inode;
> +       __u32 error_count;
> +  };


Maybe add some text about the fact the inode info is optional,
purpose of error_count and the fact that the info is related to
the first observed error.

Thanks,
Amir.
