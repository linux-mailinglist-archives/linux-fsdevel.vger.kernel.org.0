Return-Path: <linux-fsdevel+bounces-76966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCx3DZjUjGm+tgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:12:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EE212714C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF27302C90F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3234EF06;
	Wed, 11 Feb 2026 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="h7ojLjPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046227707
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836968; cv=none; b=n0oP1zabEqK+wVLm/i2TiUjBYWgdeIUQgNU+VYW3a9WIebl2zt2gG04G7q4pPCDYv1ZRn/GakCo3nvMQ8/xgwa6RQjhUX6kNG4OW+CKwc0EEEiv6Qj0W7PxsjCB24ItIgRKW5oR60LAyl4Cu6pNc6Im8vglMrHxWugOVEU96q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836968; c=relaxed/simple;
	bh=9OEX84pS5/jafcNE1Luw/tgW/J3SToEKArb0/HKcEyg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=S0CbmpvDf0GqmWyzPIyJnOTXrLGSx76hCtYBcZ60TzUar8DzHf/U4Xf1aYTIzD8byXUC39DdFxw03tmVntRhRFz4LfuYmNXjzTvKBdN2/2y4wzEw8+BXRz272+9R/AdUzotkiUS3/4fuQrmgmoUs21GZubOvVZB+Y8rAI2uTblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=h7ojLjPJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64D583F2C9
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 18:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1770836368;
	bh=9OEX84pS5/jafcNE1Luw/tgW/J3SToEKArb0/HKcEyg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To;
	b=h7ojLjPJ4gGxcx/a/q+Kg70QaRhw8Qpig+XIr8LcJ2BChDN+JMim1CxxKmVc/Jcre
	 8HKaDUOwbLsESu7LkAftEUzukZRtmBrL3iK9HF3apGa2lUBH987Yspp973Y48hLFIf
	 0sGMYZRNJmt7Tuk4M0PhxAKoPZB1xisajseI+dyq7DQjX1rWKLBMP6cPJ8vw/CuK+b
	 ieRbtA+UMYQp2zbOyFTDSqHCpY/JRuUYkmpr/bjnIUP40nO0AMXw8JUet7+Sumqq8P
	 zN2FVZkgif00/biXaUZUzt+KTsa0620Vse3onWZ0sLTWQ3xvX+R8DkHm4fb67X1Dns
	 K35YIBrOKF+zXNh/BqkCU8Ecbh/kGAg9NA0FGAA3jpf4E9TQhLnWsHvDb7sOGo/Dio
	 oxFn69qGHvn7EovrpqJTZ9U2c8pN23LiVXlMzDONuQri46UuuSca3IhLLvx20du087
	 VpdU1pddgHSg8kHeXTq9Xl5j0XKy5Sv34n1b8QBI/kcvauTCmM7tM+fgAH3SutZ4Hg
	 LCl7raFfYEXNsJC4xb/G8hiD2ygEFfmMSrtfXm7xlDPwGaD7scxH6uNK7KMif2jhN+
	 7q8Kb0Pr9DgeXYcd/IdJvxuvLGFaolCZt+Cy3/n4djPbukQENg36eEDvNwj+NcjIxo
	 C2mwHLAfC67eS0XhQzt4KahQ=
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4803b4e3b9eso56351735e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 10:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770836368; x=1771441168;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OEX84pS5/jafcNE1Luw/tgW/J3SToEKArb0/HKcEyg=;
        b=DCn4bEiJfTVOWCcv/lzbOgAaoV+k3zwol08PwqWm7qvrUL/1ocEEeHKgEFD3SMLz5S
         af5QurnjUUHwV8F9RhtIFOW87UmbiGm/uNNd65s4hyCGnimscLwfrBIBaU2nWUQd9Zk/
         inC2vVKCgDz97/5iQooQgHA3/U2hZ6VqWP9tzjkLLje1IDZ+xkQ4s+j6zYIF5R+fZKPI
         +dAQ2JK67v9SRiKUYuZ7Yw+m8PAZ8mHvLJ/Z2JtaCd4pAyjoS+BHCzTcD69WxxyxBT2r
         LbCoQPkU/eAzfUxfRAhaRrBYTCtel2BKSFtvtBUBXDEUif52MwNMz1Pu/0UO2AoED2EL
         rKvA==
