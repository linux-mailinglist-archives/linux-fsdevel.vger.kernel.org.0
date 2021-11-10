Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81E44C17D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 13:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhKJMpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 07:45:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhKJMpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:45:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 36E1021B0E;
        Wed, 10 Nov 2021 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636548177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9m7VW8AvZDd+dfCBrPD+g5xcGnBWyeM74/Dreu1ghw=;
        b=tyWVXEOmr6xqmc9ddN6pwxSLyUjBCU7GSoPIxTGqUqyU6u+FxGQLR/mGKmo1QM8WQH2BPr
        cwFuMZu54qJKHV6WbPRRWeo9lr37K3hw//dLsWV8c0tU9EhEHk0NAAXzMtN2Zxx3D95byd
        UvNgnHUT/DUAQfCjluYHUqCwweI2eqk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1B8E13C13;
        Wed, 10 Nov 2021 12:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ru8TMVC+i2HFBAAAMHmgww
        (envelope-from <mwilck@suse.com>); Wed, 10 Nov 2021 12:42:56 +0000
Message-ID: <4ea6d5f982a389dd11da2e9db9972d946648e5fe.camel@suse.com>
Subject: Re: [PATCH v4 0/4] initramfs: "crc" cpio format and
 INITRAMFS_PRESERVE_MTIME
From:   Martin Wilck <mwilck@suse.com>
To:     David Disseldorp <ddiss@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org
Date:   Wed, 10 Nov 2021 13:42:56 +0100
In-Reply-To: <20211110123850.24956-1-ddiss@suse.de>
References: <20211110123850.24956-1-ddiss@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-11-10 at 13:38 +0100, David Disseldorp wrote:
> This patchset does some minor refactoring of cpio header magic
> checking
> and corrects documentation.
> Patch 4/4 allows cpio entry mtime preservation to be disabled via a
> new
> INITRAMFS_PRESERVE_MTIME Kconfig option.
> 
> Changes since v3, following feedback from Martin Wilck:
> - 4/4: keep vfs_utimes() call in do_copy() path
>   + drop [PATCH v3 4/5] initramfs: use do_utime() wrapper
> consistently
>   + add do_utime_path() helper
>   + clean up timespec64 initialisation
> - 4/4: move all mtime preservation logic to initramfs_mtime.h and
> drop
>   separate .c
> - 4/4: improve commit message
> 
>  .../early-userspace/buffer-format.rst         | 24 +++-----
>  init/Kconfig                                  | 10 ++++
>  init/initramfs.c                              | 57 +++--------------
> --
>  init/initramfs_mtime.h                        | 50 ++++++++++++++++
>  4 files changed, 75 insertions(+), 66 deletions(-)
> 

For the set:

Reviewed-by: Martin Wilck <mwilck@suse.com>


