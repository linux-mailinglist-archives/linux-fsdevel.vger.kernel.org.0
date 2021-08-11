Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BFA3E8CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhHKJLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 05:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235282AbhHKJLN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:11:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A4E260F11;
        Wed, 11 Aug 2021 09:10:49 +0000 (UTC)
Date:   Wed, 11 Aug 2021 11:10:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: stop using seq_get_buf in proc_task_name
Message-ID: <20210811091046.n5rft5gruotit2bf@wittgenstein>
References: <20210810151945.1795567-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210810151945.1795567-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 05:19:45PM +0200, Christoph Hellwig wrote:
> Use seq_escape_str and seq_printf instead of poking holes into the
> seq_file abstraction.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Thanks! Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
