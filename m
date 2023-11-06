Return-Path: <linux-fsdevel+bounces-2043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85527E1B39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 08:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A751A1C20B03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC7D29B;
	Mon,  6 Nov 2023 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D4C8F7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 07:30:01 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A86093
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 23:30:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 388E36732D; Mon,  6 Nov 2023 08:29:57 +0100 (CET)
Date: Mon, 6 Nov 2023 08:29:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: remove dead check
Message-ID: <20231106072957.GA17547@lst.de>
References: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org> <20231104-vfs-multi-device-freeze-v2-1-5b5b69626eac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-vfs-multi-device-freeze-v2-1-5b5b69626eac@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 04, 2023 at 03:00:12PM +0100, Christian Brauner wrote:
> Above we call super_lock_excl() which waits until the superblock is
> SB_BORN and since SB_BORN is never unset once set this check can never
> fire. Plus, we also hold an active reference at this point already so
> this superblock can't even be shutdown.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

