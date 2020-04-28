Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5201BB715
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 08:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgD1G5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 02:57:06 -0400
Received: from verein.lst.de ([213.95.11.211]:54392 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgD1G5G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:57:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8A16E68C7B; Tue, 28 Apr 2020 08:57:03 +0200 (CEST)
Date:   Tue, 28 Apr 2020 08:57:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] powerpc/spufs: simplify spufs core dumping
Message-ID: <20200428065703.GB18754@lst.de>
References: <20200427200626.1622060-1-hch@lst.de> <20200427200626.1622060-2-hch@lst.de> <20200427204953.GY23230@ZenIV.linux.org.uk> <fc3b45c91e5cd50baa1fec7710f1e64cbe616f77.camel@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3b45c91e5cd50baa1fec7710f1e64cbe616f77.camel@ozlabs.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:51:56AM +0800, Jeremy Kerr wrote:
> Hi Al & Christoph,
> 
> > Again, this really needs fixing.  Preferably - as a separate commit
> > preceding this series, so that it could be
> > backported.  simple_read_from_buffer() is a blocking operation.
> 
> I'll put together a patch that fixes this.
> 
> Christoph: I'll do it in a way that matches your changes to the _read
> functions, so hopefully those hunks would just drop from your change,
> leaving only the _dump additions. Would that work?

Sure.
