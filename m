Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26BB97272
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 08:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfHUGmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 02:42:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:59986 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfHUGmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:42:14 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190821064211epoutp02d16b617a92ee0d81c490424925685f22~83Pi8FfkW1260712607epoutp02B
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 06:42:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190821064211epoutp02d16b617a92ee0d81c490424925685f22~83Pi8FfkW1260712607epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566369731;
        bh=6nvViRArjV4omK6peQr/VJEo362MQawOvuOjWNtcvUc=;
        h=From:To:Subject:Date:References:From;
        b=KgvXEC03C4r1U97r7bQ5DRRMTIXhvVfcvuv//kqB9AfekkM1a6r6AlK/dwkzmj1/j
         6Da8kMqM2aSH3vsPYueOGpcP367QkCqp/Un1AsgIkKYcR0YdMlJuZ47ea/iHjqaU9V
         dzZJioeQWALlclkJ5xlW0pzJ4Wntvqon2nNSykqw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190821064210epcas2p2b0753f2c58b6ebb1f39566c7be44018c~83PiaFvVa1369213692epcas2p22;
        Wed, 21 Aug 2019 06:42:10 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.184]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 46Cykl2yFmzMqYkV; Wed, 21 Aug
        2019 06:42:07 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.AD.04156.FB7EC5D5; Wed, 21 Aug 2019 15:42:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821064206epcas2p1d1bcaae142416506bcedb3201d9a6658~83PeydRUI2328923289epcas2p1F;
        Wed, 21 Aug 2019 06:42:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821064206epsmtrp2200b095c38c04c7c0825b9bbdffaf76e~83PesuNc52242122421epsmtrp2E;
        Wed, 21 Aug 2019 06:42:06 +0000 (GMT)
X-AuditID: b6c32a45-df7ff7000000103c-24-5d5ce7bf38af
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.C2.03638.EB7EC5D5; Wed, 21 Aug 2019 15:42:06 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821064206epsmtip198eaffa6242c7b1b17cfbe143230c99b~83PeSZEq23087530875epsmtip17;
        Wed, 21 Aug 2019 06:42:06 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Herbert Xu'" <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Biggers'" <ebiggers@kernel.org>,
        "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        "'Chao Yu'" <chao@kernel.org>,
        "'Jaegeuk Kim'" <jaegeuk@kernel.org>,
        "'Andreas Dilger'" <adilger.kernel@dilger.ca>,
        "'Theodore Ts'o'" <tytso@mit.edu>, <dm-devel@redhat.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>,
        "'Alasdair Kergon'" <agk@redhat.com>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 0/9] Flash Memory Protector Support
