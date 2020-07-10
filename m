Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C939F21B39B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGJLF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 07:05:58 -0400
Received: from nautica.notk.org ([91.121.71.147]:53207 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGJLF4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:05:56 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 5DFF1C009; Fri, 10 Jul 2020 13:05:51 +0200 (CEST)
Date:   Fri, 10 Jul 2020 13:05:36 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND] 9p: Fix memory leak in v9fs_mount
Message-ID: <20200710110536.GA17924@nautica>
References: <20200615012153.89538-1-zhengbin13@huawei.com>
 <20200615102053.GA11026@nautica>
 <ae01f0bd-da0a-f01f-cbd0-3af10ccaa4ae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae01f0bd-da0a-f01f-cbd0-3af10ccaa4ae@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zhengbin (OSKernel) wrote on Thu, Jul 09, 2020:
> Is this OK? I don't see it on linux-next

Yes, I just (still) haven't tested them, sorry.
It's in git://github.com/martinetd/linux branch 9p-test

-- 
Dominique
