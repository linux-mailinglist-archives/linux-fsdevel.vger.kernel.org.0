Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948E1515DD8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiD3NxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiD3NxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:53:06 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42A6D66CBC;
        Sat, 30 Apr 2022 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HoFZI
        NC4aFfCbd4HhSrPARXqzc6R21KBitpAHIryZhY=; b=o0tsFvfAcrcQlkQiuULQo
        3BN5FkfyfmtSHss9SIn3I6vWYVJNRk/H/Gj0PYEctE3QZPlSu3P7tXciRyfYxHGQ
        Jx8i8TPex9DxcDLPLVQ1g+zfYajGPhuIx/R1WFEo9a77T6/vmqebubJ8d+6eSod6
        SbVIkFR20brEkcFBl1xaUY=
Received: from localhost (unknown [120.229.67.207])
        by smtp11 (Coremail) with SMTP id D8CowAAnj58aPm1if+mzAA--.19060S2;
        Sat, 30 Apr 2022 21:48:11 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     willy@infradead.org, Junwen Wu <wudaemon@163.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, ddiss@suse.de,
        fweimer@redhat.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] proc: limit schedstate node write operation
Date:   Sat, 30 Apr 2022 13:48:04 +0000
Message-Id: <YmWjpWWdwN0qxFSR@casper.infradead.org> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YmNs+i/unWKvj4Kx@casper.infradead.org>
References: <YmWjpWWdwN0qxFSR@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAnj58aPm1if+mzAA--.19060S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1kArWxAw15Zr1DuFyDJrb_yoW3KrbE9w
        15J3sxu34jqFn5KFZFkr4Yqr1ag3y8GFWDW3ykZrnrXrZ8AFWvgF17KrZ5ZF1fXrsrJrn8
        CrnYvFWq9Fyj9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjDPE5UUUUU==
X-Originating-IP: [120.229.67.207]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisRzybVXlppCxtAAAsx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox <willy@infradead.org>

On Sun, Apr 24, 2022 at 03:23:54PM +0000, Junwen Wu wrote:
> From: Matthew Wilcox <willy@infradead.org>
> 
> On Sat, Apr 23, 2022 at 02:31:04AM +0000, Junwen Wu wrote:
> > Whatever value is written to /proc/$pid/sched, a task's schedstate data
> > will reset.In some cases, schedstate will drop by accident. We restrict
> > writing a certain value to this node before the data is reset.
> 
> ... and break the existing scripts which expect the current behaviour.
> 
> 
> Hi, Matthew,can you describe it in more detail.

> What detail do you need?  Existing scripts depend on the existing
> behaviour.  Your change to the behaviour will break them.  That's not
> allowed, so your patch is rejected.

ooh ,just how to operate the node make the script break. I write data to
this node can work well.

Thanks

