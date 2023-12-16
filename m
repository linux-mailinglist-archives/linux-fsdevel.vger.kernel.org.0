Return-Path: <linux-fsdevel+bounces-6295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F7B815738
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 05:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991D6B240D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E30B10A19;
	Sat, 16 Dec 2023 04:12:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640FDDAF;
	Sat, 16 Dec 2023 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED12168B05; Sat, 16 Dec 2023 05:12:21 +0100 (CET)
Date: Sat, 16 Dec 2023 05:12:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/3] btrfs: call btrfs_close_devices from
 ->kill_sb
Message-ID: <20231216041221.GA8850@lst.de>
References: <20231213040018.73803-1-ebiggers@kernel.org> <20231213040018.73803-2-ebiggers@kernel.org> <20231213084123.GA6184@lst.de> <20231215214550.GB883762@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215214550.GB883762@perftesting>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 15, 2023 at 04:45:50PM -0500, Josef Bacik wrote:
> I ran it through, you broke a test that isn't upstream yet to test the old mount
> api double mount thing that I have a test for
> 
> https://github.com/btrfs/fstests/commit/2796723e77adb0f9da1059acf13fc402467f7ac4
> 
> In this case we end up leaking a reference on the fs_devices.  If you add this
> fixup to "btrfs: call btrfs_close_devices from ->kill_sb" it fixes that failure.
> I'm re-running with that fixup applied, but I assume the rest is fine.  Thanks,

Is "this fixup" referring to a patch that was supposed to be attached
but is't? :)

