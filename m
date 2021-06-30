Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EC43B7C87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 06:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhF3EVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 00:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhF3EVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 00:21:40 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019FC061760;
        Tue, 29 Jun 2021 21:19:11 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i189so1532628ioa.8;
        Tue, 29 Jun 2021 21:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rx8A797G1YBpPMe7byH4D0TVQJIokYuVRNbWX9cvnco=;
        b=Z8y5OGy7Er5yazYRAliRflePcje/Er1l8rzJ7wHxJSJg6XoRi1D9KyPUr7vDiWwDil
         bJSZsXGPPHMAzyzVtmArvvLmbP2rC8a968DCpqLgH9H1Zh1/O1uZq3j+M//lZVZd1Hs1
         MjC4WYD7ZcDVpWc5jD5qZ/anJpXgnAyit7gAISLXm/5asxDX7CNYRaZZxwd3wCWih7H0
         h/dVIUBkK654QsVriKYgpp8IzVRuOUqpQlYeQnfm175qqSd1jfktR5tnDxa0z2Iy/S5D
         /MtlPqZdyl5L/qheW4MnNHUdmgQQTaT7EWgd+ffk2kgjNi2RhKb/ViGMfImhZEz2ajMZ
         tJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rx8A797G1YBpPMe7byH4D0TVQJIokYuVRNbWX9cvnco=;
        b=otRPFrZTbzbOY0BGEmLroMh+Qgs86YOIoZlBbejre1bimRZ4yEhN3qC+GDig8/pyhV
         YPZYto+GiNMswK/xzhy2IrFJWi3Al8fhNOlIi1W1tJUon7+MtXUlCojS662MHT1u4BWR
         nVKebHFs/ZJhMdeh/pPAwb2dcnOIyIC9vBgt8guunYnHC288H0dM1fqK5ZQOs/NRLniQ
         ecYCXzzdg7LyD2AknPWSkOuFVcCiVg+8t1cWkrECrjDO8tX13lgiF80SVxclYBaQt01L
         jTEU4zFDag+0E0x5ct9eMUjv6bPYUHYhJtb7/sK1/XtfyjqSba+3geU4GZPBaqPUNv/z
         wPEg==
X-Gm-Message-State: AOAM533wDEZHcJCwB0CuaKA6pF7lnQVZx3kYzHXU54UdMHPrqpaztSC2
        kzdeM8Nh5PnLO+NvtixzAUxuTdINwu4SnqHMAD8=
X-Google-Smtp-Source: ABdhPJyYVFgpyttLNp4z81d1/u3emYEyD+aMYZgk2hYw5mpMcie1UMJdLqyJfGHehrwLLUDhJjz3gaNlOijoiy2e4h0=
X-Received: by 2002:a05:6602:146:: with SMTP id v6mr6472057iot.5.1625026750922;
 Tue, 29 Jun 2021 21:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-16-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-16-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 07:18:59 +0300
Message-ID: <CAOQ4uxiOJDQc3nw8sxXD9yO8MSTgMbsqhCP9Xc-x8wnn2mJ0=Q@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] docs: Document the FAN_FS_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:13 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Document the FAN_FS_ERROR event for user administrators and user space
> developers.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
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
> index 000000000000..c0ab1ad268b8
> --- /dev/null
> +++ b/Documentation/admin-guide/filesystem-monitoring.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================
> +File system Monitoring with fanotify
> +====================================

It is great that you are adding an admin-guide book and it is surely
not your fault that there is no existing admin-guide for fanotify to add to.
However, the name of the book as well as this title are more generic than
what you describe.

You see, watching all the deleted files in a filesystem or all modified files
in a mount may also be considered as "filesystem monitoring" by some.

So my only request is that you keep the book name and title as is,
but place your content under a chapter about "filesystem error monitoring".

This way, other people can later fill the gaps.
(CC Matthew Borowski who indicated his interest in doing so)

Thanks,
Amir.
