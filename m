Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411341BD45D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 08:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgD2GF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 02:05:56 -0400
Received: from verein.lst.de ([213.95.11.211]:60834 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgD2GF4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:05:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3700B68CF0; Wed, 29 Apr 2020 08:05:53 +0200 (CEST)
Date:   Wed, 29 Apr 2020 08:05:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
Message-ID: <20200429060553.GA30946@lst.de>
References: <20200427200626.1622060-2-hch@lst.de> <20200428120207.15728-1-jk@ozlabs.org> <20200428171133.GA17445@lst.de> <e1ebea36b162e8a3b4b24ecbc1051f8081ff5e53.camel@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ebea36b162e8a3b4b24ecbc1051f8081ff5e53.camel@ozlabs.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 09:36:30AM +0800, Jeremy Kerr wrote:
> Hi Christoph,
> 
> > FYI, these little hunks reduce the difference to my version, maybe
> > you can fold them in?
> 
> Sure, no problem.
> 
> How do you want to coordinate these? I can submit mine through mpe, but
> that may make it tricky to synchronise with your changes. Or, you can
> include this change in your series if you prefer.

Maybe you can feed your patch directly to Linus through Michael
ASAP, and I'll wait for that before resubmitting this series?
