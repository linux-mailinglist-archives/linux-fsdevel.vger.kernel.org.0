Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6641A12F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfEJQSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 12:18:36 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36628 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfEJQSg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 12:18:36 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hP8Dm-0006xr-3M; Fri, 10 May 2019 10:18:07 -0600
To:     Frank Rowand <frowand.list@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        brendanhiggins@google.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, dan.j.williams@intel.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
References: <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <20190509233043.GC20877@mit.edu>
 <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
 <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3faa022b-0b70-0375-aa6d-12ea83a2671f@deltatee.com>
Date:   Fri, 10 May 2019 10:17:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: wfg@linux.intel.com, rostedt@goodmis.org, rientjes@google.com, richard@nod.at, pmladek@suse.com, mpe@ellerman.id.au, khilman@baylibre.com, julia.lawall@lip6.fr, joel@jms.id.au, jdike@addtoit.com, daniel@ffwll.ch, dan.j.williams@intel.com, dan.carpenter@oracle.com, amir73il@gmail.com, Alexander.Levin@microsoft.com, linux-um@lists.infradead.org, linux-nvdimm@lists.01.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, shuah@kernel.org, sboyd@kernel.org, robh@kernel.org, mcgrof@kernel.org, kieran.bingham@ideasonboard.com, keescook@google.com, brendanhiggins@google.com, gregkh@linuxfoundation.org, knut.omang@oracle.com, Tim.Bird@sony.com, tytso@mit.edu, frowand.list@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-05-09 11:18 p.m., Frank Rowand wrote:

> YES, kselftest has in-kernel tests.  (Excuse the shouting...)

Cool. From my cursory look, in my opinion, these would be greatly
improved by converting them to the framework Brendan is proposing for Kunit.

>> If they do exists, it seems like it would make sense to
>> convert those to kunit and have Kunit tests run-able in a VM or
>> baremetal instance.
> 
> They already run in a VM.
> 
> They already run on bare metal.
> 
> They already run in UML.

Simply being able to run in UML is not the only thing here. Kunit
provides the infrastructure to quickly build, run and report results for
all the tests from userspace without needing to worry about the details
of building and running a UML kernel, then parsing dmesg to figure out
what tests were run or not.

> This is not to say that KUnit does not make sense.  But I'm still trying
> to get a better description of the KUnit features (and there are
> some).

So read the patches, or the documentation[1] or the LWN article[2]. It's
pretty well described in a lot of places -- that's one of the big
advantages of it. In contrast, few people seems to have any concept of
what kselftests are or where they are or how to run them (I was
surprised to find the in-kernel tests in the lib tree).

Logan

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/
[2] https://lwn.net/Articles/780985/
