Return-Path: <linux-fsdevel+bounces-58376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5223B2DABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 13:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBD8189D5C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BDD2E3AE0;
	Wed, 20 Aug 2025 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="Ci+1gREv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72102DCF58;
	Wed, 20 Aug 2025 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688731; cv=pass; b=fra4OXZVhCho14iWMtkwZwee2UrfKrsq2gp+fNIRd6N8raEn/oMkHkQyHI5/8SxsJ8jq7kE3Tw1UM0ZadYfuBP7Vgxizui6SbDlXh7cJtRZTYTp/8DvEj7KkSUSX6zyVI6VKx5FRDTufy4dKdAMUySYNYp7J2nDgMueNt7Qsmzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688731; c=relaxed/simple;
	bh=gh4JMVoWx2g9QVgzTZ1UfSG+u2iBWGemYGCyImRUOKc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=n8CB41UFZRKN1Up8aDYz761+yGdGu9qfruIpevTmGHYhUaBwXc0yy4+exSgOSQDnR4MWOpusbGNy5AfFMSmoogA/1ywIIOvm9dXbKXRThIRw1JypGQ1gqdLv4SPMXdVLKEPenYnZcizbYTh67i4OBPmey92/UvtoVfMocV6bXSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=Ci+1gREv; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755688691; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MDoaSJ5MgzobSjosdP9fpEfA6II5Slqm7R3BM+7UTFKrkfe539jOafletTRLKxBcNQD2HNnPaYFliHLXQFJKB0ef3Wvz5B8qVrbk1C9c7tC8BcwtiEcUZiR2+B0cuXm+Q3+Lj9J2URg5JZknwej4oNVcEI9JlodUsyqYpJzAFmM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755688691; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tln7FpGzb6hM5a2Y6c1iMqDX53JGUcU2Cq7EbnEbdno=; 
	b=Uuz+L0hvM3P9VjgsY7xGlmO4axlUpFR/SYYASQ35os4vswhAFDtQ7Q2kBiYdpPFPqqryNdXW7d6fHA2HYFafuv9KRcD9807LekS6btih+SeuzOgBl/bVFutM0Qqim3WyFcxFd/qyjLFo6S+pjiv4HgGQzGifetbzREedGwoD0wY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755688691;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Tln7FpGzb6hM5a2Y6c1iMqDX53JGUcU2Cq7EbnEbdno=;
	b=Ci+1gREvG+DwWma+t9QNxApmObHsHCFrQa2Olv/9IDr9ISX661oPPFttzFFOz+yl
	jiz5j03xVX+0P+J0nuO7iBmKKq4GaqkKNURB1pDAjcUgmIKUD/lgxi119cK7iJxXdy+
	ntJEDLqijT2SLkxVNyg44OKagmGzkkE730ugJXRA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755688689152183.7487823630272; Wed, 20 Aug 2025 04:18:09 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Wed, 20 Aug 2025 04:18:09 -0700 (PDT)
Date: Wed, 20 Aug 2025 15:18:09 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Aleksa Sarai" <cyphar@cyphar.com>
Cc: "Alejandro Colomar" <alx@kernel.org>,
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Jan Kara" <jack@suse.cz>,
	"G. Branden Robinson" <g.branden.robinson@gmail.com>,
	"linux-man" <linux-man@vger.kernel.org>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>
Message-ID: <198c7335dba.d74f2e4174912.2623547306023456362@zohomail.com>
In-Reply-To: <2025-08-12.1755009210-quick-best-oranges-coats-BNJpCV@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-8-f61405c80f34@cyphar.com>
 <1989db97e30.b71849c573511.8013418925525314426@zohomail.com> <2025-08-12.1755009210-quick-best-oranges-coats-BNJpCV@cyphar.com>
Subject: Re: [PATCH v3 08/12] man/man2/move_mount.2: document "new" mount
 API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122771423f3748bc7f61e1a7cc360000d64f8919ecb0ec0828783973dc22df6f86a68cd109d6a5d5b9:zu080112274a76baa063a7b02b2b81fa3f0000c46fc46491f547e719d9515a2cb4a06be1ad67f4e14f6fac4a:rf0801122c61455fb55853888d67840f080000c977eb60d6801d08e08b75bfeb8549a36767e5d9f8114056a0e5efb69309:ZohoMail

 ---- On Tue, 12 Aug 2025 18:36:53 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > > "Filesystem root" can be understood as "root of superblock".
 > > So, please, change this to "root directory" or something.
 > 
 > Maybe I should borrow the "root mount" terminology from pivot_root(2)?

I don't like this. For me "root mount" is initial root mount, i. e. initramfs.
It is not what you mean here.

 > I didn't like using "rootfs" as
 > shorthand in a man-page.

I agree.

What you mean by "filesystem root" here? "Thing, which is changed by chroot(2)", right?
Then, please, write "root directory" (or "root"), this is standard term for that thing.
Or you can just write "/".

--
Askar Safin
https://types.pl/@safinaskar


