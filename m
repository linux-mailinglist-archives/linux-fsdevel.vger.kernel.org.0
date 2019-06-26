Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62EEE55F12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 04:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfFZCiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 22:38:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34771 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfFZCiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:38:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so530849plt.1;
        Tue, 25 Jun 2019 19:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xyvmsuEmijKSbxFAnA4vq/E+5XBo5Wy44kba2nyP6go=;
        b=BZ4Ebg4Mt6iFRuTXwwNgpnI8OJuJfNv6Djd1wfAGtRm4J6le9LnoXlG+dUNYWOR9D7
         SHVbvleUAs8CQCfiP053jw77OWwAH7Qu+pCbIWytWn1qVhaklx8aiVg/91zaBAqJVQtp
         sXkggoTIDiN/db5MeQ3pRaodF5e9xQTEcpluL/yT8iiuIiJ8pE+eoGGmkH0zII+dlNkT
         4IIZ/BgaUA2p5OeaYmxSqry1EQBjr9/lb1BV0QgKZB9DnJmpILUtCQFi+Dm/Hh1V1rrV
         mhlv8L/GIPHj6Kh0QlD02v8RGP8vBoN+9LtnPNuRNt0up7Nwe1pnhAz3F+YM+SX833Rp
         8ZYw==
X-Gm-Message-State: APjAAAXBfkt/cK+pdF8iQ9Rnchzts0gS6EGxjDfhR3ikZMvWGKP7Libt
        jNDamToKkzhoHpeM+IGDZYc=
X-Google-Smtp-Source: APXvYqzDq44Q6ELr7lMNQzzU3Ay+P/NMrvUlNETj0hOmt7FHk+liK3UY9V/aPmtCKjArXN7tpqRtdw==
X-Received: by 2002:a17:902:e512:: with SMTP id ck18mr2107905plb.53.1561516691699;
        Tue, 25 Jun 2019 19:38:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a16sm20081945pfd.68.2019.06.25.19.38.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 19:38:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BC94340336; Wed, 26 Jun 2019 02:38:09 +0000 (UTC)
Date:   Wed, 26 Jun 2019 02:38:09 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, jpoimboe@redhat.com,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
Subject: Re: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190626023809.GW19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 19, 2019 at 06:17:51PM -0700, Frank Rowand wrote:
> It does not matter whether KUnit provides additional things, relative
> to kselftest.  The point I was making is that there appears to be
> _some_ overlap between kselftest and KUnit, and if there is overlap
> then it is worth considering whether the overlap can be unified instead
> of duplicated.

From my experience as an author of several kselftests drivers, one
faily complex, and after reviewing the sysctl kunit test module, I
disagree with this.

Even if there were an overlap, I'd say let the best test harness win.
Just as we have different LSMs that do something similar.

But this is not about that though. Although both are testing code,
they do so in *very* different ways.

The design philosophy and architecture are fundamentally different. The
*only* thing I can think of where there is overlap is that both can test
similar code paths. Beyond that, the layout of how one itemizes tests
could be borrowed, but that would be up to each kselftest author to
decide, in fact some ksefltests do exist which follow similar pattern of
itemizing test cases and running them. Kunit just provides a proper
framework to do this easily but also with a focus on UML. This last
aspect makes kselftests fundamentally orthogonal from an architecture /
design perspective.

After careful review, I cannot personally identify what could be shared
at this point. Can you? If you did identify one part, how do you
recommend to share it?

  Luis
