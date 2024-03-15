Return-Path: <linux-fsdevel+bounces-14432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D557087CA68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 10:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969B02822BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611791773D;
	Fri, 15 Mar 2024 09:07:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0617592;
	Fri, 15 Mar 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.191.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493637; cv=none; b=RKeXz+eDyTxBIYeggi/69vF+q0KPSW7ryKjz6uWbjAGGjmcfpeb9OeoET2/vZ6AkjSElBoAVtQFhT4NXeQyepad07P9MFH9eNznFBVuGiTjeYmfk+BOjxqn5WPYTy0Pqi0sGh9BK1/fHAV4mp/bKlys2JmUIQ3XNC72uyWT3MkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493637; c=relaxed/simple;
	bh=JWeCD2B59pOaqgxOz/mvycvc8QuBPva2uaoQkjvv+bw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZXRCYKVWbRfgJidBYwjqWKFbKzpLEsWpB7iHmFL4KXcVUASQsD64U3w3RMMMiTzFUzXg4xmMFZjYDyrA0VOG1sib0oD22cDMDTRTz0aENjBTrSogHBIQRBw1LuPGnjyUwze/SOLXs/ZtrhumIDjhRlRMWDfheX+ctQqWYMjvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=194.150.191.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id E54608C0853;
	Fri, 15 Mar 2024 09:57:34 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject:
 Re: bcachefs: do not run 6.7: upgrade to 6.8 immediately if you have a multi
 device fs
Date: Fri, 15 Mar 2024 09:57:34 +0100
Message-ID: <12416320.O9o76ZdvQC@lichtvoll.de>
In-Reply-To: <muwlfryvafsskt2l2hgv3szwzjfn7cswmmnoka6zlpz2bxj6lh@ugceww4kv3jr>
References: <muwlfryvafsskt2l2hgv3szwzjfn7cswmmnoka6zlpz2bxj6lh@ugceww4kv3jr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Kent, hi.

Kent Overstreet - 15.03.24, 05:41:09 CET:
> there's a bug in 6.7 with filesystems that are mid upgrade and then get
> downgraded not getting marked in the superblock as downgraded, and this
> translates to a really horrific bug in splitbrain detection when the old
> version isn't updating member sequence nmubers and you go back to the
> new version - this results in every device being kicked out of the fs.

I take it that single device BCacheFS filesystems can be upgraded just fine?

I can also recreate and repopulate once I upgraded to 6.8. Still waiting a 
bit.

Best.
-- 
Martin



