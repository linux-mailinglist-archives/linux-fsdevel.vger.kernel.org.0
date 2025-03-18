Return-Path: <linux-fsdevel+bounces-44241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E6A66797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 04:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29FF3A78D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 03:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959911BCA1C;
	Tue, 18 Mar 2025 03:42:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA41ADC65
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269328; cv=none; b=gjHLvx3p785bp9zFtCMumAW/3e5jEtenwdU018gvg5SiHGdzc9j9+b0YSOgbyW1vgGhRg65QgtJtzp7Vti/tLhoHs29IDYjJRqWkRSoOEe8EUmY9rQoTvdoTQxRsNC5V5dmkYMnTJEzmZ1HJaVhHPNUIPdPkEdRhSn/zAZvebqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269328; c=relaxed/simple;
	bh=aHoLFeS9wmOOx6ir4HAUA/HhDddPfzodCcgmDsAZrms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9x1Jxj+WPdLaKgwcgAbepwV/cvnb5XWRsFKmRUQ2l6pktOOb5bZoWll6eWp2S3GH7HR6fpjuICjy/jj49az2U7SLXwbVB/I5HK2PjMeL/d+OuvWPHkXVjVRkez7gLo6EVB7pyC+Na/a+0sZ7R0r/m0oxE2gtlqRwj6EzLWzkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fnIF012167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 00C662E011B; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, jack@suse.com, Zizhi Wo <wozizhi@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH] ext4: Modify the comment about mb_optimize_scan
Date: Mon, 17 Mar 2025 23:41:29 -0400
Message-ID: <174226639138.1025346.5200311084093814962.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224012005.689549-1-wozizhi@huawei.com>
References: <20250224012005.689549-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Feb 2025 09:20:05 +0800, Zizhi Wo wrote:
> Commit 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning") introduces
> the sysfs control interface "mb_max_linear_groups" to address the problem
> that rotational devices performance degrades when the "mb_optimize_scan"
> feature is enabled, which may result in distant block group allocation.
> 
> However, the name of the interface was incorrect in the comment to the
> ext4/mballoc.c file, and this patch fixes it, without further changes.
> 
> [...]

Applied, thanks!

[1/1] ext4: Modify the comment about mb_optimize_scan
      commit: 447c11274113dd3543224816cca0d3027759c630

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

