Return-Path: <linux-fsdevel+bounces-2523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298857E6C8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BA41C20BC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDDA1D689;
	Thu,  9 Nov 2023 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FasKhzNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080F20E6;
	Thu,  9 Nov 2023 14:41:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5990C199E;
	Thu,  9 Nov 2023 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g/MKNSs+zSvArB7q8qtP8xHhJeEpQN0BOB6q7PlgYtA=; b=FasKhzNHZ2QJZXjeJ68LL5Ongh
	N89LvRhroUeruxh2YNL5s5SLOirMbWko/bFelJKx//nyRJeOZWBYFkuZ8RcQerbRGp5pgKArTsou7
	DRMwsoeAUE6YynnX8qAqKqYXF7sYOukZJ0u/4jYd0EMCiE0gLYkHcR+IDdkVhy9Ck4git4kV8hsH7
	pQvREllAN75skIu0+ywphkP+OeXoYO4XwiNl4xxmDYSLqpsYVnbmzqN/OttOu6F/qU3g1MWDgqnPR
	ZFFHeymzWz/7bDB633e5haeIGY/gi4MvvjdNE8Fbx3tEQtfKGxRKoQG/y06hWn6slHL5obdZABjHM
	d4V282Uw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r16Dh-006W1G-0Q;
	Thu, 09 Nov 2023 14:41:21 +0000
Date: Thu, 9 Nov 2023 06:41:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUzvkQfqEYbjXCMd@infradead.org>
References: <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org>
 <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
 <ZUuWSVgRT3k/hanT@infradead.org>
 <20231108-atemwege-polterabend-694ca7612cf8@brauner>
 <20231108-herleiten-bezwangen-ffb2821f539e@brauner>
 <ZUyCeCW+BdkiaTLW@infradead.org>
 <20231109-umher-entwachsen-78938c126820@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-umher-entwachsen-78938c126820@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 09, 2023 at 10:07:35AM +0100, Christian Brauner wrote:
> > How?  If they want to only rely on Posix and not just he historical
> > unix/linux behavior they need to compare st_dev for the inode and it's
> > parent to see if it the Posix concept of a mount point (not to be
> > confused with the Linux concept of a mountpoint apparently) because
> > that allows the file system to use a new inode number namespace.
> 
> That doesn't work anymore. Both overlayfs and btrfs make this
> impossible or at least inconsistent.

One you hit a different st_dev on btrfs you'll stay on that until
you hit a mount point or another (nested) subvolume.  Can't comment
on overlayfs.  But if it keeps mixing things forth and back what would
the semantics of the flag be anyway?

