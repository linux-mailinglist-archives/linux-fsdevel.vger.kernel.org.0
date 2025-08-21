Return-Path: <linux-fsdevel+bounces-58589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8BBB2F456
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B776033BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E782EF67F;
	Thu, 21 Aug 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="dJWh1pCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AE2E7F36;
	Thu, 21 Aug 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769390; cv=pass; b=XkkZcctBfehMZRtpgJuvM051zL1MVHEWeaWOR1YJQhU8P4mlu2q92qyqhU8WTTAMzCNQURouLAFUqSDwLl6n0UoocHBg+jvlcNsM+EBC9PvLtPryVPCoA/BHKsTBvLeCKaTpO6mGVGOXlOegPNjvdaXEyPE+2lKk8BgCrFq8/QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769390; c=relaxed/simple;
	bh=00IT2GFNBj2sojSpzKRrz+QslCt09lqE4RCqCNWAukE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=To1CJrqezodL+yAjUo4sZoOMGKhP3q4Q08y4EA6XLE5w9nhZad+2tLe1jiDR4uRFuOjlLmQ1Y+JCEXPyQ6FynxSbFbNutxsBI6IoLq+tHAZOtywSbIWv2D2UQVLRGsoJn7TZsIIatDmlnXx77L81Whrl3y8CbL+9+zGwM456to4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=dJWh1pCD; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755769364; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l79hCeiMG1l+JPmpZCe8qHRC4Hw9jk65n7+Tuc+HGAhrvKMTkrr/zF+7cSSEvNIFEWIDaBdSevBTy4G/U8UB50pxabkBIko7WpiTllcg3eUpCaTprjBSYNUSVrg0J8mxJN8agXQyTvpW9640Oov6MVlET3iplytezyohkuu3rW8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755769364; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CLyI4kDf1dViZxhG8N82OEUcewRrHXnbAp3Ib/mYQAc=; 
	b=iMusWNu/SUzGw0qp5Puhy3vtsa7pq7OcwshQJQcyV7Sb78De6ED6zuKnc33cufbjpNnsCWWBvv0O7AMCSxzfOjpdj7tzcep0OH1YnkifBTs0qBBtzlMFpOoqy7Qxw487bxbq/RFED0+htEQovHN+ppVRSqu7MF1In3ahYOJEtUY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755769364;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=CLyI4kDf1dViZxhG8N82OEUcewRrHXnbAp3Ib/mYQAc=;
	b=dJWh1pCDaI/Hgfi3czd40BPYxe8FijbYwjSagzIu3yA54qwK1FudyMjdqbVxavMQ
	vEtp4mLEsBJrXIdUzQ2mff6km61VevEJarHx9s2SR33/pGr7L4nlvlPieD59aEYqvuV
	iJX88puT/SItBSlof6u3pg0cB30KDl8pabo07EP4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 175576936248297.23526332386348; Thu, 21 Aug 2025 02:42:42 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Thu, 21 Aug 2025 02:42:42 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:42:42 +0400
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
Message-ID: <198cc025823.ea44e3f585444.6907980660506284461@zohomail.com>
In-Reply-To: <2025-08-12.1755022847-yummy-native-bandage-dorm-8U46ME@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-6-f61405c80f34@cyphar.com> <2025-08-12.1755022847-yummy-native-bandage-dorm-8U46ME@cyphar.com>
Subject: Re: [PATCH v3 06/12] man/man2/fsconfig.2: document "new" mount API
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
Feedback-ID: rr08011227dee011c4ba359fc500e9059100007db79ba7484654c5a5653498434b216f50461561059d32dbf7:zu08011227a5cb7776ba5e89f37adeb9890000f68e1e3f1def807e9a70a6be15172071ba36f84ae63e892f2f:rf0801122cb48f3615ec900817651bd8180000abdc6db1be998902154ea5eec4aa5d2718197cb8c3f3aba5b4253436ffea:ZohoMail

 ---- On Tue, 12 Aug 2025 22:25:40 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > On 2025-08-09, Aleksa Sarai <cyphar@cyphar.com> wrote:
 > > +Note that the Linux kernel reuses filesystem instances
 > > +for many filesystems,
 > > +so (depending on the filesystem being configured and parameters used)
 > > +it is possible for the filesystem instance "created" by
 > > +.B \%FSCONFIG_CMD_CREATE
 > > +to, in fact, be a reference
 > > +to an existing filesystem instance in the kernel.
 > > +The kernel will attempt to merge the specified parameters
 > > +of this filesystem configuration context
 > > +with those of the filesystem instance being reused,
 > > +but some parameters may be
 > > +.IR "silently ignored" .
 > 
 > While looking at this again, I realised this explanation is almost
 > certainly incorrect in a few places (and was based on a misunderstanding
 > of how sget_fc() works and how it interacts with vfs_get_tree()).
 > 
 > I'll rewrite this in the next version.

This recent patch seems to be relevant:
https://lore.kernel.org/all/20250816-debugfs-mount-opts-v3-1-d271dad57b5b@posteo.net/

--
Askar Safin
https://types.pl/@safinaskar


