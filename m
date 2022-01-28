Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACB149FD32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349725AbiA1P4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 10:56:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36938 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiA1Pz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:55:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7C6411F391;
        Fri, 28 Jan 2022 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643385356;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vzpgaAqLH7gCwNYYrQ+2BmZ46IrMyJ/+TvHIJbhEkVw=;
        b=HQCr7GA+8fMC00/0uVwZJ06iHV9mM2bLeNRTFwybz7o8hEbRv/K9MUPfzdhllmeHyglfYr
        moZT23nDT2cdwzKqyEW6xfygD8l3bydM46Gded4k98whTcBOVwD7GhrwR2Y5+x1F3lTO6Y
        TdH9nWg73tjUruSkMZ+2OdCyWKBlAww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643385356;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vzpgaAqLH7gCwNYYrQ+2BmZ46IrMyJ/+TvHIJbhEkVw=;
        b=KJbOhWbcBEgcSk70pW1pq88WQAQ086lsgu5iUEuP6+wz/To3KF+1HEelVWByXI2LyGApNt
        jrcWNoO0Y/PtqGDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6AB43A3B84;
        Fri, 28 Jan 2022 15:55:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CBA58DA7A9; Fri, 28 Jan 2022 16:55:13 +0100 (CET)
Date:   Fri, 28 Jan 2022 16:55:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
Subject: Re: [next] i386: ERROR: modpost: "__aeabi_uldivmod"
 [fs/btrfs/btrfs.ko] undefined!
Message-ID: <20220128155513.GI14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>
References: <CA+G9fYtGGdxLwkV=VHdDP_d2C0oLd7=wUhF1wcYtndpp-y5BTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtGGdxLwkV=VHdDP_d2C0oLd7=wUhF1wcYtndpp-y5BTA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:52:05PM +0530, Naresh Kamboju wrote:
> [ Please ignore this email if it is already reported ]

Yeah thanks for the report anyway, fix has been pushed to new for-next
snapshot.
