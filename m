Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1A41A8BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbhI1GXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 02:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234207AbhI1GXt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:23:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C24336113E;
        Tue, 28 Sep 2021 06:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632810128;
        bh=AMLm/4tUn9CETUOijozi+fIMLnd5VIlwNyrW/zmpnZU=;
        h=Date:From:To:Cc:Subject:From;
        b=sJ5D8lYOcyR8XkQ3XWE75T2CMzxcrtyyKrFxVSHB9GDgchWMKvVoagXfCKMR77t4T
         tNZaP15z3PZPZmZFq+3GJ5B666w32wSS4amzH8FmWHk9wed/YMpW84aGIjKqihHAQm
         qen+u0Elu7nMuyyb7132HMqy8nDL9Llziia5MIrLyfJWPYSi6jjYL4KRfHpJksfZhd
         oqLiZoy0uqOf+JKoCIm8XANT2vigPSv9BBi0fhHUKHHNm1wbys35ca6XTdVwPl3IkR
         4DzOtMZC6MyAUJ5GF3iueMgyBeVvaD/p7MF4X9Y2//IxGZnaroaeE/J0FiPIb6A1TI
         GXBH8lOUK2bCA==
Date:   Mon, 27 Sep 2021 23:22:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boris Burkov <boris@bur.io>
Subject: [GIT PULL] fsverity fix for 5.15-rc4
Message-ID: <YVK0jzJ/lt97xowQ@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to 80f6e3080bfcf865062a926817b3ca6c4a137a57:

  fs-verity: fix signed integer overflow with i_size near S64_MAX (2021-09-22 10:56:34 -0700)

----------------------------------------------------------------

Fix an integer overflow when computing the Merkle tree layout of
extremely large files, exposed by btrfs adding support for fs-verity.

----------------------------------------------------------------
Eric Biggers (1):
      fs-verity: fix signed integer overflow with i_size near S64_MAX

 fs/verity/enable.c | 2 +-
 fs/verity/open.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
