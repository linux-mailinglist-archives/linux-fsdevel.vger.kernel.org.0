Return-Path: <linux-fsdevel+bounces-2044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9119D7E1B3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 08:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10FC1C20B37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED10D29D;
	Mon,  6 Nov 2023 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17BCA7A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 07:30:50 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F614D47
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 23:30:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBCCB6732D; Mon,  6 Nov 2023 08:30:46 +0100 (CET)
Date: Mon, 6 Nov 2023 08:30:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH v2 2/2] fs: handle freezing from multiple devices
Message-ID: <20231106073046.GB17547@lst.de>
References: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org> <20231104-vfs-multi-device-freeze-v2-2-5b5b69626eac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-vfs-multi-device-freeze-v2-2-5b5b69626eac@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

