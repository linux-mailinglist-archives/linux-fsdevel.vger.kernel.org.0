Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D0E12626
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 03:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfECBpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 21:45:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32988 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfECBpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 21:45:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so2066537pfk.0;
        Thu, 02 May 2019 18:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZI6V/3n9+pa4S0kSap/rsqYeZseF3YXwwsnTTpOXHxI=;
        b=IzHws9INfv0Wab3PqWryc8nXLCUGl4Ak0ErN4UWGz/oa5Q3bx6Ym7vUbFg2Dqx16VW
         oWE14P70+9bC1kEcyxNogt4I3P4HndkNs5RErp+blOBqwXOoN+sRvrDOyunNPFAxApZ5
         GWxjJ458WsmG94/7XtkxgO5qMOVf/y0XY4UKG2ctayvfs5F5tkmBrAfFfxXWLQNmhozQ
         FgGdqQvM57obG+wUH3nrNRoNeYxwOGWCGFCKwlnl1UPR6OSjdtuSR+1SF1yttamHwiuF
         tHVqZdYB3J/J9HrwSMl4npzfzK/jusV2Hy+t88avqIGeQLvbQa2sXZZ+CQyhzOUMI8Al
         H3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZI6V/3n9+pa4S0kSap/rsqYeZseF3YXwwsnTTpOXHxI=;
        b=NZgFkNN/0Dw3XAaRCr1kJHWDWC+wr4iJs4h0obwFbmOVzcYJOBCpouUA4vVzfIXrYC
         arKrMj46McVL86VbbVSPpTyCBnbQv+jwRCIw3lQTIrLvfML4GpPEixOy3QmpbCNUe3f9
         ZKmZjxAphEK4mh7lpPbW9JU6reT6lphY3uWhsEV8gCVPbGp+YwyGJT1v3Lciaar5sXCY
         SvEvPRDrDUx9emY5fSIviO+fw3gaI6Z/o3sUL+q/hA44JjITu6srhvYCEfkvdeBKE+0x
         LSVb0zKWEnQCZnvAJKoKjbLI9iX2DyGf3nVcgN5fTc6tljExV8BG3yI/kEUJsDUvFdz+
         XqCA==
X-Gm-Message-State: APjAAAXKHgHLPA8cZXZIkXA3XASSASKIiqTjOPWs5ldqr5tsTWTAkT3z
        XAKNswy4KufAzA2ClZak+Gs=
X-Google-Smtp-Source: APXvYqwLxZ+uFuQZMF4YJqc7fAzpwsWGuH9RLKcLO+fHr/MYoaYjH8+9zszylWu8LEhaolJS2L6VrQ==
X-Received: by 2002:a63:5907:: with SMTP id n7mr7320611pgb.416.1556847948068;
        Thu, 02 May 2019 18:45:48 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n7sm553500pff.45.2019.05.02.18.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 18:45:47 -0700 (PDT)
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
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
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
 <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com>
Date:   Thu, 2 May 2019 18:45:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/2/19 4:45 PM, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 2:16 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/2/19 11:07 AM, Brendan Higgins wrote:
>>> On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
>>>>> From: Felix Guo <felixguoxiuping@gmail.com>
>>>>>
>>>>> The ultimate goal is to create minimal isolated test binaries; in the
>>>>> meantime we are using UML to provide the infrastructure to run tests, so
>>>>> define an abstract way to configure and run tests that allow us to
>>>>> change the context in which tests are built without affecting the user.
>>>>> This also makes pretty and dynamic error reporting, and a lot of other
>>>>> nice features easier.
>>>>>
>>>>> kunit_config.py:
>>>>>   - parse .config and Kconfig files.
>>>>>
>>>>> kunit_kernel.py: provides helper functions to:
>>>>>   - configure the kernel using kunitconfig.
>>>>>   - build the kernel with the appropriate configuration.
>>>>>   - provide function to invoke the kernel and stream the output back.
>>>>>
>>>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>>
>>>> Ah, here's probably my answer to my previous logging format question,
>>>> right?  What's the chance that these wrappers output stuff in a standard
>>>> format that test-framework-tools can already parse?  :)
> 
> To be clear, the test-framework-tools format we are talking about is
> TAP13[1], correct?

I'm not sure what the test community prefers for a format.  I'll let them
jump in and debate that question.


> 
> My understanding is that is what kselftest is being converted to use.
> 
>>>
>>> It should be pretty easy to do. I had some patches that pack up the
>>> results into a serialized format for a presubmit service; it should be
>>> pretty straightforward to take the same logic and just change the
>>> output format.
>>
>> When examining and trying out the previous versions of the patch I found
>> the wrappers useful to provide information about how to control and use
>> the tests, but I had no interest in using the scripts as they do not
>> fit in with my personal environment and workflow.
>>
>> In the previous versions of the patch, these helper scripts are optional,
>> which is good for my use case.  If the helper scripts are required to
> 
> They are still optional.
> 
>> get the data into the proper format then the scripts are not quite so
>> optional, they become the expected environment.  I think the proper
>> format should exist without the helper scripts.
> 
> That's a good point. A couple things,
> 
> First off, supporting TAP13, either in the kernel or the wrapper
> script is not hard, but I don't think that is the real issue that you
> raise.
> 
> If your only concern is that you will always be able to have human
> readable KUnit results printed to the kernel log, that is a guarantee
> I feel comfortable making. Beyond that, I think it is going to take a
> long while before I would feel comfortable guaranteeing anything about
> how will KUnit work, what kind of data it will want to expose, and how
> it will be organized. I think the wrapper script provides a nice
> facade that I can maintain, can mediate between the implementation
> details and the user, and can mediate between the implementation
> details and other pieces of software that might want to consume
> results.
> 
> [1] https://testanything.org/tap-version-13-specification.html

My concern is based on a focus on my little part of the world
(which in _previous_ versions of the patch series was the devicetree
unittest.c tests being converted to use the kunit infrastructure).
If I step back and think of the entire kernel globally I may end
up with a different conclusion - but I'm going to remain myopic
for this email.

I want the test results to be usable by me and my fellow
developers.  I prefer that the test results be easily accessible
(current printk() implementation means that kunit messages are
just as accessible as the current unittest.c printk() output).
If the printk() output needs to be filtered through a script
to generate the actual test results then that is sub-optimal
to me.  It is one more step added to my workflow.  And
potentially with an embedded target a major pain to get a
data file (the kernel log file) transferred from a target
to my development host.

I want a reported test failure to be easy to trace back to the
point in the source where the failure is reported.  With printk()
the search is a simple grep for the failure message.  If the
failure message has been processed by a script, and then the
failure reported to me in an email, then I may have to look
at the script to reverse engineer how the original failure
message was transformed into the message that was reported
to me in the email.  Then I search for the point in the
source where the failure is reported.  So a basic task has
just become more difficult and time consuming.

-Frank
