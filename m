Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C960BDD9D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 19:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfJSRsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 13:48:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35953 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfJSRsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 13:48:06 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so11211863iof.3;
        Sat, 19 Oct 2019 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kz0/FsscmNPnfhryu7+x8j2fQp1ZICmOKUwPPB93gHo=;
        b=i55waEalpeARsWe2kn6Q4q375oqabBYRyBGwWVACSm4Q3/7d3COTb9PVrApFE70Lp+
         XFVlS6xBe1ftzUsawcKHJUK6CovX7wzlSRK6d0Hae2WJP0erLoyRXBFF48/wW8Wsleud
         jnv0Kae/Eo5PViwh6122oxPtKk+qGziWxiVJM1zGvlCJ9Xf3ZjbMnnRxIH+gvSuUppsF
         JuEBcyMi2JyWFyF0KKZH7A8UdkZ0fho+8rB4cnrEezN3+nfkOZM8/YSswpC/0QRXnSV1
         y0jtw0BEFvtTVVc71wkAI6LyRd0HUsRlYHAzvcsrMwqx3UGnW74arc3IYPJ2In3jFfzh
         OOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kz0/FsscmNPnfhryu7+x8j2fQp1ZICmOKUwPPB93gHo=;
        b=i6xC1gRNVvwPgHeXR9camWgxK8eP5clm+jOWqZb1W5lbITJMlSSGujJeFHvtUfDIdN
         WUPLp4v5kkfweCGTEfeeQ16afINbZeKuxOKwdFa4KY40yspKuEu/y3TvkZvm7sA3FZ0M
         Bm3TC7lKVqLKpuXQqqT23PIa3DR25tpR2vrV5sFWYxXEJMjn3VOZHeaMiKSpnO5CVJRN
         dXSLesiW30lxSJ8kloWVlUqCaMxOct28FEqI96gtfCbKegHjAKN2iEFE5g1elhbUfg8V
         YR2gTdL5m8moiy+Ntbi4sv1YGaImm9MvHhNA/wvCm0hialHGsFEzU9LhV275w/o7CyUt
         iHhw==
X-Gm-Message-State: APjAAAUyemMY5/tKu1sNqvYmO5eYiUA+msez5ZHWz/EWZ7XEMueoYE+m
        SSXdh5z8hwYPUB31PMdjmXt4sSxhp3V/Z+6TQoM=
X-Google-Smtp-Source: APXvYqxo3Fr0kuSJMEqgKM6kl3CHK537pta2eV/yClGVePf9vOCnH87rNjy+8mu9SJc9u5hIR2Dwdu72XQGW0yLsUuo=
X-Received: by 2002:a6b:ef0d:: with SMTP id k13mr3210056ioh.178.1571507283798;
 Sat, 19 Oct 2019 10:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191019054039.vsWMD_v7t%akpm@linux-foundation.org>
In-Reply-To: <20191019054039.vsWMD_v7t%akpm@linux-foundation.org>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Sat, 19 Oct 2019 20:47:52 +0300
Message-ID: <CALYGNiNVJ6WZwDETrq4X4oaPBOx7wC89Gh8-ZOScY_Bf8H5Mdw@mail.gmail.com>
Subject: Re: mmotm 2019-10-18-22-40 uploaded
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 19, 2019 at 8:40 AM <akpm@linux-foundation.org> wrote:
>
> The mm-of-the-moment snapshot 2019-10-18-22-40 has been uploaded to
>
>    http://www.ozlabs.org/~akpm/mmotm/
>
> mmotm-readme.txt says
>
> README for mm-of-the-moment:
>
> http://www.ozlabs.org/~akpm/mmotm/
>
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
>
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
>
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
>
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
>
>
> A full copy of the full kernel tree with the linux-next and mmotm patches
> already applied is available through git within an hour of the mmotm
> release.  Individual mmotm releases are tagged.  The master branch always
> points to the latest release, so it's constantly rebasing.
>
> http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/

I seems git mirror does not update anymore.
Latest tag is v5.3-rc7-mmots-2019-09-03-21-33
