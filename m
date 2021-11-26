Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22845EBE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 11:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhKZKwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 05:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236394AbhKZKuh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:50:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90A1F601FF;
        Fri, 26 Nov 2021 10:47:23 +0000 (UTC)
Date:   Fri, 26 Nov 2021 11:47:20 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com
Subject: Re: [PATCH] exfat: move super block magic number to magic.h
Message-ID: <20211126104720.hprddvogsnl7heye@wittgenstein>
References: <20211125122125.6564-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211125122125.6564-1-linkinjeon@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 09:21:25PM +0900, Namjae Jeon wrote:
> Move exfat superblock magic number from local definition to magic.h. 
> It is also needed by userspace programs that call fstatfs().
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
