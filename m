Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6C46F6BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 23:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhLIW0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 17:26:40 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59402 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230479AbhLIW0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:26:39 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B9MN2VZ006794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Dec 2021 17:23:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8E8824205DB; Thu,  9 Dec 2021 17:23:01 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/13] ext4: new mount API conversion
Date:   Thu,  9 Dec 2021 17:22:59 -0500
Message-Id: <163908856059.1128916.12004716990874084466.b4-ty@mit.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 27 Oct 2021 16:18:44 +0200, Lukas Czerner wrote:
> After some time I am once again resurrecting the patchset to convert the
> ext4 to use the new mount API
> (Documentation/filesystems/mount_api.txt).
> 
> The series can be applied on top of the current mainline tree and the work
> is based on the patches from David Howells (thank you David). It was built
> and tested with xfstests and a new ext4 mount options regression test that
> was sent to the fstests list. You can check it out on github as well.
> 
> [...]

Applied, thanks!

[01/13] fs_parse: allow parameter value to be empty
        commit: 6abfaaf124a81b7d2ab132cc2c9885baa14171e5
[02/13] ext4: Add fs parameter specifications for mount options
        commit: e5a185c26c11cbd1d386be8ee4c5e57b4f62273a
[03/13] ext4: move option validation to a separate function
        commit: 4c94bff967d90e91ace38a9886c1c7777a9c6f91
[04/13] ext4: Change handle_mount_opt() to use fs_parameter
        commit: 461c3af045d3ab949360fedbfb3ea1dcd9d8b22b
[05/13] ext4: Allow sb to be NULL in ext4_msg()
        commit: da812f611934bef16fe02d667a76df77ae9cf99a
[06/13] ext4: move quota configuration out of handle_mount_opt()
        commit: e6e268cb682290da29e3c8408493a4474307b8cc
[07/13] ext4: check ext2/3 compatibility outside handle_mount_opt()
        commit: b6bd243500b6024d92eaaacf592ed8588c2c75ea
[08/13] ext4: get rid of super block and sbi from handle_mount_ops()
        commit: 6e47a3cc68fc525428297a00524833361ebbb0e9
[09/13] ext4: Completely separate options parsing and sb setup
        commit: 7edfd85b1ffd36593011dec96ab395912a340418
[10/13] ext4: clean up return values in handle_mount_opt()
        commit: 02f960f8db1cd0aa9c182f8804b2b41ffd2c37b2
[11/13] ext4: change token2str() to use ext4_param_specs
        commit: 97d8a670b4531437d5b842cf68dafa6d1a932ddf
[12/13] ext4: switch to the new mount api
        commit: cebe85d570cf84804e848332d6721bc9e5300e07
[13/13] ext4: Remove unused match_table_t tokens
        commit: ba2e524d918ab72c0e5edc02354bd6cb43d005f8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
