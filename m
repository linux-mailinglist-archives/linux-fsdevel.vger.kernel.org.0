Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6242E1BD774
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 10:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD2Ing (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 04:43:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726447AbgD2Inf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588149813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcZ6PqElQuIY2I5jkNPEa7pluAGzlonQVidKA7ck390=;
        b=dAlkn1uwdOR4eD6Hqf+FLmuJcZiWqq/BUbDuB2tH63pYzjk9woPrflXEp1svktYfU/ehSn
        UwrkXatc/SQy1H50idMrdl1sCnkVuuZJG1d4aymLF+Ke0CY8F4hPlkTV0HuCQeUWKlyVNZ
        JjE3rYSGUKSV7Ce0EaOzDkY2c/IPke0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-JE5sIyyoNyeAv0VuRsPBmQ-1; Wed, 29 Apr 2020 04:43:22 -0400
X-MC-Unique: JE5sIyyoNyeAv0VuRsPBmQ-1
Received: by mail-wm1-f70.google.com with SMTP id s12so914851wmj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 01:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QcZ6PqElQuIY2I5jkNPEa7pluAGzlonQVidKA7ck390=;
        b=bt5Zq9G7ewaWw9or0t7o0A3p6jBgNRmnHUVNq0i1+supoGvjaFxfNFFNnnL0Ts+D41
         cYdkWmlf8nCy4ATDlXkR8fipQGDxtX20XFvUU+44E5cVUz8Mnm7wl1aAc3baUGVjUsJJ
         ihFFSkZZkbze9VOF6g1zx1Agg8EPMpl48gausn5URNoLdZgAUbEZLimWSyJJvkm1gy07
         gWRSXAWH/+QZkFKWCBSQCRn7WzEYtOmsdHlu4kJsgFL/BU/eh64QZt869ouUl1ugiDvw
         iHajpUtk5uYZvbqO1F4Qy7AZICcBN6UW/OpMWjogKomSmNWT8rbRERyIEkVtvM7aJhQY
         kKkQ==
X-Gm-Message-State: AGi0PuadI3IFrcl165YbwykoM8AeGke+YUrrk3AAJaPuf9ATjGpNaSET
        n9SQOuJtn+8c3uTuJ/xmEYwawDSQpm2tsZE5SqcspPHcQXn91phSWKvQ24kuAJzYo6XpW8g5AAU
        eaqicGFREhSzwBG3rJmHeOYYb6g==
X-Received: by 2002:a1c:23d4:: with SMTP id j203mr2121763wmj.49.1588149800194;
        Wed, 29 Apr 2020 01:43:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypLcqDVfxUeEvW87fRGWUdN/d4quJBkD2yf6Dic3zqzuiXhubG6tHiMQWsgKcZj9hZwuRxpaoQ==
X-Received: by 2002:a1c:23d4:: with SMTP id j203mr2121740wmj.49.1588149799911;
        Wed, 29 Apr 2020 01:43:19 -0700 (PDT)
Received: from localhost ([2001:470:5b39:28:1273:be38:bc73:5c36])
        by smtp.gmail.com with ESMTPSA id t20sm6828575wmi.2.2020.04.29.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 01:43:19 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:43:18 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-04-26-00-15 uploaded (mm/madvise.c)
Message-ID: <20200429084318.wh7gjokuk445mr5d@butterfly.localdomain>
References: <20200426071602.ZmQ_9C0ql%akpm@linux-foundation.org>
 <bec3b7bd-0829-b430-be1a-f61da01ac4ac@infradead.org>
 <39bcdbb6-cac8-aa3b-c543-041f9c28c730@infradead.org>
 <20200427135053.a125f84c62e2857e3dcdce4f@linux-foundation.org>
 <20200427234512.GD163745@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427234512.GD163745@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 04:45:12PM -0700, Minchan Kim wrote:
> Hi Andrew,
> 
> On Mon, Apr 27, 2020 at 01:50:53PM -0700, Andrew Morton wrote:
> > On Sun, 26 Apr 2020 15:48:35 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > > On 4/26/20 10:26 AM, Randy Dunlap wrote:
> > > > On 4/26/20 12:16 AM, akpm@linux-foundation.org wrote:
> > > >> The mm-of-the-moment snapshot 2020-04-26-00-15 has been uploaded to
> > > >>
> > > >>    http://www.ozlabs.org/~akpm/mmotm/
> > > >>
> > > >> mmotm-readme.txt says
> > > >>
> > > >> README for mm-of-the-moment:
> > > >>
> > > >> http://www.ozlabs.org/~akpm/mmotm/
> > > >>
> > > >> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > > >> more than once a week.
> > > >>
> > > >> You will need quilt to apply these patches to the latest Linus release (5.x
> > > >> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > > >> http://ozlabs.org/~akpm/mmotm/series
> > > >>
> > > >> The file broken-out.tar.gz contains two datestamp files: .DATE and
> > > >> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > > >> followed by the base kernel version against which this patch series is to
> > > >> be applied.
> > > > 
> > > > Hi,
> > > > I'm seeing lots of build failures in mm/madvise.c.
> > > > 
> > > > Is Minchin's patch only partially applied or is it just missing some pieces?
> > > > 
> > > > a.  mm/madvise.c needs to #include <linux/uio.h>
> > > > 
> > > > b.  looks like the sys_process_madvise() prototype in <linux/syscalls.h>
> > > > has not been updated:
> > > > 
> > > > In file included from ../mm/madvise.c:11:0:
> > > > ../include/linux/syscalls.h:239:18: error: conflicting types for ‘sys_process_madvise’
> > > >   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
> > > >                   ^
> > > > ../include/linux/syscalls.h:225:2: note: in expansion of macro ‘__SYSCALL_DEFINEx’
> > > >   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> > > >   ^~~~~~~~~~~~~~~~~
> > > > ../include/linux/syscalls.h:219:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
> > > >  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
> > > >                                     ^~~~~~~~~~~~~~~
> > > > ../mm/madvise.c:1295:1: note: in expansion of macro ‘SYSCALL_DEFINE6’
> > > >  SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
> > > >  ^~~~~~~~~~~~~~~
> > > > In file included from ../mm/madvise.c:11:0:
> > > > ../include/linux/syscalls.h:880:17: note: previous declaration of ‘sys_process_madvise’ was here
> > > >  asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
> > > >                  ^~~~~~~~~~~~~~~~~~~
> > > 
> > > I had to add 2 small patches to have clean madvise.c builds:
> > > 
> > 
> > hm, not sure why these weren't noticed sooner, thanks.
> > 
> > This patchset is looking a bit tired now.
> > 
> > Things to be addressed (might be out of date):
> > 
> > - http://lkml.kernel.org/r/293bcd25-934f-dd57-3314-bbcf00833e51@redhat.com
> 
> It seems to be not related to process_madvise.
> 
> > 
> > - http://lkml.kernel.org/r/2a767d50-4034-da8c-c40c-280e0dda910e@suse.cz
> >   (I did this)
> 
> Thanks!
> 
> > 
> > - http://lkml.kernel.org/r/20200310222008.GB72963@google.com
> 
> I will send foldable patches to handle comments.
> 
> > 
> > - issues arising from the review of
> >   http://lkml.kernel.org/r/20200302193630.68771-8-minchan@kernel.org
> 
> Oleksandr, What's the outcome of this issue?
> Do we still need to change based on the comment?
> 

My current understanding is that we do not mess with signals excessively
in the given code path.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

