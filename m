Return-Path: <linux-fsdevel+bounces-59218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0327B36A47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B74D986FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935CA35AAB6;
	Tue, 26 Aug 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="DJP2WZR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82A350D51
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217723; cv=pass; b=H8oDQnNLQDJDH4dnEtZ5jxLQjDPzYGTWYvl2byGXi0h9WSMMYsEjOfimg/8a3VhQFv8SFSPgjo/lK0KZyiU4K9nVa+xcQQRlj98tT2lttRqCVBNTlViAvE/2IUZFxbzieQEv+FO4ZdSm3K1XxYLF9sOJOtg49jHO4xBdXtVuijE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217723; c=relaxed/simple;
	bh=w8R3pEJgTMdnRopLH6lSbbj55+WeggOW1o15skntgL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO9KqOCH9vSUj3EVh4vQr9gfF5/Ee83Gw54g+TkE1TF3sskcFwi6G+miTSZpv67B8cGXnxxgYKCnmWf2GgUJGox13WZqR58GynBsmVYT5RPIJ6609vCBOVhtQCB9USFuc+uQC/mCRqNGAhSBXw8338LEQKlcJY4wO+ntzdGkbRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=DJP2WZR3; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756217706; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m1o84HLm+bUjoMijtPWXuEb24xR4j0Xlry5S175I72GL8rMOlIeYoheD0fHXtleTMjVb8TpIXLfqs8SmRXXnYpgFHXt9uxuI67Bt75wpV/WNzhmmeS+6Nih7EpAFs+QtSiNSRSwTyHZi2RRT/OKVHs/ggUQDqKKCwtbWsnwNMng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756217706; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5nowq0oaEIFLNvGlVrvX4+e2QMzvT8I+kzHef0WJwOc=; 
	b=QXsUjg93DUhPdlSTmyhmkYrlcEz7lR3neSbyG8kqgvwFSbDee/IBvWpRVrbKd8DZDUUA5X+h+RYcf/AKbSYyHtH1iSJrLOKHa/EGUde8ISfpoCbawYn9gi0zC0RCzL8A878YVvUe2zonrLNntBcom1yrSHUKbZ3TjG7j/SYpyVk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756217706;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=5nowq0oaEIFLNvGlVrvX4+e2QMzvT8I+kzHef0WJwOc=;
	b=DJP2WZR3GZmiObyut4Lx4KQSZozC8Oe8C6q0hv0sJ+VUFC86F5tzORx7TKNqcoZG
	PRyBtBqYOexcYATA5fUZ1aVI5lxcYE4l5fli5EXJbQIIFCMijlLU/N0vMvFieh0iYd3
	bJNB5BTns/aSaZ0REQluRVUMzqv0DxD7UFXf0KtQ=
Received: by mx.zohomail.com with SMTPS id 1756217702620806.1749573771748;
	Tue, 26 Aug 2025 07:15:02 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 34/52] do_lock_mount(): don't modify path.
Date: Tue, 26 Aug 2025 17:14:57 +0300
Message-ID: <20250826141457.2729907-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825044355.1541941-34-viro@zeniv.linux.org.uk>
References: <20250825044355.1541941-34-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227b4750eb4240af6a5a6892ee30000719e832f0d4ef8b4fb216f7a1f04a5a0c00e3d9680203a8325:zu08011227b59bc93f1a3a752348e8e4ff00003fe1e94380fedcff4973d52cbcb7c6b82413f51a8cd2ed20fe:rf0801122c3cd374ca4cad32dd9f4641030000a67dea30ec9a46c4f4015fd3c07ccb306ade90dd5497c13ec7a39085e23e:ZohoMail
X-ZohoMailClient: External

> +		m = __lookup_mnt(path->mnt, *dentry = path->dentry);

I don't like this.

Someone may think you meant "*dentry == path->dentry" here.

Please, write this:

  *dentry = path->dentry;
  m = __lookup_mnt(path->mnt, *dentry);

-- 
Askar Safin

