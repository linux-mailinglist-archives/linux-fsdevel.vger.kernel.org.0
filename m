Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF81F5CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfEONpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 09:45:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:51042 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfEONpu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 09:45:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CACC1AAB;
        Wed, 15 May 2019 13:45:47 +0000 (UTC)
Date:   Wed, 15 May 2019 07:45:46 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [PATCH v3 15/18] Documentation: kunit: add documentation for
 KUnit
Message-ID: <20190515074546.07700142@lwn.net>
In-Reply-To: <20190514231902.GA12893@google.com>
References: <20190514054251.186196-1-brendanhiggins@google.com>
        <20190514054251.186196-16-brendanhiggins@google.com>
        <20190514073422.4287267c@lwn.net>
        <20190514180810.GA109557@google.com>
        <20190514121623.0314bf07@lwn.net>
        <20190514231902.GA12893@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 May 2019 16:19:02 -0700
Brendan Higgins <brendanhiggins@google.com> wrote:

> Hmmm...probably premature to bring this up, but Documentation/dev-tools/
> is kind of thrown together.

Wait a minute, man... *I* created that directory, are you impugning my
work? :)

But yes, "kind of thrown together" is a good description of much of
Documentation/.  A number of people have been working for years to make
that better, with some success, but there is a long way to go yet.  The
dev-tools directory is an improvement over having that stuff scattered all
over the place — at least it's actually thrown together — but it's not the
end point.

> It would be nice to provide a coherent overview, maybe provide some
> basic grouping as well.
> 
> It would be nice if there was kind of a gentle introduction to the
> tools, which ones you should be looking at, when, why, etc.

Total agreement.  All we need is somebody to write it!  :)

Thanks,

jon
