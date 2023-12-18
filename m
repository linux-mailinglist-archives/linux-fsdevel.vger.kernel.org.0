Return-Path: <linux-fsdevel+bounces-6434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90E817DFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8319528635E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 23:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD994760B3;
	Mon, 18 Dec 2023 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MxmO7Kk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102674E16;
	Mon, 18 Dec 2023 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vz2+SV6FQDFW+uFGsb93QwrVbDu7R4z3v/c1VUv6d/o=; b=MxmO7Kk9tqQi8N6OmthNpay4ev
	1isjVH+koLZd7JvjlnNWCPcWUiWxsQGn7JjxpOhu3OsgiB+IMou/RFTvq41DXvjvWzXOTFeA4jexu
	NcPfn9MxAmHD8vYZq/kR0TPS4fwp1LVZyueNKoZil60eDFItxCNz74T2h6ECMsNFiTj8uQsEgS5Wy
	EnDi9WGEGyOODqjUeV+CeKM0MDlgBkBLCENiCw1uw+Li+2m3K1/3511ljMACWsUn51Z0vOUu1F9XM
	YrmAgYEV5kP1nT3JfmXpsxv1swWBaETmz7B1fK5NszMHJaXH0BfjaM7Fzk5am/EDhsqnvbhME+FV8
	xXXw+l7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFMt1-00Fc1h-0M;
	Mon, 18 Dec 2023 23:18:59 +0000
Date: Mon, 18 Dec 2023 23:18:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix doc comment typo fs tree wide
Message-ID: <20231218231859.GV1674809@ZenIV>
References: <20231215130927.136917-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215130927.136917-1-aleksandr.mikhalitsyn@canonical.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 15, 2023 at 02:09:27PM +0100, Alexander Mikhalitsyn wrote:
> Do the replacement:
> s/simply passs @nop_mnt_idmap/simply passs @nop_mnt_idmap/
             ^^^                         ^^^
> in the fs/ tree.

You might want to spell it correctly in the replacement string ;-)

