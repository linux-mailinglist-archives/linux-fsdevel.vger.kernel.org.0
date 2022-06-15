Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57C654CDB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 18:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbiFOQDm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiFOQDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:03:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16F9237EF;
        Wed, 15 Jun 2022 09:03:37 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNVRp2wCgz683yD;
        Thu, 16 Jun 2022 00:01:58 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 15 Jun 2022 18:03:35 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Wed, 15 Jun 2022 18:03:35 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bug-cpio@gnu.org" <bug-cpio@gnu.org>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "takondra@cisco.com" <takondra@cisco.com>,
        "kamensky@cisco.com" <kamensky@cisco.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "rob@landley.net" <rob@landley.net>,
        "james.w.mcmechan@gmail.com" <james.w.mcmechan@gmail.com>,
        "niveditas98@gmail.com" <niveditas98@gmail.com>
Subject: RE: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Thread-Topic: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Thread-Index: AQHYgM+mPH1HC/8x8Uq7oovD5MPpKK1QoLWg
Date:   Wed, 15 Jun 2022 16:03:35 +0000
Message-ID: <d6479ebe656d4a75909b556d4cbcee22@huawei.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
 <20220615155034.1271240-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220615155034.1271240-1-alexandr.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.63.21]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Alexander Lobakin [mailto:alexandr.lobakin@intel.com]
> Sent: Wednesday, June 15, 2022 5:51 PM
> From: Roberto Sassu <roberto.sassu@huawei.com>
> Date: Thu, 23 May 2019 14:18:00 +0200
> 
> > This patch set aims at solving the following use case: appraise files from
> > the initial ram disk. To do that, IMA checks the signature/hash from the
> 
> Hi,
> is this[0] relatable somehow?

Hi Alexander

seems a separate problem. For that, we opted for having a dedicated
kernel option:

https://github.com/openeuler-mirror/kernel/commit/18a502f7e3b1de7b9ba0c70896ce08ee13d052da

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Yang Xi, Li He

> > security.ima xattr. Unfortunately, this use case cannot be implemented
> > currently, as the CPIO format does not support xattrs.
> >
> > This proposal consists in including file metadata as additional files named
> > METADATA!!!, for each file added to the ram disk. The CPIO parser in the
> > kernel recognizes these special files from the file name, and calls the
> > appropriate parser to add metadata to the previously extracted file. It has
> > been proposed to use bit 17:16 of the file mode as a way to recognize files
> > with metadata, but both the kernel and the cpio tool declare the file mode
> > as unsigned short.
> >
> > The difference from v2, v3 (https://lkml.org/lkml/2019/5/9/230,
> > https://lkml.org/lkml/2019/5/17/466) is that file metadata are stored in
> > separate files instead of a single file. Given that files with metadata
> > must immediately follow the files metadata will be added to, image
> > generators have to be modified in this version.
> >
> > The difference from v1 (https://lkml.org/lkml/2018/11/22/1182) is that
> > all files have the same name. The file metadata are added to is always the
> > previous one, and the image generator in user space will make sure that
> > files are in the correct sequence.
> >
> > The difference with another proposal
> > (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
> > included in an image without changing the image format. Files with metadata
> > will appear as regular files. It will be task of the parser in the kernel
> > to process them.
> >
> > This patch set extends the format of data defined in patch 9/15 of the last
> > proposal. It adds header version and type, so that new formats can be
> > defined and arbitrary metadata types can be processed.
> >
> > The changes introduced by this patch set don't cause any compatibility
> > issue: kernels without the metadata parser simply extract the special files
> > and don't process metadata; kernels with the metadata parser don't process
> > metadata if the special files are not included in the image.
> >
> > >>From the kernel space perspective, backporting this functionality to older
> > kernels should be very easy. It is sufficient to add two calls to the new
> > function do_process_metadata() in do_copy(), and to check the file name in
> > do_name(). From the user space perspective, unlike the previous version of
> > the patch set, it is required to modify the image generators in order to
> > include metadata as separate files.
> >
> > Changelog
> >
> > v3:
> > - include file metadata as separate files named METADATA!!!
> > - add the possibility to include in the ram disk arbitrary metadata types
> >
> > v2:
> > - replace ksys_lsetxattr() with kern_path() and vfs_setxattr()
> >   (suggested by Jann Horn)
> > - replace ksys_open()/ksys_read()/ksys_close() with
> >   filp_open()/kernel_read()/fput()
> >   (suggested by Jann Horn)
> > - use path variable instead of name_buf in do_readxattrs()
> > - set last byte of str to 0 in do_readxattrs()
> > - call do_readxattrs() in do_name() before replacing an existing
> >   .xattr-list
> > - pass pathname to do_setxattrs()
> >
> > v1:
> > - move xattr unmarshaling to CPIO parser
> >
> >
> > Mimi Zohar (1):
> >   initramfs: add file metadata
> >
> > Roberto Sassu (2):
> >   initramfs: read metadata from special file METADATA!!!
> >   gen_init_cpio: add support for file metadata
> >
> >  include/linux/initramfs.h |  21 ++++++
> >  init/initramfs.c          | 137 +++++++++++++++++++++++++++++++++++++-
> >  usr/Kconfig               |   8 +++
> >  usr/Makefile              |   4 +-
> >  usr/gen_init_cpio.c       | 137 ++++++++++++++++++++++++++++++++++++--
> >  usr/gen_initramfs_list.sh |  10 ++-
> >  6 files changed, 305 insertions(+), 12 deletions(-)
> >  create mode 100644 include/linux/initramfs.h
> >
> > --
> > 2.17.1
> 
> [0] https://lore.kernel.org/all/20210702233727.21301-1-alobakin@pm.me
> 
> Thanks,
> Olek
