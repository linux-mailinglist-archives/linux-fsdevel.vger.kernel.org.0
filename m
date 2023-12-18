Return-Path: <linux-fsdevel+bounces-6359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E7816BDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 12:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2151C22FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 11:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2319BC2;
	Mon, 18 Dec 2023 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkL3jKDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88595199A5;
	Mon, 18 Dec 2023 11:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46498C433C7;
	Mon, 18 Dec 2023 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702897558;
	bh=WTNLubnfyisNRdtZDWlLkSm9Rz36/vqI/xP24+xTDcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkL3jKDVwOB5N0/qhs/9JjBN+vonQpMsSa26ZBjSeCRCaulbO8roJteQgbMujfTXZ
	 3Pk24oNiYkl7kaOJH4+l0B3vvYwfgHe+iQlHgl15JWbDlqDuqUGQCkNX74IYjTVe8/
	 WAi00oyNO8Glx7CMmqcF7w8ioqLSdeBZVo+RVjflOBISKeZQ9jhqo6YoYcd635YauS
	 Nsvk9hyOKA3yRH7fpSLt2AJb6VqO2taL90lrMsyF44GZGUESZwPaw3Y5N/W7g2DNrx
	 nBHyVnuPNVNNsyf1euBS6V7GssBV7vDeg58lO1OxEBSBMWuW+9Gg4JBPJiuck8Y32G
	 /lwgRnx87ZYWw==
Date: Mon, 18 Dec 2023 12:05:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/39] netfs, afs, 9p: Delegate high-level I/O to
 netfslib
Message-ID: <20231218-gegen-unumstritten-fb0aeb7519af@brauner>
References: <20231213152350.431591-1-dhowells@redhat.com>
 <20231215-einziehen-landen-94a63dd17637@brauner>
 <ZXxUx_nh4HNTaDJx@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXxUx_nh4HNTaDJx@codewreck.org>

On Fri, Dec 15, 2023 at 10:29:43PM +0900, Dominique Martinet wrote:
> Christian Brauner wrote on Fri, Dec 15, 2023 at 01:03:14PM +0100:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.netfs
> 
> This doesn't seem to build:

Yeah, I'm aware. That's why I didn't push it out. I couldn't finish the
rebase completely on Friday.

