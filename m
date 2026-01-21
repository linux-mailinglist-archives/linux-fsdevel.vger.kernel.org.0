Return-Path: <linux-fsdevel+bounces-74915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMiRJec2cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:28:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AE5D38C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D507F7881EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225B53DA7EB;
	Wed, 21 Jan 2026 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="zIlxUAaJ";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="RviAK33Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954A3DA7C3
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026437; cv=none; b=Ykquv6Tzni6b9Ryf6FZqxTZGUa6HpXn3f28X7LQGYOUNcsBPUG4W22pbyJK4ixR/nn7mt3GNU+qQJg6Sn0uozpqEduPZvxAkDofeiwo160CY4VINFGaIUkMQGU5dCwP0nUiYswy6E4cgPYlUOtckDfa/0lhE+gelHOQd2st2f+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026437; c=relaxed/simple;
	bh=2aNkmmpN/maFhoXoFDhcOIJSoaTihCV4ecMI+GcnpNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InNaaSiGo3z1+KnT6VtCZSKOEYPIRk26bli9t46khbZt+DFKrtGq9oc4roouAR0Nc0PMRWgrr1yN0c8qzo3U53f57HB9qKBz2MbOWAgPdoxJVFqYJbtRvWzAQmHN6XNQC4zfxeseAbZVS3UExdwDom8Bv3kfU737kKmutdYYbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=zIlxUAaJ reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=RviAK33Q; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769027335; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=DkeWrKH0WcCHByM+aqm+Lo33XrX0YtkSj2vD2jtqy8Y=; b=zIlxUAaJeYgUAB2ty5rXTQmgdR
	6K4gYQedxmkvyk6vMfre5PHdeSP4JSZt4QgR5yT0XH8IHo21MmtIPYBK2lrsy57JXhl3KjGeNhjZQ
	9dysy5N21l8Lc92e6vUwILyl2o/6F7Lr3YwaXgDTbdNdgiupUWKRd7GyMY9xWTa1fi52xyUF5FURd
	Nc6Arq2LuZR9hiNaI7alBDnOMzAfK0sK4+3guQ8bE2ia4FrqRc9s63lUWupnu+47FNJAf/v6ZlO68
	NLJu4Vky1Hk8c+IS74NH+vBeuBylUp1nI21jpn8ehZY3LsMpbLnNiNoPd2uzsOEHt3W+P67TM0siM
	nAVTD7GQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769026435; h=from : subject
 : to : message-id : date;
 bh=DkeWrKH0WcCHByM+aqm+Lo33XrX0YtkSj2vD2jtqy8Y=;
 b=RviAK33Q80mhtugcrIgShfP+Fh7WIBYGWvYdJxtyAIt9P1BMVF6BivinHFD8/rkYcO+Dr
 9aIoU37E8Fy/T4XzQTQ9zDqUYYd40rINOadAqTs10bdlK8AwlxvmXscLTClQyjHr+d7fQZO
 P0Jvxc7o0IhwlXPqw2F1kwcoWM9TRgJJXTxrMC+AI5VdKG3HFHPpZGIccPNLUBW82J1z6oG
 vJY+PPjcMnr+EspLhmrFcPVKnCEM4yg0omw1JvYbyL8ZB5ia4zqF7EK0a7b2AJXqTPnFDFH
 XCZo+jMwb1JOFeo3M0xVLbBSlNjipbSHhaAOjRwnv05SkSRQQm/SUR3zStwg==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaJ-TRk25T-Q8; Wed, 21 Jan 2026 20:13:47 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaJ-4o5NDgruk4z-qgaY; Wed, 21 Jan 2026 20:13:47 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 0/3] 9p: Performance improvements for build workloads
