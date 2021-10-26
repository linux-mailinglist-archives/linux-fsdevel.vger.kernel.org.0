Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534E843B3B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhJZOOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 10:14:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36654 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236431AbhJZOOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:14:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Utn9eYf_1635257537;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Utn9eYf_1635257537)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Oct 2021 22:12:18 +0800
To:     Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <djwong@kernel.org>, ira.weiny@intel.com
Cc:     linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Vivek Goyal <vgoyal@redhat.com>, Christoph Hellwig <hch@lst.de>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Subject: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
Date:   Tue, 26 Oct 2021 22:12:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Recently I'm working on supporting per-file DAX for virtiofs [1]. Vivek
Goyal and I are interested [2] why the default behavior has changed
since introduction of per-file DAX on ext4 and xfs [3][4].

That is, before the introduction of per-file DAX, when user doesn't
specify '-o dax', DAX is disabled for all files. After supporting
per-file DAX, when neither '-o dax' nor '-o dax=always|inode|never' is
specified, it actually works in a '-o dax=inode' way if the underlying
blkdev is DAX capable, i.e. depending on the persistent inode flag. That
is, the default behavior has changed from user's perspective.

We are not sure if this is intentional or not. Appreciate if anyone
could offer some hint.


[1] https://lore.kernel.org/all/YW2Oj4FrIB8do3zX@redhat.com/T/
[2]
https://lore.kernel.org/all/YW2Oj4FrIB8do3zX@redhat.com/T/#mf067498887ca2023c64c8b8f6aec879557eb28f8
[3] 9cb20f94afcd2964944f9468e38da736ee855b19 ("fs/ext4: Make DAX mount
option a tri-state")
[4] 02beb2686ff964884756c581d513e103542dcc6a ("fs/xfs: Make DAX mount
option a tri-state")


-- 
Thanks,
Jeffle
