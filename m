Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3EBD901A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfJPLwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 07:52:39 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:39554 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfJPLwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:52:09 -0400
Received: by mail-wm1-f54.google.com with SMTP id v17so2425604wml.4;
        Wed, 16 Oct 2019 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFLLQScTxl1Kxv46iUCfFAsgppvcBNhe7F96dYnGJQ4=;
        b=M6eTKyA9F9F7Kqy+qseqIK+ejOB+jYYhW3znesf9bpLgfDbAv7iRDzuSiVE8G4kyLj
         v2w4chGyfNM9SE7SYpZ1fMigJPR7Xgu6OmS/g/2/MRuIWA93cCPQHZ9sa3tfSFOMj2hG
         R/cDGX3Me8iWggaGjAA5CXzSf5UyiioXmkzSN8J8gO8pQ554oUcVCeoPkEp3lXraR2Cz
         A+Wp0vTJIQTd31oNYsnSfsRxeaD8FGvGzDkbMgKhpCKc2OvQ7vWs61wFrq95mBU45hwG
         NBwgdVQLiTL8pL85a+DHDJ/KHTNvT45oAAzqR1oeSnlvxQbWCO4xqAJ1Do735N+ZzfOS
         V8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFLLQScTxl1Kxv46iUCfFAsgppvcBNhe7F96dYnGJQ4=;
        b=kUu79M/0kc/eaEqTTu5eUglMD3k+o+IeT9PpKoqmOvdpdb9SEm+9ACc6v1vMWyPwcA
         BYQEhVatbd5U4h+IdGvEqUIVLu722OZ5Frh89tNRH3RVM2FvPZkHtZHgYOzD9LJSluAX
         rFDu1qagvicqk7jJMbCVB0SvXHUIVCMK1jmhz+fMdZCJc7ZqWLA1vJeZT853HMdTwU1G
         eXeFJKDY+v+nAqy2EYyyT7MAuCWsCBmn3o4AVoYnsO5DSoTgIPMnAxB/LceP7fNV2eah
         oZ542P1fdEjtae+LJ4AeyndBEYYIpGeO132ekvKrwW6l6RTjZI83KL9PXX/mm8G4ncli
         7YcA==
X-Gm-Message-State: APjAAAXetMA23ZdERVWeDUa9OHhEKecdf2sB41ilXisYyDLhSj9kOhtM
        PBmufbO7SWGc+s5H3VhGEnEYqxqM9rLpz8nC9yKYxA==
X-Google-Smtp-Source: APXvYqyGCy2L/z06xfei6Fna0oKHQhTYFAiCGiyEPAfHfJELDGnPW8qRSa/hGQAxI1aqKdjDgZ6hYXrWTCZmhhiOk7A=
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr3194598wmb.89.1571226726484;
 Wed, 16 Oct 2019 04:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
In-Reply-To: <20191013164124.GR13108@magnolia>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Wed, 16 Oct 2019 19:51:15 +0800
Message-ID: <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
Subject: Re: [Project Quota]file owner could change its project ID?
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:41 AM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Sat, Oct 12, 2019 at 02:33:36PM +0800, Wang Shilong wrote:
> > Steps to reproduce:
> > [wangsl@localhost tmp]$ mkdir project
> > [wangsl@localhost tmp]$ lsattr -p project -d
> >     0 ------------------ project
> > [wangsl@localhost tmp]$ chattr -p 1 project
> > [wangsl@localhost tmp]$ lsattr -p -d project
> >     1 ------------------ project
> > [wangsl@localhost tmp]$ chattr -p 2 project
> > [wangsl@localhost tmp]$ lsattr -p -d project
> >     2 ------------------ project
> > [wangsl@localhost tmp]$ df -Th .
> > Filesystem     Type  Size  Used Avail Use% Mounted on
> > /dev/sda3      xfs    36G  4.1G   32G  12% /
> > [wangsl@localhost tmp]$ uname -r
> > 5.4.0-rc2+
> >
> > As above you could see file owner could change project ID of file its self.
> > As my understanding, we could set project ID and inherit attribute to account
> > Directory usage, and implement a similar 'Directory Quota' based on this.
>
> So the problem here is that the admin sets up a project quota on a
> directory, then non-container users change the project id and thereby
> break quota enforcement?  Dave didn't sound at all enthusiastic, but I'm
> still wondering what exactly you're trying to prevent.

Yup, we are trying to prevent no-root users to change their project ID.
As we want to implement 'Directory Quota':

If non-root users could change their project ID, they could always try
to change its project ID to steal space when EDQUOT returns.

Yup, if mount option could be introduced to make this case work,
that will be nice.


>
> (Which is to say, maybe we introduce a mount option to prevent changing
> projid if project quota *enforcement* is enabled?)
>
> --D
>
