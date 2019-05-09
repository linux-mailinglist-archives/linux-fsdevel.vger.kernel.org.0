Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960C9183AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 04:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEICSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 22:18:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38658 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEICSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 22:18:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id a59so327955pla.5;
        Wed, 08 May 2019 19:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=67cKgHpKn5BasI4H9G5b29AFH8V2LHpBqBhNNX7AepI=;
        b=IdWnqVyky2mloPBWQLjQqC3RNWwopYAaMClPvfqRz+kOE5FYbiQV2HYTeaz5LcNXRc
         7wOeWEeAayPUpVKD8GVgH5tlHGjOMXoHfdDjtYENRb51HqJzXvqoIVPN/c8gSgI1A8Bd
         27sn+YVD+VXjElLK8ki7xOEob0TJCp6WvbCU+Rl8BL3/htDMfD8jdKzGUvRX6k4w7lc7
         Pf0CP6YbTC4sS274CsPgsIalQHztO9A4EhBK4Z9Lb7TnlcPn29QL3JvNlnhzeK+xhVUQ
         HL6MkDTHh/MTo81DfiP0Voc8IagpScTcOZUNMy2+isvaJF7gRho5CMGYBOrvWGSA9sL6
         4Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=67cKgHpKn5BasI4H9G5b29AFH8V2LHpBqBhNNX7AepI=;
        b=rU5xxhg28CX4dohbXqqjMfNojO3iyfcG9Oe35Dz4Dv/IaUXM21z07xLY+ZBti6C+ib
         83AzCqjoPsbmWD1TcaN+edxIWxWJ1a7sSgOcaf+4Tynw3dLYD2P+kUzavwfhl26qunk/
         mUACrmRqm7+8KISD2a1LD/dE7sZi53CIrH9KNS2D8/QaBm+kTITf2+UzxDewXoKzeJ2s
         u3maC3jM4XRNsEQz7y6Ycb3S0B6W9WHndP1Wuf3dwoU0Ne3DaAiCUXi2tQpeH7jzy65I
         aWiUaywc+diGqndfXRUKN4RN+58IfQgy1ejuniKSKaSuBS1ULI3I1kFIQmMAOXiaswkC
         mL6Q==
X-Gm-Message-State: APjAAAVoyLV8NN0limvx4XOX+p/huq9SZOgKcF6VonI9xPrWEeKuqt3n
        UTkvOQWbjH/zRpvotEAIHPA=
X-Google-Smtp-Source: APXvYqxKONkqpvysOzcXsSL0stE2Fx1k07GjyXCU+F00vWxsMMPMatYsdoa5bWbRlxy93rTIbJhz0w==
X-Received: by 2002:a17:902:8f82:: with SMTP id z2mr1716364plo.51.1557368314774;
        Wed, 08 May 2019 19:18:34 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r138sm777868pfr.2.2019.05.08.19.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 19:18:33 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com> <20190507172256.GB5900@mit.edu>
 <4d963cdc-1cbb-35a3-292c-552f865ed1f7@gmail.com>
 <20190509014407.GA7031@mit.edu>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <458dcb03-8dee-a005-97e1-7296a9e5bbfd@gmail.com>
Date:   Wed, 8 May 2019 19:18:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509014407.GA7031@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/8/19 6:44 PM, Theodore Ts'o wrote:
> On Wed, May 08, 2019 at 05:58:49PM -0700, Frank Rowand wrote:
>>
>> If KUnit is added to the kernel, and a subsystem that I am submitting
>> code for has chosen to use KUnit instead of kselftest, then yes, I do
>> *have* to use KUnit if my submission needs to contain a test for the
>> code unless I want to convince the maintainer that somehow my case
>> is special and I prefer to use kselftest instead of KUnittest.
> 
> That's going to be between you and the maintainer.  Today, if you want
> to submit a substantive change to xfs or ext4, you're going to be
> asked to create test for that new feature using xfstests.  It doesn't
> matter that xfstests isn't in the kernel --- if that's what is
> required by the maintainer.

Yes, that is exactly what I was saying.

Please do not cut the pertinent parts of context that I am replying to.


>>> supposed to be a simple way to run a large number of small tests that
>>> for specific small components in a system.
>>
>> kselftest also supports running a subset of tests.  That subset of tests
>> can also be a large number of small tests.  There is nothing inherent
>> in KUnit vs kselftest in this regard, as far as I am aware.


> The big difference is that kselftests are driven by a C program that
> runs in userspace.  Take a look at tools/testing/selftests/filesystem/dnotify_test.c
> it has a main(int argc, char *argv) function.
> 
> In contrast, KUnit are fragments of C code which run in the kernel;
> not in userspace.  This allows us to test internal functions inside
> complex file system (such as the block allocator in ext4) directly.
> This makes it *fundamentally* different from kselftest.

No, totally incorrect.  kselftests also supports in kernel modules as
I mention in another reply to this patch.

This is talking past each other a little bit, because your next reply
is a reply to my email about modules.

-Frank

> 
> Cheers,
> 
> 						- Ted
> 

