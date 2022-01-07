Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5935487873
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 14:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347655AbiAGNqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 08:46:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52164 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347641AbiAGNqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:46:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 605E7B82527
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jan 2022 13:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0529C36AE5;
        Fri,  7 Jan 2022 13:46:13 +0000 (UTC)
Date:   Fri, 7 Jan 2022 14:46:10 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v6 2/6] initramfs: make dir_entry.name a flexible array
 member
Message-ID: <20220107134610.nblped3mthhoknd5@wittgenstein>
References: <20220107133814.32655-1-ddiss@suse.de>
 <20220107133814.32655-3-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220107133814.32655-3-ddiss@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 02:38:10PM +0100, David Disseldorp wrote:
> dir_entry.name is currently allocated via a separate kstrdup(). Change
> it to a flexible array member and allocate it along with struct
> dir_entry.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---

Seems good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
