Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8941F9DA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 18:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgFOQli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 12:41:38 -0400
Received: from verein.lst.de ([213.95.11.211]:34309 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730431AbgFOQlh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:41:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14E2268AFE; Mon, 15 Jun 2020 18:41:34 +0200 (CEST)
Date:   Mon, 15 Jun 2020 18:41:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
Message-ID: <20200615164133.GA23493@lst.de>
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de> <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com> <20200615141239.GA12951@lst.de> <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com> <20200615144310.GA15101@lst.de> <CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com> <20200615150926.GA17108@lst.de> <CAMzpN2htYX7s6pmRg-c8qwZL1f1_+sB=ztDG_L=617hWsm-=8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2htYX7s6pmRg-c8qwZL1f1_+sB=ztDG_L=617hWsm-=8g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:33:49AM -0400, Brian Gerst wrote:
> If you move those aliases above all the __SYSCALL_* defines it will
> work, since that will get the forward declaration too.  This would be
> the simplest workaround.

That compiles and also passes my exaustive x32 tests (chroot + ls -l).

This is the updated version:

http://git.infradead.org/users/hch/misc.git/commitdiff/c8d319711ad2f53be003ae8e9be08519068bdcee
