Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5D45C3E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351075AbhKXNol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 08:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353548AbhKXNnb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 08:43:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE38861131;
        Wed, 24 Nov 2021 12:58:53 +0000 (UTC)
Date:   Wed, 24 Nov 2021 13:58:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] proc: remove PDE_DATA() completely
Message-ID: <20211124125850.p4tdywo4nmngmzaz@wittgenstein>
References: <20211124081956.87711-1-songmuchun@bytedance.com>
 <20211124081956.87711-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211124081956.87711-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:19:56PM +0800, Muchun Song wrote:
> Remove PDE_DATA() completely and replace it with pde_data().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---

Does this survive an allmodconfig build?
(I hope you used either git sed or a cocci script for this. :))
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
