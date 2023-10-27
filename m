Return-Path: <linux-fsdevel+bounces-1307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E417D8EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C836B213EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB39474;
	Fri, 27 Oct 2023 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558438F69
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:30:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB81B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 23:30:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C90F367373; Fri, 27 Oct 2023 08:30:26 +0200 (CEST)
Date: Fri, 27 Oct 2023 08:30:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] fs: remove unused helper
Message-ID: <20231027063026.GD9109@lst.de>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org> <20231024-vfs-super-freeze-v2-8-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-8-599c19f4faac@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 24, 2023 at 03:01:14PM +0200, Christian Brauner wrote:
> The grab_super() helper is now only used by grab_super_dead(). Merge the
> two helpers into one.

I'd add grab_super to the end of the subject line, without that it is
not very descriptive.

