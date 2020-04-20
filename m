Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7161B1662
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgDTT6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDTT6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:58:37 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8058C061A10
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 12:58:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c63so12156978qke.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zzywysm.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1CahSbHOz6rwR75qjwbzvpk5/lxzAsXTVlJJFrluNmk=;
        b=DHwk8VKEaaVWe6umPwn75HeYPWa4/to4TPUyIyniHa8w0VjI4jbFRgfwiJbMPyVTBF
         XIxMCwftVuZ5LMDuVHb9gd/oo9bVOeOag3KnWsbyRKiBySEDw18VNG9po6wPOgaX+JV0
         U696lIpKGeSvPcCzw56gqM/agX1+2/QWVes4jWwOX1kSM0DMbVae9AqQEle3/5swq1WR
         3E0xc6MJg7TbdMO3xq2INKKP9cMKexf1GETBAnT4Wc/qvIJu4eZ79zfLThZbNisSrGcf
         uNvuImd6aWtDGh5xTm0hSIil3sDlm0TTj3TRSR1SEsiBL/e+4Ps6DP19SkF+CcVNT33D
         HkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1CahSbHOz6rwR75qjwbzvpk5/lxzAsXTVlJJFrluNmk=;
        b=YfQPtfIPnbjf3dRhCUqsK6T+MjpRTZeFzemylp/Qjn5XVo3d83DbjDHV88EFz7xW9M
         n/V5Dq7JKcz+Frk1PBM49tWvtQmMkB/wHA+UPaeijy5JYe8BuX4pVeuBTwEkUYGSVCIc
         SYiWopynD9k20JgDWvLrnk5abNJm4kXorTDlWIwfG31Vhc+G+PYXv8wXtm0TcklR1Ck3
         GcfgBLAVIQ/sxPT1zlJFaznyMZgv02EetEByyLVk0rzEAhnV+A0DwEGIdM0VDVmGxf4i
         9tMniHPXFtXEwq8t235g7PUxntlX7gYm7zF2c/nJWPHicBEaqv+Th4KP2XKRjcqCncBT
         B+5A==
X-Gm-Message-State: AGi0PubXoJJ8vZKuAsWzj7eumIi3EYdUzKAbpVXXV9ICr068jK2BvDx9
        /cX+EczsIzoMwH1eFmHYN6Q85A==
X-Google-Smtp-Source: APiQypLbKFRt3y7j9cRt5ohxKGUgZ2cg5IXsM72wAdwrD/eEvlPuY2BnSQ46fW3IHvQ9kSE9m6xMag==
X-Received: by 2002:a37:5284:: with SMTP id g126mr18284316qkb.51.1587412716060;
        Mon, 20 Apr 2020 12:58:36 -0700 (PDT)
Received: from [10.19.49.2] (ec2-3-17-74-181.us-east-2.compute.amazonaws.com. [3.17.74.181])
        by smtp.gmail.com with ESMTPSA id j2sm241058qtp.5.2020.04.20.12.58.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 12:58:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/9] fix empty-body warning in posix_acl.c
From:   Zzy Wysm <zzy@zzywysm.com>
In-Reply-To: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Date:   Mon, 20 Apr 2020 14:58:31 -0500
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8B969BE-A2B1-4E6D-8746-BBFBE6399328@zzywysm.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-3-rdunlap@infradead.org>
 <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Apr 18, 2020, at 1:53 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> Thirdly, there's a *reason* why "-Wextra" isn't used.
>=20
> The warnings enabled by -Wextra are usually complete garbage, and
> trying to fix them often makes the code worse. Exactly like here.
>=20

As the instigator of this warning cleanup activity, even _I_ don=E2=80=99t=
 recommend
building with all of -Wextra.  Doing so on an allmodconfig build =
generates=20
500 megabytes of warning text (not exaggerating), primarily due to=20
-Wunused-parameter and Wmissing-field-initializers.

I strongly recommend disabling them with -Wno-unused-parameter=20
-Wno-missing-field-initializers since the spew is completely =
unactionable.

On the other hand, -Woverride-init found a legit bug that was breaking =
DVD
drives, fixed in commit 03264ddde2453f6877a7d637d84068079632a3c5.

I believe finding a good set of compiler warning settings can lead to =
lots of=20
good bugs being spotted and (hopefully) fixed.  Why let syzbot do all =
the work?

zzy

