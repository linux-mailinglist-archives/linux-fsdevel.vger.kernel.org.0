Return-Path: <linux-fsdevel+bounces-59040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23656B33FDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939A6205E58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAE0220F37;
	Mon, 25 Aug 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="TG2WASjc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFA219319;
	Mon, 25 Aug 2025 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126039; cv=pass; b=CgQYESJ/cvbhV+gym3ztt4k7+olhsf7ofsU39Pt5T0ODpEhoeSUyjFrRvprxm6tTJ7mL6WyzsN1PjenkWti4FbBqXbZ77XEF+T1yT0z/gugmdiJI3Y5MMBQ/fR2NpmDX8PAqyVYeB6YkquipqMktYUPrNta9IOrmcnN/6vPTcJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126039; c=relaxed/simple;
	bh=t4SJMQNiQHEXtScoxR/9jP8egJ2wutxjzhGg9je9+eM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MBrZLyAyD2yfaxFUfpBvtWcv0y1Tdlq0DKslrx3QfpQifxyASfEca5i/P6f4ni/WTlFfATRg1GLy+w+fECG70jJIFgS77v9rSjO5A6G26P5IlAU4seJe1ZlRMzaV11eRVf7K8wjY+rGeKREtW8KsfxpbAHX4m3H3JozoRoaKX+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=TG2WASjc; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756125995; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZrrewGQgjwZA6Qou9bjvIQaX2PQIGylk4ufSSGHHfKakV/fdecGkn7PzxwFWDTl20OU9lSSqlA+WHuI80du1sBeAb6vaG0abmEbNEdE3MUop48WorBILjAkQ5pcPaaAw0QPXRSY8H0U3RtqKc7r4iaQuFZDcdhetJCLl2lEtTJQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756125995; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IPk+L6EBV8nWmPwAmrjzJLtYA2inMwHTW2qvWKCbgXM=; 
	b=aOqwRKYTqPWhRk3fNc47W8ilxtTW06QoIn37xlAan9itN9aBYMBET1mPuacJ8fbt8WeAbMWVtTn61dgFZLW3bQ+uw073KPd4dKs6zThXNJmWFRPH2d7X8ZMKCqeP/Q3SD4lOAu90HP5xeEW096mmNZpA5/Sam5FF0pJ0rw2YNgk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756125995;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=IPk+L6EBV8nWmPwAmrjzJLtYA2inMwHTW2qvWKCbgXM=;
	b=TG2WASjc2ffzUsOPK4/ryC/rb9LPnmbRsDIVeE9YOZmnJEhFIJ8ezq5o5vUxnrEh
	tYD7zcMnZxzDSIILHMdQBQxxNdA6VWWfQNvn6/Ma/jBFZ8mD4cmTyRxykNApMUAHBgs
	1LMimgskQqO/YsxQ1PyFQ+JfwjWSC4jH6Qjr9YDA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756125994881517.902991373012; Mon, 25 Aug 2025 05:46:34 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 25 Aug 2025 05:46:34 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:46:34 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Aleksa Sarai" <cyphar@cyphar.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Jan Kara" <jack@suse.cz>, "Ian Kent" <raven@themaw.net>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"autofs mailing list" <autofs@vger.kernel.org>,
	"patches" <patches@lists.linux.dev>
Message-ID: <198e1441f72.ff66ccf525195.4502015239657084211@zohomail.com>
In-Reply-To: <20250819-direkt-unsympathisch-27ffa5cefb4e@brauner>
References: <20250817171513.259291-1-safinaskar@zohomail.com>
 <2025-08-18.1755494302-front-sloped-tweet-dancers-cO03JX@cyphar.com> <20250819-direkt-unsympathisch-27ffa5cefb4e@brauner>
Subject: Re: [PATCH 0/4] vfs: if RESOLVE_NO_XDEV passed to openat2, don't
 *trigger* automounts
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
Feedback-ID: rr08011227a2f6f79cb2545c2537968e0d0000f31e6423071d731bb2a51d1c89884bfa8127823ef50d4d4164:zu080112278094aa1bffbbbda2c291471500007a343ddc053622f3cb96379bf22f3436ac54481e1d5793f4fd:rf0801122cd8fa8a6862df747cc226a87400009b69b8b6b34a7f556e06b28f92f46d18c273e96cf7c3030313fb3b9ab9c1:ZohoMail


 ---- On Tue, 19 Aug 2025 12:21:33 +0400  Christian Brauner <brauner@kernel.org> wrote --- 
 > On Mon, Aug 18, 2025 at 03:31:27PM +1000, Aleksa Sarai wrote:
 > > I would merge the first three patches -- adding and removing code like
 > Agreed.

May I still not merge these patches?

All they may (hypothetically) fail on their own.

If they do, then it will be valuable to know from bisection which of them failed.

Let's discuss them one-by-one.

The first patch moves checks from handle_mounts to traverse_mounts.
But handle_mounts is not the only caller of traverse_mounts.
traverse_mounts is also called by follow_down.
I. e. theoretically follow_down-related code paths can lead to problems.
I just checked all them, none of them set LOOKUP_NO_XDEV.
So, they should not lead to problems. But in kernel we, of course, never
can be sure. They should not lead to problems, but still can.

The second patch removes LOOKUP_NO_XDEV check.
This is okay, because if "jumped" is set and "LOOKUP_NO_XDEV" is set, then
this means that we already set error, and thus ND_JUMPED should
not be read, because it is not read in error path. But this is not obvious, and
so Al asked me add comment (
https://lore.kernel.org/linux-fsdevel/20250817180057.GA222315@ZenIV/
), and, of course, I will add it in the second version in any case.
So, ND_JUMPED should not be checked in error path, and thus this should
not lead to problems. But still can.

The third patch makes traverse_mounts fail
immidiately after first mount-crossing
(if LOOKUP_NO_XDEV is set). As opposed to very end.
This should not lead to problems. But can.

So, again, any of these 3 patches can (hypothetically)
lead to its own problems.

So, for bisection reasons I want to keep them separate.

So, may I keep them separate?

(And I agree with all other complains in this thread, and will fix them in second version.)

--
Askar Safin
https://types.pl/@safinaskar


