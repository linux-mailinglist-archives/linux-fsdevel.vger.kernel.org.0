Return-Path: <linux-fsdevel+bounces-57049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93182B1E553
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B6C7A385E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499326A08D;
	Fri,  8 Aug 2025 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="CrAgntvg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB4185E7F;
	Fri,  8 Aug 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644096; cv=pass; b=hY1oQfw/sRYkYoBXNDqfeUdTFfGTvCuuyk/d560OjUxspXOeCTdJqAeXeTUceVixxX2pkhkG/GS5b+HWaLknubOen4jbl4AHv7wjLeBAny7U0Ksy/F0DmjDgk+NVEIzEtAF1SW7bmAgQXTzGmQGW/Zjc9gZ9CiucUXlgnKcQ04s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644096; c=relaxed/simple;
	bh=wOAhvK/aDAt1hICM4jQXmX4fD4Elq3RExjkqpcq/kF0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dcDdxly/1bbX4fUnmU+2qK/6yf4MqBHIdesnRr66Shg1LdjID8hzEPbNSbK15fiak9JQHQpf7LgZCpykyIwkHtvWWMnVta/Ge2eyTSWLoWkENCToSE09zOKFj8uL1dkbvOmfVJBlfdsrHwTrigsne7lL6G61fyCyJOfz09osFGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=CrAgntvg; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754644058; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wt9dNMZ6/WnUD54UNBoF5Rwok2aAXuuJJl+1RgxotksLhyASpyYJCzX03G/LYGfQjkJZ8ooQ6fqKRDKWI8WBBy2jW0wnM6E++ecFQeeHUDLHWqHm030fN3neQklVuRHzlLM2Gp0pjqOyExXUvrl2rV2eMzCCTqoJW4o/2BcNvHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754644058; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wOAhvK/aDAt1hICM4jQXmX4fD4Elq3RExjkqpcq/kF0=; 
	b=mywkDORH75ADs4JFA/Q7jjPqMzOhIGmjcYTOk2FOhWHtMbIUOwaCh9XopUx9pAejWFeOjwpf507WrY+T3vySuchQsl2sHxnlMvUmkDMjJJ/nNK5vAmlFJEclvvwpCwYfj+uokXy6hIzNgLT7f3jSh8LwKY0rlZ6wrwwNit3dYCs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754644058;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=wOAhvK/aDAt1hICM4jQXmX4fD4Elq3RExjkqpcq/kF0=;
	b=CrAgntvgyQzxlNrCq9iJmzj0ABiT9AMSoBbp2R0mcNpggwB9HySIWD0IjMKB9rBY
	b0xG6zyPQZlpgvswhcZL5lcH0EWW8UkgZ6YX29/rIvNHlFQsP5cV5C/QWOU6lEWem0A
	mW1+LwNAXMfClUqrQ5C6hMHUU480bgCyQHg4JWl4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754644055297109.37282343360755; Fri, 8 Aug 2025 02:07:35 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Fri, 8 Aug 2025 02:07:35 -0700 (PDT)
Date: Fri, 08 Aug 2025 13:07:35 +0400
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
Message-ID: <19888ef84eb.11525d76e40004.7721042298577985399@zohomail.com>
In-Reply-To: <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com> <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
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
Feedback-ID: rr0801122773888c2639bd7806d665ab6f00004ee5d047ca45f9d3a86813263ff384c04cb8f109e393e8eaf5:zu080112272bbea445082561342a5cddab0000f398acb2d719e109dc708e1e09f65f42a72f7a25aabedc36d4:rf0801122bbfe08d8756a35890e39d15ae0000dee356a19315415c1569850218bf00409186a7dea60a401de84cf60c13:ZohoMail

 > If there are no messages in the message queue,
 > read(2) will return no data and errno will be set to ENODATA.
 > If the buf argument to read(2) is not large enough to contain the message,
 > read(2) will return no data and errno will be set to EMSGSIZE.

read(2) will return -1 in these cases? If yes, then, please, write this.

Also, I see that you addressed all my requests. Thank you!

And thank you again for writing all these manpages!

--
Askar Safin
https://types.pl/@safinaskar


