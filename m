Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E944E17D484
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2020 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCHPqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Mar 2020 11:46:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbgCHPqJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:46:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B9C7A421F7899F3EB101
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2020 23:45:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.253.249) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sun, 8 Mar 2020
 23:45:51 +0800
To:     Miklos Szeredi <miklos@szeredi.hu>
From:   piaojun <piaojun@huawei.com>
Subject: [QUESTION] How to enlarge the max write pages of fuse request
CC:     <linux-fsdevel@vger.kernel.org>
Message-ID: <5E651328.4090305@huawei.com>
Date:   Sun, 8 Mar 2020 23:45:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

I want to enlarge the fuse request's bufsize from 128K to 1MB for more
bandwidth as follows, but it does not work.

1. In libfuse, setting fuse_init_out:
outarg->max_write = 1024 * 1024; // 1MB
outarg->max_pages = 256; // 1MB

2. In kernel, fuse_send_write just handle 4B once a time, and failed at
last despite 'req->max_pages' is already set to 256. I wonder if some
more adaption needed or I just went the wrong way? Looking forward to
your rely.

Thanks,
Jun

