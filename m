Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57064319C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhJRMsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 08:48:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44276 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhJRMsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:48:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 188D12195B;
        Mon, 18 Oct 2021 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634561180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQdSuFSsooLvSPFpvKR2RlTvzvkZ8DDqKYLxxulprc0=;
        b=tPEQQ4LgP/zBNCOlrvK/UnmI14BhCrVmHKGciYwLg2oGKkyFCNoHd2SmPwhIGF8+ZP4Lpu
        OpDQr3w8jjz/2qs/U5UjtEDWayPGApD++bnoK0oGWltIdfvE8enb7GOrGF3nyyXBm2f84c
        BtiZKP11BR1KKWc0gepI8WDheDccI3Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C859C13D41;
        Mon, 18 Oct 2021 12:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FhJoLptsbWEZRgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Oct 2021 12:46:19 +0000
Subject: Re: [PATCH v11 10/14] btrfs: add send stream v2 definitions
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <ed4dc1c414a6662831e7443335065cb37dddad91.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3c185923-3ab3-2248-0c6d-481572541fe9@suse.com>
Date:   Mon, 18 Oct 2021 15:46:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ed4dc1c414a6662831e7443335065cb37dddad91.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This adds the definitions of the new commands for send stream version 2
> and their respective attributes: fallocate, FS_IOC_SETFLAGS (a.k.a.
> chattr), and encoded writes. It also documents two changes to the send
> stream format in v2: the receiver shouldn't assume a maximum command
> size, and the DATA attribute is encoded differently to allow for writes
> larger than 64k. These will be implemented in subsequent changes, and
> then the ioctl will accept the new flags.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

