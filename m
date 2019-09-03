Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E771A763D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfICVbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 17:31:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41508 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfICVbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:31:19 -0400
Received: by mail-io1-f65.google.com with SMTP id f19so1077427iof.8;
        Tue, 03 Sep 2019 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgg+hgCp6X2Un4SsyW+3qZ5TSFEYSxv9pzy5icvxR5Q=;
        b=cVXx869w7AOAbXnHxMv3DkjrwOXif49phbiltz8MmrsuDF6uuKQUw+qy4J65cDsMZL
         9DhgaVYSi1oZzI/RxpwjvpJSxUoxYl+TqN+Hq5OSob5YNnvbro2nHcIhzR+D7I0PRisj
         A85/YlZGOFrvRSh3Nb+N6SJzjglfxzX/SW6d2DPgdmYHBfhy9R5QxZF51yeCRzYUQp5s
         civHY6gG1Alh2IujuwTP3GVGzsrBdDZ2RH3TY1y/Lbg+1IFxlOFls5D7tAJR9PL1FKk5
         3bWc3iJmJMZ5Y8oWQcOduKeZ1kw623ZQhxHgWIuYFQLP3NzpN4osOpj79BzYWgkqXQrq
         GUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgg+hgCp6X2Un4SsyW+3qZ5TSFEYSxv9pzy5icvxR5Q=;
        b=aArE05oDmHjf0z9GGrEfFZLLVM5rUB3kvYl2fK2dwg9p87LgvvUWTt3b6iMFDLWCb+
         OZq83ewBDhc8CfpEr8+8drsU8l4Z94YntUF3i0hAzd/6BCFY+II3l3Uq256DCjLdjBcR
         GgetZLL1rgb/QZt6X9uPcDNwfmXmbFwn8YUsWgx/mzQ2r5/eoqRdrhr7dsHpCOy1qzFU
         v5fAJIzzHP6pb/iOPB9NWr8imykalC+X+lKQiEtkfj1v0hcDVogrdUPI5hDxCUEPgfEj
         CybJIjg/Ctbyn4/8rDQRp5XA/SS6/UJcPD5XOplZAPz1utplXktBIYEgcrwqEXIxT9aO
         Q1wA==
X-Gm-Message-State: APjAAAVrtt4Ln8i8CPk5pyEMwsxGtFoZ0cfztEJj/m+BFRmcKD7/Gh2g
        b2gl34vx8VsgilMOXIe9ZZy4ZH28SpkmaRiG9TWtaQ==
X-Google-Smtp-Source: APXvYqzYN8zV2GdJXw8lWuTFP++GljjQs489OXmtW9RR6N5HtL7EAnbszXLMLn4MsNx1OjkUsq2kZBsi1vIXXBaN028=
X-Received: by 2002:a02:948c:: with SMTP id x12mr1916478jah.96.1567546277969;
 Tue, 03 Sep 2019 14:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <1567523922.5576.57.camel@lca.pw> <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu>
In-Reply-To: <20190903211747.GD2899@mit.edu>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 3 Sep 2019 14:31:06 -0700
Message-ID: <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Qian Cai <cai@lca.pw>, Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 3, 2019 at 2:18 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Sep 03, 2019 at 09:18:44AM -0700, Deepa Dinamani wrote:
> >
> > This prints a warning for each inode that doesn't extend limits beyond
> > 2038. It is rate limited by the ext4_warning_inode().
> > Looks like your filesystem has inodes that cannot be extended.
> > We could use a different rate limit or ignore this corner case. Do the
> > maintainers have a preference?
>
> We need to drop this commit (ext4: Initialize timestamps limits), or
> at least the portion which adds the call to the EXT4_INODE_SET_XTIME
> macro in ext4.h.

As Arnd said, I think this can be fixed by warning only when the inode
size is not uniformly 128 bytes in ext4.h. Is this an acceptable
solution or we want to drop this warning altogether?

Arnd, should I be sending a pull request again with the fix? Or, we
drop the ext4 patch and I can send it to the maintainers directly?

> I know of a truly vast number of servers in production all over the
> world which are using 128 byte inodes, and spamming the inodes at the
> maximum rate limit is a really bad idea.  This includes at some major
> cloud data centers where the life of individual servers in their data
> centers is well understood (they're not going to last until 2038) and
> nothing stored on the local Linux file systems are long-lived ---
> that's all stored in the cluster file systems.  The choice of 128 byte
> inode was deliberately chosen to maximize storage TCO, and so spamming
> a warning at high rates is going to be extremely unfriendly.
>
> In cases where the inode size is such that there is no chance at all
> to support timestamps beyond 2038, a single warning at mount time, or
> maybe a warning at mkfs time might be acceptable.  But there's no
> point printing a warning time each time we set a timestamp on such a
> file system.  It's not going to change, and past a certain point, we
> need to trust that people who are using 128 byte inodes did so knowing
> what the tradeoffs might be.  After all, it is *not* the default.

We have a single mount time warning already in place here. I did not
realize some people actually chose to use 128 byte inodes on purpose.

-Deepa
