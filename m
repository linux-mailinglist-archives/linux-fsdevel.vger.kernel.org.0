Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785D54316E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 13:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJRLMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 07:12:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44958 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRLMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:12:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 066041FD79;
        Mon, 18 Oct 2021 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634555404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmFWWTxLru0FFDyFNahu7eQU4Qn5Tk89QoI5XxFGA3k=;
        b=FOy2N6fNR5sACCaSTXfHbcU/vQqj4CT5w3SMKPT1eRK+wznKTHyq99NXLrnhgtadPDynmY
        LqX/dLEmwKXA6FhaRpXQdm+Ly46sqJ8XKHUZfZqibMXIh1dZAKqSyVIOrRSkngcQIYbZ+3
        k/wjURE0WSzOq9Mlvk4eLb7/eTILLrg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7F3513C14;
        Mon, 18 Oct 2021 11:10:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oa2GKgtWbWHhEAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Oct 2021 11:10:03 +0000
Subject: Re: [PATCH v11 12/14] btrfs: send: allocate send buffer with
 alloc_page() and vmap() for v2
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <74a9595599ad41fa5b843473ce6e9d436def210f.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <5807a793-cc15-6d2d-6b80-bf3265dac660@suse.com>
Date:   Mon, 18 Oct 2021 14:10:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <74a9595599ad41fa5b843473ce6e9d436def210f.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> For encoded writes, we need the raw pages for reading compressed data
> directly via a bio. So, replace kvmalloc() with vmap() so we have access
> to the raw pages. 144k is large enough that it usually gets allocated
> with vmalloc(), anyways.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
