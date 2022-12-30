Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81999659D57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 23:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiL3W6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 17:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbiL3W6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 17:58:21 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DBF1B9E2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 14:58:20 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id n78so24827321yba.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 14:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqtp6bJvnIdH4l1kpVXjKH6th+W9ZeGI3ZtjXCjz/08=;
        b=jENvGtkb4U49d9eBV72YgxKq/biLIDdS/PBHwRGGpWiQYohJJz9FqMWqTbd6vMiVVr
         mbkv9H1GYFdbBtqiHlw00fbGNWF9ha2SlBPa4J5GwkIMNUKWVUmELvQlZ1ImHaM4+swT
         qfF62x0SBX3D8ROqq98HMEJax2TB/MHv/EBZaWqFVxyA4r7hLwjeSxh/FfwLdPVJYZ98
         9k0wxdy7UkkwRewXF5HZgym1tJaA7TdN4YUk5aKJWC74r0altkxkG8jpeT7UoUjY0dHg
         wmtwJrl35eybVVEkGboimbpXWPDFXzA4XKLMVUp4N+poYr6aN3tYjky6f9SL8PZEMbxp
         umMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqtp6bJvnIdH4l1kpVXjKH6th+W9ZeGI3ZtjXCjz/08=;
        b=Jz6/nDxcvAu0n0865SLJYPfVMSxqdeArAugaJSYZshdzoEXajPsogE0VStv7E6Igxr
         txSr14rVoMOLR0Np/ig0ZQy+do3J3kZ43pNn94sQ8pixGowX7HYokzwrdn+eU7fR7OA3
         VFPvplWMjJIW3Yf22ZencDqVixpAYKTjfjZbq+M2NP23ukJuIATEpQ5YQR5csyr25l68
         VxeE9FJvFGr4nf3ZqkELokea4F4sITV/lYniKuwF61l4I7ZXCDgnF5jGoAocElmZVKSx
         RwEXoWVw7xJuzwqQ1uCJngc+tQNGxAEgvCgVidtm3uQ7Cu9o3WrbuU5x2vV0iJj6L0CP
         9LcA==
X-Gm-Message-State: AFqh2krogpSz5EUdPUj+FMkjKNYwjK62YqoWeqNmAshI+AKwd7m9CqEK
        1sMceKnxkS+2dh21f1nkTe8PCj5aMAWhgMmE6S230nU9u1A=
X-Google-Smtp-Source: AMrXdXsC7JbBCVEGddX66FPZbt/6weLgp5xnwk92EQNzWCwQ5aMSLL6kVvHgEDPHmxdvjJUu0K8dwpVBecpNawwc6RM=
X-Received: by 2002:a25:3452:0:b0:754:1cc3:a34d with SMTP id
 b79-20020a253452000000b007541cc3a34dmr2876054yba.304.1672441099921; Fri, 30
 Dec 2022 14:58:19 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQOZx85f3KxKO1feSPcwYTZGRNNVEgqn4D_+nhhXvqQzQ@mail.gmail.com>
 <Y67EPM+fIu41hlCO@casper.infradead.org> <CAM7-yPROANYjeGn3ECfqmn0sLzEQPUpzCyU5zSN3-mJv3UA4CA@mail.gmail.com>
 <CAM7-yPSDZG6Sd9pcm+5zXteMfKYujZ8bjpywwJV4whrmRr+ELQ@mail.gmail.com> <Y69dRHaTLqgY+vLG@sol.localdomain>
In-Reply-To: <Y69dRHaTLqgY+vLG@sol.localdomain>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sat, 31 Dec 2022 07:58:09 +0900
Message-ID: <CAM7-yPSdnPg56fQ=j11neee5UN3jLE6e3D5tmtMxHufR_nVD+g@mail.gmail.com>
Subject: Re: [Question] Unlinking original file of bind mounted file.
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> No, it doesn't change the refcount of the dentry.  The unlink does temporarily
> increment, and then decrement, the refcount.  However, there is still another
> reference that's held by the bind mount.  For that reason, the dentry's inode is
> not released yet; instead, the dentry is just made unavailable to lookups.
>

>You can't actually do that, because the unlink fails with EBUSY.  And even if
> you could, it would be a different dentry (b instead of a).

Thanks for the correction!. I've said wrong sorry!


> If you have a reproducer for an actual crash, please provide it.  (And if you do
> indeed have an actual crash, please consider that its root cause may be
> completely unrelated to the theory that you've described...)

What I describe doesn't cause any panic. but I've traced with crash in
live below situation.:

======================================================
/**
 * NOT directory bind, file bind.
 */
1. mount --bind {original file} {bind file}

  // original's inode->i_count = 1, inode->i_nlink =0, and ext4_inode
becomes orphaned,
  // inode->i_no which managed by ext4 is freed and become reusable.
2. rm -f {original file}
=======================================================

It's not issued remove of bind itself. after step (2)
In the view of VFS, inode seems live, but in the view of EXT4, it
becomes "orphaned" and
its inode->i_no which managed by ext4. was removed and reuse by other
created file.

In that situation, if inode->i_no is reused, via bind fil,
It seems "arbitrary access" the data of new created one with same i_no.
(write, and read...)

What I wonder is that it's intended action or not.
IMHO, should it prohibit to unlink of original to prevent above
arbitrary access?

Thanks.

--
Sincerely,
Levi
