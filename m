Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690F154E90A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiFPSEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiFPSEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:04:41 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719CA27FF4;
        Thu, 16 Jun 2022 11:04:40 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id w27so3251819edl.7;
        Thu, 16 Jun 2022 11:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxBbijLGkabpeC4pY/EUsmny0FnneoQB/NVkI1DMQ9Y=;
        b=xUFv8D74MSaWbtNkt3AGLOcTnwN8xHkMRMa1dbQmUwJwG6ii9RIP+SEJJCz6uc5fSX
         SltgWEfP3eKX2buVdJGGwf1o87hU1ghYz1v4rR75cRFQSDixBZFjfYZ50TkX40K8ot6Q
         wLXFTIq74qEsFLaDoIYNKvk5F1ox4nmHUFrmezK2gDR5kn8sJm3fdpYeP6cDrEJJojMM
         lx8dBgjfFzU4H5ALFB5AwK3u5kq18CTdp72slp6VmwpJYfd1fvxJlP9q/dMxkzevUBMs
         hbpW8WAffH6aPKqrb4u9Bb80xL/wL8n+f+wGH1odlokDy47wbocb3i2PnGieWAeZ0bAG
         qu5A==
X-Gm-Message-State: AJIora99VG7IVYVn7bWz4x0rxJ7om0o91rOwsKQFYEUMnoHDkgOum6YE
        bfCeeNI7Sbmp+2eImJnDurIzYtYXg4o=
X-Google-Smtp-Source: AGRyM1sR+9gzFj0e5k0yuCVOBJtJQuFcfcf9J0crtKteKk55+2+b0UU5rEJx/eOPGRtwLYLptf+wMw==
X-Received: by 2002:a05:6402:28a2:b0:42d:e116:de8f with SMTP id eg34-20020a05640228a200b0042de116de8fmr7965365edb.305.1655402678989;
        Thu, 16 Jun 2022 11:04:38 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7ca4c000000b0042e0385e724sm2233916edt.40.2022.06.16.11.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 11:04:38 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id u8so2833810wrm.13;
        Thu, 16 Jun 2022 11:04:38 -0700 (PDT)
X-Received: by 2002:a5d:620f:0:b0:20c:c1ba:cf8e with SMTP id
 y15-20020a5d620f000000b0020cc1bacf8emr5683660wru.426.1655402677883; Thu, 16
 Jun 2022 11:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <165408450783.1031787.7941404776393751186.stgit@warthog.procyon.org.uk>
In-Reply-To: <165408450783.1031787.7941404776393751186.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Thu, 16 Jun 2022 15:04:25 -0300
X-Gmail-Original-Message-ID: <CAB9dFduhbTyC1_VLYH=Uz=W0JrpByHFzcb7p27_LuVxFA0yFiw@mail.gmail.com>
Message-ID: <CAB9dFduhbTyC1_VLYH=Uz=W0JrpByHFzcb7p27_LuVxFA0yFiw@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix dynamic root getattr
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 1, 2022 at 8:55 AM David Howells <dhowells@redhat.com> wrote:
>
> The recent patch to make afs_getattr consult the server didn't account for
> the pseudo-inodes employed by the dynamic root-type afs superblock not
> having a volume or a server to access, and thus an oops occurs if such a
> directory is stat'd.
>
> Fix this by checking to see if the vnode->volume pointer actually points
> anywhere before following it in afs_getattr().
>
> This can be tested by stat'ing a directory in /afs.  It may be sufficient
> just to do "ls /afs" and the oops looks something like:
>
>         BUG: kernel NULL pointer dereference, address: 0000000000000020
>         ...
>         RIP: 0010:afs_getattr+0x8b/0x14b
>         ...
>         Call Trace:
>          <TASK>
>          vfs_statx+0x79/0xf5
>          vfs_fstatat+0x49/0x62
>
> Fixes: 2aeb8c86d499 ("afs: Fix afs_getattr() to refetch file status if callback break occurred")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---
>
>  fs/afs/inode.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 30b066299d39..33ecbfea0199 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -745,7 +745,8 @@ int afs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>
>         _enter("{ ino=%lu v=%u }", inode->i_ino, inode->i_generation);
>
> -       if (!(query_flags & AT_STATX_DONT_SYNC) &&
> +       if (vnode->volume &&
> +           !(query_flags & AT_STATX_DONT_SYNC) &&
>             !test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
>                 key = afs_request_key(vnode->volume->cell);
>                 if (IS_ERR(key))

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>

Marc
