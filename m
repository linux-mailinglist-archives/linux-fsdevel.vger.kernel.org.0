Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12EA1A459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfEJVMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 17:12:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfEJVMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 17:12:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so3853703pfa.1;
        Fri, 10 May 2019 14:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+ESw1rm0vOQ8XrrTL92EUV44kZc8ZXapKKTT6DaubOw=;
        b=abQaEAUT/PwZVqII0uePTmS9FBR01d5OlkiCxRNEH2BX3NkEApVpdySLV3IoMgo3eE
         MP1rCnCnuCPSjhTkzHIQIu9EjwponUbG5NaVheL2B404JO3C7VDo9y+Mqy+KY7Lg/zk4
         HZTfCWvMUNfLp0nVXqu1vIXWG6DicO5EafSNtq2E9JGj8YNzk+9a7zc27b0qnafPNljm
         IM58BuLw+T91Vgkv/o68Z8iYzoCT3SgFEQ+60d0CSXdbj6HfDIyr/aisHXQJRc+XYuor
         tOktoH4JOGyFwmXPs1QyTI/Nhvaq7L9FFdinnXWtQ6JoCZdVbpWiloLrGBNB+AoVHD1q
         8ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ESw1rm0vOQ8XrrTL92EUV44kZc8ZXapKKTT6DaubOw=;
        b=YpAvhgZJMjWG8B+lqGeacDkXmA9iQB031V7R8AcxIoLDMCyTQ671G97r2oQGdrJW45
         F8zCZiZ089U+/WN0HhbabW4ylUFBo0fU2OfHdtJ8/s7qcDdc166vNLOkkwYPLqr+sH9m
         bqQdiwDjl1VSGtUCevq856NjQ53MZX3C5IwndI79C+DBsnu69yMRZ1HDJyrw5Aa79xYd
         GsLZ+4PVNmv5/ULPmz4eFrhu2Xg+pH9fMyUQh6JGjIv7NgCyemeHAkPj/+KrPkkhiG1l
         PqN29l8ShriJ1npkCcY+LyKWItHVDsQlKRWJ9uGG8l+pMPG6X5F3Jnp1rCjI/bK/IskY
         EDRA==
X-Gm-Message-State: APjAAAVjQ9EHargyCm1IcO1azTbK1NlU7f0iZBoAMgmSrYZtaA5l/jnI
        7TDH3RJmzmzC8AR8LkT+qXc=
X-Google-Smtp-Source: APXvYqwYkJPgFPW1Q2jECQKvaMp3I+Sd6dA//ZzL+oYRc3FbXlWvh0CqFEtZZOyMry0CoGOK+X3rcA==
X-Received: by 2002:a62:6842:: with SMTP id d63mr17487032pfc.9.1557522763176;
        Fri, 10 May 2019 14:12:43 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r8sm7860997pfn.11.2019.05.10.14.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 14:12:42 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Theodore Ts'o <tytso@mit.edu>, Tim.Bird@sony.com,
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
        julia.lawall@lip6.fr, khilman@baylibre.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
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
 <20190509214233.GA20877@mit.edu>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
Date:   Fri, 10 May 2019 14:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509214233.GA20877@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/19 2:42 PM, Theodore Ts'o wrote:
> On Thu, May 09, 2019 at 11:12:12AM -0700, Frank Rowand wrote:
>>
>>    "My understanding is that the intent of KUnit is to avoid booting a kernel on
>>    real hardware or in a virtual machine.  That seems to be a matter of semantics
>>    to me because isn't invoking a UML Linux just running the Linux kernel in
>>    a different form of virtualization?
>>
>>    So I do not understand why KUnit is an improvement over kselftest.
>>
>>    ...
>>
>>    What am I missing?"
> 
> One major difference: kselftest requires a userspace environment; it
> starts systemd, requires a root file system from which you can load
> modules, etc.  Kunit doesn't require a root file system; doesn't
> require that you start systemd; doesn't allow you to run arbitrary
> perl, python, bash, etc. scripts.  As such, it's much lighter weight
> than kselftest, and will have much less overhead before you can start
> running tests.  So it's not really the same kind of virtualization.
> 
> Does this help?
> 
> 					- Ted
> 

I'm back to reply to this subthread, after a delay, as promised.

That is the type of information that I was looking for, so
thank you for the reply.

However, the reply is incorrect.  Kselftest in-kernel tests (which
is the context here) can be configured as built in instead of as
a module, and built in a UML kernel.  The UML kernel can boot,
running the in-kernel tests before UML attempts to invoke the
init process.

No userspace environment needed.  So exactly the same overhead
as KUnit when invoked in that manner.
