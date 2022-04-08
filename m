Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B654F98BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiDHO6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiDHO6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:58:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC01116B58;
        Fri,  8 Apr 2022 07:56:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E6C9E1F862;
        Fri,  8 Apr 2022 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649429785;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VcxLvlVCQO4rH2Xwy2B4XiLp12u0K/N6J1DwYp0BOz4=;
        b=DmaevUROaXjkghWhbFK7ZgcVlBIgSZm2DccHif0IYzBacnvVPnyDJYptN5XpP59/vLseO1
        OUiwbX5F4VjIwqgoapCQ7pZlBkygGqgFDvJV7oCOHPvv+selT7qvD6uefySkPNfHWSqpE6
        k1bsdsWl0mazTFfzPyYwBFrEHDCJ/cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649429785;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VcxLvlVCQO4rH2Xwy2B4XiLp12u0K/N6J1DwYp0BOz4=;
        b=dy4oginC1lZ7phDKwIki4GuKu+gkfE/C9XBnisHJf3rdXQak5y6wF7mFyhMbVMVxjQs/JM
        Iy4xOwH4Yye0R8BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B0C3DA3B8A;
        Fri,  8 Apr 2022 14:56:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E577ADA832; Fri,  8 Apr 2022 16:52:22 +0200 (CEST)
Date:   Fri, 8 Apr 2022 16:52:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Bruno Damasceno Freire <bdamasceno@hotmail.com.br>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, fdmanana@suse.com
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
Message-ID: <20220408145222.GR15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Bruno Damasceno Freire <bdamasceno@hotmail.com.br>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, fdmanana@suse.com
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
 <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
 <MN2PR20MB251203B4B5445B4B0C4148C9D21D9@MN2PR20MB2512.namprd20.prod.outlook.com>
 <35b62998-e386-2032-5a7a-07e3413b3bc1@leemhuis.info>
 <MN2PR20MB251205164078C367C3FC4166D2E59@MN2PR20MB2512.namprd20.prod.outlook.com>
 <9163b8a9-e852-5786-24fa-d324e3118890@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9163b8a9-e852-5786-24fa-d324e3118890@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 12:32:20PM +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
> 
> Btrfs maintainers, what's up here? Yes, this regression report was a bit
> confusing in the beginning, but Bruno worked on it. And apparently it's
> already fixed in 5.16, but still in 5.15. Is this caused by a change
> that is to big to backport or something?

I haven't identified possible fixes in 5.16 so I can't tell how much
backport efforts it could be. As the report is related to performance on
package updates, my best guess is that the patches fixing it are those
from Filipe related to fsync/logging, and there are several of such
improvements in 5.16. Or something else that fixes it indirectly.
