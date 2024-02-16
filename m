Return-Path: <linux-fsdevel+bounces-11897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E279C858869
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 23:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0BD2838E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 22:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7719E1482FE;
	Fri, 16 Feb 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T7zyTECw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C614600B
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121615; cv=none; b=K39gkLQsi9jgQ41yFa4f+V3PPHzH42Qe/9Da2u63AqratPO5eL5cu+BeTcVdOKW09Oxfzoktk73csHuo+mYVkQ873HY1p8i0sRRGGeXBaWY97DuOYfpZxAuYEFpfdgxgVMQatjekBwHqXTzQUlZXmdt/BXhyBFlzuTdo6WKxzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121615; c=relaxed/simple;
	bh=ZNIlbIiD9UR2jIKezKKIlhDWYCK4vKriAc8nkw6/w34=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p0ej4dLt4hFZnFOeBfB4GPftCnGT+jwUer4hIuR9uWZiCrmaKeqt8tdQ1W5iYfjSgY2lKlWEHfPn9pgDeNmdzgGVrzlM5dJzWugmk1vGwaOq9ov3C17OPlrPm02jM9G7BNFoYcveO6JCZkbsVtBVADfIfYNXOTzxl/kPJYaXono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T7zyTECw; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Feb 2024 17:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708121610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ZNIlbIiD9UR2jIKezKKIlhDWYCK4vKriAc8nkw6/w34=;
	b=T7zyTECwTjy1maLPfhH3pF0DFNR8l45iKxPmyzCiBL6DIQps79a3qhWjSdvFyCR7CijhAw
	Uk8SHWdcZpy3Ds4qp8iB3XaNF5UTnA/5aObMtlCsxdzEThmnl6F4ZoaQ1IhEUuDTrLmpKz
	i89CgtQi6EUORDhaixdUnLCLjXrLeNc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [weekly bcachefs cabal] tuesday, 1PM EST
Message-ID: <l75bqikzjjrtehvkkv7jzsr4ei5ingz6ygxwjnt4tv6otqexdq@cbr5brx7xzmo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

been a bit since I've sent out an announce for this, and there's new
names popping up on the list contributing fixes, so...

chat about bugs, complain about code you're staring at, the usual
filesystem bullshit

shoot me an email for an invite

