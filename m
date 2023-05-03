Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0806F57B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjECMQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 08:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjECMPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 08:15:54 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59765587;
        Wed,  3 May 2023 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1683116150;
        bh=VDKmAp+D+K8DEGYmTk7RY6tTKuk1qCgpkelWg/ywlAg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=PlkG5v+bL2k1SR6S+xTcurYCQMY1gqlm0glsK3Tehy9JLi4tipUL2h0fY91Ww/VO3
         xDO5VLDNlSvr1ssHxu7B/uhx43c8VdCE70ZP8rGdKM8n07MK0plgjoj7x5eBJNKiLf
         ZQX0hxl/XubtAQyr+oR+xbN/Fjm9fwU7RWvy5GrI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3409C1285CEE;
        Wed,  3 May 2023 08:15:50 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id TVvOwDLNFpHO; Wed,  3 May 2023 08:15:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1683116149;
        bh=VDKmAp+D+K8DEGYmTk7RY6tTKuk1qCgpkelWg/ywlAg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=J6HQpG+VrJ9szCbazPDOCSIgT+5ut4XwqZK3Dc0MdxaQliyHK3p1NrakhT8ZMCjIK
         DNU+c0q6UaQjTZWPcZArAplMwU8UXy5bNs7sVcjLlrCYF64EO/PeWZtKPIX4uqlfWh
         7xj+nhVGXEVTMTaNQqx/bgBI26AK0f9jPuO3roXU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 15CC91281819;
        Wed,  3 May 2023 08:15:44 -0400 (EDT)
Message-ID: <8f3ab2a3091d7e2d1c3f593a335b03f3dcbebc89.camel@HansenPartnership.com>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in
 string_get_size's output
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Noralf =?ISO-8859-1?Q?Tr=EF=BF=BDnnes?= <noralf@tronnes.org>
Date:   Wed, 03 May 2023 08:15:42 -0400
In-Reply-To: <20230502225016.GJ2155823@dread.disaster.area>
References: <20230501165450.15352-1-surenb@google.com>
         <20230501165450.15352-2-surenb@google.com>
         <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
         <ZFAUj+Q+hP7cWs4w@moria.home.lan>
         <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
         <ZFCA2FF+9MI8LI5i@moria.home.lan>
         <2f5ebe8a9ce8471906a85ef092c1e50cfd7ddecd.camel@HansenPartnership.com>
         <20230502225016.GJ2155823@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-05-03 at 08:50 +1000, Dave Chinner wrote:
> On Tue, May 02, 2023 at 07:42:59AM -0400, James Bottomley wrote:
> > On Mon, 2023-05-01 at 23:17 -0400, Kent Overstreet wrote:
> > > On Mon, May 01, 2023 at 10:22:18PM -0400, James Bottomley wrote:
> > > > It is not used just for debug.  It's used all over the kernel
> > > > for printing out device sizes.  The output mostly goes to the
> > > > kernel print buffer, so it's anyone's guess as to what, if any,
> > > > tools are parsing it, but the concern about breaking log
> > > > parsers seems to be a valid one.
> > > 
> > > Ok, there is sd_print_capacity() - but who in their right mind
> > > would be trying to scrape device sizes, in human readable units,
> > 
> > If you bother to google "kernel log parser", you'll discover it's
> > quite an active area which supports a load of company business
> > models.
> 
> That doesn't mean log messages are unchangable ABI. Indeed, we had
> the whole "printk_index_emit()" addition recently to create
> an external index of printk message formats for such applications to
> use. [*]

I didn't say they were.
> 
> > >  from log messages when it's available in sysfs/procfs (actually,
> > > is it in sysfs? if not, that's an oversight) in more reasonable
> > > units?
> > 
> > It's not in sysfs, no.  As aren't a lot of things, which is why log
> > parsing for system monitoring is big business.
> 
> And that big business is why printk_index_emit() exists to allow
> them to easily determine how log messages change format and come and
> go across different kernel versions.
> 
> > > Correct me if I'm wrong, but I've yet to hear about kernel log
> > > messages being consider a stable interface, and this seems a bit
> > > out there.
> > 
> > It might not be listed as stable, but when it's known there's a
> > large ecosystem out there consuming it we shouldn't break it just
> > because you feel like it.
> 
> But we've solved this problem already, yes?

Well, yes; since it's a simple bit of extra thought and a couple of
lines addition not to afflict everyone with the change, that's the
simplest course.  It also gets us out of arguing about whether the
space reads better and is SI consistent.

> If the userspace applications are not using the kernel printk format
> index to detect such changes between kernel version, then they
> should be. This makes trivial issues like whether we have a space or
> not between units is completely irrelevant because the entry in the
> printk format index for the log output we emit will match whatever
> is output by the kernel....

Just because we have better tools to fix a problem when it happens
doesn't mean we should actively cause the problem when its easily
avoidable.  In the same way we shouldn't drive less carefully just
because cars are built safer today.

James

