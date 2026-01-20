Return-Path: <linux-fsdevel+bounces-74573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D417CD3BF74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5CD24F8B34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792B36D4EF;
	Tue, 20 Jan 2026 06:40:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB236CDF8;
	Tue, 20 Jan 2026 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891248; cv=none; b=BY3UpvuDuFw0AydI5jtLgIKonfbD0KkbgZHcGzE7ZGESr9dRDJIIROSlz1/An0tgY8YpJfDSRXJAqBE/1uB8gbtqzwJ7dv1eqGvFLAOX8tQZFo5enyewOt7p0/frfZYErxe9Na/wu9myfnysapwYdV/fc0PanSXt49hz/zl2DV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891248; c=relaxed/simple;
	bh=+Rj7uGD9BAg2RPQZhg6lU/sk+HcT1mWI2EcyTdXtF7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Btv9XTs6C0BlS6Nv+oD+Rzd/y5QcJVzgCJ4K6afksuDR0IykeKmPUATPBraXkw7a8t4F9pTc9rbR1Hzhg2M7o0BxQUx764bQI8oesXbX8PY0qlA20q77U1YEiW0UV/ZQVZzft4DLumwB71nsvw3dJduGjHwlomxvbRuZSo/jafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EDB22227AA8; Tue, 20 Jan 2026 07:40:32 +0100 (CET)
Date: Tue, 20 Jan 2026 07:40:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org,
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v5 02/14] ntfs: update in-memory, on-disk structures
 and headers
Message-ID: <20260120064032.GA3350@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-3-linkinjeon@kernel.org> <20260116082352.GB15119@lst.de> <CAKYAXd9SeJYhBOOK6rZ+0c4G42wvFZkjJ9vGnSrythsz55WLwA@mail.gmail.com> <20260119070527.GB1480@lst.de> <CAKYAXd_Kio7Xeh1SnbZtxrh8nvenQ8RZ59p9RyhE2MSSUbjnMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd_Kio7Xeh1SnbZtxrh8nvenQ8RZ59p9RyhE2MSSUbjnMw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 20, 2026 at 01:27:55PM +0900, Namjae Jeon wrote:
> On Mon, Jan 19, 2026 at 4:05 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Sun, Jan 18, 2026 at 01:54:06PM +0900, Namjae Jeon wrote:
> > > > It seem like big_ntfs_inode is literally only used in the conversion
> > > > helpers below.  Are there are a lot of these "extent inode" so that
> > > > not having the vfs inode for them is an actual saving?
> > > Right, In NTFS, a base MFT record (represented by the base ntfs_inode)
> > > requires a struct inode to interact with the VFS. However, a single
> > > file can have multiple extent MFT records to store additional
> > > attributes. These extent inodes are managed internally by the base
> > > inode and do not need to be visible to the VFS.
> >
> > What are typical numbers of the extra extent inodes?  If they are rare,
> > you might be able to simplify the code a bit by just always allocating
> > the vfs_inode even if it's not really used.
> Regarding the typical numbers, in most cases, It will require zero or
> only a few extra extent inodes. Okay, I will move vfs_inode to
> ntfs_inode.

This was just thinking out loud.  If it doesn't help to significantly
simplify things, don't bother.


