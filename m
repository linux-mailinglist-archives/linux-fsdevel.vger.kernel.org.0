Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04242492C40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 18:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346973AbiARRZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 12:25:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58676 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243633AbiARRZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:25:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 027631F3B5;
        Tue, 18 Jan 2022 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642526743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiezLhDBKqAsWLi6gm10m7XokcstGprj+9tuWvvQhsk=;
        b=yunBoXD59wcdMOdC6jSlp6grM4HDP84gSfaEKLGK/grrlsWi2uu6vt+LKSZwvVcV8jDIL8
        Rs8lqPawv9e4c4L8LLCiBFcgDs/9H4LkrAHaiZx2fVAkbGf+bZJJkXOa60ooS6G1ZOwWq+
        K+MnPQcmPr8gV3aYe/9bdodZn7upewA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642526743;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiezLhDBKqAsWLi6gm10m7XokcstGprj+9tuWvvQhsk=;
        b=/Tzvd+GjJ4ZTY3qiCq3rukhQ7hdMdbSlcbarH6Y2uVrAn6xgpRe9wjfhRgzgkqZWiwfUCg
        vIBxESx1p4ks/rCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD98D13DC8;
        Tue, 18 Jan 2022 17:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ayNDLBb45mH9IQAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 18 Jan 2022 17:25:42 +0000
Date:   Tue, 18 Jan 2022 18:25:41 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     viro@zeniv.linux.org.uk, willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v6 0/6] initramfs: "crc" cpio format and
 INITRAMFS_PRESERVE_MTIME
Message-ID: <20220118182541.3e454a94@suse.de>
In-Reply-To: <20220107133814.32655-1-ddiss@suse.de>
References: <20220107133814.32655-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  7 Jan 2022 14:38:08 +0100, David Disseldorp wrote:

> This patchset does some minor initramfs refactoring and allows cpio
> entry mtime preservation to be disabled via a new Kconfig
> INITRAMFS_PRESERVE_MTIME option.
> Patches 4/6 to 6/6 implement support for creation and extraction of
> "crc" cpio archives, which carry file data checksums. Basic tests for
> this functionality can be found at
> Link: https://github.com/rapido-linux/rapido/pull/163

Ping, anything I can do to help move this patchset along?