Date:   Wed, 21 Aug 2019 15:42:06 +0900
Message-ID: <003c01d557eb$8ca76790$a5f636b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVX55ZGLpDJ2oWzRvaIZpriXB0iug==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf2wTZRjOd9e765DK2VX9qEbq4Yh0rrRlnd+EGhIRzsgfM8Qgc828rJdu
        sb/Sa2HTRFC37ofT6YgySjcGEpCNMrbVucA6cPwozNVFl+JAnIThkE4n7gdJB4i93Yz773nf
        93nyPc/35pXjygZKLS9xenmPk7Mz5CJZ15mVKOvUzQKL/tjRdDQzXSVDbf3ncdT6Sx2Jvvs8
        hqHgYLkMRSb2EijUcw9HHyWeRDfaAjganvUTqG50HEeDg8cp1DF6iUCRK5no15EkhvY0XSXR
        jwc2okTTHRnqiVyUoaETQRKdfVAHUMNgL4b87TMAVdQmKRQNbVm3lA0fuYyx5Z3b2a7TGexQ
        zMd2tFST7NVLPSTbeXAHe7J5CmM/GDiHs3/1xkn2k3ALYKc6nspbnG9fW8xzVt6j4Z1FLmuJ
        02ZmXt1c+FKhKUdvyDLkoucZjZNz8GZm/aa8rA0l9lR2RrONs/tSrTxOEJhVL671uHxeXlPs
        Erxmhndb7W6Dwa0TOIfgc9p0RS7HCwa93mhKMd+yFw8nGgj3cW3p7n0fEztBYlkNSJNDOhv2
        V8aJGrBIrqS7ATwai+NSMQlgW3zffHEHwK7yC2QNkM9JIjGdqFbSEQCH2ldInFsAhn+YBuKA
        pDNhZ7QFiAMV/Q8Fd19rwsVBOr0aVtTeJkQsozPgofq/MREr6Fx4IRgjJfwIvLjnhkzEOL0M
        fvNnEJe8amB3bHzuARWtg/XfjhASRwX3VvvnOUkKvh+0SHg93NU3jkk4HSaiYUrCajg1ESEl
        vAPGD31JiUYhXQvgwKx/nrQaBsYqgZgYp1fCthOrpPDL4dkr89YehlVn7lNSWwGr/EpJ+Axs
        nBzCpLYa3q59T2qzsL4xiknfZoHRUzeJT4EmsCBvYEHewIJcgf8tNANZC3iMdwsOGy8Y3YaF
        q+4Ac1ehfbkbNHy/qQ/QcsAsViQLCixKgtsmlDn6AJTjjEpRGsy3KBVWruwd3uMq9PjsvNAH
        TKl1fIarHy1ypW7M6S00mIw5OfpcEzLlGBHzuKLzocsFStrGefm3ed7Ne/7TYfI09U5QTa3J
        sD7R/AcfMs90TWjH/EvXNfKv478fO7B9VJs2AkvDoa8P02P5jtYt1w1jd835/Tbd/jW7nE3d
        2ZWZ0x9u5OKHt664db56Sbbm2k+/Ddz7ufnkF61bqbLJ5P2vjhhVT9v50Onrr8lf2XxOeKB8
        82DF9HPe4SW976bdfbbyjfYN0VlGJhRzBi3uEbh/ASwhXbYrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCSnO6+5zGxBrfnaFh8/dLBYrH+1DFm
        i9V3+9ksTk89y2Qx53wLi8Xed7NZLdbu+cNs0f1KxuLJ+lnMFjd+tbFa9D9+zWxx/vwGdotN
        j6+xWuy9pW1x/95PJouZ8+6wWVxa5G7xat43Fos9e0+yWFzeNYfN4sj/fkaLGef3MVm0bfzK
        aNHa85Pd4vjacAdJjy0rbzJ5tGwu99h2QNXj8tlSj02rOtk87lzbw+axeUm9x+4Fn5k8ms4c
        ZfZ4v+8qm0ffllWMHp83yQXwRHHZpKTmZJalFunbJXBl3Hg1g7Vgg1bF9Pm9rA2Mr+S7GDk4
        JARMJPae1eti5OQQEtjNKHHriTyILSEgJbG1fQ8zhC0scb/lCGsXIxdQzXNGiW9LXrKAJNgE
        tCU2H1/FCJIQEZjGIfGjdTZYQljAWKK15wMriM0ioCqxbNJHJhCbV8BS4sScs2wQtqDEyZlP
        WECOYBbQk2jbyAgSZhaQl9j+dg7UYgWJHWdfg8VFgEomHbzHClEjIjG7s415AqPALCSTZiFM
        moVk0iwkHQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHupbWDsYTJ+IPMQpw
        MCrx8O64GR0rxJpYVlyZe4hRgoNZSYS3Yk5UrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxj
        kUIC6YklqdmpqQWpRTBZJg5OqQZG1zfv+6S1qyQq73im+HoYzs6IOW60odkhWaVaybJ9is3n
        1qNBR77Omempbhj+TMxljtS71x7zdyhdcPiw4NoxrVZvt9xrd+8e2yKtFd7Q2u3XKdN8tv29
        0TmNfee6c5/bHPG8IVXi3jMjbM7z+FgDx1ddvDXbLl87fbDoqW2QFK/Vt1+L9SOUWIozEg21
        mIuKEwHPOnoc8QIAAA==
X-CMS-MailID: 20190821064206epcas2p1d1bcaae142416506bcedb3201d9a6658
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821064206epcas2p1d1bcaae142416506bcedb3201d9a6658
References: <CGME20190821064206epcas2p1d1bcaae142416506bcedb3201d9a6658@epcas2p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Exynos has a H/W block called FMP (Flash Memory Protector) to protect data
stored on storage device.
FMP interworks with the storage controller to encrypt a data before writing
to the storage device and decrypt the data after reading from storage
device.
FMP is a kind of ICE (inline crypto engines), which is generally known
as being used for the above role.

To use FMP, the modification of various layers such as Fscrypt, ext4, f2fs,
DM-crypt, storage controller driver and block is required.
FMP solution introduces a new diskcipher similar to the existing skcipher
in crypo API in order to minimize the modification of these layers and
to improve the code readability.

This patchset includes the following for using FMP:
- Diskcipher and FMP are added to crypto API.
- The crypto users such as dm-crypt and fscrypt are modified to support
  diskcipher.
- The bio submitters such as f2fs, ext4, dm-crypt are modified to support
  diskcipher.
- Block layer is modified to pass diskcipher to storage controller driver.
- Storage controller driver is modified to support crypto operation.

