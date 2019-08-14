Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E418CC86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfHNHSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 03:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfHNHSm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:18:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76072054F;
        Wed, 14 Aug 2019 07:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565767121;
        bh=pa8ZM0cB7Ynd5h1v6jDVACGMr40DuVATemDtrICxNrI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gFnMnbltojWFSsXrQHAtHzmV8Q0rNvZIWkw018qtr3Fxuh94zPr/qzmIgXjlo/Pzb
         ueeNYjpdxcdtYM/fj/HS0Gzo8HhvRxS/Pbf3S8gXc0JRsgzdUsUzYLi6pw/xzuct4F
         D32CJqllklCakBmqBQMSV8Swqw4sBNLi+YJG9e0o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814055108.214253-13-brendanhiggins@google.com>
References: <20190814055108.214253-1-brendanhiggins@google.com> <20190814055108.214253-13-brendanhiggins@google.com>
Subject: Re: [PATCH v13 12/18] kunit: test: add tests for KUnit managed resources
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
        wfg@linux.intel.com, Avinash Kondareddy <akndr41@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 00:18:40 -0700
Message-Id: <20190814071840.E76072054F@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-13 22:51:02)
> From: Avinash Kondareddy <akndr41@gmail.com>
>=20
> Add unit tests for KUnit managed resources. KUnit managed resources
> (struct kunit_resource) are resources that are automatically cleaned up
> at the end of a KUnit test, similar to the concept of devm_* managed
> resources.
>=20
> Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

