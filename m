Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3448845F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiAHQD6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sat, 8 Jan 2022 11:03:58 -0500
Received: from mail-dm6nam10olkn2029.outbound.protection.outlook.com ([40.92.41.29]:12128
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229521AbiAHQD6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:03:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V00W9GnW3y7JRT0NSY4tU8KDAyCG9BVVvZGki4Lyl18peEo5l/CsMtjVNGw3ibrD5F5avdEKUeW4LVDlDsD8mv6GQYIWe3pfzBnWqzrNOV1iMEnNkOi+EIap6xk1cH9DDdpfFftr2U8BQ2cqSEVe6cXWdh3KOqhllXcuoldcezxNbb8BcOHCcUsYhwqnJGV54Fk27Q4ixPjZKHRBhNE0bDnvP90ARaXcMTMpZeawNARRbd871FZhYvpdKohV9GFAIDkVwl3MBi7J85MKCNaW0NNtMrnBIW48rufpeDztOt/UJNSFPv/T9ZQKyjqVucvp1emzartFMYzhpNuJXksOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lluLhYThWZbnGKaEuNylSVgJ+Jk5L6bNNzY8zn4YZvY=;
 b=X75DldUZ8xJ9QOxflD5Ui4s7Li+0mlWePrkg5MxeISue1DZ8qz7+Ndg5nsPbqo7xCfU9N6R7NYxFbKF4ipapBDtAj3gjt0HSjCnl/RLo9hYXq3VNoOxwsRqjfSkrlivQ1ItZ8k+Q1+O2GbxfMaKBqIoAzA1JdeGYQ+7a8WX/rIcCEgNrw0vmvGInTzZJEcbsg9DC5CW4t9L5CXbyT8xwgxAax8UYSOyjveMztENN0VYhytaDR0kWPYnj28sBaWIVUxQjOiJDzgfkIQwji2Fb0mKNPw2Yv/7iPs9cHdDkAow4UnbpPuKVMGK1WVPIAkHnZQaXkO2za/AfRbDcIZTJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR20MB2512.namprd20.prod.outlook.com (2603:10b6:208:130::24)
 by MN2PR20MB2798.namprd20.prod.outlook.com (2603:10b6:208:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Sat, 8 Jan
 2022 16:03:53 +0000
Received: from MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::3401:d907:2f5a:1ef]) by MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::3401:d907:2f5a:1ef%5]) with mapi id 15.20.4867.011; Sat, 8 Jan 2022
 16:03:53 +0000
From:   Bruno Damasceno Freire <bdamasceno@hotmail.com.br>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
Thread-Topic: https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
Thread-Index: AQHYBKUvfGPP4zkeOE+imujfBNEVkQ==
Date:   Sat, 8 Jan 2022 16:03:53 +0000
Message-ID: <MN2PR20MB251235DDB741CD46A9DD5FAAD24E9@MN2PR20MB2512.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: aae771a5-276d-b03a-474b-9d6eed6a4be1
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [dDTN4wUgaeM05aKAn3rQDO+z2CQ0IDGq]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ddfdb8e-9cce-49ac-77ae-08d9d2c077ff
x-ms-traffictypediagnostic: MN2PR20MB2798:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GCsZdAbmPbNvdAD+qefyMNhC3bDbN2ccr/ZRp0I8/5v0FsvXzqtb9JImw5/Jf29nOj25cKu3GhIx3nGvXtkGB5fLHPylgQKTANZg/pP61Y4AidqTUgCL1ryxa2wV2g5WujUMtyKKUA0U9G8Y/FbqRulvlq56mtCZ1uocgPNvozQruRM0EkuZZAkG9882rBWf6xzL6XjKXFRDkzolKmFyAysetFevtHwgLCayFJYM1uZVBhN72j/RH8td/F9TPhvT6XRbQSWwdSKP2caJqsER3C+VtvSAxFNfLwp7T1c6axAoOLoPce6WT+thinTTMToQTMls5nvqislDg26KsS1wgyXywl3je2dt9d5jWJVVM61TUdQu3KO9xvRGKMHfODqhuLkgvTEFVoUDjXx8gK21Da9ZRscToZC39z7q6xBjYop4W+fTKMGuBAB+shTqgbf4sm5qy1In+Ic9vFFKxbyjyFlzRHofxZMhKEEx9EUOzK8QDDdzXlZBA16l/xPX1FkzeN41BTGvT1szFluZqeqkkweuc5qXdG+9cqfEASSI0FmNGSywm+PIvHmQyshkspk2MPUxElS0gJXuvkbH5/5+l31liEsBVEbO086YxYfR8mxhJQiWR+QMA7OBboNDofb
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: ju1RNK8Kuz0lj9t6nih4RizQ5c/frN2q7DWgMDGFe0N1fdSXhIU/1VzjPv9VgkX71pOMBgWZVB9fNstl53+fug+Jy7G1LzSAtG2kdz4kS09fKW6icZJCNsiIR3zntWU7ZdSmnDKG7JOooXETvpUJ1UCaL5jJ8fsuWAhk6feQ8UZYQMfJmUK2WS25tVHEFx6Gs43kwKI5PVO43EmRT2WIl1eV6EDrXOBe9e2aOLR6N30MdAoK+I8zKgdp6COIAhgbNUFVCqjYdbEM/ufduWdj9yVf5f1tnKcb1XLtLoWROUQJ/UNKoV2ck1gj/HDejTU8BJ20Ck+NGKzwhGWK90+Wnzwg363orf3RlNYt/9ae3v1D7ZjoPPlmN+LzmEw6uFLVysyPE3LQVE6qTyQM/vUMFVBXBVui/PVcE7lJfG02+ZcDCbM0en9y2vzUe3YUdjn2hqmSN5Z/C5WlI1uN9YfcSD2nCGRWhXUezB0LQc8UV5lWpKppTDtwiWjepm41PsxzA2hWolPcPCp+/cCb9SJ04FOLT446yzBaAW+9UvYK489VOCQx+hRtz8w74wK9m1lrAl8TbVCxanimXTF4m9x6TgauR98avrzK2LBTQ/L2bmavkF+GZor+0H3bnOE3V6kU12QNLp6PyjDgWj2zFOOfSXQNX9tZjYcgJqti61Tgc0O4VGT4P2EfbipkdwWQNnWFEbIZPKl8cvJ2II86r9DDgb7+pUgq1RhdDq45OY/+OdEJPfRiPSKaUtCzaJFaZW+mdCpSaP4/04qJZp78GNGLxLjdUgQZu1I2STZ4UaZjUb2L4nreF7mwWCJa0o8dcvRiiDYSzFI82kc0s11BZ9tSBMkGdi9NRNlwgNCasoD8jtH4KL9XsXUeiQbtzAb+Sql4mR0/feUzBCkENr+7IcajyUY+frc9u+g29lOcVwlzReoUCU2rhwp0lR28hkWEqY8R
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR20MB2512.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddfdb8e-9cce-49ac-77ae-08d9d2c077ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2022 16:03:53.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB2798
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everybody;

