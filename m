Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1795644631B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Nov 2021 13:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhKEMGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 08:06:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58996 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhKEMGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:06:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F016B2177B;
        Fri,  5 Nov 2021 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636113811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inLEKYY0L4MKzHSEYGhxudpIeKf0XmzB5OYXLvMub9M=;
        b=p00arJMTIN/a6pkTG/pKlwKRnSe4W3ewg7S+Q67qpm5IsHiFd4cPqL6YOMNnMDrYkfurw3
        xEcmMYcNO9+7DK0oR5Lp82ZoGCHISID4u1Ed9D75OU4rmg1K7o3WMgy1NxX94adWD+NS0/
        umefJiiT2KLBvZh9Yak/E8P4x9kkMtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636113811;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inLEKYY0L4MKzHSEYGhxudpIeKf0XmzB5OYXLvMub9M=;
        b=UXSK03KxtDDnAAiGdKBdmqOs5iCLPC4qlNhd40U6r8aVI4izi++A9ptRZ17Dlekl2HN0mo
        euNRliVZwwXlesDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B643513FF4;
        Fri,  5 Nov 2021 12:03:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xcLlKpMdhWEZOwAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 05 Nov 2021 12:03:31 +0000
Date:   Fri, 5 Nov 2021 13:03:30 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v3 0/5]: initramfs: "crc" cpio format and
 INITRAMFS_PRESERVE_MTIME
Message-ID: <20211105130330.49a783c6@suse.de>
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

Ping again. I still think this patchset is worthwhile... Any feedback?

Cheers, David
