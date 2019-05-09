Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F343194D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 23:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEIVoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 17:44:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45284 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726219AbfEIVoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 17:44:16 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x49LgY32008689
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 May 2019 17:42:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B6256420024; Thu,  9 May 2019 17:42:33 -0400 (EDT)
Date:   Thu, 9 May 2019 17:42:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Tim.Bird@sony.com, knut.omang@oracle.com,
        gregkh@linuxfoundation.org, brendanhiggins@google.com,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190509214233.GA20877@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        brendanhiggins@google.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
        sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
References: <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 11:12:12AM -0700, Frank Rowand wrote:
> 
>    "My understanding is that the intent of KUnit is to avoid booting a kernel on
>    real hardware or in a virtual machine.  That seems to be a matter of semantics
>    to me because isn't invoking a UML Linux just running the Linux kernel in
>    a different form of virtualization?
> 
>    So I do not understand why KUnit is an improvement over kselftest.
> 
>    ...
> 
>    What am I missing?"

One major difference: kselftest requires a userspace environment; it
starts systemd, requires a root file system from which you can load
modules, etc.  Kunit doesn't require a root file system; doesn't
require that you start systemd; doesn't allow you to run arbitrary
perl, python, bash, etc. scripts.  As such, it's much lighter weight
than kselftest, and will have much less overhead before you can start
running tests.  So it's not really the same kind of virtualization.

Does this help?

					- Ted
