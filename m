Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA99C35A330
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhDIQ0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhDIQ0F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:26:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B64E66108B;
        Fri,  9 Apr 2021 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985552;
        bh=P55O8g84c2M0apwMzkGvkURBLk9reHeYjCsbklS4T8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=sBo/qVV89CWN8c9bNFBk5HTyfQGtaa2q4OUGGrL+6lqn5iLkHsSIVIpryH9cauOKv
         1cqRuM1n7RFfoFfmD1r3EtIAtmqum9uLL29WuT7+qr99NN2kUxe9zruo4W3bmT128z
         xot2m9DreM12wEwlAUk+kSAgUlOMOpaPVs/WqtJaHynSYp47RgOy671ptDYHnmCA6P
         R+UtqdsqCCYuU9A99wlyw491x/ZgwSuNYfRoPdRp9aDbUwK/wYdtl+oq5wFeibn4Xq
         cviIGRN5dMr/SgMIHMPKlaitfA83wpgcdWZgSjbHzGGDviY6ELUpwKA6WHbBTsTHWS
         3DPo/U3oYn3aA==
From:   Christian Brauner <brauner@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/3] ecryptfs: fixes and port to private mounts
Date:   Fri,  9 Apr 2021 18:24:19 +0200
Message-Id: <20210409162422.1326565-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

Similar to what we do in overlayfs and now in cachefiles too ecryptfs
should rely on a private mount that can't change mount properties
underneath it and puts ecryptfs in full control (apart from changes that
affect the superblock of the underlying fs of course) over the mount it
is using to store its encrypted files in.

Thanks!
Christian

Christian Brauner (3):
  ecryptfs: remove unused helpers
  ecryptfs: use private mount in path
  ecryptfs: extend ro check to private mount

 fs/ecryptfs/ecryptfs_kernel.h | 12 ------------
 fs/ecryptfs/main.c            | 19 ++++++++++++++++++-
 2 files changed, 18 insertions(+), 13 deletions(-)


base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.27.0

