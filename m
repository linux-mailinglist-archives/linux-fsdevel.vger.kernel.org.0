Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F343F0956
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhHRQkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 12:40:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41442 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhHRQky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:40:54 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C7DA2206D;
        Wed, 18 Aug 2021 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629304818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fs+nmWMlPFAnBSmFFC7SBLxg9kEBC0nXvEG9WVq/PXI=;
        b=H2j8At3ZIM1+6tU9Zkp6M3MZUJjHgvoObBDvJqmhjTWBWQUoen2y+Jv8wKA8LXaFTdtWcU
        9KAZj+bWG1UJ+/c2lBeDICQP3E7neGmwbpUfjc8/a+jHdEMe/YoSJgmtCIULpkZdZWk6zw
        0+ZJFlsbqLWgfNq94I0GuiVpRt6S7os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629304818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fs+nmWMlPFAnBSmFFC7SBLxg9kEBC0nXvEG9WVq/PXI=;
        b=vPtDoXX8Hy/80BmOoIU0aTbh0qLF0wpfSi7Di6hze0LEo4dlPXsjYTBY47Kwcg4r1Dm/c7
        0KSuwOsQJuRrAjCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 55FBD137C0;
        Wed, 18 Aug 2021 16:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xeyCE/I3HWGSEgAAGKfGzw
        (envelope-from <ddiss@suse.de>); Wed, 18 Aug 2021 16:40:18 +0000
Date:   Wed, 18 Aug 2021 18:40:16 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] exfat: allow access to paths with trailing dots
Message-ID: <20210818184016.2631aeae@suse.de>
In-Reply-To: <20210818124835.pdlq25wf7wdn2x57@wittgenstein>
References: <20210818111123.19818-1-ddiss@suse.de>
        <20210818124835.pdlq25wf7wdn2x57@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Aug 2021 14:48:35 +0200, Christian Brauner wrote:

> On Wed, Aug 18, 2021 at 01:11:21PM +0200, David Disseldorp wrote:
> > This patchset adds a new exfat "keeptail" mount option, which allows
> > users to resolve paths carrying trailing period '.' characters.
> > I'm not a huge fan of "keeptail" as an option name, but couldn't think
> > of anything better.  
> 
> I wouldn't use "period". The vfs uses "dot" and "dotdot" as seen in e.g.
> LAST_DOT or LAST_DOTOT. Maybe "keep_last_dot"?

Works for me, although I was under the impression that underscores were
avoided for mount options. Also, I think it'd be clearer as the plural
"keep_last_dots".

Cheers, David
