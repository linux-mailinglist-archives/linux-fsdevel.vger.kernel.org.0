Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176FE3B9007
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhGAJxP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 05:53:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60214 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhGAJxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:53:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5CA2C1FD29;
        Thu,  1 Jul 2021 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625133044;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cTB9nVM4uA6qiO0zlpVYuohcq0FJKgfhWvwgxn4CuCE=;
        b=kIdeRxepWU8Ec/pgwqEnXjkdL0VFul/miZ+keEBCmPH25PLu/Uhizd7O1S68/zOY34wt6P
        2mT9U+6YcyipYAAhm8M0s85fPmRAzYkSaJ0wncqR5vvKZZjdkyl6kO/skJCaMBRQp3h7aK
        FfN9oya/CtETQy67HrFtzNZuT/zGX4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625133044;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cTB9nVM4uA6qiO0zlpVYuohcq0FJKgfhWvwgxn4CuCE=;
        b=ZRu8U95A1GAgEC3fioffJpFavaOFkYze5RFRdGtgq2/C+bNTS/TF5srioMS511UYK7yUhK
        ChgP1uwP+uLiuRCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 400E3A3B87;
        Thu,  1 Jul 2021 09:50:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7474DA6FD; Thu,  1 Jul 2021 11:48:13 +0200 (CEST)
Date:   Thu, 1 Jul 2021 11:48:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Arthur Williams <taaparthur@gmail.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [fs]  87f196bed3: xfstests.generic.157.fail
Message-ID: <20210701094813.GV2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        kernel test robot <oliver.sang@intel.com>,
        Arthur Williams <taaparthur@gmail.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20210619110148.30412-1-taaparthur@gmail.com>
 <20210701021928.GB21279@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701021928.GB21279@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 01, 2021 at 10:19:28AM +0800, kernel test robot wrote:
> generic/156	[not run] xfs_io funshare  failed (old kernel/wrong fs?)
> generic/157	- output mismatch (see /lkp/benchmarks/xfstests/results//generic/157.out.bad)
>     --- tests/generic/157.out	2021-06-28 16:41:45.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//generic/157.out.bad	2021-12-01 20:44:35.949001218 +0000
>     @@ -14,7 +14,7 @@
>      Try to reflink a device
>      XFS_IOC_CLONE_RANGE: Invalid argument
>      Try to reflink to a dir
>     -TEST_DIR/test-157/dir1: Is a directory
>     +XFS_IOC_CLONE_RANGE: Is a directory

The sense of the error hasn't changed but the output is different so
it needs some filter again.

>      Try to reflink to a device
>      XFS_IOC_CLONE_RANGE: Invalid argument
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/157.out /lkp/benchmarks/xfstests/results//generic/157.out.bad'  to see the entire diff)
> generic/158	- output mismatch (see /lkp/benchmarks/xfstests/results//generic/158.out.bad)
>     --- tests/generic/158.out	2021-06-28 16:41:45.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//generic/158.out.bad	2021-12-01 20:44:37.783001265 +0000
>     @@ -18,7 +18,7 @@
>      Try to dedupe a device
>      XFS_IOC_FILE_EXTENT_SAME: Invalid argument
>      Try to dedupe to a dir
>     -TEST_DIR/test-158/dir1: Is a directory
>     +XFS_IOC_FILE_EXTENT_SAME: Is a directory

Same.

>      Try to dedupe to a device
>      XFS_IOC_FILE_EXTENT_SAME: Invalid argument
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/158.out /lkp/benchmarks/xfstests/results//generic/158.out.bad'  to see the entire diff)
