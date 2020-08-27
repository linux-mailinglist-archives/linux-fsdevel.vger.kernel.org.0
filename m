Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE054254943
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgH0PXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgH0L37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:29:59 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6455C06123D;
        Thu, 27 Aug 2020 04:28:00 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k20so4103481otr.1;
        Thu, 27 Aug 2020 04:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=k625p4G1ECZOtwn1k2tuoTbtrkLs0SeTZjD+MKyFwgY=;
        b=XTIDtUKLznQZ3eFoodQ5ObQE+hlE31ej9LC3XXt2V/IhgiW3AfvLs50Pqf0zA8+Ac7
         5q74EL3RhwZdjHjCLZbNG8J7+hRW+0BKgfM+V0Ndh86ZpCkzCFmo6EE2wJszoZUm8VeM
         Y5wn2AgldTpAf0OlqKEMaQ8iFmekMhQiO/b3QnfLFt4p3nWIGC9Rp/oHkqWtSLNTD9Xy
         BMsNcX5cB3OaCJ06Avbp1dTk+nZGLZ6RHLEF1hoP51L5dBlr4eZAVNHaFdsu88JRT2sK
         xgCpu5AGzSjTsBcifL6FhiRtS25WtSUDDRFddUDXEs5KBsGp6tdFrXSXUwb91Om2X1Rd
         NQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=k625p4G1ECZOtwn1k2tuoTbtrkLs0SeTZjD+MKyFwgY=;
        b=Fxi/c1MD/14a6iEG1rTZjkmLaVkISdJ1um4o0B7ddZXmXVDDH+Ef74jInDP7uvLXHY
         iHy2iT58+pxEROsGHq3MuyN9WAdciKjKHyzYFOQdlITLJW9aJCCRC5v5f0NlgdX1w5gg
         I/+vdqFEVaU+GzdXYa1JU5/yEAxcm9RnL1VZD2MRDq/V9Iq7U2RVDAdcJVX0CklHBrTl
         OyXeJKHk2EVhNeg/afsAgFitR7/KqLIlLLMCxz9i/ClunchTokw9h3SgvNq0USwPVXae
         gZ1r1wvp/MfrR93TQORKAr62U/6EtmLl/fCbEhFJQsW3E1Nz0ZKJVZ0+zCe2baaFsgCT
         1MAg==
X-Gm-Message-State: AOAM533REwMGlUaI5XIvHcogwNzbR3CH2DLhfNMnI9Y1WByGSSIlvMJh
        CoA2SmalBSDTsiXXrw0gaUbslbAENw8Ff+IyfE0=
X-Google-Smtp-Source: ABdhPJyPcLPDh2dczuD4C4JhbPC3GweS3vl1yW5srMZV0DS8qhBoE7ckUH241CvoCU6Ggn858A1mofPXnr/blrDJ0SQ=
X-Received: by 2002:a9d:a2b:: with SMTP id 40mr13528946otg.308.1598527680174;
 Thu, 27 Aug 2020 04:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646180259.1784947.223853053048725752.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646180259.1784947.223853053048725752.stgit@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 27 Aug 2020 13:27:48 +0200
Message-ID: <CAKgNAkgAjEnvPvi66Jd+XLvogy_w8TT5egJwFGmrM2BQGWii=g@mail.gmail.com>
Subject: Re: [PATCH 02/18] fsinfo: Add fsinfo() syscall to query filesystem
 information [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

On Mon, 3 Aug 2020 at 15:37, David Howells <dhowells@redhat.com> wrote:
>
> Add a system call to allow filesystem information to be queried.  A request
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.

Do we have an up to date manual page for this system call?

Could you please (re)post to the same CC as this mail, plus linux-man@?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
