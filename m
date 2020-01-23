Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE7146771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 13:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAWMAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 07:00:14 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWMAO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:00:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 483LSB6550z9sR1;
        Thu, 23 Jan 2020 23:00:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579780811;
        bh=Qssy8Z8NfuyAy51hONYL4hX6c8q5cwlksF+KATS/Va0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rLl+08kzBb4g2n8F7VQzk3NNFL71siESbd3j3NyU3b5ioG1xV4TQjTyPmSbuv05gH
         jJbBeekJ9gpGoGJzfG9JCmMujWREFb+dmbfC6P9gfC99Ls+vRUV0Jx7uHNPqFhrMvV
         moWcxcT51f5wE7M/O3EepUDBr7PLY3H26w8mC+ehhmaqlHJRS1h7NA2upaWLhzj/u1
         2iYaGuvGanDFaavf8yo84Eu1cWYL5Lii/6Ev6lXhH2Xci8x/J/nfWgkIrmY4xC0kdU
         Q5kTE46q7HbZuPcIFGutldnmSQE4xU4JXR4PRFEplJkGeoOOjMvNyLNx1mk723HJPR
         El3F5oAbZzTWg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
In-Reply-To: <87muaeidyc.fsf@mpe.ellerman.id.au>
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr> <87muaeidyc.fsf@mpe.ellerman.id.au>
Date:   Thu, 23 Jan 2020 23:00:09 +1100
Message-ID: <87k15iidrq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Hi Christophe,
>
> This patch is independent of the rest of the series AFAICS

And of course having hit send I immediately realise that's not true.

> So I'll take patches 2-6 via powerpc and assume this patch will go via
> Linus or Al or elsewhere.

So I guess I'll wait and see what happens with patch 1.

cheers
