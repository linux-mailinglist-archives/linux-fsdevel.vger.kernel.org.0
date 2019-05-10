Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5F719801
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 07:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfEJFSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 01:18:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40965 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfEJFSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 01:18:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so2402074pgp.8;
        Thu, 09 May 2019 22:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xr7T45ENj0X8h0TTVYIw3YN3QMd5VAPV0aYioKPyHGs=;
        b=E1W7JeDYer401ts5Pou7l1Dg8TvNv88Ns4Lxp8N/AgQI/qtmKYf4sNUlvOULHL6msw
         bA+I7RbCsYKAaaMHAvXT6Fy1BGVr1yesoASaRLH6j/RcI8tUmGMA5UmJ/rWF+KvKU+u2
         kHaJkGp0GSxbcaoUl+lU2S18kDfjfldcm6/dgG8YRjndn5rv5Vcgo2gT7GV7bNpO12MH
         WACO3dSP6EWF4OBYJVOjOuhUw87UecegOh600ZVYpyP23r15SmCI6/2JOlQtfBmzCiBv
         GKCcSYfhY18upXwnqcnmZwEFLwwyITRtKemOfO3+vrLyFwKarkL6tbKzZ3EF3xyKXxzT
         KHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xr7T45ENj0X8h0TTVYIw3YN3QMd5VAPV0aYioKPyHGs=;
        b=ZrLeRC0dVWtw2i61ISCEscA5vpfCyC7KvDc3i1oD2xwj8o2iB/JJLjiew5JkH26+d3
         a2s0QCFgKyMyWO0mcwc1yjTWIKephgp0MX+dt9WPclc4QT5N6yK3qx7x/O2IaYnSgaUE
         pn0zmZpdK+fr1i5qQ1KPQO/+Px+X4FBqiPaDbldNQ9YHLbeqzlArTaXqCG9dn/EuwKhR
         ksmnhOkltM3zMVM6wQjZzF+yQvRZDG0WBi1EHN7MSO6nTbUK8ZFQUmVNwgBow0WY1pGp
         Eu4GPG2Bye7rc0KkKaNFE9h/o8aUOdGzf2B2qRHFzu/1MVdsu/Orzyc38Wr+JscuvRXS
         Q+Yw==
X-Gm-Message-State: APjAAAWiogm++iDkzrUGupfAleMM4AAWGyj8ZvdCM9hCMUm3srvmVz2S
        7IeSfgOutr7l3Xt0uljExdw=
X-Google-Smtp-Source: APXvYqwtH7Skgh8l1ykgmrPjhuMGx9pfdkEsTTFsM6aBvQOxMoXlEpvU8usovtkKH/1Zc0SXCzAcIQ==
X-Received: by 2002:a63:4820:: with SMTP id v32mr11058846pga.89.1557465509602;
        Thu, 09 May 2019 22:18:29 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l19sm4974597pff.1.2019.05.09.22.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 22:18:29 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Logan Gunthorpe <logang@deltatee.com>,
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
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
Date:   Thu, 9 May 2019 22:18:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/19 4:40 PM, Logan Gunthorpe wrote:
> 
> 
> On 2019-05-09 5:30 p.m., Theodore Ts'o wrote:
>> On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
>>>
>>> The second item, arguably, does have significant overlap with kselftest.
>>> Whether you are running short tests in a light weight UML environment or
>>> higher level tests in an heavier VM the two could be using the same
>>> framework for writing or defining in-kernel tests. It *may* also be valuable
>>> for some people to be able to run all the UML tests in the heavy VM
>>> environment along side other higher level tests.
>>>
>>> Looking at the selftests tree in the repo, we already have similar items to
>>> what Kunit is adding as I described in point (2) above. kselftest_harness.h
>>> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
>>> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
>>>
>>> However, the number of users of this harness appears to be quite small. Most
>>> of the code in the selftests tree seems to be a random mismash of scripts
>>> and userspace code so it's not hard to see it as something completely
>>> different from the new Kunit:
>>>
>>> $ git grep --files-with-matches kselftest_harness.h *
>>
>> To the extent that we can unify how tests are written, I agree that
>> this would be a good thing.  However, you should note that
>> kselftest_harness.h is currently assums that it will be included in
>> userspace programs.  This is most obviously seen if you look closely
>> at the functions defined in the header files which makes calls to
>> fork(), abort() and fprintf().
> 
> Ah, yes. I obviously did not dig deep enough. Using kunit for
> in-kernel tests and kselftest_harness for userspace tests seems like
> a sensible line to draw to me. Trying to unify kernel and userspace
> here sounds like it could be difficult so it's probably not worth
> forcing the issue unless someone wants to do some really fancy work
> to get it done.
> 
> Based on some of the other commenters, I was under the impression
> that kselftests had in-kernel tests but I'm not sure where or if they
> exist.

YES, kselftest has in-kernel tests.  (Excuse the shouting...)

Here is a likely list of them in the kernel source tree:

$ grep module_init lib/test_*.c
lib/test_bitfield.c:module_init(test_bitfields)
lib/test_bitmap.c:module_init(test_bitmap_init);
lib/test_bpf.c:module_init(test_bpf_init);
lib/test_debug_virtual.c:module_init(test_debug_virtual_init);
lib/test_firmware.c:module_init(test_firmware_init);
lib/test_hash.c:module_init(test_hash_init);	/* Does everything */
lib/test_hexdump.c:module_init(test_hexdump_init);
lib/test_ida.c:module_init(ida_checks);
lib/test_kasan.c:module_init(kmalloc_tests_init);
lib/test_list_sort.c:module_init(list_sort_test);
lib/test_memcat_p.c:module_init(test_memcat_p_init);
lib/test_module.c:static int __init test_module_init(void)
lib/test_module.c:module_init(test_module_init);
lib/test_objagg.c:module_init(test_objagg_init);
lib/test_overflow.c:static int __init test_module_init(void)
lib/test_overflow.c:module_init(test_module_init);
lib/test_parman.c:module_init(test_parman_init);
lib/test_printf.c:module_init(test_printf_init);
lib/test_rhashtable.c:module_init(test_rht_init);
lib/test_siphash.c:module_init(siphash_test_init);
lib/test_sort.c:module_init(test_sort_init);
lib/test_stackinit.c:module_init(test_stackinit_init);
lib/test_static_key_base.c:module_init(test_static_key_base_init);
lib/test_static_keys.c:module_init(test_static_key_init);
lib/test_string.c:module_init(string_selftest_init);
lib/test_ubsan.c:module_init(test_ubsan_init);
lib/test_user_copy.c:module_init(test_user_copy_init);
lib/test_uuid.c:module_init(test_uuid_init);
lib/test_vmalloc.c:module_init(vmalloc_test_init)
lib/test_xarray.c:module_init(xarray_checks);


> If they do exists, it seems like it would make sense to
> convert those to kunit and have Kunit tests run-able in a VM or
> baremetal instance.

They already run in a VM.

They already run on bare metal.

They already run in UML.

This is not to say that KUnit does not make sense.  But I'm still trying
to get a better description of the KUnit features (and there are
some).

-Frank
