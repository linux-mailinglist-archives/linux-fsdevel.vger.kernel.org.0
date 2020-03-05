Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B32F17B154
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 23:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCEWVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 17:21:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45635 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgCEWVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:21:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id z12so426898qkg.12;
        Thu, 05 Mar 2020 14:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hjtx1RhxIJ79+HtjekmYaD6b4sMC5UbYlDmlzGRDS1o=;
        b=sQN0vEkP3aC1hSrFZP7n9s8CPuE2ahPRI4xmxKaklhHA0PgzPO3hoHAxPlCw/E6QAj
         LJLrjFAzAHGpQa4qWLneFXVGAhy9xmmRsBQYGTgi0ZaoOPF/iBG/v68GL+Gcksb9Bhln
         jzE/lfzrVzIDqnpC/g9pfgA7TBaaB1iDjxIqpofWxpasTENLg3TLRpN2AKKRiY652TOg
         42IaLoNBIQY+hQvcWg3am5RDrCyUWmp+eCtlooyZPY2W6Ae4IHfZfpX+y81a3Q2msCWb
         T6B2VJfsyi72VL1y39OomY3tM5cUwlwwFFl7LWZ4y5gHB0XPOab6Xb8pdbrBjVMquRbu
         6cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hjtx1RhxIJ79+HtjekmYaD6b4sMC5UbYlDmlzGRDS1o=;
        b=tlGFm7OsUAVc1V9wUY9+CjDEYRZ/dVtNmaeTR+WNcroeRizKne7DeTeofgc5mYwANu
         8vHzgukXA1tnOfBs2k2FqxaO/JJAMmCc0xtseO+derrY0WpwxQ6/iaZg8Ck8j/5h4P3U
         feHx1RxmaP1wX1v/GjMfYHXr8Hdic9f9XLXoh3idI48J6XGVaXMR4H8G/RTshDZY+5HL
         4L9DYwAKhU0n7sCYa+PrkyrJ1xgew9XPSSDrrkhCH91U1wGXc4EryCsFbfsj5cNK8jvh
         Sazxek2TXH8oev68cMppBrBkr1Vc4O59aBR9kuvWvx0pNhO05rERWWQ9NTWatYF3pxa6
         jPUA==
X-Gm-Message-State: ANhLgQ345Jo43ywLzbZ+dzn7cAsMzjc0pOANZTg63mqYLq3uENWkXqpJ
        PM/DoMJkBYp+OAfpUsKeE10=
X-Google-Smtp-Source: ADFU+vuEnZNTb7dSSUASyTV4BlDR1ihIyk5njV2lS+G7xSQ3ykeQaeW06bH51aV/12YnCLqp6wK1CQ==
X-Received: by 2002:a05:620a:1186:: with SMTP id b6mr214359qkk.59.1583446881492;
        Thu, 05 Mar 2020 14:21:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d9sm16120639qth.34.2020.03.05.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:21:21 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 5 Mar 2020 17:21:18 -0500
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Ignat Korchagin <ignat@cloudflare.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH] mnt: add support for non-rootfs initramfs
Message-ID: <20200305222117.GA1291132@rani.riverdale.lan>
References: <20200305193511.28621-1-ignat@cloudflare.com>
 <1583442550.3927.47.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1583442550.3927.47.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 05, 2020 at 01:09:10PM -0800, James Bottomley wrote:
> On Thu, 2020-03-05 at 19:35 +0000, Ignat Korchagin wrote:
> > The main need for this is to support container runtimes on stateless
> > Linux system (pivot_root system call from initramfs).
> > 
> > Normally, the task of initramfs is to mount and switch to a "real"
> > root filesystem. However, on stateless systems (booting over the
> > network) it is just convenient to have your "real" filesystem as
> > initramfs from the start.
> > 
> > This, however, breaks different container runtimes, because they
> > usually use pivot_root system call after creating their mount
> > namespace. But pivot_root does not work from initramfs, because
> > initramfs runs form rootfs, which is the root of the mount tree and
> > can't be unmounted.
> 
> Can you say more about why this is a problem?  We use pivot_root to
> pivot from the initramfs rootfs to the newly discovered and mounted
> real root ... the same mechanism should work for a container (mount
> namespace) running from initramfs ... why doesn't it?

Not sure how it interacts with mount namespaces, but we don't use
pivot_root to go from rootfs to the real root. We use switch_root, which
moves the new root onto the old / using mount with MS_MOVE and then
chroot to it.

https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt

> 
> The sequence usually looks like: create and enter a mount namespace,
> build a tmpfs for the container in some $root directory then do
> 
> 
>     cd $root
>     mkdir old-root
>     pivot_root . old-root
>     mount --
> make-rprivate /old-root
>     umount -l /old-root
>     rmdir /old-root
> 
> Once that's done you're disconnected from the initramfs root.  The
> sequence is really no accident because it's what the initramfs would
> have done to pivot to the new root anyway (that's where container
> people got it from).
> 
> 
> James
> 
