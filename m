Return-Path: <linux-fsdevel+bounces-4377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7637FF285
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E11284D68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422051007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK3sAR6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB766168B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C243EC433C8;
	Thu, 30 Nov 2023 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701348567;
	bh=43oR/TEPhaIDiT8t2RmZkke7Hwv0fwWi2zI2h/JVix4=;
	h=From:Subject:Date:To:Cc:From;
	b=EK3sAR6e2qsHoZXzXk2oyY7ghkji5Nh5k6nV5hgp859QB+OlzNJZWf+3yFnL010EF
	 khrBFoz9FcovLhy8+uhS2Wtfp4dTYqabHROKJqmHw3ghSlMdRUEVLgi6uNCRTRCB2M
	 o83bcGY7TMjQCPK6zLXnV7SHI4fKF0muK/GT745pkCvT3XuzUWFVF0uo74BQrLAeku
	 JXtSlY4/jqNH6hHyCgIqP5fRCefNJvTysWrg+uhAwrV6PgYXoRmgJPdELyGw/DUHSr
	 llgl2FLJa89lwLI6/r3dZjuozQN9AvFtZL+3HZblmbiSbjejeqPeCqW52pV0hDpG5y
	 znkJqtobsdacw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/5] file: minor fixes
Date: Thu, 30 Nov 2023 13:49:06 +0100
Message-Id: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKEaGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQyNL3bK0Yt20zJxUEFkBJA3MjU0s0gyTkk0NEpWAugqKUsESQE3RSkF
 uzkqxQMGkxOJU3aSixLzkDJBhQDP0cjOLk5VqawGZtQgIgQAAAA==
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, 
 Carlos Llamas <cmllamas@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-7edf1
X-Developer-Signature: v=1; a=openpgp-sha256; l=343; i=brauner@kernel.org;
 h=from:subject:message-id; bh=43oR/TEPhaIDiT8t2RmZkke7Hwv0fwWi2zI2h/JVix4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRmtFxdut61ZrVZL0+s+YdmLnZ28ZM+XC9nWDHt25Z54
 +e3ybwvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS9J2R4T7Hu+n/zXrXrrx4
 7g+fifWJznNTfPKDsnZplKTvubdEuJCRocHSOffs9WyJi0pmL+5dbiy8VOt5p/0nz/vQl5orj7O
 Y8AMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

* reduce number of helpers
* rename close_fd_get_file() helprs to reflect the fact that they don't
  take a refcount
* rename rcu_head struct back to callback_head now that we only use it
  for task work and not rcu anymore


---
base-commit: 9da5933ccd0f0cc5ed235f99e1211d4ad7cd2013
change-id: 20231129-vfs-files-fixes-07348f1bc50a


