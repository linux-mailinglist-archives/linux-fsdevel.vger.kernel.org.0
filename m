Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469D039D396
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 05:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFGDoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 23:44:13 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:41700 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230311AbhFGDoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:44:09 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 35268180A5AE1;
        Mon,  7 Jun 2021 03:42:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 40B721D42F7;
        Mon,  7 Jun 2021 03:41:59 +0000 (UTC)
Message-ID: <ad31080c1f7d474e8c327533a212607821c72dce.camel@perches.com>
Subject: Re: [PATCH] fs: file_table: Fix a typo
From:   Joe Perches <joe@perches.com>
To:     lijian_8010a29@163.com, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Date:   Sun, 06 Jun 2021 20:41:57 -0700
In-Reply-To: <20210607033039.112297-1-lijian_8010a29@163.com>
References: <20210607033039.112297-1-lijian_8010a29@163.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.28
X-Stat-Signature: ice5qg7ry9iwgkpfqiesrhj73tqmiejy
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 40B721D42F7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/dgnFZ5E0DIfOaXupV+Z8s5LI2Fz1hkFI=
X-HE-Tag: 1623037319-563153
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-07 at 11:30 +0800, lijian_8010a29@163.com wrote:
> From: lijian <lijian@yulong.com>
> 
> Change 'happend' to 'happen'.
[]
> diff --git a/fs/file_table.c b/fs/file_table.c
[]
> @@ -121,7 +121,7 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
>  }
>  
> 
>  /* Find an unused file structure and return a pointer to it.
> - * Returns an error pointer if some error happend e.g. we over file
> + * Returns an error pointer if some error happen e.g. we over file

happened


