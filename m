Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24857428AEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 12:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhJKKnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 06:43:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44622 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbhJKKnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:43:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7ADB20051;
        Mon, 11 Oct 2021 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633948877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7uYzxX5pDrFQTY/NfWWInHzTcq1Hw/TEfxOF6zynUpY=;
        b=EHXI+lm2m789h1nPpgtwFHsmSNQWqxicJzWSyZJKhAVCSlYwgSws/Xg9xZkSDqnUkq3Zau
        4IDBIsPb07lotxkjJaiSuRkuNWT9Ug8c3awrpYNYpJfAKmYok84SWIjQPgcuGRXeAVOVLj
        KeSr6tYsnNJIMvqvfFy27QnPUKo6lUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633948877;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7uYzxX5pDrFQTY/NfWWInHzTcq1Hw/TEfxOF6zynUpY=;
        b=aqq7DpwAi5HokEQgj46VAFnh1VG+ASreELCqTpETd8dj3jXPNiTBjpW6oSjgruS8UtgDhN
        7kHcexwDWtA1b8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B248213C4C;
        Mon, 11 Oct 2021 10:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ryf5Kc0UZGFPPwAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 11 Oct 2021 10:41:17 +0000
Date:   Mon, 11 Oct 2021 12:41:16 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v3 0/5]: initramfs: "crc" cpio format and
 INITRAMFS_PRESERVE_MTIME
Message-ID: <20211011124116.66d01f4d@suse.de>
In-Reply-To: <20211001134256.5581-1-ddiss@suse.de>
References: <20211001134256.5581-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  1 Oct 2021 15:42:51 +0200, David Disseldorp wrote:

> This patchset does some minor refactoring of cpio header magic checking
> and corrects documentation.
> Patches 4/5 and 5/5 allow cpio entry mtime preservation to be disabled
> via a new INITRAMFS_PRESERVE_MTIME Kconfig option.

Ping, any feedback for these changes?

Cheers, David
