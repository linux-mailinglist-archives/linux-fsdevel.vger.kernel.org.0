Return-Path: <linux-fsdevel+bounces-58601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC7B2F696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 13:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B69B62EB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCE531194B;
	Thu, 21 Aug 2025 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="Z6w1GR4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C230DD31;
	Thu, 21 Aug 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775675; cv=pass; b=bL3NyX3E8V3P35oA3U9kQgTLZpqK0yIPw8M/AhN7oI+1sHV2uuplyepJhtBR78goluvHDoLzag10AwzWgN7JS1cq1smMgUZMsjYGwrP8WZ2p7XQfSLj8XH1p+h1TVBnIe+j69z4GO5Jqo2Qbi1RCOh2ntlK+Lwirs90ayPR84Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775675; c=relaxed/simple;
	bh=Ml6qAqGr9DYYMdLrrFQDTK7UsSw87+JjZwOQ3nNOSD4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FowvV/bBYlkwff9C+fBgObbWYXh0ZwgnXuXuzSMeEhytmVYPp5SWZQW74z+4a4fqwI5VEpv4gyM1OViVJgap6eK5nRJ6eQsXMhgG5d86NIrmQXEgPUs7OfxshPXYdSPIIfWI/z+4M1Skx6yjMDkDrFcp52wSfgSx0Vwj+VHWPEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=Z6w1GR4O; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755775647; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A1HkbTK4TtvbxICeYyEQtnlcg3q57I7V/5FCFzHoFFnZ75IAFBqC06qZXgYKp3w75p5puMt/xety39tnEl+pSlFgZV2CGz0ehn6WGW+/xbJtfsdYdqeaz8Idmc4hbZNQrK4ArCGPqLQLKBuxWvf1yREjZoyY/mr6GUhO4jh7BVw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755775647; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ml6qAqGr9DYYMdLrrFQDTK7UsSw87+JjZwOQ3nNOSD4=; 
	b=lTgYc8cZ8xjami4XN54cXBa7/45QWWcmINNci9Awnzzk8J5uN/Z9SJYWwpKiPsCqH3Y9O/uisIJ+yeSpcfvinYox8WEYUlwyXntxq30IdKN7WZUnO0NHzccwwaEHoOwsZfQX6Mjz6JNcpGX/4KFHc5EmIZUsqj2j0zBQuTDP/RA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755775647;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Ml6qAqGr9DYYMdLrrFQDTK7UsSw87+JjZwOQ3nNOSD4=;
	b=Z6w1GR4OqdcZ7Me4vC2zea+3bDAYuTKz68c+hrfmzDUrD3L1+RJRyrIo07UE+cBJ
	p1PhGQqsLZMHHM6KNFlP1Qz8lUXBYepsb9zMQBj0JtUWN+oJyw+sIzKvExHWDyhCZZD
	rJ3lYj/e6Dj16tCbL2vB5kSEhvmXU1JIx97zgZCU=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755775646035655.8159490659623; Thu, 21 Aug 2025 04:27:26 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Thu, 21 Aug 2025 04:27:26 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:27:26 +0400
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
Message-ID: <198cc623944.11ea2eb5d86377.2604785241030508275@zohomail.com>
In-Reply-To: <20250809-new-mount-api-v3-9-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com> <20250809-new-mount-api-v3-9-f61405c80f34@cyphar.com>
Subject: Re: [PATCH v3 09/12] man/man2/open_tree.2: document "new" mount API
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
Feedback-ID: rr0801122738b9ca616885b96e6a346c1b000029f7d176fcbc0ca6387c04737e069b0cfc026959ea99ad7bbb:zu0801122795be1e590bd6c0f3fda4f0830000be25aa7391ade2b7b4a40b275e24eefd5e10390916a417795f:rf0801122c49854dd2868c08e73faf045b0000366dfca0d6a36b3bb26432695356d1edaba2834ff4a4d30e1ed51fa16dab:ZohoMail

man open_tree says:
> mount propagation
> (as described in
> .BR mount_namespaces (7))
> will not be applied to bind-mounts created by
> .BR open_tree ()
> until the bind-mount is attached with
> .BR move_mount (2),

It seems this is wrong, because this commit exists: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=06b1ce966e3f8bfef261c111feb3d4b33ede0cd8 .
I'm not sure about this. (I didn't test this.)



--
Askar Safin
https://types.pl/@safinaskar


