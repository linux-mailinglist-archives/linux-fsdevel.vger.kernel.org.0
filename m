Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA67367834
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 06:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhDVEGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 00:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhDVEGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 00:06:50 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18ABC06174A;
        Wed, 21 Apr 2021 21:06:16 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id s16so38978880iog.9;
        Wed, 21 Apr 2021 21:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcF3dH9D8J2d3hAX5xh3Gkr02GgerEVN2BNTqssnfyo=;
        b=IIRCyYm5fdZGOh6SCYe4yXpgnngtQK4ovM3afyMHgNCTLieCu3ArQtwoB09zXYpVI2
         X7uiR8PY3xtuMmpypcH65uN0+exDDHuIyc0d+ksshA9fapaZsSwxyJ7VaE9Bw8cR/M2s
         ufwbgypE+Wb/hdyGy0fvTArdGLbH/0PaDLYPu/iEbT6eeYpKDY24LarIAzKOosju/gZt
         HPA56R6cPRwaqguWB4ek0/xu4nNTa0Vqvkx2FrWDGV5heuTOZ2GXTuBg/KDr/kNHtiV+
         HBBOgF80AKl5CrnWLAzxxMzxefGh6CPUze8LEX/wwmf5BCB0YCQbsteCHv1bb0SWg3t/
         T8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcF3dH9D8J2d3hAX5xh3Gkr02GgerEVN2BNTqssnfyo=;
        b=jdk8S1VBX+RMTmkgoWEmAJa6HY9FJh4v3psg6vgneQeoDCYgza2LzUM3iVsJG4LY2P
         ndph4HdW8gHRMxrW+g+bpe/GfDk1hWmNPPazF3UQPBsu2FfXYC63XXsnvcYYnUci/wt/
         0+fdiiqC5IWoHBWTSboZQ5shhtdg1qY4Yl50IFy7t+1ked89CvOqn0N0NrdWSp/ZQMpG
         bumfF2Wj3leZRrmm4pt6gndv8gMb3f8uBWw9QQslgl2Waurn7zUSKQDYz7xHOKFx4jaA
         x+8Mkd+SRdf15YnniLLKm7F80JcrskxmNQ+kWVK8SWq9V1AAPqtvNSVLgaOEHQsLgV11
         vZpQ==
X-Gm-Message-State: AOAM532rG2chZMC0YwijQRC8LHbQNGhcYBvFnBu5EwPJwnOdPUtACxhI
        8c6gpQsOp4B/Q6WleiUNAr9q37obha3u2EEsYog=
X-Google-Smtp-Source: ABdhPJxvj/aCAtlVTMmyu3zvAKA5NHNGpEsaJNHLj+fC7/2ighn5TF1exvrJXGXv8dGE2+oigBgO09k/L/M22wrinbQ=
X-Received: by 2002:a6b:f115:: with SMTP id e21mr1107946iog.5.1619064376269;
 Wed, 21 Apr 2021 21:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210422003836epcas1p391ed30aed1cf7b010b93c32fc1aebe89@epcas1p3.samsung.com>
 <20210422002824.12677-1-namjae.jeon@samsung.com> <20210422002824.12677-2-namjae.jeon@samsung.com>
In-Reply-To: <20210422002824.12677-2-namjae.jeon@samsung.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 22 Apr 2021 07:06:05 +0300
Message-ID: <CAOQ4uxgCJukhh9c0FjnP_CR0=Jpj+ObK1JPFVjsD4=oxuakcaw@mail.gmail.com>
Subject: Re: cifsd/nfsd interop
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>, senozhatsky@chromium.org,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        aurelien.aptel@gmail.com,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 4:31 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> This adds a document describing ksmbd design, key features and usage.
>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>  Documentation/filesystems/cifs/cifsd.rst | 152 +++++++++++++++++++++++
>  Documentation/filesystems/cifs/index.rst |  10 ++
>  Documentation/filesystems/index.rst      |   2 +-
>  3 files changed, 163 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/filesystems/cifs/cifsd.rst
>  create mode 100644 Documentation/filesystems/cifs/index.rst
>
> diff --git a/Documentation/filesystems/cifs/cifsd.rst b/Documentation/filesystems/cifs/cifsd.rst
> new file mode 100644
> index 000000000000..cb9f87b8529f
> --- /dev/null
> +++ b/Documentation/filesystems/cifs/cifsd.rst
> @@ -0,0 +1,152 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========================
> +CIFSD - SMB3 Kernel Server
> +==========================
> +
> +CIFSD is a linux kernel server which implements SMB3 protocol in kernel space
> +for sharing files over network.
> +

Hello cifsd team!

I am very excited to see your work posted and especially excited to
learn about the collaboration with the samba team.

One of the benefits from kernel smbd implementation is improved ability
to interoperate with VFS in general and nfsd in particular.

For example, I have discussed with several samba team members
the option that ksmbd will serve as a kernel lease agent for samba,
instead of having to work around the limitations of file lock UAPI.

Could you share your plans (if any) for interoperability improvements
with vfs/nfsd?

It would be useful to add an "Interop" column to the Features table below
to document the current state and future plans or just include a note about
it in the Status column.

Off the top of my head, a list of features that samba supports
partial kernel/nfsd interop with are:
- Leases (level 1)
- Notify
- ACLs (NT to POSIX map)
- Share modes

In all of those features, ksmbd is in a position to do a better job.

I only assume that ksmbd implementation of POSIX extensions
is a "native" implementation (i.e. a symlink is implemented as a symlink)
so ksmbd and nfsd exporting the same POSIX fs would at least observe
the same objects(?), but I would rather see this explicitly documented.

Thanks,
Amir.

[...]

> +
> +CIFSD Feature Status
> +====================
> +
> +============================== =================================================
> +Feature name                   Status
> +============================== =================================================
> +Dialects                       Supported. SMB2.1 SMB3.0, SMB3.1.1 dialects
> +                               excluding security vulnerable SMB1.
> +Auto Negotiation               Supported.
> +Compound Request               Supported.
> +Oplock Cache Mechanism         Supported.
> +SMB2 leases(v1 lease)          Supported.
> +Directory leases(v2 lease)     Planned for future.
> +Multi-credits                  Supported.
> +NTLM/NTLMv2                    Supported.
> +HMAC-SHA256 Signing            Supported.
> +Secure negotiate               Supported.
> +Signing Update                 Supported.
> +Pre-authentication integrity   Supported.
> +SMB3 encryption(CCM, GCM)      Supported.
> +SMB direct(RDMA)               Partial Supported. SMB3 Multi-channel is required
> +                               to connect to Windows client.
> +SMB3 Multi-channel             In Progress.
> +SMB3.1.1 POSIX extension       Supported.
> +ACLs                           Partial Supported. only DACLs available, SACLs is
> +                               planned for future. ksmbd generate random subauth
> +                               values(then store it to disk) and use uid/gid
> +                               get from inode as RID for local domain SID.
> +                               The current acl implementation is limited to
> +                               standalone server, not a domain member.
> +Kerberos                       Supported.
> +Durable handle v1,v2           Planned for future.
> +Persistent handle              Planned for future.
> +SMB2 notify                    Planned for future.
> +Sparse file support            Supported.
> +DCE/RPC support                Partial Supported. a few calls(NetShareEnumAll,
> +                               NetServerGetInfo, SAMR, LSARPC) that needed as
> +                               file server via netlink interface from
> +                               ksmbd.mountd.
> +============================== =================================================
> +
