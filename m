Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA723814D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 00:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfFFWwy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 6 Jun 2019 18:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfFFWwy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:52:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0889F30821DF;
        Thu,  6 Jun 2019 22:52:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B61CD78569;
        Thu,  6 Jun 2019 22:52:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190606212140.GA25664@vmlxhi-102.adit-jv.com>
References: <20190606212140.GA25664@vmlxhi-102.adit-jv.com> <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <155981421379.17513.13158528501056454772.stgit@warthog.procyon.org.uk>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 10/10] Add sample notification program [ver #3]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31574.1559861570.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 06 Jun 2019 23:52:50 +0100
Message-ID: <31575.1559861570@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 06 Jun 2019 22:52:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eugeniu Rosca <erosca@de.adit-jv.com> wrote:

> How about arm64? Do you intend to enable cross-compilation?

There's no guarantee that a cross-compiler can actually build userspace apps,
though I haven't intended to encode anything against that in the Makefile.

> > +			asm ("lfence" : : : "memory" );
> [..]
> > +			asm("mfence" ::: "memory");
> 
> FWIW, trying to cross-compile it returned:
> 
> aarch64-linux-gnu-gcc -I../../usr/include -I../../include  watch_test.c   -o watch_test
> /tmp/ccDXYynm.s: Assembler messages:
> /tmp/ccDXYynm.s:471: Error: unknown mnemonic `lfence' -- `lfence'
> /tmp/ccDXYynm.s:568: Error: unknown mnemonic `mfence' -- `mfence'

Yeah.  I need to use C-standard __atomic_* stuff.

David
