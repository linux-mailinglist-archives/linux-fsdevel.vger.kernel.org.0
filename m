Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2079F2E22D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfE2QUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 12:20:39 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42244 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfE2QUi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 12:20:38 -0400
Received: by mail-yw1-f68.google.com with SMTP id s5so1302966ywd.9;
        Wed, 29 May 2019 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgWFwBbqc/TIeFx+G72gp5eLEUxfA2pK5OKuDEowGKc=;
        b=jQSFEpXtckdK15GU+zOhWiGnSetf0KAzWuZb58/zupTyFnbmFnkOKY/iSToYuQyN5L
         MkI6aVdlMmOcfKlg9ISJwKI+z1ZDwj3q5XuMNWjHeIXgiskwej8PInH6I/oXzzsCBq0X
         QbUBwy1a+RM+qyUmZ3+hCoLNYZVgX+YehA8iiDIrxLJdqHnITrrPL3YC/9ZjncB+SoBO
         Nk6bungjzgZ15oeBYTgVV/FQhatnWgz1WrbbG7rU6pRlMWg7bIMhim8quPwHVPp4GVxW
         9qzJHOnagZq48iB2ZR7WXJ1NaV6qWYsbq4NZfDfLWONADgwARn6tkDmxfZLQCSgbrmFg
         Zt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgWFwBbqc/TIeFx+G72gp5eLEUxfA2pK5OKuDEowGKc=;
        b=Lqn2X94KepSJd87ksswKtyzwVgccWw7Y0ZkNyo27lHSc4qDB2nbwa65qxVzMtf9i8q
         ui7cUCm70p1bXExouRJmbtf00MLwwaioZFeZoKzLL2aE5IstHZahK1Wv6wX+fZJy2d+/
         o4XS4HUvlN3odpqUTrk9LWP6+rIeVXUIsg+tsIrRlO4uLUH2arlvVkUY13DHYaVjh5/p
         wqSwf7gVuNDKz8e2k3o1Jrm0mQ/DPn8zL+mSCtS2vNzB6Y2Arr+Oa8Cu9Ajn1CvX3XYZ
         bnrKqaVXecAtBdVLSjAlv38bSNYBf5Qzq8m7IKiam2vmxewV/EBt9XHmOwRePRm45OxU
         M+yg==
X-Gm-Message-State: APjAAAVNgpmDxwzXkWdrPY/LzDATgpDEsiD+vqLNlipNWCRMthJIyfT1
        eOanGB7BEiTCmkK/VGdZogsK7WcL1F4aDpWiiy0=
X-Google-Smtp-Source: APXvYqzzgbRrTpnULwe/IoxAzcoJVne1h/bBy2qlyUlmguuG3+RHGMFZemo93QUU34JXx68hkctDvcHbDw8oHipDSVE=
X-Received: by 2002:a81:3797:: with SMTP id e145mr53153276ywa.25.1559146832803;
 Wed, 29 May 2019 09:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190526061100.21761-1-amir73il@gmail.com> <20190526061100.21761-10-amir73il@gmail.com>
 <20190528164844.GJ5221@magnolia>
In-Reply-To: <20190528164844.GJ5221@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 19:20:21 +0300
Message-ID: <CAOQ4uxiWxkmvtK6qX6T5cOAFeTb3Oo9xocG+yY24RaMftnJ2tQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/8] man-pages: copy_file_range updates
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +A major rework of the kernel implementation occurred in 5.3. Areas of the API
> > +that weren't clearly defined were clarified and the API bounds are much more
> > +strictly checked than on earlier kernels. Applications should target the
> > +behaviour and requirements of 5.3 kernels.
>
> Are there any weird cases where a program targetting 5.3 behavior would
> fail or get stuck in an infinite loop on a 5.2 kernel?

I don't think so. When Dave wrote this paragraph the behavior was changed
from short copy to EINVAL. That would have been a problem to maintain
old vs. new copy loops, but now the behavior  did not change in that respect.

>
> Particularly since glibc spat out a copy_file_range fallback for 2.29
> that tries to emulate the kernel behavior 100%.  It even refuses
> cross-filesystem copies (because hey, we documented that :() even though
> that's perfectly fine for a userspace implementation.
>
> TBH I suspect that we ought to get the glibc developers to remove the
> "no cross device copies" code from their implementation and then update
> the manpage to say that cross device copies are supposed to be
> supported all the time, at least as of glibc 2.(futureversion).

I don't see a problem with copy_file_range() returning EXDEV.
That is why I left EXDEV in the man page.
Tools should know how to deal with EXDEV by now.
If you are running on a new kernel, you get better likelihood
for copy_file_range() to do clone or in-kernel copy for you.

>
> Anyways, thanks for taking on the c_f_r cleanup! :)
>

Sure, get ready for another round ;-)

Thanks for the review!
Amir.
