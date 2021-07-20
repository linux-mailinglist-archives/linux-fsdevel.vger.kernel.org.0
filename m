Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57633CFFEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhGTQcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 12:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbhGTQ1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 12:27:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B853DC061762;
        Tue, 20 Jul 2021 10:07:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c15so3194881wrs.5;
        Tue, 20 Jul 2021 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNygOtZpkIIP08PxsGiZ5ssIxJ/z+tvBQ5q38tIgqgs=;
        b=k1EnSfz85sJZRY6p9qzIgt+o4W9g2sU3MRfFiA3tQU5E/a8CPtAvfRF1+FmvtHuWeo
         5q4g0nsBPzwkiz9WQm88kJmL4h12x0lfr6Y61ih9eD7u7uzqchCrQb5G8ZpfVP0bCTt0
         kZaBgsjJDCioGKO1aq609akM48pm/mprFFqaTve4wJtC+vTjPManzjGcm53ZLJk5lzzc
         RJnrQcWhCAr1Gb4vCrxBPMBrlE+HfIJLyQ1b9w5/YQBoLZUDGqiRStue6ZKhRnbJnoVK
         6qdL2ZlRdRm11hsvTA5l9cLvJBdFWQrZBsG9aQZC7+XgveLz1SauNZNBpbpF4fcMfzg5
         ZWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNygOtZpkIIP08PxsGiZ5ssIxJ/z+tvBQ5q38tIgqgs=;
        b=BTNnD4KDfLWC0eK621RItXOdEePUkr3xPIgno2cppO5tuFsDWNmlcaUHkoE8YHxG29
         kAuPJH6QE3PtF0l2fQ159ibbuomiPZYdQT8g7EIIbnclFj0MTQ8K5EMhHZchUJ1rcGvn
         ymGh5+ZKDn0qv7mt/02UW75NI9diWBMt37gi/iTZu/NUS0QhTljNxhAUzz5/Juq2g06D
         pVDx0cpeiqjM+0j/ig0sQGpc9E4O0+emKB+ev36kNQVwX6xr7i4XwhMlwBZOaFFVteZQ
         ZB5vjAvKarxl8OEiMIDvlsiVFhWnOpg0LBbihPS9yApM5TAXU21GYoBnjbii74OfrBpX
         MlHQ==
X-Gm-Message-State: AOAM5332hGfKTtym186YmtPmZhNg038MlMvTM5kzlHCd7+emttkCGvZZ
        tcFxAmlKI2dvyd1y8DrkER5darOnMqhdSz6j4Ko=
X-Google-Smtp-Source: ABdhPJxHVuHNdNbggrwZQHkYjR15ABf3zbvwV8sxRHzwcBvsks6yv3AlJiBf8yBQrO34v1cGhLP9tBA9nv2bq25DmYU=
X-Received: by 2002:adf:fb8f:: with SMTP id a15mr37716944wrr.92.1626800856299;
 Tue, 20 Jul 2021 10:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210720155944.1447086-1-krisman@collabora.com> <20210720155944.1447086-17-krisman@collabora.com>
In-Reply-To: <20210720155944.1447086-17-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Jul 2021 20:07:25 +0300
Message-ID: <CAOQ4uxhCKYo7Rx3_U=H2JJAK_GkbA-peWZEjyxzd7Sc=s=Eu3g@mail.gmail.com>
Subject: Re: [PATCH v4 16/16] docs: Document the FAN_FS_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 7:00 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Document the FAN_FS_ERROR event for user administrators and user space
> developers.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Expect one outdated detail...

> ---
> Changes Since v3:
>   - Move FAN_FS_ERROR notification into a subsection of the file.
> Changes Since v2:
>   - NTR
> Changes since v1:
>   - Drop references to location record
>   - Explain that the inode field is optional
>   - Explain we are reporting only the first error
> ---
>  .../admin-guide/filesystem-monitoring.rst     | 70 +++++++++++++++++++
>  Documentation/admin-guide/index.rst           |  1 +
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
>
> diff --git a/Documentation/admin-guide/filesystem-monitoring.rst b/Documentation/admin-guide/filesystem-monitoring.rst
> new file mode 100644
> index 000000000000..6c8982985a27
> --- /dev/null
> +++ b/Documentation/admin-guide/filesystem-monitoring.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================
> +File system Monitoring with fanotify
> +====================================
> +
> +File system Error Reporting
> +===========================
> +
> +fanotify supports the FAN_FS_ERROR mark for file system-wide error
> +reporting.  It is meant to be used by file system health monitoring
> +daemons who listen on that interface and take actions (notify sysadmin,
> +start recovery) when a file system problem is detected by the kernel.
> +
> +By design, A FAN_FS_ERROR notification exposes sufficient information for a
> +monitoring tool to know a problem in the file system has happened.  It
> +doesn't necessarily provide a user space application with semantics to
> +verify an IO operation was successfully executed.  That is outside of
> +scope of this feature. Instead, it is only meant as a framework for
> +early file system problem detection and reporting recovery tools.
> +
> +When a file system operation fails, it is common for dozens of kernel
> +errors to cascade after the initial failure, hiding the original failure
> +log, which is usually the most useful debug data to troubleshoot the
> +problem.  For this reason, FAN_FS_ERROR only reports the first error that
> +occurred since the last notification, and it simply counts addition
> +errors.  This ensures that the most important piece of error information
> +is never lost.
> +
> +FAN_FS_ERROR requires the fanotify group to be setup with the
> +FAN_REPORT_FID flag.
> +
> +At the time of this writing, the only file system that emits FAN_FS_ERROR
> +notifications is Ext4.
> +
> +A user space example code is provided at ``samples/fanotify/fs-monitor.c``.
> +
> +A FAN_FS_ERROR Notification has the following format::
> +
> +  [ Notification Metadata (Mandatory) ]
> +  [ Generic Error Record  (Mandatory) ]
> +  [ FID record            (Mandatory) ]
> +
> +Generic error record
> +--------------------
> +
> +The generic error record provides enough information for a file system
> +agnostic tool to learn about a problem in the file system, without
> +providing any additional details about the problem.  This record is
> +identified by ``struct fanotify_event_info_header.info_type`` being set
> +to FAN_EVENT_INFO_TYPE_ERROR.
> +
> +  struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       __s32 error;
> +       __u32 error_count;
> +  };
> +
> +The `error` field identifies the type of error. `error_count` count
> +tracks the number of errors that occurred and were suppressed to
> +preserve the original error, since the last notification.
> +
> +FID record
> +----------
> +
> +The FID record can be used to uniquely identify the inode that triggered
> +the error through the combination of fsid and file handler.  A
> +filesystem specific handler can use that information to attempt a
> +recovery procedure.  Errors that are not related to an inode are
> +reported against the root inode.

Not uptodate...

Thanks,
Amir.
