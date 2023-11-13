Return-Path: <linux-fsdevel+bounces-2798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC797EA1BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 18:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3844280E97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594AB224C3;
	Mon, 13 Nov 2023 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sgy+ROpV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE9200D1
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 17:15:56 +0000 (UTC)
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056AF1737
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 09:15:54 -0800 (PST)
Date: Mon, 13 Nov 2023 12:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699895752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=q6gpvBOQSMdRG3VMs18zvP55wkOMgUPmfx5PPCGo4u0=;
	b=sgy+ROpVn8iQFWHdZOmYgArduhjKak4rMVyeQXlUH+EVV3wvv3hPff9/PdNy6uRwKiAyiO
	kWOwEwuxkRSGWqhm5mxUvW3t8ev4vhqA1m+xrFG7Txtxnr5mxyyqHI8MjQ5ueFVr+3flFr
	vqfDFbAXz142lwxS4mtMygrgIJ8BJc0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [bcachefs cabal meeting] 1 PM EST
Message-ID: <20231113171549.rt2ahac327yxygza@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hoping to get the roadmap fleshed out some more, start collecting more
ideas and sketching out design plans: https://bcachefs.org/Roadmap/

I'll be talking a bit about the btree write buffer work, and the disk
space accounting rewrite (which should, hopefully, get us per
subvol/snapshot accounting).

Shoot me an email for an invite.

Cheers,
Kent

