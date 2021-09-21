Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0069E413482
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhIUNlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 09:41:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33718 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhIUNlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:41:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2051FEDF;
        Tue, 21 Sep 2021 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632231619;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=toTVANTVHwsgB5kR1e4hk9xFXSzXz5LlWgRVGGlnA7U=;
        b=Qn3SysEETMonxC4QOp72gwkZaMWwt8zVEufZXKtGoG/ZDGf3kDEqqzfBXWSOY697um0mXo
        6eXFHq+dA9mR/DDD1yEOOnR6UENezn7JSo4OE9QgSAY8MHQX7EW/7pp/heWgL18u/CLXct
        /pnHtQECZMZMnD2d8s0cTFRTvA0Tk/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632231619;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=toTVANTVHwsgB5kR1e4hk9xFXSzXz5LlWgRVGGlnA7U=;
        b=XJkGV8ALNPejKFod8vy0eK0NQvE8AbUn1aoOllax5W3sM/LJd22BhzMsBp5+n7/AT+C/Qi
        Jh3RQnWbyGvt59CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92DFD13BD1;
        Tue, 21 Sep 2021 13:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iE5WIsLgSWGMRQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 21 Sep 2021 13:40:18 +0000
Date:   Tue, 21 Sep 2021 15:40:17 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] aio: Wire up compat_sys_io_pgetevents_time64 for
 x86
Message-ID: <YUngwSp4hRlU9p6T@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210921130127.24131-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921130127.24131-1-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I also wondered, if it should be added for other archs like the other compat
functions.

Kind regards,
Petr
