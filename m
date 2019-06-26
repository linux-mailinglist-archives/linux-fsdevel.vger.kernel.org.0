Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870A655CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 02:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFZABy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 20:01:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41270 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFZABy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 20:01:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so247312pff.8;
        Tue, 25 Jun 2019 17:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8jiVaE2JFBMfd+G3WCzNTPAlyBMExhnepJubp+vEbhM=;
        b=k+q+lL9JnManagsxYEhmD0SBcXkhaynxhSHiLAl0Ja+vnLH1iUkw4tZmA1+71kxgZE
         bgqgqaUKVuS0AOS342nb17+pjIKKxRi3U/ZWIYxDD7ND7INQyVWdDJisf5tOxstRt1Ky
         QxAxufzM5o2vnvYo7pLaEI32jWlufcvAMoN6UQN3eWfrdH+PVSOFXJ26Q+gIqH2Yd4ik
         buLtYhv3wnjU7FRRAHC7pWlG9dd0mPyoYvRDKEG1XdxXlXJmNJ4HfXqpk2FCdBoyDmOK
         hfsMtbCBdWAg0ReHyde2M31PpclLEkcwoSDyubDLiob12mO1J5PnhKo/Ph+klZQvoVOD
         Yoeg==
X-Gm-Message-State: APjAAAVWja7kG8Zm87XUU0bTOOui8G/YIPiDi0TnKNdYJ2B5jsSUw9EX
        mWX4/p/eXJ5PsjgU9ZOj1M8=
X-Google-Smtp-Source: APXvYqzNTUiSwWdZ3UgJYHzcAJb5xsbwt8eGmi7SJjyzu5XA3lIGVxbDEngQABiwrdIPUAy8M4OQFg==
X-Received: by 2002:a63:d756:: with SMTP id w22mr33935466pgi.156.1561507312844;
        Tue, 25 Jun 2019 17:01:52 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z22sm14694045pgu.28.2019.06.25.17.01.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 17:01:51 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0674940336; Wed, 26 Jun 2019 00:01:50 +0000 (UTC)
Date:   Wed, 26 Jun 2019 00:01:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, peterz@infradead.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        rdunlap@infradead.org, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [PATCH v5 13/18] kunit: tool: add Python wrappers for running
 KUnit tests
Message-ID: <20190626000150.GT19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-14-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-14-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:26:08AM -0700, Brendan Higgins wrote:
>  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
>  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
>  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-failure.log
>  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
>  create mode 100644 tools/testing/kunit/test_data/test_output_isolated_correctly.log
>  create mode 100644 tools/testing/kunit/test_data/test_read_from_file.kconfig

Why are these being added upstream? The commit log does not explain
this.

  Luis
