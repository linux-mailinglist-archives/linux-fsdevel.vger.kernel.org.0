Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2601A453A80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 21:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhKPUEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 15:04:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240149AbhKPUED (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 15:04:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68B0F61A89;
        Tue, 16 Nov 2021 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637092866;
        bh=Ynrka1yWhfVCzAzmYhDHu5sH4g5cHmPDLnKJdmLK8YI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=neNhS1h886Kaixhsht7yeAo+QVmkAcGP146mL0ESM3aLhv0bPcohQlUcklu+xYXSZ
         pDigaSrgfzJUvk5++ARPT7jG3aBZGwmAVL+R4s6QTMMS3XdKc1H5guX1L+I9LXIBzA
         jgTm+dOC+xySpqtPVapKWQX/qR0KXaObnsN6Jk4s=
Date:   Tue, 16 Nov 2021 12:01:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, gladkov.alexey@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/4] remove PDE_DATA()
Message-Id: <20211116120104.f96b7f21a333c2c8d140e015@linux-foundation.org>
In-Reply-To: <CAMZfGtX+GkVf_7D8G+Ss32+wYy1bcMgDpT5FJDA=a9gdjW36-w@mail.gmail.com>
References: <20211101093518.86845-1-songmuchun@bytedance.com>
        <20211115210917.96f681f0a75dfe6e1772dc6d@linux-foundation.org>
        <CAMZfGtX+GkVf_7D8G+Ss32+wYy1bcMgDpT5FJDA=a9gdjW36-w@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 16 Nov 2021 16:26:12 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> >
> > because new instances are sure to turn up during the development cycle.
> >
> > But I can handle that by staging the patch series after linux-next and
> > reminding myself to grep for new PDE_DATA instances prior to
> > upstreaming.
> 
> I'd be happy if you could replace PDE_DATA() with inode->i_private.
> In this case, should I still introduce pde_data() and perform the above
> things to make this series smaller?

I do tend to think that pde_data() would be better than open-coding
inode->i_private everywhere.  More explanatory, easier if we decide to
change it again in the future.

