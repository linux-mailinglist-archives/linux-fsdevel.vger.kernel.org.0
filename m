Return-Path: <linux-fsdevel+bounces-1305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4560A7D8EA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA73EB2131F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155508F4F;
	Fri, 27 Oct 2023 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142758F43
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:26:05 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E4D4B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 23:26:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 105DD67373; Fri, 27 Oct 2023 08:26:02 +0200 (CEST)
Date: Fri, 27 Oct 2023 08:26:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] bdev: add freeze and thaw holder operations
Message-ID: <20231027062601.GB9109@lst.de>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org> <20231024-vfs-super-freeze-v2-4-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-4-599c19f4faac@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

I still find it weird to add the methods in a separate commit without
the users, but otherwise this still loooks good to me.


