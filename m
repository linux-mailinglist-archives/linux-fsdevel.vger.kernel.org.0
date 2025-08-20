Return-Path: <linux-fsdevel+bounces-58373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B747B2D971
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BFB18932D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D12D9ED7;
	Wed, 20 Aug 2025 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="SCzCHqQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004927781D;
	Wed, 20 Aug 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683744; cv=pass; b=DMIcahWzgnuvp3Vrz5e7xus3aaRfI3H58iouPYawdZ+TkRQnOXaRHco8L3LJaPGHU0pqcQxjI1iS+rJcISQnvGSyGYnXI8/OvgcxXHVQwwh6MsaCaopt9G/wc209Rh3G8QN50TpCLrCMqx4n+PuUFIPnt7LpuDkORKxJIq8ORf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683744; c=relaxed/simple;
	bh=IKpQmKnl94o09xHTfN0Qj4qrIjMXgULlD1i7dOwaeqQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ntom1PhbT4JmGSfAWFEsVzTnTpo/tkYV6YBDjEEDwOa0mtJKZ0aAPUnPYTYalB+L3nKOFBVOh5+9NoHTiCGqiX5UJ3hO7YlEZWD81Khxbgds3jFwo4/tlwQTKe6Eehlb8e2Khxdx+YlR6VtoWaxRyeH0lTpR+uiTIk4ACmWmmIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=SCzCHqQO; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755683714; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FF7XtyYZ1iC1yi/0BToMG1xTw7ue//z0f1Nvxmf+q5/EZ+BjTNnJaaWHWFbsD+Z7Rtli8CR0icjj87BiBZ6RvRYMm3aqfgl2vqGnnb5naMWk1WMQEEnGSGjV580fEQcq73b3p6zzItsxbxSOOjb8sL4PxDuu91Mu+27GYIxXJ8o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755683714; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BUPX1b+b29tEGwDxGtup37O9TfSUrxsSkkD/2ccJ4RQ=; 
	b=HTlwjIB7O1lKFyuMn4BDWXBxcTTa8ofQkSpV7fESlsBQhU9GxY+oYdhCBCJkeURd3A7jq7VVeKc3fTk8hNilDHXSjXOPGxMp9vnCR4aX+Bto4k1E0QP81fWC5nZZn+OTwR71hYk9IZVVR61EQnJDDUEVxef51Wx3A2U0JLJMKJo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755683714;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=BUPX1b+b29tEGwDxGtup37O9TfSUrxsSkkD/2ccJ4RQ=;
	b=SCzCHqQO/eOp9SQ7wF1v79eZ23Z9t5uCIVtz3wpGnLTmPinoLn0oElvc4vu7rAPw
	KPFq1DLa3l6mN2VsibDdJJD79imFIhguGRp4lZWTBUE64/rooO33HG6pWCOz2it8bPo
	pq3PjriF625OJQwOAPudxnhdwG/tD3ogz/WpYj9c=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755683712335934.369788539951; Wed, 20 Aug 2025 02:55:12 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Wed, 20 Aug 2025 02:55:12 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:55:12 +0400
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
Message-ID: <198c6e76d3e.113f774e874302.5490092759974557634@zohomail.com>
In-Reply-To: <2025-08-12.1755007445-rural-feudal-spacebar-forehead-28QkCN@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-7-f61405c80f34@cyphar.com>
 <1989d90de76.d3b8b3cc73065.2447955224950374755@zohomail.com> <2025-08-12.1755007445-rural-feudal-spacebar-forehead-28QkCN@cyphar.com>
Subject: Re: [PATCH v3 07/12] man/man2/fsmount.2: document "new" mount API
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
Feedback-ID: rr08011227545c51e94901738994e1f5e2000047135d7af27e819aaa01fe2a47021fcd9af6db3fa45b746c76:zu08011227107231d3fae46b62a6258fc10000e8860ecb7f121ef78d2f53533e95725069394e9c0054f229bb:rf0801122caa7c5d6c6320fed86a2713960000dcd6057744201fc24466520d20ac336f526c27f94dab53187a27f20c08a3:ZohoMail

 ---- On Tue, 12 Aug 2025 18:33:04 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 >   Unlike open_tree(2) with OPEN_TREE_CLONE, fsmount() can only be called
 >   once in the lifetime of a filesystem context.

Weird. open_tree doesn't get filesystem context as argument at all.
I suggest just this:

  fsmount() can only be called
  once in the lifetime of a filesystem context.

--
Askar Safin
https://types.pl/@safinaskar


