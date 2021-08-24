Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51303F5D01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhHXLSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 07:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236471AbhHXLSq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:18:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 321C86120A;
        Tue, 24 Aug 2021 11:17:58 +0000 (UTC)
Date:   Tue, 24 Aug 2021 13:17:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/6] fs/ntfs3: Remove unnecesarry mount option noatime
Message-ID: <20210824111755.cuoou3cvnxvj4sac@wittgenstein>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-2-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-2-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 03:26:28AM +0300, Kari Argillander wrote:
> Remove unnecesarry mount option noatime because this will be handled
> by VFS. Our option parser will never get opt like this.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---

Looks good. Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
