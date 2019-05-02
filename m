Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA494123FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 23:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEBVQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 17:16:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36361 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEBVQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 17:16:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so1633188pgc.3;
        Thu, 02 May 2019 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SXzn4PL7BS9Zk+Qjz5Z6ao7p78pnuZhgvrrpjIHBgqs=;
        b=kCJFdJIIF969KctuD3d2wM6Ofbq6dPOZFLTH8wlGl+7+cVokVRuDwro7NOWN9ohV8k
         ImAl50lyzEBsv7yN+yDsApIRZoLtSCfwhyzyxPvjXoEWcvwOBh4YVBGfYFjfXofVIUhG
         4IdfwHyJltRS5sW89ee6jcilUM33Ka1rf9l/1hx/r4xvkgirrOsCcjMVyOo7fNRjZFEX
         W57GSaPxOGJB3pNyXX+NzqVUj3/2JEPXwOjRvCBv8sNkyMt8fb6SSscfdGTffg6t6JdB
         E1xSneePimV/qvTL3gOacgC8P6jcyMC1ik1HBxyp2Tove1HOXYfOKbo6mTy7cNVaJPvY
         TkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXzn4PL7BS9Zk+Qjz5Z6ao7p78pnuZhgvrrpjIHBgqs=;
        b=pcJqDcIzbpppzXFbvgI0rUcsLQ6lnBA27PfHO9JPODM+fQgYK63DOJxxWgTVdq9FWp
         V2Azdulv3zKvkEnOEVQ/udBOpZsAdMmU+YEkQ5ObvZllNXUnrXPk4z5wo7QEPOp4nybN
         L7d+5/1X0D05k8J4xphzTNJbcUa4edawtNYodf5pXehhJ96msYgDZWXzVbJ+n0in1CKc
         x9YaDZsbm1w0AshA5yOMDasYnrX++vdexqLx0T7kpsp4iP+unwGfd/aj9piYTLxaWTo8
         fC8WVrNCqFlTWQYyMpeNABlAL36Arjc/9hieexCg8SfxSV0/mFT088kBzTf22bhYPP+L
         HsRw==
X-Gm-Message-State: APjAAAXZTHeEI4ilZYR6xyaLTDyRV7ZS/GCwKiPFe3/dPT8uX9G468mX
        aSo5coEv1JtmH2fZJI/vmzI=
X-Google-Smtp-Source: APXvYqyaAKrOO8dNkOZg12O3d42lENfOgkrL7qBtR/V01hTlj71I+CQb4vEU5IP/L2A0+G0+xdSQEg==
X-Received: by 2002:a63:5f42:: with SMTP id t63mr6174518pgb.275.1556831786717;
        Thu, 02 May 2019 14:16:26 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f63sm102173pfc.180.2019.05.02.14.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 14:16:26 -0700 (PDT)
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To:     Brendan Higgins <brendanhiggins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah@kernel.org, devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
Date:   Thu, 2 May 2019 14:16:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/2/19 11:07 AM, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
>>> From: Felix Guo <felixguoxiuping@gmail.com>
>>>
>>> The ultimate goal is to create minimal isolated test binaries; in the
>>> meantime we are using UML to provide the infrastructure to run tests, so
>>> define an abstract way to configure and run tests that allow us to
>>> change the context in which tests are built without affecting the user.
>>> This also makes pretty and dynamic error reporting, and a lot of other
>>> nice features easier.
>>>
>>> kunit_config.py:
>>>   - parse .config and Kconfig files.
>>>
>>> kunit_kernel.py: provides helper functions to:
>>>   - configure the kernel using kunitconfig.
>>>   - build the kernel with the appropriate configuration.
>>>   - provide function to invoke the kernel and stream the output back.
>>>
>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>
>> Ah, here's probably my answer to my previous logging format question,
>> right?  What's the chance that these wrappers output stuff in a standard
>> format that test-framework-tools can already parse?  :)
> 
> It should be pretty easy to do. I had some patches that pack up the
> results into a serialized format for a presubmit service; it should be
> pretty straightforward to take the same logic and just change the
> output format.

When examining and trying out the previous versions of the patch I found
the wrappers useful to provide information about how to control and use
the tests, but I had no interest in using the scripts as they do not
fit in with my personal environment and workflow.

In the previous versions of the patch, these helper scripts are optional,
which is good for my use case.  If the helper scripts are required to
get the data into the proper format then the scripts are not quite so
optional, they become the expected environment.  I think the proper
format should exist without the helper scripts.

-Frank
