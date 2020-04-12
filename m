Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940351A5E48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 13:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgDLL3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 07:29:47 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:39075 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLL3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 07:29:46 -0400
Received: by mail-io1-f52.google.com with SMTP id m4so6597107ioq.6;
        Sun, 12 Apr 2020 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lr8Du1SNizwqButahq7qkxIKOJ2tYQem2z0WmME8mcI=;
        b=LRxbCfnM2pAXUuR19iUj6iP0vBxBl6OyeOmOOFBnYiOUeygcQ6wd1ZJA8timIuABUC
         qwiyPIxYWoFB0KCfgStqa+sucIENFSFvuxV8jsgBP98rW2uLQoWKjQxVJhKDGBVZ+6xe
         R7PXQvvSTcHwhvyiqPcN/tjHlnXBVdMgSle2tEim4e0DIJkyK36IJJVTuF4NMB9PnNgy
         B7JPZMVRJ2EQMuwlhRlQreGJoMd/A9TK4nt09k72toTtnRmCb9qFnVIIux0+PIBx24ng
         qHmcHmpPCaKYSBeG1F+fEImHYHNyFphV79PbEwuBStrk1+bH4acZopN6z/F0OA7M8hY4
         zEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lr8Du1SNizwqButahq7qkxIKOJ2tYQem2z0WmME8mcI=;
        b=DNCrM6CC1K7gz75dwyseFfjfYG0aNrb6lKA6PO9gsCRpO8Eje2Tzy75VHJDRsxbSNS
         zWqGkP18q4RFbsG+XbJa29s9KYguopuRHk8bhC8P95t9aLEit8HQG/6rE9f/qS+/qZQa
         xAPKzTsZc3xbb7S1KGlwjn/K1R0pM1+LQZBgU5aM5tHyXnK5EpK2Aeqxr1LUU1hrMO9+
         DSluX7McTJcMjULXVeZDcX939IP/K3aCOo1ZOfYZXP00Tnest2cPbEEHxJQ7NHss1X2M
         dLDcCV/PJLtN6BFziFbNMh9IiVbAxSkiJ4dxdTx48geHuemYYrUek1bHr23wCsYN+iVM
         hRyg==
X-Gm-Message-State: AGi0Pubk4M+aVapQJc/fO1Qik9hs3qL4vXT11L/icNFxAK5lIz5SR7LZ
        afG1agQYkDrEpnsEftJ6sJKQ/QN8kXLg++4gftE=
X-Google-Smtp-Source: APiQypJoFFkbwvHNs7m2NtbtOkd6202kUw0Zhm4Xg4fnqOTM83ohDAaCR7uPl1lz0AyybO2GXi0EnO5JCXeTMI5sX7g=
X-Received: by 2002:a05:6638:38e:: with SMTP id y14mr11426792jap.123.1586690986095;
 Sun, 12 Apr 2020 04:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRw_jGxPqWc68Bj-uP_hSrKO0MmShOmtuzGQA2W3WHyCrg@mail.gmail.com>
In-Reply-To: <CABV8kRw_jGxPqWc68Bj-uP_hSrKO0MmShOmtuzGQA2W3WHyCrg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 12 Apr 2020 14:29:35 +0300
Message-ID: <CAOQ4uxhPKR34cXvWfF49z8mTGJm+oP2ibfohsXNdY7tXaOi4RA@mail.gmail.com>
Subject: Re: Same mountpoint restriction in FICLONE ioctls
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+CC XFS,NFS,CIFS

On Sun, Apr 12, 2020 at 1:06 PM Keno Fischer <keno@juliacomputing.com> wrote:
>
> Hello,
>
> I was curious about the reasoning behind the
> same-mountpoint restriction in the FICLONE
> ioctl. I saw that in commit
>
> [913b86e92] vfs: allow vfs_clone_file_range() across mount points
>
> this check was moved from the vfs layer into
> the ioctl itself, so it appears to be a policy restriction
> rather than a technical limitation. I understand why
> hardlinks are disallowed across mount point boundaries,
> but it seems like that rationale would not apply to clones,
> since modifying the clone would not affect the original
> file. Is there some other reason that the ioctl enforces
> this restriction?
>

I don't know. I suppose that when FICLONE was introduced
there wasn't any use case for cross mount clone.

Note that copy_file_range() also had this restriction, which was
recently lifted, because NFSv4 and CIFS needed this functionality.

As far as I can tell, CIFS and NFSv4 can also support cross mount
clone, but nobody stepped up to request or implement that.

The question is: do you *really* need cross mount clone?
Can you use copy_file_range() instead?
It attempts to do remap_file_range() (clone) before falling back to
kernel copy_file_range().

> Removing this restrictions would have some performance
> advantages for us, but I figured there must be a good reason
> why it's there that I just don't know about, so I figured I'd ask.
>

You did not specify your use case.
Across which filesystems mounts are you trying to clone?

Thanks,
Amir.
