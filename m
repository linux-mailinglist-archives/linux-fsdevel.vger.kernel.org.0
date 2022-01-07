Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF30487757
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 13:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiAGMGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 07:06:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47916 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiAGMGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:06:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8623E61538;
        Fri,  7 Jan 2022 12:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F0AC36AE5;
        Fri,  7 Jan 2022 12:06:22 +0000 (UTC)
Date:   Fri, 7 Jan 2022 13:06:19 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH] fs/pipe: local vars has to match types of proper
 pipe_inode_info fields
Message-ID: <20220107120619.zueev37fhuvq3k6i@wittgenstein>
References: <20220106171946.36128-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220106171946.36128-1-avagin@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 06, 2022 at 09:19:46AM -0800, Andrei Vagin wrote:
> head, tail, ring_size are declared as unsigned int, so all local
> variables that operate with these fields have to be unsigned to avoid
> signed integer overflow.
> 
> Right now, it isn't an issue because the maximum pipe size is limited by
> 1U<<31.
> 
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Suggested-by: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
