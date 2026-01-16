Return-Path: <linux-fsdevel+bounces-74226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F7D38594
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 336F43198B31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF303A0B1D;
	Fri, 16 Jan 2026 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="Qh/pAAvY";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VaDEu67u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-73.smtp-out.amazonses.com (a11-73.smtp-out.amazonses.com [54.240.11.73])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141352F3618;
	Fri, 16 Jan 2026 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590644; cv=none; b=BnPW6pDnnWxIz6vqHj/V48glIu6qffJrJ93DoyMHoRwA7CXutN3TfLPSJ5Gdu24v/rsrp5MG1hRwHs3vxYWUXSyRC19ETiSf35vID8Ooo1yIA/AM1hwl337mbVPDuxqKE9GL4buSPVOgdWlOrhBYBkABFkig6IEbKTQYh6syqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590644; c=relaxed/simple;
	bh=aX0MxqKSHtpzGZG0ql/uP5wJ7sQ5GgZnnburJft8KWU=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=hIM7IZj1HWbtovySRZhCcs+aOqkQZUMmADMr0/dwhJINRMsVCRzx3G4SRxBROrl2giZmkR2R9Zoy7RhV0hq52ycMW/iZ/Taup2xAQXL7oTEaE2voQJaf9bly3XjINoWQ++BUA5VDtDkW3u4xqbooibOkC8Ii319BxDnhCfYNey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=Qh/pAAvY; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=VaDEu67u; arc=none smtp.client-ip=54.240.11.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590642;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=aX0MxqKSHtpzGZG0ql/uP5wJ7sQ5GgZnnburJft8KWU=;
	b=Qh/pAAvYp9MmXfVg2zQvBSjJBIIs5V/Cj50STyuqfsPRqhGGVlTT4HXX0pPFyNEm
	j0pTkhcLgl3g0mMQV+oKo4WF4+HpTd2VeuXDxBCnAQb2bAvb5F9Ozg86hKc74Ka+T0s
	T0YEB6VG6VDDtDmyUNklGkqhWJy4BuGyFKC81N70=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590642;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=aX0MxqKSHtpzGZG0ql/uP5wJ7sQ5GgZnnburJft8KWU=;
	b=VaDEu67u9eg6fmsHticL6KnLFE9HNJVES8RBBMCyXXvqiPnA9ZMyGDURNCFv8EKT
	+tFboaMr8vIhIY/wxNPjpOhrjzJ7hcFuU9yWXllc4iCVu1q9dEeKmd4r0Z7h2BBGYgL
	az7ecESY1JxFT9XLdEnP5ctEnu9LhVa6JR+JoJOk=
Subject: [PATCH V5 0/3]
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 19:10:41 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260116125831.953.compound@groves.net>
References: <20260116125831.953.compound@groves.net> 
 <20260116191036.1470-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAAa/D4
Thread-Topic: [PATCH V5 0/3]
X-Wm-Sent-Timestamp: 1768590640
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc8378ae4-7232d134-d430-408c-919c-92f174ffb08b-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.73

From: John Groves <john@groves.net>

This short series adds adds the necessary support for famfs to libfuse.

This series is also a pull request at [1].

No changes since V4 - resend due to dropped messages

Changes since V3:
- The patch "add API to set kernel mount options" has been dropped. I found
  a way to accomplish the same thing via getxattr.

References

[1] - https://github.com/libfuse/libfuse/pull/1414


John Groves (3):
  fuse_kernel.h: bring up to baseline 6.19
  fuse_kernel.h: add famfs DAX fmap protocol definitions
  fuse: add famfs DAX fmap support

 include/fuse_common.h   |  5 +++
 include/fuse_kernel.h   | 98 ++++++++++++++++++++++++++++++++++++++++-
 include/fuse_lowlevel.h | 37 ++++++++++++++++
 lib/fuse_lowlevel.c     | 31 ++++++++++++-
 patch/maintainers.txt   |  0
 5 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 patch/maintainers.txt


base-commit: 6278995cca991978abd25ebb2c20ebd3fc9e8a13
-- 
2.52.0


