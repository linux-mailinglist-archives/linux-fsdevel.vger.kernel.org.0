Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40556466911
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376261AbhLBRan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359872AbhLBRam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:30:42 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128DC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:27:20 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso580005ota.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 09:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VcGN66OMRK1XhzLGpEwcANloElYgQiOe9mKqjeCq5ss=;
        b=Xc5H03QFONeOKr6h/gPaHY1y4lY7rB45YFqA2Cmc8IzVxuXMJtUXVlPAlkNyJ/gPTL
         TvetCwUZVEd+CF/FdRJYveUhFr4IgobMQqdlyWrAo8rWCUaW0Dgvxb0/B+Ztdt9YdAPy
         JzVDsPhXuj390Gb676lGePg5wxi2SBgeQlqBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VcGN66OMRK1XhzLGpEwcANloElYgQiOe9mKqjeCq5ss=;
        b=I1S6wkX4PD6FRs0SOIJfsvORk/G7rqSePZcuhOgdZ8Tu48SwRhiZh6AcSzXmbxSn1y
         2tHQ6ryETzOkjtLKxOkByVCJRtxUN+ekywIGA1JFyrR0Wf4WO6BhOVSM+nDrQ1HU2OPL
         TYKJp3oerd+gkmMPvl7dhJt1LkN1IwkQ8S7QiAcIQshtSAE96+Fkrii+6oPaAiarTETs
         WEOv5s1TN45R2FrCAIhkuwcC0WAl7Qjx6F4linzJd9vPSWvB4m+b7HwoYvM79IiKGG1X
         H7vT+yy4wACKncQmeUpUfJe4kXaOhJxo2CDdx7McQxmVMD3xAU8TkbStjjQ0X4D0iwlc
         kw+A==
X-Gm-Message-State: AOAM531qZpfQ6VGoPVMoLlu/Mow3TB3FrVhm+i/EfHDCNVo4blV8C3Ii
        cb8s3eDkVf6HX7qj5C4ILPuQR5j+YwnjVUfR
X-Google-Smtp-Source: ABdhPJz3upn0EEF4UCiYvHaF6rw5Z92UrVcDIvX2i0GRFboilhgV2tFkYgvND+QrrXQEveFpmt3bfA==
X-Received: by 2002:a05:6830:4b3:: with SMTP id l19mr12333144otd.284.1638466039727;
        Thu, 02 Dec 2021 09:27:19 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:49aa:e3a:9f96:cf34])
        by smtp.gmail.com with ESMTPSA id l6sm144787otu.12.2021.12.02.09.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:27:19 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:27:19 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 05/10] docs: update mapping documentation
Message-ID: <YakB9wVjcEHYuZUr@do-x1extreme>
References: <20211130121032.3753852-1-brauner@kernel.org>
 <20211130121032.3753852-6-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130121032.3753852-6-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:10:27PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Now that we implement the full remapping algorithms described in our
> documentation remove the section about shortcircuting them.
> 
> Link: https://lore.kernel.org/r/20211123114227.3124056-6-brauner@kernel.org (v1)
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> ---
> /* v2 */
> unchanged
> ---
>  Documentation/filesystems/idmappings.rst | 72 ------------------------
>  1 file changed, 72 deletions(-)
> 
> diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
> index 1229a75ec75d..7a879ec3b6bf 100644
> --- a/Documentation/filesystems/idmappings.rst
> +++ b/Documentation/filesystems/idmappings.rst
> @@ -952,75 +952,3 @@ The raw userspace id that is put on disk is ``u1000`` so when the user takes
>  their home directory back to their home computer where they are assigned
>  ``u1000`` using the initial idmapping and mount the filesystem with the initial
>  idmapping they will see all those files owned by ``u1000``.
> -
> -Shortcircuting
> ---------------
> -
> -Currently, the implementation of idmapped mounts enforces that the filesystem
> -is mounted with the initial idmapping. The reason is simply that none of the
> -filesystems that we targeted were mountable with a non-initial idmapping. But
> -that might change soon enough. As we've seen above, thanks to the properties of
> -idmappings the translation works for both filesystems mounted with the initial
> -idmapping and filesystem with non-initial idmappings.
> -
> -Based on this current restriction to filesystem mounted with the initial
> -idmapping two noticeable shortcuts have been taken:
> -
> -1. We always stash a reference to the initial user namespace in ``struct
> -   vfsmount``. Idmapped mounts are thus mounts that have a non-initial user
> -   namespace attached to them.
> -
> -   In order to support idmapped mounts this needs to be changed. Instead of
> -   stashing the initial user namespace the user namespace the filesystem was
> -   mounted with must be stashed. An idmapped mount is then any mount that has
> -   a different user namespace attached then the filesystem was mounted with.
> -   This has no user-visible consequences.
> -
> -2. The translation algorithms in ``mapped_fs*id()`` and ``i_*id_into_mnt()``
> -   are simplified.
> -
> -   Let's consider ``mapped_fs*id()`` first. This function translates the
> -   caller's kernel id into a kernel id in the filesystem's idmapping via
> -   a mount's idmapping. The full algorithm is::
> -
> -    mapped_fsuid(kid):
> -      /* Map the kernel id up into a userspace id in the mount's idmapping. */
> -      from_kuid(mount-idmapping, kid) = uid
> -
> -      /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
> -      make_kuid(filesystem-idmapping, uid) = kuid
> -
> -   We know that the filesystem is always mounted with the initial idmapping as
> -   we enforce this in ``mount_setattr()``. So this can be shortened to::
> -
> -    mapped_fsuid(kid):
> -      /* Map the kernel id up into a userspace id in the mount's idmapping. */
> -      from_kuid(mount-idmapping, kid) = uid
> -
> -      /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
> -      KUIDT_INIT(uid) = kuid
> -
> -   Similarly, for ``i_*id_into_mnt()`` which translated the filesystem's kernel
> -   id into a mount's kernel id::
> -
> -    i_uid_into_mnt(kid):
> -      /* Map the kernel id up into a userspace id in the filesystem's idmapping. */
> -      from_kuid(filesystem-idmapping, kid) = uid
> -
> -      /* Map the userspace id down into a kernel id in the mounts's idmapping. */
> -      make_kuid(mount-idmapping, uid) = kuid
> -
> -   Again, we know that the filesystem is always mounted with the initial
> -   idmapping as we enforce this in ``mount_setattr()``. So this can be
> -   shortened to::
> -
> -    i_uid_into_mnt(kid):
> -      /* Map the kernel id up into a userspace id in the filesystem's idmapping. */
> -      __kuid_val(kid) = uid
> -
> -      /* Map the userspace id down into a kernel id in the mounts's idmapping. */
> -      make_kuid(mount-idmapping, uid) = kuid
> -
> -Handling filesystems mounted with non-initial idmappings requires that the
> -translation functions be converted to their full form. They can still be
> -shortcircuited on non-idmapped mounts. This has no user-visible consequences.
> -- 
> 2.30.2
> 