Date: Wed, 21 Jan 2026 20:56:07 +0100
Message-ID: <cover.1769013622.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: vjBCcuWTrR1H.-uxwllURuJOy.A9IaZwEn6mh
Feedback-ID: 510616m:510616apGKSTK:510616sVoWefEZkJ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[triplefau.lt,quarantine];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74915-lists,linux-fsdevel=lfdr.de];
	DKIM_MIXED(0.00)[];
	R_DKIM_PERMFAIL(0.00)[smtpservice.net:s=maxzs0.a1-4.dyn];
	DKIM_TRACE(0.00)[smtpservice.net:~,triplefau.lt:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[triplefau.lt:mid,triplefau.lt:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0B0AE5D38C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset introduces several performance optimizations for the 9p
filesystem when used with cache=loose option (exclusive or read only
mounts). These improvements particularly target workloads with frequent
lookups of non-existent paths and repeated symlink resolutions.

The very state of the art benchmark consisting of cloning a fresh
hostap repository and building hostapd and wpa_supplicant for hwsim
tests (cd tests/hwsim; time ./build.sh) in a VM running on a 9pfs rootfs
(with trans=virtio,cache=loose options) has been used to test those
optimizations impact.

For reference, the build takes 0m56.492s on my laptop natively while it
completes in 2m18.702sec on the VM. This represents a significant
performance penalty considering running the same build on a VM using a
virtiofs rootfs (with "--cache always" virtiofsd option) takes around
1m32.141s. This patchset aims to bring the 9pfs build time close to
that of virtiofs, rather than the native host time, as a realistic
expectation.

This first two patches in this series focus on keeping negative dentries
in the cache, ensuring that subsequent lookups for paths known to not
exist do not require redundant 9P RPC calls. This optimization reduces
the time needed for the compiler to search for header files across known
locations. These two patches introduce a new mount option, ndentrytmo,
which specifies the number of ms to keep the dentry in the cache. Using
ndentrytmo=-1 (keeping the negative dentry indifinetly) shrunk build
time to 1m46.198s.

The third patch extends page cache usage to symlinks by allowing
p9_client_readlink() results to be cached. Resolving symlink is
apparently something done quite frequently during the build process and
avoiding the cost of a 9P RPC call round trip for already known symlinks
helps reduce the build time to 1m26.602s, outperforming the virtiofs
setup.

Here is summary of the different hostapd/wpa_supplicant build times:

  - Baseline (no patch): 2m18.702s
  - negative dentry caching (patches 1-2): 1m46.198s (23% improvement)
  - Above + symlink caching (patches 1-3): 1m26.302s (an additional 18%
    improvement, 37% in total)

With this ~37% performance gain, 9pfs with cache=loose can compete with
virtiofs for (at least) this specific scenario. Although this benchmark
is not the most typical, I do think that these caching optimizations
could benefit a wide range of other workflows as well.

Changes since v2:
  - Rebase on 9p-next (with new mount API conversion)
  - Integrated symlink caching with the network filesystem helper
    library for robustness (a lot of code expects a valid netfs context)
  - Instantiate symlink dentry at creation to avoid keeping a negative
    dentry in cache
  - Moved IO waiting time accounting to a separate patch series

Thanks.

Remi Pommarel (3):
  9p: Cache negative dentries for lookup performance
  9p: Introduce option for negative dentry cache retention time
  9p: Enable symlink caching in page cache

 fs/9p/fid.c             |  11 +++--
 fs/9p/v9fs.c            |  10 +++-
 fs/9p/v9fs.h            |   2 +
 fs/9p/v9fs_vfs.h        |  15 ++++++
 fs/9p/vfs_addr.c        |  24 +++++++--
 fs/9p/vfs_dentry.c      | 105 ++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_inode.c       |  13 +++--
 fs/9p/vfs_inode_dotl.c  |  73 +++++++++++++++++++++++++---
 fs/9p/vfs_super.c       |   1 +
 include/net/9p/client.h |   2 +
 10 files changed, 220 insertions(+), 36 deletions(-)

-- 
2.50.1


