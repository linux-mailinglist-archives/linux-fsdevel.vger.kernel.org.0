Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30594B5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfHSRKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 13:10:37 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58618 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfHSRKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:10:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4E1CE6083139;
        Mon, 19 Aug 2019 19:10:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1PQhCAiESOU6; Mon, 19 Aug 2019 19:10:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0EF46621FCD3;
        Mon, 19 Aug 2019 19:10:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 50KLyhFl0tO2; Mon, 19 Aug 2019 19:10:33 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D5D506088967;
        Mon, 19 Aug 2019 19:10:33 +0200 (CEST)
Date:   Mon, 19 Aug 2019 19:10:33 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-erofs@lists.ozlabs.org
Cc:     gaoxiang25@huawei.com, linux-fsdevel@vger.kernel.org,
        yuchao0@huawei.com, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
Subject: erofs: Question on unused fields in on-disk structs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Index: bPOHXV7QxwRTyFuSImcS2EHKU0x0Yw==
Thread-Topic: erofs: Question on unused fields in on-disk structs
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

struct erofs_super_block has "checksum" and "features" fields,
but they are not used in the source.
What is the plan for these?

Same for i_checksum in erofs_inode_v1 and erofs_inode_v2.

At least the "features" field in the super block is something I'd
expect to be used.
...such that you can have new filesystem features in future.

Thanks,
//richard