I'd like to publicize the following bug that I reported for opensuse:
[kernel 5.15][btrfs compression property] zypper taking too long to install one package
https://bugzilla.opensuse.org/show_bug.cgi?id=1193549

I got support from the btrfs developer Filipe Manana and the issue is well understood regarding this file system but, since the root cause wasn't found, maybe it is of interest for the VFS kernel subsystems.


TL;DR:
comment #46
Filipe Manana 2022-01-05 10:54:16 UTC
(In reply to Bruno Damasceno Freire from comment #45)
> k5.14.14-3 : @inode_evictions: 1715
> k5.15.12-1 : @inode_evictions: 166106
> k5.16~rc8  : @inode_evictions: 1715
That confirms the hypothesis. Somehow a 5.15 is triggering ~100x inode evictions, which will result in renames doing unnecessary inode logging.
As to why that is happening, I have no idea if anything in mm or vfs changed in some 5.15 release that results in triggering a lot more evictions.


To reproduce:
I am an opensuse user, so I'm not sure on how to reproduce the issue on other distros.
Here are some updated instructions to reproduce it on tumbleweed:

SETUP--------------------------------------------
1 get the installation image
  wget http://download.opensuse.org/tumbleweed/iso/openSUSE-Tumbleweed-NET-x86_64-Current.iso
2 create a basic VM
  11GB storage shold be enought for the tumbleweed installer
3 install a server or a desktop version with btrfs
  no btrfs snapshots needed
4 downgrade the kernel if its > 5.15 (should be available for the next 3 weeks)
  wget http://download.opensuse.org/history/20220106/tumbleweed/repo/oss/x86_64/kernel-default-5.15.12-1.2.x86_64.rpm
  zypper in --force kernel-default-5.15.12-1.2.x86_64.rpm
  boot the 5.15 kernel
5 get the affected package: libKF5Emoticons5 (4 minutes), gutenprint (32 minutes)...
  env LANGUAGE=eng zypper info libKF5Emoticons5 | grep Version
  wget http://download.opensuse.org/tumbleweed/repo/oss/x86_64/libKF5Emoticons5-(version).x86_64.rpm
TEST---------------------------------------------
6 install the package: it should take a few seconds
  rpm --force -U -nodeps ./libKF5Emoticons5-(version).x86_64.rpm
7 enable any compression (zlib, lzo, zstd) on the package's destination folder with most files
  optional: rpm -ql libKF5Emoticons5 | less
  btrfs property set /usr/share/emoticons/EmojiOne compression zstd:1
8 retry to install: it should take much longer now !!! <<<<<
  rpm --force -U -nodeps ./libKF5Emoticons5-(version).x86_64.rpm
9 disable compression
  btrfs property set /usr/share/emoticons/EmojiOne compression ""
10 retry to install: it should take a few secons again
   rpm --force -U -nodeps ./libKF5Emoticons5-(version).x86_64.rpm


Alternatively:
1 get an installation image with a 5.15 kernel
  http://opensuse.zq1.de/history/20220106/tumbleweed/iso/openSUSE-Tumbleweed-DVD-x86_64-Snapshot20220106-Media.iso
3 install a server or a desktop version with btrfs
  no btrfs snapshots needed
  To get the files (and the 5.15 kernel) from the image you:
  a) should not activate repositories or
  b) should not enable network


TIA, Bruno
