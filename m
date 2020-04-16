Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822BD1AD14B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbgDPUjd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 16:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgDPUjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:39:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F54C061A0C;
        Thu, 16 Apr 2020 13:39:30 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n4so2328431ejs.11;
        Thu, 16 Apr 2020 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=HNb0EHRhkWtKUARLipiCx52VLuKYf8eL5nJ5ugzAA0c=;
        b=EqrrRxjtz0tJjCve/SiMHYHloXIVDRhZX+QD8PshnCXpsUKpu4vQsIW44CAndOscTD
         JGD/3xJ3EYLnjBVNOwyNzz5siBGUz4mCK86egaojycNi1/eq8PegaO6/omy94vw4i6wP
         BA7kBIRRCpa6TMNGMLbNwmX4cqs8yfH5JkQBXDfWWcP8Ob97EsY3hfq33/2HX8uZ9wd8
         qOuWhUNIKPkZkov5zWQblh9PVK2/502otHGgASNw0rVfCh8SWfm7Gs4fsCRYAZVrGysj
         Xz1l3MAW+csfj13MZkynPiTdS6tTTTsfgMqCf2vwpFdPbdU0ekBiTchXz7JtaijLnV3S
         VQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=HNb0EHRhkWtKUARLipiCx52VLuKYf8eL5nJ5ugzAA0c=;
        b=RPkJi33qKrTjWfBGBZIgsiE6ah1KCQZ8czgpP/rAlIFSF5b6MQypFV0NiXtTms/D8C
         yAGEn8hoTKPi6PFgn4PxmVe5FyKBKExr7ph9wN2aX/VL1YWr6aRDyFVPS5PhjdfVjIJ/
         LbwQhdVxvHM3Xwm+bAYtnMb08zje+vWDxGgzY96ViAyunLZCVxjTfyHUE2dw8apd8m9Z
         j4yFs70keWzFg8vwzWoIdLX1Yzd7Hq7ONIfQjznggeRlnxA1s2/j2E8GHJFYgXH/80Dl
         lvxnWA4Fo54VnY9oy6VxLClJAfJOGpS1dkFuAvdQXyCIB53hAhMEVX+G2npeRzZWkxmj
         EXpQ==
X-Gm-Message-State: AGi0Pubp07P0q9+FSjjMpeQzEmrts7W4diEzcqomRJY068LKlGsvWKiJ
        iRZkKQDhp6MWsUIwKzf+sqv4/gvRFI9Cwl7JeDU=
X-Google-Smtp-Source: APiQypL8tp8DSIXGFOBm/yRjtw9JN+p+xgFOm5Hy0L7IRyUbnQtTORpjEtZw8bxi1wufV7Z0ltkzex/a+M4PXpjQYkE=
X-Received: by 2002:a17:906:5fd2:: with SMTP id k18mr11124460ejv.243.1587069569098;
 Thu, 16 Apr 2020 13:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1582930832.git.osandov@fb.com> <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
 <CAKgNAkhpET_oK8SKoJhmo1LWk2n0pUXQ-+LfA6=V1cBK485RWw@mail.gmail.com> <20200416170203.GA696015@vader>
In-Reply-To: <20200416170203.GA696015@vader>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 16 Apr 2020 22:39:17 +0200
Message-ID: <CAKgNAkhd_y5AqaHVXFMVucJNXuDwch=UpepG_a9pKvKMkxp9Bw@mail.gmail.com>
Subject: Re: [PATCH man-pages v4] Document encoded I/O
To:     Omar Sandoval <osandov@osandov.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux btrfs Developers List <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Omar,

On Thu, 16 Apr 2020 at 19:02, Omar Sandoval <osandov@osandov.com> wrote:
>
> On Thu, Apr 16, 2020 at 02:26:01PM +0200, Michael Kerrisk (man-pages) wrote:
> > Hello Omar,
> >
> > (Unless you CC both me and mtk.manpages@gmail.com, it's easily
> > possible that I will miss your man-pages patches.)
>
> That's good to know, thanks. Do you mind being CCd on man-pages for
> features that haven't been finalized yet?

Please do CC me and linux-man@ on such patches. Just make sure that
the patch notes that the feature is not yet upstream.
>
> > What's the status here? I presume the features documented here are not
> > yet merged, right? Is the aim still to have them merged in the future?
>
> They're not yet merged but I'm still working on having them merged. I'm
> still waiting for VFS review.

Okay.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
