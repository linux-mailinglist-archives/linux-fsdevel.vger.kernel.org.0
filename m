Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BD72E9C1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 18:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhADRga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 12:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbhADRga (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:36:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 123D32065E;
        Mon,  4 Jan 2021 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609781750;
        bh=Eh5gXZUSxbdW8jr3WOJHcrAU8vNNsf3HNo8dRBgJAuk=;
        h=Date:From:To:Subject:From;
        b=BrKSnK+Zk5LsgSiQMlt+e+4AM8rOStZPMP83H73VE4BucQEMw44L2d34ucssC95vx
         PWkkHyY++lyO18y+KKDCY4lqDpo/rEVvGOmfDMyfWMQmgMZul2bL/NAqJmkvmKjgjs
         T0SVoinkdn8tWaWKca6xN6KdLy88Nx0J6fUjBR6sXMwTQXgCmvKzABgm8MgjAl4+4K
         WX7oYtgCeJoOsEazdnoXMKfJq02oLQ8U1Ihs01KUwy58bxCpj1VmaNqYp9RDj2Jmtt
         b/JNgv33Dg5GzJY1uV0wuNPIoIPMD1T7SEek4mGcxOfl2g2AvJNuz/p+l0rXlAsYBd
         hm5G+bOlsmTuQ==
Received: by pali.im (Postfix)
        id C188C7F0; Mon,  4 Jan 2021 18:35:47 +0100 (CET)
Date:   Mon, 4 Jan 2021 18:35:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE] udftools 2.3
Message-ID: <20210104173547.w75dop4klbucudoy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello! I would like to announce a new version of udftools 2.3.

udftools contains linux userspace utilities for UDF filesystems and
DVD/CD-R(W) drives.

The most visible change in this release is support for Multisession UDF
disc images, fixed formatting of CD-RW discs on modern drivers and new
options for manipulating with owner/organization/contact information.

More information with link to tarball are available at:
https://github.com/pali/udftools/releases/tag/2.3

Or at project homepage:
https://github.com/pali/udftools
