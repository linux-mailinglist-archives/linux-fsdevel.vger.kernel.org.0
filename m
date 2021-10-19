Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB37F432ECB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 09:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhJSHEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 03:04:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbhJSHEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:04:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B64C41FD8C;
        Tue, 19 Oct 2021 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634626915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTtghidN1tUht75ypA/9k1IWjUIifPJNlq2l4MCWTHo=;
        b=nGsMcbU1JJj5K719zTU3ugI777aw8gwk3L1cXY30VtMjqAX84b+w7YImZVmievlc3TQBJj
        DG3dDan19ZAsWUUeu3XTr/EseDwk4b6PrRF11+qVyOqEajnXx9ON3comHmkO+L2H/zrlNH
        +sGCrLQo2ujvs4NjibUFfPRLVPa/qog=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6497313F09;
        Tue, 19 Oct 2021 07:01:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T51BFWNtbmHmYwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 19 Oct 2021 07:01:55 +0000
Subject: Re: [PATCH v11 10/14] btrfs: add send stream v2 definitions
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <ed4dc1c414a6662831e7443335065cb37dddad91.1630514529.git.osandov@fb.com>
 <f94e2e0d-0cf9-1c9d-0dfb-b21438fe852d@suse.com>
 <YW3DvJBzV1exIF6Q@relinquished.localdomain>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <63d6f4db-be5d-8502-33c8-6944368685a1@suse.com>
Date:   Tue, 19 Oct 2021 10:01:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YW3DvJBzV1exIF6Q@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 18.10.21 г. 21:58, Omar Sandoval wrote:
> I suppose I could do something like this, is that what you had in mind?


Yes, however I think it needs to be augmented a bit like making this
member populated/checked only if V2 is being used? But that's generally
what I had in mind.
