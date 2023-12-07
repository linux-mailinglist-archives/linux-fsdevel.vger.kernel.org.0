Return-Path: <linux-fsdevel+bounces-5089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D80807FA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 05:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90937B20A56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA27101F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r00ehVHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DCF137;
	Wed,  6 Dec 2023 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wkUbEgsT8kNDGnTQ+f2FTszBUpCpO7t7fL8xzputNT4=; b=r00ehVHVV4tFckzjwm9kVevs98
	cdFDuHzbnScMOKmGjjs62I666xSsM7nibYUEvZ2TUwz90A+UfZXQ2LzQSndu8Ctmasw08Sm1/6LHL
	NbNV4obpYC8XDsyROBsHgpHZkwrlxuB55YP7LTSWJHSlfFPjSlMUAUuUxRZkAExGbigmq9+6mSv/e
	+s1IwT7QGhdE2AnM2ThIcfSQan+ezCrwVnwetc44D5yoWn9H17F1vzBME2wQP7MEzV+qQLUd7euxn
	VUlHKiOFh94YqLSonRQye73MO5teOUsBG1RmYEOQ7TpfnrG6MutGtAoIPRi1bxCOCe/41i778aWnr
	vdU9lGOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB4ef-0083nC-15;
	Thu, 07 Dec 2023 03:02:25 +0000
Date: Thu, 7 Dec 2023 03:02:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] vfs: factor out inode hash head calculation
Message-ID: <20231207030225.GV1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-7-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-7-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 05:05:35PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> In preparation for changing the inode hash table implementation.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

ACKed-by: Al Viro <viro@zeniv.linux.org.uk>

