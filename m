Return-Path: <linux-fsdevel+bounces-6181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC181494A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51838B23B10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFDB2DF97;
	Fri, 15 Dec 2023 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ZOF0Y6Oz";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="L+tc9AV7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5231A68;
	Fri, 15 Dec 2023 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 05FD3C023; Fri, 15 Dec 2023 14:30:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702647009; bh=b20vpyg00WVKyH6ybuqsHsgOXZgJ2nb71oRe/G0ycJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOF0Y6OzwY77P+4OK/bRx/LrA92E+Ewqg7UEcUTXhlBz8WRRzkOsyWJsKm9lxRTtw
	 xtoPSv6O9oxvJpuYguK9xY1uPTJXr5NOHCCZ3kbcQEzGdY/Kq9KpKIuO3NDqlKgGud
	 Aa/7f/fAGOuveFvNH08lFTZqK6znaj71tk3Wbc3Wt90uEINykdavQ7zyd9dEfOnuOn
	 Z1PlzvWTFz9HUtDsPMNqv0OC7r1zw6rrA0ZvUKg6sP5xpVeJNHQtNc82xrdQxMSQ4D
	 Q69/KGCAz9V7u1p8dyz2oTi4YMj8SYbIX/256qZJEKxGq6iQXgGtwx5tJrh+QtXvPb
	 dDAehFNnM+a7w==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 4FAF9C009;
	Fri, 15 Dec 2023 14:30:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702647008; bh=b20vpyg00WVKyH6ybuqsHsgOXZgJ2nb71oRe/G0ycJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+tc9AV77ZtJkbnBcyJo/SQdJxBCl8J00AjfEfjPJmuB3W7CjYkI69XJqbf38qbVT
	 iN+BVGUZw1IYvZhn1OkWsRzzuwmEc7GnlsnkX4mCFTRmV6WY6RBx7G5X6Vfhpk3XWX
	 wBNxZF1klac/LiiNCkqMeYfLQsZz1fiAjDDp+YL/ln7seybyTXVhRQdhKNBhbPDqtD
	 kQrnngf4YY5S7T1KSuB565s8Mj6l7wUDoBCP9f/DxD8OojN/sRJRPVDJTiNwnqRgAP
	 XW+EhZXAuxEGyJR4xoprwR5o8PgJeUaAxnDl+jDKDdW2/e0t2NfYEWTLP2bGT8gWku
	 LoIkI9axCVNMA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 6ce99df9;
	Fri, 15 Dec 2023 13:29:58 +0000 (UTC)
Date: Fri, 15 Dec 2023 22:29:43 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Brauner <brauner@kernel.org>
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
Message-ID: <ZXxUx_nh4HNTaDJx@codewreck.org>
References: <20231213152350.431591-1-dhowells@redhat.com>
 <20231215-einziehen-landen-94a63dd17637@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231215-einziehen-landen-94a63dd17637@brauner>

Christian Brauner wrote on Fri, Dec 15, 2023 at 01:03:14PM +0100:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.netfs

This doesn't seem to build:
-------
  CC [M]  fs/netfs/buffered_write.o
fs/netfs/buffered_write.c: In function ‘netfs_kill_pages’:
fs/netfs/buffered_write.c:569:17: error: implicit declaration of function ‘generic_error_remove_folio’; did you mean ‘generic_error_remove_page’? [-Werror=implicit-function-declaration]
  569 |                 generic_error_remove_folio(mapping, folio);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |                 generic_error_remove_page
cc1: some warnings being treated as errors
-------

This helper is present in -next as commit af7628d6ec19 ("fs: convert
error_remove_page to error_remove_folio") (as of now's next), apparently
from akpm's mm-stable:
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-stable

(which obviously have some conflict in afs when trying to merge...)


I'll go back to dhowell's tree to finally test 9p a bit,
sorry for lack of involvement just low on time all around.


Good luck (?),
-- 
Dominique Martinet | Asmadeus

