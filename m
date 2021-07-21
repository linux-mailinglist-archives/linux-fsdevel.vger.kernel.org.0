Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC1E3D0755
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 05:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhGUCl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 22:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhGUCl1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 22:41:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BD8F60725;
        Wed, 21 Jul 2021 03:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626837723;
        bh=DEpAlubo4wmFRzygO3DVuFLxAl5/U8Do+4uKSqqfF+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KpBbjwnDBWoF7SYGUtNo5SkT3BEEspxf2yDeKu+esB6+mmurj7DNpxGEaS593hy4D
         5OLsH3M1a1MI4K3FJDfx25QMqIpEmCL8++T4G9nVQOxjmQc45IrtC1P1CKQlrG3Hlg
         hInjq0edbIf2d2/MywBVQC/86gAs+J2nl2n3Pnwk=
Date:   Tue, 20 Jul 2021 20:22:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-Id: <20210720202202.dfd4d9c3490e51e35cf1455e@linux-foundation.org>
In-Reply-To: <YPeKnIpd+EAU4SZP@casper.infradead.org>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
        <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
        <20210720094033.46b34168@canb.auug.org.au>
        <YPY7MPs1zcBClw79@casper.infradead.org>
        <20210721122102.38c80140@canb.auug.org.au>
        <20210720192927.98ee7809717b9cc28fa95bb6@linux-foundation.org>
        <YPeKnIpd+EAU4SZP@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Jul 2021 03:46:52 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> > Sure, let's go that way.  Linus wasn't terribly enthusiastic about the
> > folio patches and I can't claim to be overwhelmed by their value/churn
> > ratio (but many MM developers are OK with it all, and that
> > counts).  Doing it this way retains options...
> 
> I'm happy to take these three patches through my tree if it makes life
> easier (and it does resolve the majority of the pain):
> 
> mm, memcg: add mem_cgroup_disabled checks in vmpressure and swap-related functions
> mm, memcg: inline mem_cgroup_{charge/uncharge} to improve disabled memcg config
> mm, memcg: inline swap-related functions to improve disabled memcg config

They're rather unimportant, can be deferred.

I'll probably move these to the post-linux-next queue, but let's just
do it and see how it goes.

