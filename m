Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB71F9444
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgFOKFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOKFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:05:20 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5820CC061A0E;
        Mon, 15 Jun 2020 03:05:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p20so17105775iop.11;
        Mon, 15 Jun 2020 03:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfs5PllpQpG9QpYkVZTr5YGvpGpnNGmZTQiHA7UaSnw=;
        b=Rm9uZHQ6qwXtdXIirn2i9Fii8ebIQCWolZpKBzlXT7okYU7u/azWvU+8b7sqW/YcUW
         ueDgXdICoowFfocCx2+bP5cZxxiTGZtoFD3Rj8MxuHhfGVMxP7A/5vZklUxUQWT6aBk7
         NHE4H4ZlKtqPC6AAfiJIFbn2Hu3ZCcHe509LrqUtQkVMKdzYbtP5q06WyV53SY4sM1Qb
         JBGM/6CD86ycKuf94WO1HOtOjPs5KHWV4GLz3kfw3sSWOALL1SZWpfEKCo/5LnkgNRvw
         yPJKX2c6g34XP6ZRPKLvPGsaYZiUQt7NoWsovDir5xdi39QJv9qax/GvJ2byOJbpoh1j
         R9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfs5PllpQpG9QpYkVZTr5YGvpGpnNGmZTQiHA7UaSnw=;
        b=ZCG6wxvHKYa0FlJEsBekRj4kPd4tHv+NqTmh4PnFRGxvu7z7qpThI0chDLih0rrnTP
         kDyf2GTQzCKDjICc6vG98Aw3uZQSoKrD33IKVanphAOu38QJNO5STKupfofE6sBq7qqk
         mwDr0excSEMmd1LKOAaAf+rGTi6krek/wjq32Blkn0bGfdj+q067PeUMRfLSQO5CE1ge
         8uhwFXFRdXMmpnWyZtfFhJjGwlHYWI8MYMWY+WxNP+bkMpjksKtIJXQRX6OPxijAgraZ
         rM1XXYJ0bZ3DeUlLe/BdSW8QBwd6Cd2z6fFO2jaL7z7XC/evTdyzoc1PGLdzuADUlYiC
         vuvA==
X-Gm-Message-State: AOAM532IBfPHP9PCrYt/i6OCa7d38JaRrSBcFtJUGLZwdQTQuVfR3D2X
        6r9saIUm7rBc6NOoT8XgqTE64iVq8b+HEDqDa5c=
X-Google-Smtp-Source: ABdhPJw2ZNSatUBV5nkdNWJB5epCtTEMUWyTNWezAfi/r72JR+OKrJKz92f3vb55u1hjxnOO0jazboJ+w2X3EnzYQqk=
X-Received: by 2002:a05:6638:d96:: with SMTP id l22mr21113713jaj.120.1592215519677;
 Mon, 15 Jun 2020 03:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk> <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
 <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
 <6e8924b0-bfc4-eaf5-1775-54f506cdf623@oracle.com> <CAJfpegsugobr8LnJ7e3D1+QFHCdYkW1swtSZ_hKouf_uhZreMg@mail.gmail.com>
In-Reply-To: <CAJfpegsugobr8LnJ7e3D1+QFHCdYkW1swtSZ_hKouf_uhZreMg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Jun 2020 13:05:08 +0300
Message-ID: <CAOQ4uxgA+_4_UtVz17_eJL6m0CsDEVuiriBj1ZOkho+Ub1yuSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:53 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sat, Jun 13, 2020 at 9:12 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 6/12/20 11:53 PM, Amir Goldstein wrote:
>
> > As a hugetlbfs developer, I do not know of a use case for interoperability
> > with overlayfs.  So yes, I am not too interested in making them work well
> > together.  However, if there was an actual use case I would be more than
> > happy to consider doing the work.  Just hate to put effort into fixing up
> > two 'special' filesystems for functionality that may not be used.
> >
> > I can't speak for overlayfs developers.
>
> As I said, I only know of tmpfs being upper layer as a valid use case.
>    Does that work with hugepages?  How would I go about testing that?

Simple, after enabling CONFIG_HUGETLBFS:

diff --git a/mount_union.py b/mount_union.py
index fae8899..4070c70 100644
--- a/mount_union.py
+++ b/mount_union.py
@@ -15,7 +15,7 @@ def mount_union(ctx):
         snapshot_mntroot = cfg.snapshot_mntroot()
         if cfg.should_mount_upper():
             system("mount " + upper_mntroot + " 2>/dev/null"
-                    " || mount -t tmpfs upper_layer " + upper_mntroot)
+                    " || mount -t hugetlbfs upper_layer " + upper_mntroot)
         layer_mntroot = upper_mntroot + "/" + ctx.curr_layer()
         upperdir = layer_mntroot + "/u"
         workdir = layer_mntroot + "/w"

It fails colossally, because hugetlbfs, does not have write_iter().
It is only meant as an interface to create named maps of huge pages.
So I don't really see the use case for using it as upper.

Thanks,
Amir.
