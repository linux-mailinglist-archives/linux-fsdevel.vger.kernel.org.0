Return-Path: <linux-fsdevel+bounces-5090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B7807FA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 05:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA151C203E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048410A1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BtIVegwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D60919E;
	Wed,  6 Dec 2023 19:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IEfEAW8Upymct/6VGRYrscPfQ9rwqDyeWXvyRn18uJw=; b=BtIVegwCorHHSu8ndACf/UxXbK
	ZujJD8nArCsBUBERFNWhPFTccfqj0K2pKUYOJPfBkg7AKVKYBYJXM4aexPgL5GbXZccWGdd3JxPim
	mVJB0vOUXZIjsUDqcuZGpwyJQOrq5DDwEFoD8c/kUVOTA3Plq13gd7XgoKnzTJfy2JUohIqy3f0pU
	oidHOobCFWj0qmmivEMRm4J9Oy0RsE7HlIxc1QjRePPga6LI0WzjV4vRHh5LI3u11LRKckQZ1SsRe
	eNm5n3IkliGntyNHcjrgm/jYvoovCsgcJVgKegOhEIaWitt2eNp7Jxw/pij/XO5A1x8tXeLtDIMge
	9eyMrvDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB4hO-0083q0-2D;
	Thu, 07 Dec 2023 03:05:14 +0000
Date: Thu, 7 Dec 2023 03:05:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] hlist-bl: add hlist_bl_fake()
Message-ID: <20231207030514.GW1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-8-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-8-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 05:05:36PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> in preparation for switching the VFS inode cache over the hlist_bl
> lists, we nee dto be able to fake a list node that looks like it is
> hased for correct operation of filesystems that don't directly use
> the VFS indoe cache.

I'd probably put it as "we need hlist_bl counterparts of hlist_fake()
and hlist_add_fake()"...

