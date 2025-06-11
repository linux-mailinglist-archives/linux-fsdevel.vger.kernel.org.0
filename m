Return-Path: <linux-fsdevel+bounces-51373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAF3AD63A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 01:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9213AD1ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2325A642;
	Wed, 11 Jun 2025 22:59:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30ED258CDA;
	Wed, 11 Jun 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682743; cv=none; b=eCp1nfUi0GafE+IoQgzv9L1sQAAJpfVcdOyFT/26KOA/czL8InMoubg175lVBuLzZV0rWV7+3WpNHR6ND+wiv0j+s19MThyS30ECXlRl7LjHRwat61A8cp/mJKIuGr4RhjFJG9z/nyrPFtlYLiApIDjEJx6otg3TRlu41kz+CVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682743; c=relaxed/simple;
	bh=KhfHCo03+BpyqIlVn0HQYSQXet3Sv21rJk1RCE0w+tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7l284W2rRTDlKn2Msb44DMm2vgS9Yh8KY8IvorocQDl27fNx71Lui7Fq/33xBZlVf9vIlfqmFrY8GlcP95hzd9AtrgjRpueay2DLnU6rWMjd6g1/UR9Gz6KIBinStXAup65HFFueDKn3HgRAIw5CfN0F+YB4JQXS/2t/d/Cmic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPUPK-008OC2-0c;
	Wed, 11 Jun 2025 22:58:58 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 0/2] Minor VFS-related cleanups
Date: Thu, 12 Jun 2025 08:57:01 +1000
Message-ID: <20250611225848.1374929-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are improvements that I think are generally useful which I
developed as part of my work to change directory locking.

Thanks,
NeilBrown

 [PATCH 1/2] VFS: change old_dir and new_dir in struct renamedata to
 [PATCH 2/2] fs/proc: take rcu_read_lock() in proc_sys_compare()

