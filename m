Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914108AE02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 06:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfHMEqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 00:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfHMEqj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:46:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE742063F;
        Tue, 13 Aug 2019 04:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565671598;
        bh=Z0Svjt3Fo8yC4rslfkTmnZfxHx3ViQG+m+g6HFA41bY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=p83RZOpoKeUNPUd+BdLuIegfK0mpL5tQfiQzpBv6UO83yoxyp6adRidjeuhcOC4wC
         s338nTaCM7+3P21nyMlcXltcWN54xO5KBDwL0hp97UL6MvRD39sidLzFl/y7TD+7lb
         qRCWhAmLlx4CTBKgLcjNqWOK/XK9pEWO4ut/NKQY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812182421.141150-16-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-16-brendanhiggins@google.com>
Subject: Re: [PATCH v12 15/18] Documentation: kunit: add documentation for KUnit
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        Felix Guo <felixguoxiuping@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 21:46:37 -0700
Message-Id: <20190813044638.7FE742063F@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 11:24:18)
> Add documentation for KUnit, the Linux kernel unit testing framework.
> - Add intro and usage guide for KUnit
> - Add API reference
>=20
> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

