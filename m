Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90A494A17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359472AbiATIvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:51:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46446 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbiATIvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:51:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3EAF6178E;
        Thu, 20 Jan 2022 08:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DF4C340E0;
        Thu, 20 Jan 2022 08:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642668697;
        bh=dkLdf3lbzd0Tp2Q+IWqLFX0sC22K1J2jFtMc7CnCQxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AihWf4BZBf00zTG6mlZh81sc2cXytbv4+OvwS2THDWGDdcvHpbS0gHrlzhhpFJ+0A
         bVNnrEge9J4sSHwzsqIJhYuXTWGsJ4a6yX1JKhw6mRnTOZGgxV8OcJuYc+id4uvzuF
         WL0Lq8eQGo43wfj5F6ObkvBYZBM9zVpHv0zWgKYBk/sZDNMtxLBbwRytKR3Y46aIfl
         Uv4ZN/R+i5f1Lo/7NYiLEutMXWVpxjG6pvYQvMD+eT+zTi9FOkcUID9K2JiTxhuf9p
         ZNMYqG+pVDMMTO0+H6XmEJ3i9hUgRuRTUDTRCwMagANwIggy0fFO4df5N2iQJqOH/b
         HMmVQ51sHpGrA==
Date:   Thu, 20 Jan 2022 09:51:32 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] pipe: remove redundant assignment to pointer buf
Message-ID: <20220120085132.27w7lwam3tq6yyby@wittgenstein>
References: <20220119225633.147658-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119225633.147658-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 10:56:33PM +0000, Colin Ian King wrote:
> The pointer buf is being assigned a value that is never read, it is
> being re-assigned later on closer to where is it required to be set.
> The assignment is redundant and can be removed. Cleans up clang
> scan build warning:
> 
> fs/pipe.c:490:24: warning: Value stored to 'buf' during its
> initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
