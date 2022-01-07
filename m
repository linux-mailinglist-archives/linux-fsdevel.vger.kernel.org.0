Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27049487892
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 14:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347691AbiAGNwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 08:52:42 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35862 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347679AbiAGNwm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:52:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A154ACE2AF3
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jan 2022 13:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95481C36AE0;
        Fri,  7 Jan 2022 13:52:37 +0000 (UTC)
Date:   Fri, 7 Jan 2022 14:52:29 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v6 1/6] initramfs: refactor do_header() cpio magic checks
Message-ID: <20220107135229.d3moxxff3clzslrr@wittgenstein>
References: <20220107133814.32655-1-ddiss@suse.de>
 <20220107133814.32655-2-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220107133814.32655-2-ddiss@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 02:38:09PM +0100, David Disseldorp wrote:
> do_header() is called for each cpio entry and fails if the first six
> bytes don't match "newc" magic. The magic check includes a special case
> error message if POSIX.1 ASCII (cpio -H odc) magic is detected. This
> special case POSIX.1 check can be nested under the "newc" mismatch code
> path to avoid calling memcmp() twice in a non-error case.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> Reviewed-by: Martin Wilck <mwilck@suse.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
