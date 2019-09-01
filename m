Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171D7A478D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 07:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfIAFvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 01:51:50 -0400
Received: from sonic303-23.consmr.mail.gq1.yahoo.com ([98.137.64.204]:46495
        "EHLO sonic303-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbfIAFvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 01:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567317108; bh=8vuTTgilnndAay+1QQhKe0yY1WR62jcI88iV2uYpBWI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kdZcaoW15p6mDZzbSEdi+fMRDYamfJ7wHFN2NMHnGVvOaCMsSu478b3Cs42vYZGNkk8uXIKoNqGU9LVvGVKIIrKGp9KwLiHA/Fzu9qUAIR97djtpO6u3uI9rr2NRzcG6bWz6XSrFsnVm7TLK0N/eK0CplNUnZ/JxKiWE6pM5UtiU2sKY9MwKTiNWVMd55gPixuE05cnnm1o0T1UY4Bf91c+kwCps5xZvPvpDubYjE+q1P0Imx1qV7PMGxwjKuQmwd73Hh74R9aX0YHITuxTN+YnbfW5/tZpCgZYFBbrS4tG7a12DpXGEpumGer/A5lCndt1VURj007XLdMJ/MmZbdA==
X-YMail-OSG: vcTN0YUVM1l1H75oH9NnT74c_r398x0WEkE3foLHiahdtX7wph9UuQPnnfJ123X
 1aOj20tzQ4E5076QEZZwrtfYtCwsTft.Qg80X2j9j2.DDTMs2JvLBghd9qNwzWHn_OHies2KhtwB
 EzbVLHqGRiSC8Bf5KFfe3cs3RKkbbtC8o8DHnFpwmylivsqo4muUOCqnj8kJppv3AgtXQSvt8SKq
 pluH0eKwZT5LS4sNeV85qU6ap.YTzCbl_fDMEPZf1PHazWepyNr7Nwmiou7CdE7Pxq.bL0DOM_FN
 ZrJAY8a822JP1zfsOH.k2oml6y5kVKMl.zdhx6obsojtnM4mthEetWrlbZz0qlx8dLpLfK0sZPC1
 Um1eModXM1XiXvaT2TCAyFoMSBLY0jbQclCiWy6CvXb_nH5TC_2QfvMzHhNZdCOiYKAA2UpwR11U
 0qR27uH9QT4rBbptEL_MCHxW5iQ1usL5qj87KP7bw6cNvB4aQljPf2I.WYYTVnGz.DfPsVkuBahQ
 yPCIhzrZvBR6X94NbLPBeTmIh2EIVK1nJVGaeFswrN0pZ8v5A3GcMz54rdVo1GUdJUGe1jfs.D.C
 6wys0b1fikCMq4h5POYomNIipRxyF5Arg0xMNBZ3ios7Z4qte4O55ek86WeMXfe8KZPMaF.fzgIQ
 UBvifBZLy5M.B_.jhRwaNwR0S6dFo09p2SToeWwCrAShHthW9CUhAbt5UwhsuZFqvz8ePqndXenC
 qQzaBsfVS7fhm4Ok2HZq50nhH5g54K0oYI_5AwrUnAg8Ag4kf2LpFdXE71ljwxcDNBAOi2BfP9mt
 k6B_XbOtVGhrCWUxPOtsE7cKFbEpfHCawcaVRoBCkdGaA.JW2szvHsxzKlg20Rq36ZtZRp6tTqtU
 ALBYj4ZJQdeymeVYc3kczLvwUrKxxhkICvv_Yi8z9IAXnZTTeWVCx_1UyMFnzxagf4pEKClchwEc
 mcUBISF2YbcMV6ViQQk5Dqk6uA9z7WA_oTBmOgMweGvUWCO9MCXyFIruVETxZr941lHBbwpOB0m9
 8zDNMMuvMcmM47WuO_nVgn2qj5ELVSPw5oZ.BsJTe59jFWK5qLf16fvyY4myz_Zq.zz7BC3pBZH5
 EwCpeQGiEU.Q9XfNiLMWscN.6qcIYrW5iri3RUAiTOi8VHkiCqp.uOPbDOYuyi83nf36wMzSwTDH
 iIiQQpaEq4TtLOsDoJ.DxSQBYocpBBXHTZKLEHw5z9fopkpKPqLVytJQl4KuKu5kKfotyUffESQA
 nvkk1zW_EoXVW4hNWfFcXcQRScSs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:51:48 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 426e3b5ec1af9e36f409445c51071a70;
          Sun, 01 Sep 2019 05:51:46 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@aol.com>
Subject: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Date:   Sun,  1 Sep 2019 13:51:09 +0800
Message-Id: <20190901055130.30572-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802125347.166018-1-gaoxiang25@huawei.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patchset is based on the following patch by Pratik Shinde,
https://lore.kernel.org/linux-erofs/20190830095615.10995-1-pratikshinde320@gmail.com/

All patches addressing Christoph's comments on v6, which are trivial,
most deleted code are from erofs specific fault injection, which was
followed f2fs and previously discussed in earlier topic [1], but
let's follow what Christoph's said now.

Comments and suggestions are welcome...

[1] https://lore.kernel.org/r/1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org/

Thanks,
Gao Xiang

Gao Xiang (21):
  erofs: remove all the byte offset comments
  erofs: on-disk format should have explicitly assigned numbers
  erofs: some macros are much more readable as a function
  erofs: kill __packed for on-disk structures
  erofs: update erofs_inode_is_data_compressed helper
  erofs: kill erofs_{init,exit}_inode_cache
  erofs: use erofs_inode naming
  erofs: update comments in inode.c
  erofs: update erofs symlink stuffs
  erofs: kill is_inode_layout_compression()
  erofs: use dsb instead of layout for ondisk super_block
  erofs: kill verbose debug info in erofs_fill_super
  erofs: simplify erofs_grab_bio() since bio_alloc() never fail
  erofs: kill prio and nofail of erofs_get_meta_page()
  erofs: kill __submit_bio()
  erofs: kill magic underscores
  erofs: use a switch statement when dealing with the file modes
  erofs: add "erofs_" prefix for common and short functions
  erofs: kill all erofs specific fault injection
  erofs: kill use_vmap module parameter
  erofs: save one level of indentation

 Documentation/filesystems/erofs.txt |   9 --
 fs/erofs/Kconfig                    |   7 --
 fs/erofs/data.c                     |  62 +++-------
 fs/erofs/decompressor.c             |  34 ++---
 fs/erofs/dir.c                      |   6 +-
 fs/erofs/erofs_fs.h                 | 162 ++++++++++++------------
 fs/erofs/inode.c                    | 176 +++++++++++++-------------
 fs/erofs/internal.h                 | 156 +++--------------------
 fs/erofs/namei.c                    |  12 +-
 fs/erofs/super.c                    | 185 ++++++++--------------------
 fs/erofs/xattr.c                    |  33 +++--
 fs/erofs/xattr.h                    |   4 +-
 fs/erofs/zdata.c                    |  44 +++----
 fs/erofs/zmap.c                     |  32 ++---
 include/trace/events/erofs.h        |  14 +--
 15 files changed, 338 insertions(+), 598 deletions(-)

-- 
2.17.1

