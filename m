Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E3E157F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 05:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfEGDOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 23:14:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46486 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfEGDOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 23:14:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id j11so7822249pff.13;
        Mon, 06 May 2019 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XPy6o0NjYz38vWpV6pc1h2A6N4smSYs4Cq49Ux9zwV8=;
        b=uTQNGYZ1XWIvXYHBEeJQovmqhK2Jtpq+d64Qro6G5OKceot5sQNTlLbfduNr0K3PGx
         CsKeB5E/nKLx2mO5rHvB5C3cSTlrSg27HAg1bLnsc6sS6Ob71hOBqLsY7CZ9Kc78pahW
         2bjV9Jxur71IdhgsqsXU4h/nzLhauMpdelIF+i15235Qca74Y0OgvP33q3BLK9LqDfFd
         Xr/fhjikEY63MLGvaPSmYU14OjokXybBFpWj/AGZsAXkXpEZkB0f6qswg2ygyAISGWpA
         7eDh4rZZ2yShjUppASxA0qxx7J3s6zLlj/zKwFDiXJf9dX+MaLJqGhuEngD27vSXcDZx
         mNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XPy6o0NjYz38vWpV6pc1h2A6N4smSYs4Cq49Ux9zwV8=;
        b=bpGmhPA4nLB6Twbk5csOyQsxQkRfpaM0M3+zBCdYF2ditokfKtQja54RhMiUuc8VKm
         99wUhRwxzKKuwyDDRdKqc6806OVTvYJavNSiJdHNcBvgtC7UWcOTyRAUDT0EEbaN1iDK
         +RVrbZ901k3ouQgWRIsfQp0kmUNLbEGByWkcmXyT3JEvzPSjDv/lPCMVi7oNFshfQhZV
         DQViNHZ5miie3fHmUTwEvaSjQ13KFLJ1W3FHorGtDGD0t85LWDeqsujQJ57zffUlBUWq
         qmAY4eJOXIAnz2b787wqSKwdvk1M4M4d3RaXVzdp3qBJC96szIC6dw2ggUlAs/J5IJVe
         /PYA==
X-Gm-Message-State: APjAAAU5SaVa7bH19Pdkzl0Pf2PmKJ6V6i2/NLXVqmpEE+nCc7gnNWnF
        MWEiMzXZNqRh8l8aS+kWvo5YXwxZ0NA=
X-Google-Smtp-Source: APXvYqwISNSy9xefPMYRgOslBbKIROeiQ4y33+rxQnv0dnHw2MR5wA3FiL1meR7p3JPjBqzEw/Pz1Q==
X-Received: by 2002:a65:4802:: with SMTP id h2mr34368073pgs.98.1557198856091;
        Mon, 06 May 2019 20:14:16 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id m11sm17053726pgd.12.2019.05.06.20.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 20:14:15 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
Date:   Mon, 6 May 2019 20:14:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 4:01 PM, Brendan Higgins wrote:
> ## TLDR
> 
> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> 5.2.
> 
> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> we would merge through your tree when the time came? Am I remembering
> correctly?
> 
> ## Background
> 
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
> 
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> and does not require tests to be written in userspace running on a host
> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> can run several dozen tests in under a second. Currently, the entire
> KUnit test suite for KUnit runs in under a second from the initial
> invocation (build time excluded).
> 
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.

As a result of the emails replying to this patch thread, I am now
starting to look at kselftest.  My level of understanding is based
on some slide presentations, an LWN article, https://kselftest.wiki.kernel.org/
and a _tiny_ bit of looking at kselftest code.

tl;dr; I don't really understand kselftest yet.


(1) why KUnit exists

> ## What's so special about unit testing?
> 
> A unit test is supposed to test a single unit of code in isolation,
> hence the name. There should be no dependencies outside the control of
> the test; this means no external dependencies, which makes tests orders
> of magnitudes faster. Likewise, since there are no external dependencies,
> there are no hoops to jump through to run the tests. Additionally, this
> makes unit tests deterministic: a failing unit test always indicates a
> problem. Finally, because unit tests necessarily have finer granularity,
> they are able to test all code paths easily solving the classic problem
> of difficulty in exercising error handling code.

(2) KUnit is not meant to replace kselftest

> ## Is KUnit trying to replace other testing frameworks for the kernel?
> 
> No. Most existing tests for the Linux kernel are end-to-end tests, which
> have their place. A well tested system has lots of unit tests, a
> reasonable number of integration tests, and some end-to-end tests. KUnit
> is just trying to address the unit test space which is currently not
> being addressed.

My understanding is that the intent of KUnit is to avoid booting a kernel on
real hardware or in a virtual machine.  That seems to be a matter of semantics
to me because isn't invoking a UML Linux just running the Linux kernel in
a different form of virtualization?

So I do not understand why KUnit is an improvement over kselftest.

It seems to me that KUnit is just another piece of infrastructure that I
am going to have to be familiar with as a kernel developer.  More overhead,
more information to stuff into my tiny little brain.

I would guess that some developers will focus on just one of the two test
environments (and some will focus on both), splitting the development
resources instead of pooling them on a common infrastructure.

What am I missing?

-Frank


> 
> ## More information on KUnit
> 
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here:
> https://google.github.io/kunit-docs/third_party/kernel/docs/
> Additionally for convenience, I have applied these patches to a branch:
> https://kunit.googlesource.com/linux/+/kunit/rfc/v5.1-rc7/v1
> The repo may be cloned with:
> git clone https://kunit.googlesource.com/linux
> This patchset is on the kunit/rfc/v5.1-rc7/v1 branch.
> 
> ## Changes Since Last Version
> 
> None. I just rebased the last patchset on v5.1-rc7.
> 

