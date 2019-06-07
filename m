Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2717B38224
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 02:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfFGAY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 20:24:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46518 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbfFGAY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:24:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id m15so174602ljg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 17:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjpV/GVZC7/6NIkIkxAR62f8LfbTURZiuQDu/JwjMc4=;
        b=mo8v7L2bQwYrCa6Pti65Zqcc17+FdG8pp51g2QjNpsi5JfRhPVIQ6qz0+m251oQYex
         nlPMLyMTZsGyC59Q5NUJJWnt28hyU0pKeGvJ02lPFpbOoqfntWJt29PkHuzUrkT3sgKw
         O/Wyq7vd95AYqQuK06WaBJyfcuXZithf6YRCQOiuFRkDFCkA8IddSf1Bss1xeF3TkLdd
         ESH97+R/leIfLxAPqwJKNb/jEQG4Fqcu8lxyQ/OPR/vv/SOy8OUdc17ETr38YVB8b//S
         ezd0v46trG1ajnfZl+27UM316dKibz5mGOTMRt8CYN1Wp/k/OKdU41evhYISeyXMa+Mh
         2gLA==
X-Gm-Message-State: APjAAAWOyyDUhLRjdh94HjuNPkQ2zqDk2RNI1X/bHis18yQm+FrI8Qfr
        4a+mjvFlgeewgHyG07YSA5aBkZHMl/bIAWQCENdmyj/BAT8=
X-Google-Smtp-Source: APXvYqwugrE+HvpR1/J4UXMXJZT0jDeaBBB2NZMXth8iUXpfhZxwaHA9es7vfuwPufY+SwVTgs5F2CrkwWpGfygSiyg=
X-Received: by 2002:a2e:83ca:: with SMTP id s10mr22921626ljh.163.1559867096646;
 Thu, 06 Jun 2019 17:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190530035339.hJr4GziBa%akpm@linux-foundation.org>
 <5a9fc4e5-eb29-99a9-dff6-2d4fdd5eb748@infradead.org> <2b1e5628-cc36-5a33-9259-08100a01d579@infradead.org>
In-Reply-To: <2b1e5628-cc36-5a33-9259-08100a01d579@infradead.org>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 7 Jun 2019 02:24:20 +0200
Message-ID: <CAGnkfhyO0gtg=RGUMGHYH43UhUV1htmqa-56nuK2tt_CACzOfg@mail.gmail.com>
Subject: Re: mmotm 2019-05-29-20-52 uploaded (mpls) +linux-next
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 5, 2019 at 12:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/30/19 3:28 PM, Randy Dunlap wrote:
> > On 5/29/19 8:53 PM, akpm@linux-foundation.org wrote:
> >> The mm-of-the-moment snapshot 2019-05-29-20-52 has been uploaded to
> >>
> >>    http://www.ozlabs.org/~akpm/mmotm/
> >>
> >> mmotm-readme.txt says
> >>
> >> README for mm-of-the-moment:
> >>
> >> http://www.ozlabs.org/~akpm/mmotm/
> >>
> >> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> >> more than once a week.
> >>
> >> You will need quilt to apply these patches to the latest Linus release (5.x
> >> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> >> http://ozlabs.org/~akpm/mmotm/series
> >>
> >> The file broken-out.tar.gz contains two datestamp files: .DATE and
> >> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> >> followed by the base kernel version against which this patch series is to
> >> be applied.
> >>
> >
> > on i386 or x86_64:
> >
> > when CONFIG_PROC_SYSCTL is not set/enabled:
> >
> > ld: net/mpls/af_mpls.o: in function `mpls_platform_labels':
> > af_mpls.c:(.text+0x162a): undefined reference to `sysctl_vals'
> > ld: net/mpls/af_mpls.o:(.rodata+0x830): undefined reference to `sysctl_vals'
> > ld: net/mpls/af_mpls.o:(.rodata+0x838): undefined reference to `sysctl_vals'
> > ld: net/mpls/af_mpls.o:(.rodata+0x870): undefined reference to `sysctl_vals'
> >
>
> Hi,
> This now happens in linux-next 20190604.
>
>
> --
> ~Randy

Hi,
I've just sent a patch to fix it.

It seems that there is a lot of sysctl related code is built
regardless of the CONFIG_SYSCTL value, but produces a build error only
with my patch because I add a reference to sysctl_vals which is in
kernel/sysctl.c.

And it seems also that the compiler is unable to optimize out the
unused code, which gets somehow in the final binary:

$ grep PROC_SYSCTL .config
# CONFIG_PROC_SYSCTL is not set
$ readelf vmlinux -x .rodata |grep -A 2 platform_lab
  0xffffffff81b09180 2e630070 6c617466 6f726d5f 6c616265 .c.platform_labe
  0xffffffff81b09190 6c730069 705f7474 6c5f7072 6f706167 ls.ip_ttl_propag
  0xffffffff81b091a0 61746500 64656661 756c745f 74746c00 ate.default_ttl.

If the purpose of disabling sysctl is to save space, probably this
code and definitions should all go under an #ifdef

Regards,
-- 
Matteo Croce
per aspera ad upstream
