Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5004A3DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 07:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357765AbiAaGot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 01:44:49 -0500
Received: from verein.lst.de ([213.95.11.211]:53705 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347924AbiAaGos (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:44:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9117A68AFE; Mon, 31 Jan 2022 07:44:44 +0100 (CET)
Date:   Mon, 31 Jan 2022 07:44:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] unicode: clean up the Kconfig symbol confusion
Message-ID: <20220131064444.GA4745@lst.de>
References: <20220118065614.1241470-1-hch@lst.de> <87zgnp51wo.fsf@collabora.com> <20220124090855.GA23041@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124090855.GA23041@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:08:55AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 20, 2022 at 08:10:47PM -0500, Gabriel Krisman Bertazi wrote:
> > > Fixes: 2b3d04787012 ("unicode: Add utf8-data module")
> > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > I fixed the typo and pushed the patch to a linux-next visible branch
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/commit/?h=for-next&id=5298d4bfe80f6ae6ae2777bcd1357b0022d98573
> > 
> > I'm also sending a patch series shortly turning IS_ENABLED into part of
> > the code flow where possible.
> 
> Thanks.  It might make sense to get the one patch to Linux for 5.17
> so that we don't have the new Kconfig symbol for just one release.

Can we try to get this into 5.17-rc, please to avoid adding the Kconfig
symbol Linus complained about in one release just to remove it again
in the next one?
