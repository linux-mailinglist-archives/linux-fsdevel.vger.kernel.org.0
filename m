Return-Path: <linux-fsdevel+bounces-56831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82459B1C43A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 12:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F627A6842
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6915D28B3F7;
	Wed,  6 Aug 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="U3I5F5KD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE5207A22;
	Wed,  6 Aug 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475939; cv=pass; b=pvzf4/FS/95vtAoGrRA8fEUpj+MXj8MGlnFhWT98zssD/P3otK8QqaxlnV6oVpsjDIVIVJT3GR80FAaveh/RKwj1A/FLE6IPClJ7euTOdyaOiyICnwWwly0RKpXvICZ3wx7mnxylPj5KX504fxTAvKdYLW0SO6uens68UDlm/aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475939; c=relaxed/simple;
	bh=+wmQqhO/faO6co4hBA9A8Ni4X+9sQBZZYbpDBYq8EfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmvyG/sc1cn8eEyPOBPBtRQN+Suzj5QJmuEiFbcjkMvkoxhT9/vVESia8v3ET+plvrYeDTb75B3cWRayRA6wloTOa7H4cmJH9oF8nlfCTkFDHHJ5UG3Y45DMIUMjQK990CZPtQwjHNC/WxtPa+GCPlZntUC2FdBPCKIqybHUt+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=U3I5F5KD; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754475910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fepJ8qRfgN4zCRlmQcXewJjX7ndwkr9ZErcwug1fF/Qm4DmSeg0CtFZXIJbYf+F0xfwH7f/CECvYQPanzhikWH8O/BjUqDef0G9p41zZKS3zwx8o9HWSCtjm5koJhUTATq32wNwln4xbiCrj24wmFmfcGZAS/93DgCViOLuRcIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754475910; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+wmQqhO/faO6co4hBA9A8Ni4X+9sQBZZYbpDBYq8EfQ=; 
	b=hVATTcTbTnrdSRZYHokKzVn89UaAZFwSJiHoVgn25NRuEf9eaZydmSHv8+FY1BByvl0yZZPq8dgcb1ghDlZ/FgDz1ZZdaNcWkFy5hZGJlnz4xFwlFGZPt4v+dEFf9sTiW4q7wIyQaI3yYItV/AA3lh4qJpH9URv93h6skV3OOSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754475910;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=+wmQqhO/faO6co4hBA9A8Ni4X+9sQBZZYbpDBYq8EfQ=;
	b=U3I5F5KDYBTv3/hL6pjdw8mRCB0ECyCmCoRP/aqriH0MSxXaWoFSIv1w8BmYmWLz
	e4V+2FbB/iEiLnq9uTfVGKgrFCzK14RYT1Ns0kLmSQHWUdXS+E0AfpUZj+IM2FkTgCV
	/q0+57F21dqblHR/PNOwAZcgpHgsMiIgVhhH9/hk=
Received: by mx.zohomail.com with SMTPS id 1754475907706352.8426825833187;
	Wed, 6 Aug 2025 03:25:07 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: cyphar@cyphar.com
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	corbet@lwn.net,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@amacapital.net,
	shuah@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
Date: Wed,  6 Aug 2025 13:25:01 +0300
Message-ID: <20250806102501.75104-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025-08-05.1754378656-steep-harps-muscled-mailroom-lively-gosling-VVGNTP@cyphar.com>
References: <2025-08-05.1754378656-steep-harps-muscled-mailroom-lively-gosling-VVGNTP@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227cd007dd0b9c9dcb652e3ba8400007454c63885fa4739e1a2448e2dfcd94715a18ae97a0dffae61:zu08011227eb8290984d483d5d1a43e04000005dc1ce89a5e53403a5117830c5dff694efbf2d6162e2802556:rf0801122c8cf1f5d05d0e16bf0447132600008990b2a0cdb4e3567989e390629257cc551dc8fb0a863a8c551d183331cc:ZohoMail
X-ZohoMailClient: External

> I just realised that we probably also want to support FSCONFIG_SET_PATH

I just checked kernel code. Indeed nobody uses FSCONFIG_SET_PATH. Moreover, fsparam_path macro is present since 5.1. And for all this time nobody used it. So, let's just remove FSCONFIG_SET_PATH. Nobody used it, so this will not break anything.

If you okay with that, I can submit patch, removing it.

--
Askar Safin

