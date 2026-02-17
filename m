Return-Path: <linux-fsdevel+bounces-77400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKz8CFzalGl7IQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:15:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1B1150A00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 926B430576EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278237A481;
	Tue, 17 Feb 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qME5lVPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEE3793B1;
	Tue, 17 Feb 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362878; cv=none; b=I1cE0czN/JqrzwCyYagf5KFZu2o2M3/tomV5KpJ3m76vgxobOJgTM0cEsY8zprq11QsGUJNYWVld+2V7PuI2Ho0eHbUunAz6fN6oTrIsrYwPc/Ses21IHJztjbV7AbtH/IUbJpTrIQkT7PrrYtAnLgPVv52tTi8pTqUqiDuJvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362878; c=relaxed/simple;
	bh=SWr3Pg6zIeu2S3Z6UDsk8BzZU6tf527GPJ41POMlghM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qf73RQTBW78Pcv6J9dBKvzNX/FNGJgXVTmVVoigvinF0CjnwPfK0iR0uj8VK38XoiI6cVmH64K4TLto6Y3pEc02dtB225HrR8fIR/RV3h6mqzIvUGnbdLlsk8MLaVaquaRd2p/sYT+3a1y5N6U27AF7NGxXcL3SWTYAmHp7+jO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qME5lVPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0DCC19425;
	Tue, 17 Feb 2026 21:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771362878;
	bh=SWr3Pg6zIeu2S3Z6UDsk8BzZU6tf527GPJ41POMlghM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qME5lVPCgbs75GtVkYDVSedStUuy5Pu7iKCY4IKu3xqN3EcQE+Oh5yA77hoZy7VyU
	 +0wZZYMpZQVXM9oVuFBmRCNz9ULENuT2B5em0ouDg88Yb0OXaPujVB/GBPkgNNMpHr
	 EhgPO+uLpu1WI515RTCnoSYcSuoUoWHPdRcl280BUTS4HjHiimnSyoFiD+9+NmEu7s
	 4m0WVXB/a1C6i48qotqtPrvf49sFdMixg5MNCldkNycO7JhTW+IJtnP0WEfZw+8dYi
	 1uYBY6iDz7huxRyc2w6LATusfRgMkVW0RAKYcp9Uufer3E7jADONKO2Apo8cM0wFiU
	 pB1OIFY+N5Jzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1123806667;
	Tue, 17 Feb 2026 21:14:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 00/24] vfs: require filesystems to explicitly
 opt-in to lease support
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <177136286957.643511.1991968143318289235.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 21:14:29 +0000
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: luisbg@kernel.org, salah.triki@gmail.com, nico@fluxnic.net,
 hch@infradead.org, jack@suse.cz, al@alarsen.net, viro@zeniv.linux.org.uk,
 brauner@kernel.org, dsterba@suse.com, clm@fb.com, xiang@kernel.org,
 chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, guochunhai@vivo.com,
 jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 hirofumi@mail.parknet.co.jp, dwmw2@infradead.org, richard@nod.at,
 shaggy@kernel.org, konishi.ryusuke@gmail.com, slava@dubeyko.com,
 almaz.alexandrovich@paragon-software.com, mark@fasheh.com,
 jlbec@evilplan.org, joseph.qi@linux.alibaba.com, hubcap@omnibond.com,
 martin@omnibond.com, miklos@szeredi.hu, amir73il@gmail.com,
 phillip@squashfs.org.uk, cem@kernel.org, hughd@google.com,
 baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
 linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
 chuck.lever@oracle.com, alex.aring@gmail.com, agruenba@redhat.com,
 corbet@lwn.net, willy@infradead.org, ericvh@kernel.org, lucho@ionkov.net,
 asmadeus@codewreck.org, linux_oss@crudebyte.com, xiubli@redhat.com,
 idryomov@gmail.com, trondmy@kernel.org, anna@kernel.org, sfrench@samba.org,
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
 tom@talpey.com, bharathsm@microsoft.com, hansg@kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,lists.sourceforge.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.infradead.org,lists.orangefs.org,lists.samba.org,lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-77400-lists,linux-fsdevel=lfdr.de,f2fs];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE1B1150A00
X-Rspamd-Action: no action

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu, 08 Jan 2026 12:12:55 -0500 you wrote:
> Yesterday, I sent patches to fix how directory delegation support is
> handled on filesystems where the should be disabled [1]. That set is
> appropriate for v6.19. For v7.0, I want to make lease support be more
> opt-in, rather than opt-out:
> 
> For historical reasons, when ->setlease() file_operation is set to NULL,
> the default is to use the kernel-internal lease implementation. This
> means that if you want to disable them, you need to explicitly set the
> ->setlease() file_operation to simple_nosetlease() or the equivalent.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,01/24] fs: add setlease to generic_ro_fops and read-only filesystem directory operations
    https://git.kernel.org/jaegeuk/f2fs/c/ca4388bf1d9e
  - [f2fs-dev,02/24] affs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/663cdef61a27
  - [f2fs-dev,03/24] btrfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f9688474e413
  - [f2fs-dev,04/24] erofs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f8902d3df893
  - [f2fs-dev,05/24] ext2: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/ccdc2e0569f5
  - [f2fs-dev,06/24] ext4: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/20747a2a29c6
  - [f2fs-dev,07/24] exfat: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/b8ca02667552
  - [f2fs-dev,08/24] f2fs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/9e2ac6ddb397
  - [f2fs-dev,09/24] fat: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/a9acc8422ffb
  - [f2fs-dev,10/24] gfs2: add a setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/3b514c333390
  - [f2fs-dev,11/24] jffs2: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/c275e6e7c085
  - [f2fs-dev,12/24] jfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/7dd596bb35e5
  - [f2fs-dev,13/24] nilfs2: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f46bb13dc5d9
  - [f2fs-dev,14/24] ntfs3: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/6aaa1d6337b5
  - [f2fs-dev,15/24] ocfs2: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f15d3150279d
  - [f2fs-dev,16/24] orangefs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/136b43aa4b16
  - [f2fs-dev,17/24] overlayfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/94a3f60af5dc
  - [f2fs-dev,18/24] squashfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/dfd8676efe43
  - [f2fs-dev,19/24] tmpfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f5a3446be277
  - [f2fs-dev,20/24] udf: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/dbe8d57d1483
  - [f2fs-dev,21/24] ufs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/545b4144d804
  - [f2fs-dev,22/24] xfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/6163b5da2f5e
  - [f2fs-dev,23/24] filelock: default to returning -EINVAL when ->setlease operation is NULL
    https://git.kernel.org/jaegeuk/f2fs/c/2b10994be716
  - [f2fs-dev,24/24] fs: remove simple_nosetlease()
    https://git.kernel.org/jaegeuk/f2fs/c/51e49111c00b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



