Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128E51AF895
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 10:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSIDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 04:03:43 -0400
Received: from verein.lst.de ([213.95.11.211]:35696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDSIDm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:03:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ABB1568BEB; Sun, 19 Apr 2020 10:03:39 +0200 (CEST)
Date:   Sun, 19 Apr 2020 10:03:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/8] signal: clean up __copy_siginfo_to_user32
Message-ID: <20200419080339.GC12222@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-3-hch@lst.de> <87pnc5akhk.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnc5akhk.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:08:23PM -0500, Eric W. Biederman wrote:
> This bothers me because it makes all architectures pay for the sins of
> x32.  Further it starts burying the details of the what is happening in
> architecture specific helpers.  Hiding the fact that there is only
> one niche architecture that does anything weird.
> 
> I am very sensitive to hiding away signal handling details right now
> because way to much of the signal handling code got hidden in
> architecture specific files and was quite buggy because as a result.

I much prefer the unconditional flags over the crazy ifdef mess in
the current coe and your version.  Except for that and the rather
strange and confusing copy_siginfo_to_external32 name it pretty much
looks the same.
