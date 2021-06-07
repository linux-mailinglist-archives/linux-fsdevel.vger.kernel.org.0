Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F439D2F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhFGCaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 22:30:24 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:56572 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230139AbhFGCaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:30:24 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E3821100E7B40;
        Mon,  7 Jun 2021 02:28:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 1506F240235;
        Mon,  7 Jun 2021 02:28:30 +0000 (UTC)
Message-ID: <9116a85a80cf253aba94257f6eac5c15ebc6fd88.camel@perches.com>
Subject: Re: [PATCH] fs: pnode: Fix a typo
From:   Joe Perches <joe@perches.com>
To:     lijian_8010a29@163.com, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Date:   Sun, 06 Jun 2021 19:28:29 -0700
In-Reply-To: <20210607022456.66124-1-lijian_8010a29@163.com>
References: <20210607022456.66124-1-lijian_8010a29@163.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1506F240235
X-Spam-Status: No, score=4.10
X-Stat-Signature: rbsikraggg4kxgjaj6kdgp3sgnz4be7g
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Ev54UeVXHIf3yHYkqRQqsoo5BoSMmeuM=
X-HE-Tag: 1623032910-367149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-07 at 10:24 +0800, lijian_8010a29@163.com wrote:
> From: lijian <lijian@yulong.com>
> 
> Change 'accross' to 'across'.
[]
> diff --git a/fs/pnode.c b/fs/pnode.c
[]
> @@ -573,7 +573,7 @@ int propagate_umount(struct list_head *list)
>  				continue;
>  			} else if (child->mnt.mnt_flags & MNT_UMOUNT) {
>  				/*
> -				 * We have come accross an partially unmounted
> +				 * We have come across an partially unmounted

perhaps fix the an/a mismatch too

				 * We have come across a partially unmounted


