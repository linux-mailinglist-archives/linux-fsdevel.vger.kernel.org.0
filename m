Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129771BD4A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 08:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgD2G3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 02:29:36 -0400
Received: from verein.lst.de ([213.95.11.211]:60981 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgD2G3g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:29:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15B4768BEB; Wed, 29 Apr 2020 08:29:34 +0200 (CEST)
Date:   Wed, 29 Apr 2020 08:29:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fixup! signal: factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-ID: <20200429062933.GB31478@lst.de>
References: <20200428074827.GA19846@lst.de> <20200428195645.1365019-1-arnd@arndb.de> <d00b4436-9a97-5e90-2a6f-e79f90be9736@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00b4436-9a97-5e90-2a6f-e79f90be9736@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 08:17:22AM +0200, Christophe Leroy wrote:
>>   +#ifndef CONFIG_X86_X32_ABI
>
> Can it be declared __weak instead of enclosing it in an #ifndef ?

I really hate the __weak ifdefs.  But my plan was to move to a
CONFIG_ARCH_COPY_SIGINFO_TO_USER32 and have x86 select it.