X-Forwarded-Encrypted: i=1; AJvYcCVYDNTj00R84oNl7eo8ySe/0vUUjUElhN/6jnldOboM1qDZM0DQPxGIyNVtfkAYg97O0sR+gLjzizltzTxZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8moa3v9C3AbdxjQXTCISCjW5amrYj/tqzUeTbQLbTrtZyDlD5
	Vmjp4qTvPH8e0YjCPok3h0bjtGGFBJpIwi9xEE7uyRzQnyhJK9ocqRWTgRu8vCMkyaEGnq2t5Km
	1XPFAxuBce6BXYfkDy/VI9F022qYhWL6gX9jvALrJNEmHY5qGn75n2jekKIOKp/JR5QfSRSICFk
	bWpEAWlMSUQ7Pk0NnY7Q==
X-Gm-Gg: AZuq6aI9CMjq8cPrk16/kZUmn4BeCTDu60hnhLhwLNoSCoHWYGsHdOjkl5zGquf9S73
	Akb+rP3Z3alOwsvB6NnroFYY536o6poWvGhQE/Int7xy9x4yni84hgJDdjPivOLRwetziHW/5A8
	+qeYwncluivWxaggNqgBD/4nefgdtFntb6MV82qdEce/k7uoU+RBz6NxRM6mBPF0Y9ZjThgJE5U
	Fg2dleQgri6+i42ovai3NvxlUZvZhbPJBEliQSlLvlyVoL4sNtF1cuVMI78W5tMuTEAy8hJHERJ
	a0Owzsgj0L1ybBOhlZ0CH429Ui3MikYx6cwZSbzjo7rmc03HK7pNLeaWmvtmkWqJkMMGZqTEERT
	trUL+6RKXfLbEfgJzw0xG
X-Received: by 2002:a05:600c:3b1a:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-4836571ea9bmr2586195e9.34.1770836368001;
        Wed, 11 Feb 2026 10:59:28 -0800 (PST)
X-Received: by 2002:a05:600c:3b1a:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-4836571ea9bmr2586005e9.34.1770836367588;
        Wed, 11 Feb 2026 10:59:27 -0800 (PST)
Received: from localhost ([2001:67c:1562:8007::aac:4abc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4c4sm260909665e9.10.2026.02.11.10.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 10:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Feb 2026 12:59:25 -0600
Message-Id: <DGCD3NMVHDJQ.2J8WVPEBM4ZRS@canonical.com>
Subject: Re: PROBLEM: Duplicated entries in /proc/<pid>/mountinfo
From: "Zachary M. Raines" <zachary.raines@canonical.com>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.0-2ubuntu1~jmap
References: <DG0B0GEW323Q.29Y4J0A0Q5DQ5@canonical.com>
 <20260129-geleckt-treuhand-4bb940acacd9@brauner>
 <DG1B2T5I7REV.30XR7YCI0RSZ4@canonical.com>
In-Reply-To: <DG1B2T5I7REV.30XR7YCI0RSZ4@canonical.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76966-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[canonical.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zachary.raines@canonical.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,canonical.com:mid,canonical.com:dkim]
X-Rspamd-Queue-Id: A6EE212714C
X-Rspamd-Action: no action

On Thu Jan 29, 2026 at 1:04 PM CST, Zachary M. Raines wrote:
> On Thu Jan 29, 2026 at 8:28 AM CST, Christian Brauner wrote:
>> On Wed, Jan 28, 2026 at 08:49:12AM -0600, Zachary M. Raines wrote:
>> I suspect the issue is real though. I'm appending a patch as a proposed
>> fix. Can you test that and report back, please? I'm traveling tomorrow
>> so might take a little.

Just following up on the patch you sent and thanks again.

> Thank you for the quick turnaround on that patch. I applied it on top
> of 6.19-rc7 and after about 3 hrs I haven't seen any duplicates, in
> contrast to without the patch where they appear in under 10 minutes.
>
> Let me know if there's any other testing that would help.

According to my testing, your patch resolves the issue. Do you plan to
submit it upstream? Please let me know if there's anything
I can do to help on that front.

Best,
Zach