Exynos FMP solution consists of Diskcipher and FMP driver.
Diskcipher is a symmetric key cipher of crypto API that supports inline
crypto engine like FMP.
FMP driver is a cipher algorithm running on diskcipher.
FMP driver registers 'cbc(aes)-disk' and 'xts(aes)-disk' algorithms to
crypto API.
FMP can be tested with various test vectors in testmgr of crypto API.

When encrypting using FMP, additional control is required to deliver and
manage encryption information between encryption users (fscrypt, DM-crypt)
and FMP drivers. Diskcipher provides this control.

The encryption using FMP is made up of 4 steps.
The first step is to assign a password and set a key.
Encryption users such as Fscrypt or DM-crypt assign diskcipher, and set key
to the diskcipher.
The second step is to deliver diskcipher that has crypto information to
storage drivers such as UFS and MMC. BIO is used to this delivery.
The BIO submitters, such as ext4, f2fs and DM-crypt, checks if there is
diskcipher in crypto configuration before issuing BIO. If there are
diskcipher, the submitter sets it to BIO.
In addition, the BIO submitter skips the task of encrypting data before BIO
and decrypting data after BIO is completed.
In the third step, the storage driver gets the diskcipher from the BIO and
requests the FMP to encrypt.
In the final step, the FMP extracts crypto information from the diskcipher
and writes it in the descriptor area allocated for FMP H/W.
The FMP H/W uses the descriptor of the storage controller to contain crypto
information. So the descriptor of storage controller should be expanded
for FMP.

Boojin Kim (9):
  crypt: Add diskcipher
  crypto: fmp: add Flash Memory Protector driver
  mmc: dw_mmc: support crypto operation
  mmc: dw_mmc-exynos: support FMP
  block: support diskcipher
  dm crypt: support diskcipher
  fscrypt: support diskcipher
  fs: ext4: support diskcipher
  fs: f2fs: support diskcipher

 block/bio.c                      |   1 +
 block/blk-merge.c                |  19 +-
 block/bounce.c                   |   5 +-
 crypto/Kconfig                   |   9 +
 crypto/Makefile                  |   1 +
 crypto/diskcipher.c              | 349 +++++++++++++++++++++++
 crypto/testmgr.c                 | 157 +++++++++++
 drivers/crypto/Kconfig           |   2 +
 drivers/crypto/Makefile          |   1 +
 drivers/crypto/fmp/Kconfig       |  13 +
 drivers/crypto/fmp/Makefile      |   1 +
 drivers/crypto/fmp/fmp.c         | 595
+++++++++++++++++++++++++++++++++++++++
 drivers/crypto/fmp/fmp_crypt.c   | 243 ++++++++++++++++
 drivers/crypto/fmp/fmp_test.c    | 310 ++++++++++++++++++++
 drivers/crypto/fmp/fmp_test.h    |  30 ++
 drivers/md/dm-crypt.c            | 112 +++++++-
 drivers/mmc/host/Kconfig         |   8 +
 drivers/mmc/host/dw_mmc-exynos.c |  62 ++++
 drivers/mmc/host/dw_mmc.c        |  48 +++-
 drivers/mmc/host/dw_mmc.h        |   6 +
 fs/buffer.c                      |   2 +
 fs/crypto/bio.c                  |  43 ++-
 fs/crypto/fscrypt_private.h      |  28 +-
 fs/crypto/keysetup.c             |  60 +++-
 fs/crypto/keysetup_v1.c          |   2 +-
 fs/ext4/inode.c                  |  39 ++-
 fs/ext4/page-io.c                |   8 +-
 fs/ext4/readpage.c               |   7 +
 fs/f2fs/data.c                   |  98 ++++++-
 fs/f2fs/f2fs.h                   |   2 +-
 include/crypto/diskcipher.h      | 245 ++++++++++++++++
 include/crypto/fmp.h             | 324 +++++++++++++++++++++
 include/linux/bio.h              |  10 +
 include/linux/blk_types.h        |   4 +
 include/linux/bvec.h             |   3 +
 include/linux/crypto.h           |   1 +
 include/linux/fscrypt.h          |  19 ++
 include/uapi/linux/fscrypt.h     |   2 +
 tools/include/uapi/linux/fs.h    |   1 +
 39 files changed, 2837 insertions(+), 33 deletions(-)
 create mode 100644 crypto/diskcipher.c
 create mode 100644 drivers/crypto/fmp/Kconfig
 create mode 100644 drivers/crypto/fmp/Makefile
 create mode 100644 drivers/crypto/fmp/fmp.c
 create mode 100644 drivers/crypto/fmp/fmp_crypt.c
 create mode 100644 drivers/crypto/fmp/fmp_test.c
 create mode 100644 drivers/crypto/fmp/fmp_test.h
 create mode 100644 include/crypto/diskcipher.h
 create mode 100644 include/crypto/fmp.h

-- 
2.7.4

