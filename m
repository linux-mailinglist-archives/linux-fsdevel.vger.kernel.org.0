Return-Path: <linux-fsdevel+bounces-3830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 958647F8F93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 23:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2244DB21065
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D7230FB8;
	Sat, 25 Nov 2023 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QiCZ7pPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30360107;
	Sat, 25 Nov 2023 14:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w22BbJzeiV5XdRVkK/jPp6/I8D2fBwuLyal6AMwg+KE=; b=QiCZ7pPBmVtTKXaZnn+lVDn6Cm
	0ZY9/4Ndamq0jcwiz2+MJu/TjCe+BfNXGPFfHF9p97+bjEtUahfNsS9vnXzSCWb2dk63NcIv6N2qW
	Vb1wlZBPrlh6XSS2wB7URt2LyMmyCM+O18AOr3k3rIbFHHhUzarDz8ORLN7STfesDoCLTm2cmlgc6
	nv5IV1VEl1qWmjlfmetJC9M00CCkWH+KRKJV2SewjR8IgiOT8s1d6W/jAf6hlFE5+7Dm/q/Am6LMP
	lOxcbYLvPQI3uU3RmBCWA3J6gPalgTA3rB8r7WitEJOwo3z8fHAUxyd97D7/imaTDhaJmOZalkmA/
	6dqV+u3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r70iW-003CV8-2x;
	Sat, 25 Nov 2023 22:01:37 +0000
Date: Sat, 25 Nov 2023 22:01:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231125220136.GB38156@ZenIV>
References: <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <87leangoqe.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leangoqe.fsf@>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 24, 2023 at 10:22:49AM -0500, Gabriel Krisman Bertazi wrote:

> ack. I'll base the other changes we discussed on top of your branch.

Rebased to v6.7-rc1, fixed up (ceph calls fscrypt_d_revalidate() directly,
and D/f/porting entry had been missing), pushed out as #no-rebase-d_revalidate

