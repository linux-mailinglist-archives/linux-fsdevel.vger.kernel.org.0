Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1229A4E1FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 05:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiCUEyk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 00:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbiCUEyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:54:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2031.outbound.protection.outlook.com [40.92.40.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CDC25FF
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 21:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReC9SFaexioxb4hXtA+4RxCEZLV51Rq2p4cHK0HNWHhU4sDm7j9EY8gH2pGorkjes8qrFTXLg4yNLzNQIn/fDoWWpjbwupLbgZzndPvsDuGioxuRMBCgkh4iz4V5q3qQ0/Jq4kDM8gX8CcipjUbD8/hACrk7o88+F1A1xM2IB1yPQmSGV7LhRmAwvFJSwE844WdjeT6d7UPVkHFh9rNrIn+wIXcLG5ASXiASrI2jQJWGyyyqJrFvmyb0bXwF/hBPe4EbGMpNq5DryVBtSh0FgKQjPjUkIS3mQd48fL+ZO8zaTSpsLekVjrwW4ZQwa626CLPR174F1JxsVAVp0gOeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UKReM3Y6zFQMr79+fsBi2+0NCbfcdXLc/QYaenEd1o=;
 b=hBJOlfdB6qUH1TCnWslfv/2xhdcLxDue1Wf16M1WlEG51Iepu36qYB6fhxdwqMudPI19pC0xIzSwk9SKvO4wLoIwjLsfsi0eGYjd/woLT9/iuqqIXqeLKZRd4G80CCyhSVByHDQvWbC4uLFjr/Y0Y437UBGqT85UPrrfQq+snsBlAlMx+KggeWw7/81zdiKILk1QjbGjCweZGVHXE41LofzG+w979W3sa7RTrSN4KKUUJZqkllqjLCtsroJjAQzTbjqSOccS0I+7X4jwmph6g8osR1339Jxjz1OBKlWsZgSZzc7sV1Aws6R/RNEpvFzXoO49yGZw5WqglrMkwKm2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR20MB2512.namprd20.prod.outlook.com (2603:10b6:208:130::24)
 by CY4PR20MB1351.namprd20.prod.outlook.com (2603:10b6:903:8b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 04:53:12 +0000
Received: from MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::9478:70e3:10c0:b16b]) by MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::9478:70e3:10c0:b16b%6]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 04:53:12 +0000
From:   Bruno Damasceno Freire <bdamasceno@hotmail.com.br>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Topic: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Index: AQHYPN5CzLbpGwv62Eyf/QOJSNQRSg==
Date:   Mon, 21 Mar 2022 04:53:11 +0000
Message-ID: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: f07fc5fc-ec24-34bf-4b9c-f96f0760372d
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [EBGxIbCcxz35DxNfNQEM3pEPhbKK/JPX]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b55665e-9f20-474b-112d-08da0af6b3c9
x-ms-traffictypediagnostic: CY4PR20MB1351:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nk3H5ZxbRWseM8C/ulW6UaotDujEHOJ0gIiVlKEvH/Thu0hkEc8iZe3zfchC+VzcqpIyyUL9e/sbq8mKsNBZ5/aVA8Ce0/74clVcBgTlLLDwGbTcvVRnz5m6VX1BNZ8dKB75Dgc4ECVoKbC3dR8UqUZIDH7VjW9eN1eCiSHIUuF7bfOKDVEdmPZerYvUpWbNxHEc/ICYMBO5jCOgK8TQifD+7td+IlPBRl8O2yV0ijZV0WlXnhUw1N3MHHT03Huh3OKYiBdFeO5Ba8/nd+o9NYGw7NEzUwyrlrABfi+xyHenFziUpuqMUZhj2M4xA/bnkXuUS2myOr2fIHqef5dsBFA8tNBxylgf+ViWqdyYwkRtkhg8g5p+tYGU1EbShVzy1ZkQAcVjNDP+upBnNgAWy3IdXiKgqIWA+zsJmCvmocm9hmWw/p1ok791ep+QC+sFmAIoh2Ak+n3fjwESVRMMIppWUf04TyiiVdu4exp10d4FABFlKKf0z5lcRVZZlMGrua/UEfZf6+DYtqhF63hYtMXItZEIazIxxVafyyIrjUHlC4hxR3Hxp46U/OVL6iOkLHRwzyxWkbG6UW5xIFez+nEHu485qOD9DgHH4r+RGOoBPHUTSTAj42Y6EGkq/47D
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+tyR1s9nQgT5q1+aP23lMandmwXIbiIXpwfw1X0PGwM42DFncylscPodYv?=
 =?iso-8859-1?Q?kc7e1cx79/cXdWwae79RPpUUHbUizVjj0PnrXwnR7Y5gQ+Ez7YtujZuMz1?=
 =?iso-8859-1?Q?QXqmEiVxeReT+S6foalfUT0ViO4yD7+GQpjfYPmg/BsHNed66DTy5wsdvT?=
 =?iso-8859-1?Q?PWQXKHg//xJ23yVk5LHLulOn2XjdfoIRSsMHp3SYePnObw0wIv1TU0z7tf?=
 =?iso-8859-1?Q?YuCPJc+dC1Sg0FGyNO2C9kO1Kgs4murkyivgEeOrzr2WsVhJOGZc0J/k5N?=
 =?iso-8859-1?Q?4VxcDB3DXjtq53K0LsK6BEZFTAcko9XrbJvpaKwmuOZYijAPDryb1oebxH?=
 =?iso-8859-1?Q?Q16LODlnLj3UqPphoHIsITorYGbFVu6Q11ggdjv8H2iFcP94CS0pEP6qGA?=
 =?iso-8859-1?Q?bT5I8099kVgpGGiJEm58No0icOVcIgoVaFwW1HJhpy+q8jA9rB2Q9W29vQ?=
 =?iso-8859-1?Q?rVCQ2K7innrckLMynaHnmcQXK2RjbsGL9W1srEH4fKX5HZMogFD0DgKo+j?=
 =?iso-8859-1?Q?uXUBp7Qa9Px3Nl1nvG4TLOGV48SUInqU0f3d+lPPqEO+CC88nIo3J1gCXC?=
 =?iso-8859-1?Q?LOmTmZle1ENk2W3759AnT566mGsRFtvQjyCepLgn4yhwoDUFUX/rzvQ60h?=
 =?iso-8859-1?Q?VRW5AWn9BNdpSfUmY0wbOqL3U2S/po7nf5uJ/hy4IZLcTHBB3i58hM17HD?=
 =?iso-8859-1?Q?jv4j8DZWjr/VYVRHKv28hIp6P15zG1gBiGx+8AH2tqEB+kqMIWdmaJ/yVY?=
 =?iso-8859-1?Q?Dv/aLrHtTeEPnkQFksaad0+/wMTY042AoOtM80BYrWISnoQYZVmr3QBvRP?=
 =?iso-8859-1?Q?+sxWBRPRaD9YZ8X247VI/WfOxA3I7+cxaTRBsrijBe7blsJvtG5k/Fo5X0?=
 =?iso-8859-1?Q?6/dh8Ut4K/n8qJ7JxjozKKTSTjCtmHzVKghWf2v8bqaw6h0737Tu4FNDdN?=
 =?iso-8859-1?Q?Z6PIj9d7i2cXtGjDHUoEU3X2PSFHQDdF5q6FyZDmb8LVtQPueSI1P/i3E9?=
 =?iso-8859-1?Q?r3Xl0DAHBKs6YX1Bk30+RALrSZ5l+Vd9hI/XxeDa+kbJPXFlaIAAQsdk4/?=
 =?iso-8859-1?Q?xj37bRaQaDh+5b/vUSLKJtm61NfUQG5LgtNb+Qz36JZ54S5YZx/yxKxrdY?=
 =?iso-8859-1?Q?RC21LNQIxt8fonedyJGVdO2HrvSbfo6XMqRMIPs5ote1zoO01C?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR20MB2512.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b55665e-9f20-474b-112d-08da0af6b3c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 04:53:11.7440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR20MB1351
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everybody;

