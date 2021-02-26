Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880CA326166
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 11:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhBZKhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 05:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhBZKfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:35:18 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6901AC061574;
        Fri, 26 Feb 2021 02:34:38 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e7so7591221ile.7;
        Fri, 26 Feb 2021 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKPWJ2vXHOJ7BygK8wqPKLpAtkdMRDyOo5zcEtzB+lQ=;
        b=aDCpldvU7pTZUlcU0bh6o6izJC3pMqDFf8ZoDaybY8UHQjifgj4QKmw6tHh6dmWjs3
         g/6JzYFlohIuHURl2qjlVa45z5RI1iWkiPBqRsOYYWUyvzR3k/kUjIuCBYbGP9x6+pSy
         a8EUhKcyvGGm8hQBgvPLAM+KJcKKKQcxqT2E+w55xSfNV6k8QxIPLxE/Mi5YQ7V8aWmI
         uR5PCEOJqUV3yfiJwcLovgZnaSB0/E+uV8qd11D7DH1KFuREX0JZ2R4e/bmS+fAbG5fo
         q6kOEL485/WcHBRPc3Oiv0OQ0T1YXAgROhbbjEsROUg2CiABoxGyLa4mHWXc6atJxf8y
         Oidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKPWJ2vXHOJ7BygK8wqPKLpAtkdMRDyOo5zcEtzB+lQ=;
        b=ZFLJ3fXAeJovWGhtUQZWjcDMIf41JuKHp8d+l/XHcQlVDCgIhNJ4E/UFy1a6siBWc8
         rITx5AkJxeE40cIdrB7jMAZJayK3oHLBeXVR2Rc0UYpIEiNpFG8lBFJHRkBqAaZFELdG
         lpFLP9AUn67oj39BKz73dM0zDzJp7OxJsFxoIg3pPjrnbr1cEApAms0QZFoeFKW2UMrd
         oTeMtyGTxFQICxWM7wp7R3RBmRSTez277HZR/m30YFVtqmYLDzqvFf0nZ9owZnzp5WcK
         NyyZS3/oLwDbEH64PKSbwres1ITbQ/l2r8e82cUYyc4/rlzqpcDQAQ1/t+1XXRgfblTH
         HMdw==
X-Gm-Message-State: AOAM530mkxc/rGqFSM5iDYbToO7stEEhnJ03E4vZgZU68D+/aCo3Utzv
        stM+U9DUTvpM7HYR2y142Yf+ghGQ40KXXkWl0AI=
X-Google-Smtp-Source: ABdhPJyVvQafC62ZZanNVOmiYZS+T7dRdoUjzY7ufrxA7FhWOl4Xvpul8DKSph5sHFpVYsYNJ4N2URBdaIKR7OVs1xg=
X-Received: by 2002:a92:da90:: with SMTP id u16mr1918861iln.275.1614335677822;
 Fri, 26 Feb 2021 02:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20210222102456.6692-1-lhenriques@suse.de> <20210224142307.7284-1-lhenriques@suse.de>
 <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
 <YDd6EMpvZhHq6ncM@suse.de> <fd5d0d24-35e3-6097-31a9-029475308f15@gmail.com>
In-Reply-To: <fd5d0d24-35e3-6097-31a9-029475308f15@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 Feb 2021 12:34:26 +0200
Message-ID: <CAOQ4uxiVxEwvgFhdHGWLpdCk==NcGXgu52r_mXA+ebbLp_XPzQ@mail.gmail.com>
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:13 PM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> Hello Luis,
>
> On 2/25/21 11:21 AM, Luis Henriques wrote:
> > On Wed, Feb 24, 2021 at 06:10:45PM +0200, Amir Goldstein wrote:
> >> If it were me, I would provide all the details of the situation to
> >> Michael and ask him
> >> to write the best description for this section.
> >
> > Thanks Amir.
> >
> > Yeah, it's tricky.  Support was added and then dropped.   Since stable
> > kernels will be picking this patch,  maybe the best thing to do is to no
> > mention the generic cross-filesystem support at all...?  Or simply say
> > that 5.3 temporarily supported it but that support was later dropped.
> >
> > Michael (or Alejandro), would you be OK handling this yourself as Amir
> > suggested?
>
> Could you please provide a more detailed history of what is to be
> documented?
>

Is this detailed enough? ;-)

https://lwn.net/Articles/846403/

Thanks,
Amir.
