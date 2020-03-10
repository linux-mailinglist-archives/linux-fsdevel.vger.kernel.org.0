Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAAC17F44A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 11:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgCJKDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 06:03:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgCJKDy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:03:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D89F0864280E2703CCAC
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 18:03:51 +0800 (CST)
Received: from [10.173.111.60] (10.173.111.60) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 10 Mar
 2020 18:03:51 +0800
To:     <miklos@szeredi.hu>
CC:     <linux-fsdevel@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Subject: [RFC][QUESTION] fuse: how to enlarge the max pages per request
Message-ID: <6149dfe9-1389-ada6-05db-eb71b989dcb2@huawei.com>
Date:   Tue, 10 Mar 2020 18:03:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.111.60]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

From my test, a fuse write req can only contain 128KB which seems
limited by FUSE_DEFAULT_MAX_PAGES_PER_REQ in kernel. I wonder if I
could enlarge this macro to get more bandwidth, or some other adaption
should be done?

Up to now, many userspace filesystem is designed for big data which
needs big bandwidth, such as 2MB or more. So could we add a feature to
let the user config the max pages per request? Looking forward for your
reply.

Thanks,
Jun
