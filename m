Return-Path: <linux-fsdevel+bounces-3659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6969B7F6E24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EC22818B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A01C148;
	Fri, 24 Nov 2023 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxfz4qO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D4BE4B
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 08:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558A2C433C7;
	Fri, 24 Nov 2023 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700814549;
	bh=lKoCrkJ5s5dxIMY878XieGCWR60Uyva4ef9/CtedcUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xxfz4qO7BoftCWr/EbCggvO1QCszKbYNSAT3M4B7RaDIy8zUMZmO21mAiO+s6DYIF
	 7xSxsdSngvajNxtlX43Zvkk/jAxWMyTh1CPYe8xPIV7AGLfDCKq5xUjHwysBmWDCvw
	 isgXg+sQvU2lawxm9Yoc72ynX5+ox9vQLgqRkudgLG8qAiJBC+4ogqRLjkBgFk0Jnk
	 nc7rkZbhoMfHWugNJDRpdKg+J48STOGfQuL0ZZusJ046xiOp5u3z3hg/Bs5E5+qJMM
	 OfP4CUWRaH3HwMoRDn8Tb59t+islmjIYABMVBHVOX7gHBFgLk1IOM6djraAmI8I4b1
	 VYsvR04tW/uPg==
Date: Fri, 24 Nov 2023 09:29:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/20] [software coproarchaeology] dentry.h: kill a
 mysterious comment
Message-ID: <20231124-nieder-zugverbindung-b0073f12bb13@brauner>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
 <20231124060644.576611-9-viro@zeniv.linux.org.uk>
 <CAOQ4uxgRiQCG_Q5TP+05_N4V=iFTemzGTd62ePgAgotK52EAAQ@mail.gmail.com>
 <20231124081141.GV38156@ZenIV>
 <20231124082621.GW38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124082621.GW38156@ZenIV>

> BTW, there's this, covering more than just BK times:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

An absolute life-saver at times this repo for the ones of us who haven't
been around for 20+ years...

