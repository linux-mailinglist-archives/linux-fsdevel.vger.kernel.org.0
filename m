Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929BE3F42B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 02:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhHWA5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 20:57:45 -0400
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:48191 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhHWA5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 20:57:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1628733|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.140926-0.00254726-0.856527;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.L6VWebn_1629680219;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.L6VWebn_1629680219)
          by smtp.aliyun-inc.com(10.147.40.233);
          Mon, 23 Aug 2021 08:56:59 +0800
Date:   Mon, 23 Aug 2021 08:57:00 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
Cc:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
In-Reply-To: <20210819021910.GB29026@hungrycats.org>
References: <162932318266.9892.13600254282844823374@noble.neil.brown.name> <20210819021910.GB29026@hungrycats.org>
Message-Id: <20210823085658.0ABE.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> rsync -H and cpio's hardlink detection can be badly confused.  They will
> think distinct files with the same inode number are hardlinks.  This could
> be bad if you were making backups (though if you're making backups over
> NFS, you are probably doing something that could be done better in a
> different way).

'rysnc -x ' and 'find -mount/-xdev' will fail to work in
snapper config?
snapper is a very important user case.

Although  yet not some option like '-mount/-xdev' for '/bin/cp',
but maybe come soon.

I though the first patchset( crossmnt in nfs client) is the right way,
because in most case, subvol is a filesystem, not  a directory.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/08/23




