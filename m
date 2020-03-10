Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2552F180176
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgCJPT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 11:19:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34151 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgCJPT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:19:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id j16so13513898otl.1;
        Tue, 10 Mar 2020 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xX58n7HrcqiWwfqiADHm2VC/zPfB/XyLn2w/ITZTBso=;
        b=YWw4nos7b+hGzOMSwwJ38VHt9AgaUg0Z4LDMkDR9Z7KwabqUlEbgKD4NC+O62KLKd9
         G0IqKWl2WDgQ+w2NlE9BX3RiUlnVa0XFERlBm+FRuQo4y9agaH39uFMutpT7+svV/Ocp
         cc++/jtIHoXVAcDea1eMt4A4nEgT95Xy0lkcRsozndacPoFMH7wbUOdO9oaIr6u540e2
         AqTSqiwJ00yW49gad9fsttuNE50GaGehNizm/wEZY6N/Cjwzj6YW+Ii+pcjS8K83GLdU
         OA/lKNGWCMkUx5vW6BGVUdgGeZumA0lyYwQJ53hWiXNpKL/nqOfYebD26hfFMAMmqk1f
         0WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xX58n7HrcqiWwfqiADHm2VC/zPfB/XyLn2w/ITZTBso=;
        b=sZ03pfMu8vs2z916njkgHYWSyTxdVbZwb6D/xrH3auVmZqHpR2gqrb1y2LuOnLEJrb
         BgzaA0ykYPczMfKGmoehRMbM3H7M5H5cHM2BpWRcfCd7onQZ9iihBLFwqTgaKroi4aqY
         X8mDG/8VF6kHt912tVm5DlidW7bJHX19DIDXT3paqLsPkrdk+ySVfWKncJKrc806E6fh
         BFTNDilDYnmUdeXQpU5NUR2KHoa5/tcJQCjp+8/4rqRsyphuXy5j/fmVSJ5cSrNi0pHB
         aWBKrTiO0dexrHNEzbW6lgkSPKwqgI6EHorr8gYkqa5yyMUJ7dcrWXBv7scNV5N/Q+wy
         ndug==
X-Gm-Message-State: ANhLgQ0mtI0a1yp6yPycteMc53V1y8lvszk0M/E47Xei+tOveUXQX1Rm
        0i+KaJ3ONGGNTNRX9/94Dwsd4LvF+Iz094ye0ao=
X-Google-Smtp-Source: ADFU+vset1oBmJxvGBEb6dStPd1IDmEUChQ7RV3Q5I/mdy+vXN/44NJcuRJgMGpYckoc0sMxuU1Nx/smi65szqP1tKU=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr16435956otr.89.1583853565299;
 Tue, 10 Mar 2020 08:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200303225837.1557210-1-smayhew@redhat.com> <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
 <20200304143701.GB3175@aion.usersys.redhat.com> <CAEjxPJ7A1KRJ3+o0-edW3byYBSjGa7=KnU5QaYCiVt6Lq6ZfpA@mail.gmail.com>
 <20200306220132.GD3175@aion.usersys.redhat.com> <dc704637496883ac7c21c196aeae4e1ab37f76fa.camel@btinternet.com>
 <CAEjxPJ6pLLGQ2ywfjkanDNZc1isVV8=6sJmoYFy8shaSGr972A@mail.gmail.com> <46f9ffe8fa54538951dacac478c08077a744c8d7.camel@btinternet.com>
In-Reply-To: <46f9ffe8fa54538951dacac478c08077a744c8d7.camel@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 10 Mar 2020 11:20:13 -0400
Message-ID: <CAEjxPJ4_kBJF4=K_k54_o1xT11NKFTkdfFRNMMiSsWdiXva0EQ@mail.gmail.com>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Scott Mayhew <smayhew@redhat.com>, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, bfields@fieldses.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-nfs@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 9:27 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Mon, 2020-03-09 at 09:35 -0400, Stephen Smalley wrote:
> > 2. Mount a security_label exported NFS filesystem twice, confirm that
> > NFS security labeling support isn't silently disabled by trying to
> > set a label on a file and confirm it is set (fixed by  kernel commit
> > 3815a245b50124f0865415dcb606a034e97494d4).  This would go in
> > tools/nfs.sh
> > since it is NFS-specific.
>
> And another one. If you run the same mount twice using mount(2) you get
> EBUSY. If you run with fsmount(2) it works. A simple test below, just
> set $1 to fs for fsmount(2)

I don't know if that's a bug or just an inconsistency between mount(2)
and fsmount(2).
Question for David, Al, and/or fsdevel (cc'd).

>
> Otherwise I've completed the remaining tests with no problems.
>
> #!/bin/sh -e
> MOUNT=`stat --print %m .`
> TESTDIR=`pwd`
> NET="nfsvers=4.2,proto=tcp,clientaddr=127.0.0.1,addr=127.0.0.1"
>
> function err_exit() {
>     echo "Error on line: $1 - Closing down NFS"
>     umount /mnt/selinux-testsuite
>     exportfs -u localhost:$MOUNT
>     rmdir /mnt/selinux-testsuite
>     systemctl stop nfs-server
>     exit 1
> }
>
> trap 'err_exit $LINENO' ERR
>
> systemctl start nfs-server
> exportfs -orw,no_root_squash,security_label localhost:$MOUNT
> mkdir -p /mnt/selinux-testsuite
>
> if [ $1 ] && [ $1 = 'fs' ]; then
>     RUN="tests/fs_filesystem/fsmount"
> else
>     RUN="tests/filesystem/mount"
> fi
>
> $RUN -v -f nfs -o vers=4.2,$NET,context=system_u:object_r:etc_t:s0 -s
> localhost:$TESTDIR -t /mnt/selinux-testsuite
> $RUN -v -f nfs -o vers=4.2,$NET,context=system_u:object_r:etc_t:s0 -s
> localhost:$TESTDIR -t /mnt/selinux-testsuite
> echo "Testing context mount of a security_label export."
> fctx=`secon -t -f /mnt/selinux-testsuite`
> if [ "$fctx" != "etc_t" ]; then
>     echo "Context mount failed: got $fctx instead of etc_t."
>     err_exit $LINENO
> fi
> umount /mnt/selinux-testsuite
> umount /mnt/selinux-testsuite
>
> echo "Done"
> exportfs -u localhost:$MOUNT
> rmdir /mnt/selinux-testsuite
> systemctl stop nfs-server
