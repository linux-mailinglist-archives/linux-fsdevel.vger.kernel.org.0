Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14671BB21E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 01:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgD0XpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 19:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgD0XpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:45:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818ECC0610D5;
        Mon, 27 Apr 2020 16:45:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so7596885plo.7;
        Mon, 27 Apr 2020 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rFXLWpL8UxKU55UxWfH5CWuFkfOuWYDSTHntxNLKnuQ=;
        b=tAQlBRu906bcu+Kn/D0kh+IkH5FBzwAI4N6u4ya8SC229DUUmedHfy5FGH7GoY1qpp
         Ns/0KadsrEMWhpf6EEvfq7xXkqAERd+TvwugBYhsFuNv/4EJWFBCtpb0Z/CwyTd05BUy
         dzFn10SjeVBBJytBUA3xRgiKOmEKo7lSh0zvRCdFwOSnIIEbDcSGn9iZtPTIwc4lp6LP
         sKU+k2S63igNlofeIlZxDg7oAbI1fFmW4Xsmj6cRIG0xvD6+BvS/7dDJrXeJJK4rAwkx
         hDwVaUc5xCPecHtda+ev6AYjGwQ4mLjcK/Pn3JBDKZ/xRMiRBt+kSaPfLVQDFWTdQ0Ew
         KCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=rFXLWpL8UxKU55UxWfH5CWuFkfOuWYDSTHntxNLKnuQ=;
        b=XxyW9IkuT2GhF9iG4ZdKvm26JyLd0ZxYjvKt/rO2nH/lvKrXzPJFxUWy4yPw3Cc99n
         E+tVcCtibzl7s+b/Ns0UwvqtCwPl/WOVgOCfknEoLOeQmefioALvlcx+i/HkdUsSX+zT
         OJyh5TqUYTHxn+PQxXwgwyt8tFUJWCd746UOKGrMXabr26Su/PZtnoKWCxTN76kqGCAz
         9qBP1q5SeobF4KmcJ7H1SwTNwYTFBAV8T7zLVrnT9ePsPgxykMzY6kpIAhrobl/ZcL22
         jMIRE/6Q83TwsQfAmI+J5TzT1YMqVoXT5oiX/KB6EW4jx2qUm77dF2oiQZtce5npB9dK
         IBTQ==
X-Gm-Message-State: AGi0PuYVOnsjM9pctJOKmh1nLLDKwy2OOZT5UM712b9pRAiVMt3UDhcl
        wd6yTP50BXsgkkMNAZuBx1U=
X-Google-Smtp-Source: APiQypLpJP0BVvqzVPXFCCCSvMFE1KRQabPbNnXGyiE5YOxENYjwyTOd3DwoJmizsAWCUTExhC08ig==
X-Received: by 2002:a17:902:9f8a:: with SMTP id g10mr2878813plq.233.1588031115775;
        Mon, 27 Apr 2020 16:45:15 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id o40sm358029pjb.18.2020.04.27.16.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 16:45:14 -0700 (PDT)
Date:   Mon, 27 Apr 2020 16:45:12 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, oleksandr@redhat.com
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-04-26-00-15 uploaded (mm/madvise.c)
Message-ID: <20200427234512.GD163745@google.com>
References: <20200426071602.ZmQ_9C0ql%akpm@linux-foundation.org>
 <bec3b7bd-0829-b430-be1a-f61da01ac4ac@infradead.org>
 <39bcdbb6-cac8-aa3b-c543-041f9c28c730@infradead.org>
 <20200427135053.a125f84c62e2857e3dcdce4f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427135053.a125f84c62e2857e3dcdce4f@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

On Mon, Apr 27, 2020 at 01:50:53PM -0700, Andrew Morton wrote:
> On Sun, 26 Apr 2020 15:48:35 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 4/26/20 10:26 AM, Randy Dunlap wrote:
> > > On 4/26/20 12:16 AM, akpm@linux-foundation.org wrote:
> > >> The mm-of-the-moment snapshot 2020-04-26-00-15 has been uploaded to
> > >>
> > >>    http://www.ozlabs.org/~akpm/mmotm/
> > >>
> > >> mmotm-readme.txt says
> > >>
> > >> README for mm-of-the-moment:
> > >>
> > >> http://www.ozlabs.org/~akpm/mmotm/
> > >>
> > >> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > >> more than once a week.
> > >>
> > >> You will need quilt to apply these patches to the latest Linus release (5.x
> > >> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > >> http://ozlabs.org/~akpm/mmotm/series
> > >>
> > >> The file broken-out.tar.gz contains two datestamp files: .DATE and
> > >> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > >> followed by the base kernel version against which this patch series is to
> > >> be applied.
> > > 
> > > Hi,
> > > I'm seeing lots of build failures in mm/madvise.c.
> > > 
> > > Is Minchin's patch only partially applied or is it just missing some pieces?
> > > 
> > > a.  mm/madvise.c needs to #include <linux/uio.h>
> > > 
> > > b.  looks like the sys_process_madvise() prototype in <linux/syscalls.h>
> > > has not been updated:
> > > 
> > > In file included from ../mm/madvise.c:11:0:
> > > ../include/linux/syscalls.h:239:18: error: conflicting types for ‘sys_process_madvise’
> > >   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
> > >                   ^
> > > ../include/linux/syscalls.h:225:2: note: in expansion of macro ‘__SYSCALL_DEFINEx’
> > >   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> > >   ^~~~~~~~~~~~~~~~~
> > > ../include/linux/syscalls.h:219:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
> > >  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
> > >                                     ^~~~~~~~~~~~~~~
> > > ../mm/madvise.c:1295:1: note: in expansion of macro ‘SYSCALL_DEFINE6’
> > >  SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
> > >  ^~~~~~~~~~~~~~~
> > > In file included from ../mm/madvise.c:11:0:
> > > ../include/linux/syscalls.h:880:17: note: previous declaration of ‘sys_process_madvise’ was here
> > >  asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
> > >                  ^~~~~~~~~~~~~~~~~~~
> > 
> > I had to add 2 small patches to have clean madvise.c builds:
> > 
> 
> hm, not sure why these weren't noticed sooner, thanks.
> 
> This patchset is looking a bit tired now.
> 
> Things to be addressed (might be out of date):
> 
> - http://lkml.kernel.org/r/293bcd25-934f-dd57-3314-bbcf00833e51@redhat.com

It seems to be not related to process_madvise.

> 
> - http://lkml.kernel.org/r/2a767d50-4034-da8c-c40c-280e0dda910e@suse.cz
>   (I did this)

Thanks!

> 
> - http://lkml.kernel.org/r/20200310222008.GB72963@google.com

I will send foldable patches to handle comments.

> 
> - issues arising from the review of
>   http://lkml.kernel.org/r/20200302193630.68771-8-minchan@kernel.org

Oleksandr, What's the outcome of this issue?
Do we still need to change based on the comment?
