Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A12DA7FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 07:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgLOGLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 01:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgLOGKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:10:50 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F45C06179C;
        Mon, 14 Dec 2020 22:10:09 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp3XB-001NO1-IC; Tue, 15 Dec 2020 06:10:05 +0000
Date:   Tue, 15 Dec 2020 06:10:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH] proc: Escape more characters in /proc/mounts output
Message-ID: <20201215061005.GF3579531@ZenIV.linux.org.uk>
References: <20201215042454.998361-1-siddhesh@gotplt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215042454.998361-1-siddhesh@gotplt.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:54:54AM +0530, Siddhesh Poyarekar wrote:

> +	get_user(byte, (const char __user *)data);
> +
> +	return byte ? strndup_user(data, PATH_MAX) : NULL;
>  }

No.  Not to mention anything else, you
	* fetch the same data twice
	* fail to check the get_user() results
