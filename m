Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C704C12406
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEBVS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 17:18:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44989 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEBVS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 17:18:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so1738499pfm.11;
        Thu, 02 May 2019 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IMDXeiJnZScTm/Z2fnilFyDCMvT/so814pMi9HZOjlE=;
        b=F6aEAFFTMEY1A2qy1v4j/PN2GP6GkE/6G2UBiv6QtH3csxGy/tWQz9UyALBQT0H1TD
         MeqU6hM9umqY0cg0Apce+C6xD7p/xobhUeh9MvWiRshhDTYwjMCFPRJXDlmB1nI2J9BP
         OzIBfpWyS6JYvMDV31/EOZgJHoSWDTYYtNA+I4V1u8ppBrJn22kX8LSoN6iqCo9WhEY7
         d+Gb6Xl5Xs5otxILTZsg9XkKBj+kf5e2zhHYN3mehnTBbPBGx+Rmo9Huu3e7g+KZRBMy
         FLtK+ZKMR1Bm1xie5Eekig7pGAK9pe7NuFPMeA4bw49W6KmIoFN+i8IYZC8Mr/CFaKXa
         I9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IMDXeiJnZScTm/Z2fnilFyDCMvT/so814pMi9HZOjlE=;
        b=hDDN271P8NcMcvALdq2P5oOss1i/8EkzQNfhiYOq9TDxmhwIbkUswQ9nggKntqUBbZ
         uHejWkd4ExzGsZg5FKf5x85Iw/MtoCQLinOqq51GQNYKZ5sJMnvYDc67vx/5KJXmfWBw
         IeteT6r0VdqaiVo67CpfPrnuVzfo67JBGnwyW9PSPaZnTmWGFMDRmMmePjRXb5bPSW2v
         HFWW9t08ynkAryy34hvkMSH8+wXHe+iPSbEJ3E0O3kwuoZHSVdB7J1DdyUkeq5Rb7uc8
         IwWyTKrHno2KlydOK39cbpKSpOR3YFKhXyT/aL1qWj7t5LfZlk0SWIdW06pWdg3I8t2m
         Ep+w==
X-Gm-Message-State: APjAAAWzlhg9+Fslm+jgPdxOwzs5uJB73aLecIUreuApi2JPPLA2yOkB
        gnKVcsaAeAMKGopqX15eNh8=
X-Google-Smtp-Source: APXvYqyX3j/ct3IijwmpxxuiCJMGeDGeHP5eVJgN3Sl6Ovmj2WM37sI+ZAhRzZjNxXrFUHk4WRTuBA==
X-Received: by 2002:a65:5089:: with SMTP id r9mr6248599pgp.14.1556831937028;
        Thu, 02 May 2019 14:18:57 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l1sm232976pgp.9.2019.05.02.14.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 14:18:56 -0700 (PDT)
Subject: Re: [PATCH v2 04/17] kunit: test: add kunit_stream a std::stream like
 logger
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-5-brendanhiggins@google.com>
 <20190502110008.GC12416@kroah.com>
 <CAFd5g47ssM7RQZxQsUJ86UigcF-Uz+Kwv2yvKN_gZK-TtW89bA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6fcf1218-a026-fd7b-236f-ea95f6312e1d@gmail.com>
Date:   Thu, 2 May 2019 14:18:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47ssM7RQZxQsUJ86UigcF-Uz+Kwv2yvKN_gZK-TtW89bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/2/19 1:25 PM, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 4:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Wed, May 01, 2019 at 04:01:13PM -0700, Brendan Higgins wrote:
>>> A lot of the expectation and assertion infrastructure prints out fairly
>>> complicated test failure messages, so add a C++ style log library for
>>> for logging test results.
>>
>> Ideally we would always use a standard logging format, like the
>> kselftest tests all are aiming to do.  That way the output can be easily
>> parsed by tools to see if the tests succeed/fail easily.
>>
>> Any chance of having this logging framework enforcing that format as
>> well?
> 
> I agree with your comment on the later patch that we should handle
> this at the wrapper script layer (KUnit tool).

This discussion is a little confusing, because it is spread across two
patches.

I do not agree that this should be handled in the wrapper script, as
noted in my reply to patch 12, so not repeating it here.

-Frank
