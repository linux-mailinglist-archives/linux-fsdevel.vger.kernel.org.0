Return-Path: <linux-fsdevel+bounces-1623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2167DC8E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 10:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C1E2817DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 09:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC22F12E76;
	Tue, 31 Oct 2023 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C7125CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 09:02:50 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6596B3;
	Tue, 31 Oct 2023 02:02:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8D886732D; Tue, 31 Oct 2023 10:02:42 +0100 (CET)
Date: Tue, 31 Oct 2023 10:02:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: catherine.hoang@oracle.com, cheng.lin130@zte.com.cn,
	dan.j.williams@intel.com, dchinner@redhat.com, djwong@kernel.org,
	hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, osandov@fb.com, ruansy.fnst@fujitsu.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 22c2699cb068
Message-ID: <20231031090242.GA25889@lst.de>
References: <87fs1s3bk6.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs1s3bk6.fsf@debian-BULLSEYE-live-builder-AMD64>
User-Agent: Mutt/1.5.17 (2007-11-01)

Can you also pick up:

"xfs: only remap the written blocks in xfs_reflink_end_cow_extent"

?

Also this seems to a bit of a mix of fixes for 6.7 and big stuff that
is too late for the merge window.


