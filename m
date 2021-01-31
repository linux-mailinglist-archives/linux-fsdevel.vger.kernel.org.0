Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6614F309EF9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhAaUii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 15:38:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhAaUii (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 15:38:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 713E064DDF;
        Sun, 31 Jan 2021 20:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612125477;
        bh=Y+HbrdqwIzbllpR48lZD7Uz1qpCFGm76sW5CgByGzg4=;
        h=Date:From:To:Subject:From;
        b=eNXNF3rl5Dpb+SsuaiBWU3iO3B2CRTFLpeL7goA68OjiS3Qvm1joQVpMdsf6xH0MA
         a0mZditjsWUCahYX6GVV3hb/kq3ZCJG90GBTrDMh8OLhRRZrH3uZDgMorZ31oQ+Lxa
         V9GeGt+noucAiP1s5xc/G7ttgbyXj7bSBFDlL9XQJPcteu57MqMgG5g3UHchc4BjLX
         c5yiQYmGcv1dNSVCmo/apJ69FjNIxDWNqMtm5bNUuc7yvdLejRr/RHBGLhZFDx5wA5
         S5fhZpyNF9CrBdBZojQ4y1XAMgTlsiLuFcG+VzpiTnckadUFE4s+emO/1WeCcbxHYm
         NR1MtoqsPYaVQ==
Received: by pali.im (Postfix)
        id 48650947; Sun, 31 Jan 2021 21:37:55 +0100 (CET)
Date:   Sun, 31 Jan 2021 21:37:48 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE] dosfstools 4.2
Message-ID: <20210131203748.6iodn4tpcjzb56a6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello! I would like to announce a new version of dosfstools 4.2:

https://github.com/dosfstools/dosfstools/releases/tag/v4.2

Project dosfstools contains standard Linux utilities for FAT12/16/32
filesystems: mkfs.fat, fsck.fat and fatlabel.

New version is there after 4 years of development and contains lot of
fixes and improvements. Details are on above release page and also in
the NEWS file found in release tarball.

If you found any problem in the newly released version, please report it
to the dosfstools issue tracker at github:

https://github.com/dosfstools/dosfstools/issues
