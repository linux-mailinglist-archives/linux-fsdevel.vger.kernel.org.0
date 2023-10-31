Return-Path: <linux-fsdevel+bounces-1658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AD67DD469
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 18:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A66E281843
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0433520338;
	Tue, 31 Oct 2023 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFD2031D
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 17:12:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF3983;
	Tue, 31 Oct 2023 10:12:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3654A67373; Tue, 31 Oct 2023 18:12:31 +0100 (CET)
Date: Tue, 31 Oct 2023 18:12:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chandan Babu R <chandanbabu@kernel.org>,
	catherine.hoang@oracle.com, cheng.lin130@zte.com.cn,
	dan.j.williams@intel.com, dchinner@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	osandov@fb.com, ruansy.fnst@fujitsu.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 22c2699cb068
Message-ID: <20231031171230.GA31580@lst.de>
References: <87fs1s3bk6.fsf@debian-BULLSEYE-live-builder-AMD64> <20231031090242.GA25889@lst.de> <20231031164359.GA1041814@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031164359.GA1041814@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 31, 2023 at 09:43:59AM -0700, Darrick J. Wong wrote:
> If by 'big stuff' you mean the MF_MEM_PRE_REMOVE patch, then yes, I
> agree that it's too late to be changing code outside xfs.  Bumping that
> to 6.8 will disappoint Shiyang, regrettably.
> 
> The patchsets for realtime units refactoring and typechecked rt-helpers
> (except for the xfs_rtalloc_args thing) I'd prefer to land in 6.7 for a
> few reasons.  First, the blast radii are contained to the rtalloc
> subsystem of xfs.  Second, I've been testing them for nearly a year now,
> I think they're ready from a QA perspective.

I mean both of them.  And yes, I was hoping to see the RT work in 6.7
as well, but for that it needs to be in linux-next before the release
of 6.6.

