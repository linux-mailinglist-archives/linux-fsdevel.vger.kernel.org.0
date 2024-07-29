Return-Path: <linux-fsdevel+bounces-24457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6113E93F928
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7712830F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E615665C;
	Mon, 29 Jul 2024 15:11:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82949156641
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265892; cv=none; b=SElLh/a9XI0ii7tPuFl/o5+1LwwRmbwjDa0igsrjti0rd3XpFUpEf6Qt00JsSt58mZscNdvUFDNvXG8BEQJq0oMqn3m70SbLMjHAkj/65xNp5iWzePzMdAaAQtNIMiyTt8vGzwS5Mokk4fMwCMlRzme0E1QaW2rA6aQZXfSE110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265892; c=relaxed/simple;
	bh=69h5UDmnFdl+LdsOlBUwHmnFG2sUrD8NhDkz3f66jZ8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=IyiKVp52yA5h9RVNtKdIC9YNaKNFp2xhFp8BF4cDXe4JJtynWTxxj+3Ld3ad1q9T2iK+gIGt81tAWYuha9Qx4GLcVPrBObYjK33CBvwzOGZ+c3f9M3SUOepXTXo4z5T3hAUCnoItYgqnyUS5QMoNPSWLhYGg04pfI1P1Je9bWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: hch@lst.de
Cc: libc-hacker@sourceware.org,linux-fsdevel@vger.kernel.org,trondmy@hammerspace.com
Subject: Re: posix_fallocate behavior in glibc
In-Reply-To: <20240729150952.GA29194@lst.de>
Organization: Gentoo
Date: Mon, 29 Jul 2024 16:11:24 +0100
Message-ID: <87wml4b5cz.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Please write to libc-alpha@.

thanks,
sam

