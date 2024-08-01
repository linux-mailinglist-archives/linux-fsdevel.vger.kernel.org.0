Return-Path: <linux-fsdevel+bounces-24836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE9B945393
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 21:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7841C230F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3314A617;
	Thu,  1 Aug 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r8maXDG4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7F114A614
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542130; cv=none; b=k+X6+FmqSVNdk69/0JgeDIyufWYC00lyvANNJDgtPU/yxXi/gmy6nil9ew6GBsuay5kquUZHrhuyXMOxIoeJ38Fe2GgcktwS1yu1/xpAHuE0H8NX9ddzAIJtizWHdihBIPCYY5AWVB8Z/E/zH7/gr40aTJDgugEpSzxlHjtxQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542130; c=relaxed/simple;
	bh=pM25fzDODGrXIqcfrFAag2ocVQcXAoqjEajowcFmiQM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ds0ikKp3/GU3BmSGS3daebMAWKBnOf2NOUcXUG/L7zl2fsouD7dCU2gIqFRHcSGFxz6uwMMq09+Iqdr+a53EwVDNfW8UNlj7I3168r4hmFZmIm8PwXcSbU6ytxoi2MFY//c7oOlW3BhU3bkRkuVIud1MB5ocCw1qjA+IMIpGXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=r8maXDG4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IAMzbL5qOLdwhj2HR91Fk0wkSGs4mY93vrq6MVqZq4M=; b=r8maXDG4e4YyOE+HyADpAozPYo
	7U9VYcWaYUyfIWRwbtMlEUtaqhhhcDBHJuACvWl5jeu+6B4d0Z9FbW+GP8+0nZAYgCFPvSJ2rbYpe
	oVaAxPwwbRiwbFD1F3f6sNkTTgneTri3sknCnmeXk1PfFvfbstP2RDtHk0MOsSlcMI1M6sxGeolbk
	fnhpMEgzlOkp2EbxcNMkZoBvwKIXzivxTBEfyefJjrWj61B33tWVgbjuJUxH8HqgLIlObR4nj+K5Z
	CpnDO3gasO2KElG0gpX3p8rhEgcYULBCaGoc1wUQJysIiQq+zujxf+ymXuVBkyizkBQW9FPv7x5im
	y1fW38MA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZbtV-00000000o1w-3VN8;
	Thu, 01 Aug 2024 19:55:25 +0000
Date: Thu, 1 Aug 2024 20:55:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20240801195525.GT5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 8aa37bde1a7b645816cda8b80df4753ecf172bf1:

  protect the fetch of ->fd[fd] in do_dup2() from mispredictions (2024-08-01 15:51:57 -0400)

----------------------------------------------------------------
do_dup2() out-of-bounds array speculation fix

----------------------------------------------------------------
Al Viro (1):
      protect the fetch of ->fd[fd] in do_dup2() from mispredictions

 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

