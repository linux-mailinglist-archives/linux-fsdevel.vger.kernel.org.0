Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1FC41344C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhIUNfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 09:35:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40676 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhIUNfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:35:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0DB42212C;
        Tue, 21 Sep 2021 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632231255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dz5qSW/vIE0C9b96WRqJrDiPaO441jP3yZ4XrNvQgCA=;
        b=bOB9cM999mRlGL1qCQRlCOcNnqL0GisdAByfT7efFGq79RUATPcJWLHr3N75MsBiiN70E2
        eQCqPTRCekXVMVJoc3kW7OM9gjPzHVTc1ZKTBwXmJJ1S75ZEm1JponC6MAntDhNp4/wIO9
        unYyVBrh6Wt8Uugc4sB2/mRiQnjL990=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632231255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dz5qSW/vIE0C9b96WRqJrDiPaO441jP3yZ4XrNvQgCA=;
        b=ZAWJGzdMkElo0sT9uf1r1b4V1ylafQ+GmzMzOHXcoqijmL6lnmodlvqfNvOoxmmkth0uRL
        Xrg5US4lmBXGuQAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D30E13BD1;
        Tue, 21 Sep 2021 13:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PQulCVffSWFDQgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 21 Sep 2021 13:34:15 +0000
Date:   Tue, 21 Sep 2021 15:34:13 +0200
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
Message-ID: <YUnfVVjDhLNMSigV@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210921130127.24131-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921130127.24131-1-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richie,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

Kind regards,
Petr
