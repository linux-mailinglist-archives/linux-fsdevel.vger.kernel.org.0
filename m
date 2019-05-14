Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7501C2BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 08:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfENGEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 02:04:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44730 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfENGEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 02:04:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so8018086pgv.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 23:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wphR9fs1TaZsZNH4NQjQ2k5wiALr/JJ7E+MkCJWg1G8=;
        b=dXeMBsJluQkuZhtQlsIs60i39Eowu4Bt+MfjENGGmqpwBGoiYmgZ+5w8Qv26k9QKXI
         1cnJzcNtxLLINZMIPeb4dfPgJ9g1ycOJEIg8i4YfGPpKugYG/E5lbz6d5J5x9AuwEioW
         4w2gtbfJr7C59YLC9izuQhoVm6zDXWPFcTTTt0JfnLD/xaylHZ0XCbk5pClrxdins17i
         5S5K0uYGrPEnttnkWkkw5N35wkZ3iKovTWWT7UaNVg+Cgtqi0115K/LElBXGDu9PpvZF
         H60HHv+fa3B8a/nV2ZgfeVrjAVx8la+EU59rYesO3d6/OVXgbE5DewFQtzpmhhvoUR6U
         YnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wphR9fs1TaZsZNH4NQjQ2k5wiALr/JJ7E+MkCJWg1G8=;
        b=m56E6x1h0KirFMPtnNsqg0yS1BJquB2c0VZVmxAxtKNksYzClWDmthETegq6mpYgsk
         oaQftqlNOoxV4E4/jeMr7eA3Eq+zmWVLrgBY+rgcKQOq/EMEIg019xBCTu8Q8ALk6qZF
         Ix9zupfzh5QJ0QTbVjwuKDCCA/IJkyu4EEU532sDI20zedqg3PWcAWN6sp6qEo3oeSRJ
         u1p8xuGHZyomTYjGEF5I6Whbbx3qZotAsAYDjuxoEt186shJTWZSIo+Oo53yz/K9zOPp
         Esww1TT1cjS1/hIKAFTOIuE9RNnN5dG4Jyxh1ZL+P7kFzsaMLnPmuVs+5k2dTPpGezlA
         RGJA==
X-Gm-Message-State: APjAAAUVoGR01kxtqb4XZEqilewrSYnRbTuKlVEeaoyx+KZ/5Uz588s4
        +C5g1GFZRFaWZmgharKkIFRB8w==
X-Google-Smtp-Source: APXvYqzgwWIVKsYY211IYVBjZXLCdV1/hwybUBgofPR0QuIs5iXekLntSbypfxIlEzH7138sP0qZvw==
X-Received: by 2002:aa7:8008:: with SMTP id j8mr38436137pfi.120.1557813879741;
        Mon, 13 May 2019 23:04:39 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id k10sm16067228pgo.82.2019.05.13.23.04.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 23:04:38 -0700 (PDT)
Date:   Mon, 13 May 2019 23:04:33 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190514060433.GA181462@google.com>
References: <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
 <20190511173344.GA8507@mit.edu>
 <20190513144451.GQ17751@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513144451.GQ17751@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 13, 2019 at 04:44:51PM +0200, Daniel Vetter wrote:
> On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> > On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > > is the context here) can be configured as built in instead of as
> > > a module, and built in a UML kernel.  The UML kernel can boot,
> > > running the in-kernel tests before UML attempts to invoke the
> > > init process.
> > 
> > Um, Citation needed?
> > 
> > I don't see any evidence for this in the kselftest documentation, nor
> > do I see any evidence of this in the kselftest Makefiles.
> > 
> > There exists test modules in the kernel that run before the init
> > scripts run --- but that's not strictly speaking part of kselftests,
> > and do not have any kind of infrastructure.  As noted, the
> > kselftests_harness header file fundamentally assumes that you are
> > running test code in userspace.
> 
> Yeah I really like the "no userspace required at all" design of kunit,
> while still collecting results in a well-defined way (unless the current
> self-test that just run when you load the module, with maybe some
> kselftest ad-hoc wrapper around to collect the results).
> 
> What I want to do long-term is to run these kernel unit tests as part of
> the build-testing, most likely in gitlab (sooner or later, for drm.git

Totally! This is part of the reason I have been insisting on a minimum
of UML compatibility for all unit tests. If you can suffiently constrain
the environment that is required for tests to run in, it makes it much
easier not only for a human to run your tests, but it also makes it a
lot easier for an automated service to be able to run your tests.

I actually have a prototype presubmit already working on my
"stable/non-upstream" branch. You can checkout what presubmit results
look like here[1][2].

> only ofc). So that people get their pull requests (and patch series, we
> have some ideas to tie this into patchwork) automatically tested for this

Might that be Snowpatch[3]? I talked to Russell, the creator of Snowpatch,
and he seemed pretty open to collaboration.

Before I heard about Snowpatch, I had an intern write a translation
layer that made Prow (the presubmit service that I used in the prototype
above) work with LKML[4].

I am not married to either approach, but I think between the two of
them, most of the initial legwork has been done to make presubmit on
LKML a reality.

> super basic stuff.

I am really excited to hear back on what you think!

Cheers!

[1] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-7bfa40efb132e15c8388755c273837559911425c
[2] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-a6784496eafff442ac98fb068bf1a0f36ee73509
[3] https://developer.ibm.com/open/projects/snowpatch/
[4] https://kunit.googlesource.com/prow-lkml/
