Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7547D3E53CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 08:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhHJGrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 02:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhHJGra (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:47:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90D3461058;
        Tue, 10 Aug 2021 06:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628578028;
        bh=EwApVal98GJfGLrb0/RTF40PF/lUG0GVeGxLHsgKH7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVN757FRS1gi/Y3lvE4P4YibmF7yaIUlKzDvclQOpm16d8lBEmubBUx/RUUJELrpd
         c+4sBjWHP9L4zatRbHZ43X2HalE8LN7679dg7k2h+yvqB/ekIlG2uQmHk9YAe3X1eS
         Jhc0/do/eA5qmKQTw98eSsVkTYCjC+Fgl2QxptfVikZHvOcmYHW7xexhTL9kl02OBG
         siGyHbhKAYYp67V0JHdxZRTGE/dXngEldBcHRGLuCSe5CVNXhKRfEefpxN4O7hPJtX
         2oucPH6NRTnh3QTIXgBVdWsi8jVk/B6sZ4tWmNWszdSmOz0Wga+k2HqfMtmCKDcoJ7
         D9ZXpWC15mJcg==
Date:   Mon, 9 Aug 2021 23:47:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH v27 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20210810064708.GI3601405@magnolia>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210810054637.aap4zuiiparfl2gq@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810054637.aap4zuiiparfl2gq@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 08:46:37AM +0300, Kari Argillander wrote:
> On Thu, Jul 29, 2021 at 04:49:33PM +0300, Konstantin Komarov wrote:
> > This patch adds NTFS Read-Write driver to fs/ntfs3.
> > 
> > Having decades of expertise in commercial file systems development and huge
> > test coverage, we at Paragon Software GmbH want to make our contribution to
> > the Open Source Community by providing implementation of NTFS Read-Write
> > driver for the Linux Kernel.
> > 
> > This is fully functional NTFS Read-Write driver. Current version works with
> > NTFS(including v3.1) and normal/compressed/sparse files and supports journal replaying.
> > 
> > We plan to support this version after the codebase once merged, and add new
> > features and fix bugs. For example, full journaling support over JBD will be
> > added in later updates.
> 
> I'm not expert but I have try to review this series best I can and have
> not found any major mistakes which prevents merging. Yeah there are
> couple bugs but because this is not going to replace NTFS driver just
> yet then IMO it is best that merge will happend sooner so development
> fot others get easier. I will also try to review future patches (from
> Paragon and others), test patches and make contribution at my own for this
> driver. So please use
> 
> Reviewed by: Kari Argillander <kari.argillander@gmail.com>

Nit: there's supposed to be a dash between 'Reviewed' and 'by'.

That said, thanks for putting your name out there! :)

--D
