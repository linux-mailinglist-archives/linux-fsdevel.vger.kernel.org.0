Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D1D6CA673
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjC0Nub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 09:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjC0NuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:50:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2A6729B;
        Mon, 27 Mar 2023 06:48:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5E6F21EFF;
        Mon, 27 Mar 2023 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679924927;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lLZ1tOH+2IQe9KNBkCOduf46JwkVP7E5NFMbAeK+g0c=;
        b=wCrUqDGGkVY91bPwyB4sKnxEuP4mikf5NEyxFiPcU35xaIOlDqLcyokCLFiG+JNPJSHvn3
        ZAeRqlVqf461/gWCnsRQuZw1feCMUo14Yd9SCu1bLurzSX9WzzqBkwnSa3XfoaIkYOxR7P
        0rXNnaAotneuHk9dOnMW+xq2BLEb3wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679924927;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lLZ1tOH+2IQe9KNBkCOduf46JwkVP7E5NFMbAeK+g0c=;
        b=U+TejpDKl5C4Rt5qFxt4ivAQLJBhX5lzpC9S5ByUqJ5CQETauQ9p0GqWEeKWL4pH/c5Gs8
        qbRyffZS2aUMENBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FBE313482;
        Mon, 27 Mar 2023 13:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5j8wHr+eIWQAfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Mar 2023 13:48:47 +0000
Date:   Mon, 27 Mar 2023 15:42:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+list32e5d8c30adcfd4f0ca2@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs] Monthly Report
Message-ID: <20230327134234.GE10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000b4315105f7a7d014@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b4315105f7a7d014@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:23:36AM -0700, syzbot wrote:
> Hello btrfs maintainers/developers,
> 
> This is a 30-day syzbot report for btrfs subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/btrfs
> 
> During the period, 3 new issues were detected and 0 were fixed.
> In total, 53 issues are still open and 29 have been fixed so far.

The overview is convenient and monthly frequency is reasonable, thanks.