This regression was first found during rpm operations with specific packages that became A LOT slower to update ranging from 4 to 30 minutes.

The slowness results from:
a_ the kernel regression: specific system calls touching files with btrfs compression property will generate higher inode eviction on 5.15 kernels.
b_ the inode eviction generating btrfs inode logging and directory logging.
c_ the btrfs directory logging on the 5.15 kernel not being particulary efficient in the presence of high inode eviction.

There is already an ongoing work [1] to improve "c" on newer kernels but I was told they are not elegible for the 5.15 version due to backporting policy restrictions.
AFAIK there isn't any work for "a" yet.
The consequence is that btrfs users running the 5.15 LTS kernel may experience severely degraded performance for specific I/O workloads on files with the compression property enabled.

___How to reproduce:
After some research I learned how to reproduce the regression without rpm.

1st option)
I made a script specifically to research this regression [2].
It has more information, more test results and several options.
The scrip does a little too much so I'm just linking it here.
I hope it can help.

2nd option)
boot a 5.15 kernel,
setup and mount a RAM disk with btrfs,
create a folder and set its compression property,
populate the folder,
make a loop that:
-rename a file,
-unlink the renamed file,
-create a new file.

[1] https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
[2] https://github.com/bdamascen0/s3e

___Test results
These tests were done on a virtual machine (kvm) with Ubuntu Jammy Jellyfish.
The kernel is 5.15.0.23 that relates to the 5.15.27 upstream kernel.

Main results (x86_64):
250 files - zstd:         17521 ms @inode_evictions: 31375
250 files - lzo:          17114 ms @inode_evictions: 31375
250 files - uncompressed:  1138 ms @inode_evictions: 499

Load test results (x86_64):
1000 files - 51.6 x more inode evictions - 18.1 x more time
250  files - 62.9 x more inode evictions - 15.2 x more time
100  files - 25.4 x more inode evictions -  3.7 x more time
50   files - 12.8 x more inode evictions -  2.0 x more time
10   files -  2.8 x more inode evictions -  1.3 x more time

CPU usage results (x86_64):
1000 files - zstd:           137841 ms
real    2m17,881s
user    0m1,704s
sys     2m11,937s
1000 files - lzo:            135456 ms
real    2m15,478s
user    0m1,805s
sys	2m9,758s
1000 files - uncompressed:     7496 ms
real    0m7,517s
user    0m1,386s
sys     0m4,899s

I'm sending this message to the linux-fsdevel mailing list first.
Please tell if you think this subject would be of interest of another kernel subsystem.
PS: I'm not subscribed to this list.

TIA, Bruno
