Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEEE22F7EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgG0SnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 14:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgG0SnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:43:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6CC061794;
        Mon, 27 Jul 2020 11:43:17 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k085j-003p8e-WE; Mon, 27 Jul 2020 18:43:16 +0000
Date:   Mon, 27 Jul 2020 19:43:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] binfmt_elf: fix unsigned regset0_size compared to
 less than zero
Message-ID: <20200727184315.GK794331@ZenIV.linux.org.uk>
References: <20200727174054.154765-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727174054.154765-1-colin.king@canonical.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 06:40:54PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable regset0_size is an unsigned int and it is being checked
> for an error by checking if it is less than zero, and hence this
> check is always going to be false.  Fix this by making the variable
> regset0_size signed.

Folded and pushed...
