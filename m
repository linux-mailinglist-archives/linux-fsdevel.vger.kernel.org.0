Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD11410D110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 06:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfK2F3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 00:29:42 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53657 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbfK2F3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 00:29:42 -0500
X-IronPort-AV: E=Sophos;i="5.69,256,1571673600"; 
   d="scan'208";a="79253352"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Nov 2019 13:29:39 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B394F4CE14FC;
        Fri, 29 Nov 2019 13:21:12 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 29 Nov 2019 13:29:38 +0800
Subject: Re: [LTP] [PATCH] syscalls/newmount: new test case for new mount API
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>, <ltp@lists.linux.it>
CC:     <linux-fsdevel@vger.kernel.org>
References: <20191128173532.6468-1-zlang@redhat.com>
 <9c487d75-0de0-af8f-a439-d3ce9d965808@cn.fujitsu.com>
Message-ID: <fa006742-d29d-4d19-c628-30b0454c8f72@cn.fujitsu.com>
Date:   Fri, 29 Nov 2019 13:29:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <9c487d75-0de0-af8f-a439-d3ce9d965808@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: B394F4CE14FC.AEC16
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



on 2019/11/29 11:39, Yang Xu wrote:
> --- /dev/null
> +++ b/include/lapi/newmount.h
> @@ -0,0 +1,106 @@
> +/*
> + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#ifndef __NEWMOUNT_H__
> +#define __NEWMOUNT_H__
> +
> +#include <stdint.h>
> +#include <unistd.h>
> +#include "lapi/syscalls.h"
> +
> +#if !defined(HAVE_FSOPEN)
When we run make autotools and ./configure, this macro is in 
"include/config.h". You should include this header file like other lapi 
files.
> +static inline int fsopen(const char *fs_name, unsigned int flags)
> +{


