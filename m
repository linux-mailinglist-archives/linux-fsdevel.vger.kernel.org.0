Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71264951E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 16:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376781AbiATP63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 10:58:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37526 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243632AbiATP6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:58:22 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20KFwDfQ001102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 10:58:14 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CF09C15C41B6; Thu, 20 Jan 2022 10:58:13 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2 0/5] ext4/jbd2: inline_data fixes and minor cleanups
Date:   Thu, 20 Jan 2022 10:58:12 -0500
Message-Id: <164269428249.194735.9368808618979556408.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1642416995.git.riteshh@linux.ibm.com>
References: <cover.1642416995.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Jan 2022 17:41:46 +0530, Ritesh Harjani wrote:
> Please find v2 of the inline_data fixes and some minor cleanups found during
> code review.
> 
> I have dropped patch-6 in v2 which was removing use of t_handle_lock (spinlock)
> from within jbd2_journal_wait_updates(). Based on Jan comments, I feel we can
> push that as killing of t_handle_lock into a separate series (which will be on
> top of this).
> 
> [...]

Applied, thanks!

[1/5] ext4: Fix error handling in ext4_restore_inline_data()
      commit: 2fdd85005f708691a64270ecb67d98191d668c4c
[2/5] ext4: Remove redundant max inline_size check in ext4_da_write_inline_data_begin()
      commit: c7fc77e512a432bba754f969c4eb72b33cda3431
[3/5] ext4: Fix error handling in ext4_fc_record_modified_inode()
      commit: 6dcee78ea266fb736a3357c2e04d81ee7ec7b6e4
[4/5] jbd2: Cleanup unused functions declarations from jbd2.h
      commit: 16263b9820b0d40c778c8ee867f853d3fe638f37
[5/5] jbd2: Refactor wait logic for transaction updates into a common function
      commit: b0544c1f23ddeabd89480d842867ca1c6894e021

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
