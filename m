Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999E146849B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354805AbhLDMAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 07:00:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59426 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351073AbhLDMAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:00:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A81FA60C14;
        Sat,  4 Dec 2021 11:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65251C341C4;
        Sat,  4 Dec 2021 11:57:18 +0000 (UTC)
Date:   Sat, 4 Dec 2021 12:57:14 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hao Li <lihao2018.fnst@cn.fujitsu.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/dcache: avoid unused-function warning
Message-ID: <20211204115714.kle6llg6ndmslt3q@wittgenstein>
References: <20211203190123.874239-1-arnd@kernel.org>
 <20211203190123.874239-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211203190123.874239-2-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 03, 2021 at 08:01:02PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Now that 'dentry_stat' is marked 'static', we can run into this warning:
> 
> fs/dcache.c:128:29: error: 'dentry_stat' defined but not used [-Werror=unused-variable]
>   128 | static struct dentry_stat_t dentry_stat = {
> 
> Hide it in the same #ifdef as its only references.
> 
> Fixes: f0eea17ca8da ("fs: move dcache sysctls to its own file")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
