Return-Path: <linux-fsdevel+bounces-44756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42338A6C777
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 04:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6583B46424F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2388D156653;
	Sat, 22 Mar 2025 03:37:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D9155382
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614621; cv=none; b=EdfkqC5HdZarlXokOx3I4JUHvuJ828SprYsi/lPNmJbmcTPDGvG6rr8CzMOSeoYGZ6e4JsbZP1mZfDsr1qTWbo4v6yFCy0kuNpOYHrJSqhP4O4TsvlUXjQbrrgugUn2FKlnAzR0BHi8me1WBg3KIZob4JyvN5t+S5oza/MKF0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614621; c=relaxed/simple;
	bh=G7S8mDnweQ0QEQVt0tgiIFlnUT/TmYty8hUukQIlgB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmDVfH7EzLV9yZTJjDRcmRqg5N5HlMg3L/tgTlZBYNKPkFUtAgQUfdQm3iNMWQwvzIV3GeE3k5JiPbYqPUXoMGR5M7sIga0ATScokwyOULeeQI0zigiXqZOO33Fb3QJ+//rhLxxCSM4RVyVkCsQXj1Bei+CILpHbzEcCmX7FeIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aNo8007718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:24 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C3C8A2E0110; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next] ext4: correct the error handle in ext4_fallocate()
Date: Fri, 21 Mar 2025 23:36:19 -0400
Message-ID: <174261457018.1344301.14790065059237204237.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319023557.2785018-1-yi.zhang@huaweicloud.com>
References: <20250319023557.2785018-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Mar 2025 10:35:57 +0800, Zhang Yi wrote:
> The error out label of file_modified() should be out_inode_lock in
> ext4_fallocate().
> 
> 

Applied, thanks!

[1/1] ext4: correct the error handle in ext4_fallocate()
      commit: 129245cfbd6d79c6d603f357f428010ccc0f0ee7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

