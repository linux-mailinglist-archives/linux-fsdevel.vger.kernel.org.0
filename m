Return-Path: <linux-fsdevel+bounces-2360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819737E516B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CB11C20A84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284BD519;
	Wed,  8 Nov 2023 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSnRQY4B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62023D50E;
	Wed,  8 Nov 2023 07:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CD9C433C7;
	Wed,  8 Nov 2023 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699430017;
	bh=EO6SIeq3IRVmtcKnhSZW5myz/GbmhWsorKkfsMWlq0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSnRQY4BD1Zt326N3ax1KgytTnQmiA7/5HwRTE9BjxrlM6t57aKI5tDLxjWKbsBCG
	 XpmFBhlpZeeOmTQIcJ7TJYUyuhSL0UOs32vU80NdjTgdfPbEjznC54ZKN+KyoNxTdw
	 ECKKUhFw5qPTj7Z2WU6umcUrUp1qOnGIBzY2Qj+kt42o3TivB/T7wdWVIWbzGL0hEh
	 NrVwKVfnb/BFKTzlSNBaiF80d63DFH+3cZOvK1fYQKhmhvxSCQTegZP3o8BYTEtzEV
	 9iXBC4GTjo3HtNqAyVYWlcgcfxx0pKXN86hO+VdXnW0v28QiiCYVFQSSgjtosqRI6D
	 ofbIH/INlerDQ==
Date: Wed, 8 Nov 2023 08:53:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Message-ID: <20231108-redakteur-zuschauen-a9aeafaf4fad@brauner>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
 <87il6d1cmu.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il6d1cmu.fsf@meer.lwn.net>

> Why use struct __mount_arg (or struct mnt_id_req :) here rather than
> just passing in the mount ID directly?  You don't use the request_mask

Please see Arnd's detailed summary here:
https://lore.kernel.org/lkml/44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com

