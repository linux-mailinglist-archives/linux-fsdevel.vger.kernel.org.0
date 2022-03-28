Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B4C4E8B95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 03:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiC1Bat convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 21:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiC1Bas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:30:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2023.outbound.protection.outlook.com [40.92.20.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0815A09
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Mar 2022 18:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+xrUF1yKFnxO8wmDCPBTjGJ46yc7P9NxcjjkQ76HsmO346Vc3kJGw+pa4aXxNkWVjJEqj9304IlxsSoJJIx3N32VITfWtpNrGjJJeBx+vqU68K1+Vdz0SwiPQvPGGRZbRGWl5PDQhNofsiKQ7a4uT/3K+HnPQrXgKAFONunQ/guktoUOtbwebwL+l/BLghjf42EeycRcKUiT37POlwi8fn/5YwOxxAZqc4z+gHdAhHGFJadLBcx4/SpEA4Nxu+nxNHZTyIbQTCv7oSlPPEGNLBTiywa+g5WULMv4oqNSOMz4DFtn34Y1ybeXeR+x+Tj20EJrz+TeQGB+9yUlfzDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM/Gk8CkN9QO2X71vQYdvFC37BB5K2QHcIXhvnuctT8=;
 b=hSPLwMIj//FGBvrkjrLlyI55CSNjwFlwi0zufy3S8pxhIPan8Hjd3s9p1bcnOdqafAkpZ08tJlxtWRxmdSKYboaXZr1UAMFEaGP9Azc8j944SwGCSHxusPrGl3ioWC0vmXtC4snjfnu6ze9SNmEZATDemPnqh+5GeSPCWNKXb353KDEKs1mTTyGR1RwFOkW33e+/RdqrFLasAGRJxMGIf/8nLlfOFrr0QH/AMBIxxT5kQDtDiP0CA/YCaWkQPIrMXSqwqywDWlo3keVZ3naAL/Y95IVvyMHyLW9dMKisuCZp7jwVm8rkHJlGChB1pWR9Ek5MfI5v6U6pOdRDMAZwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR20MB2512.namprd20.prod.outlook.com (2603:10b6:208:130::24)
 by CH0PR20MB3929.namprd20.prod.outlook.com (2603:10b6:610:cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 01:29:06 +0000
Received: from MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::9478:70e3:10c0:b16b]) by MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::9478:70e3:10c0:b16b%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 01:29:06 +0000
From:   Bruno Damasceno Freire <bdamasceno@hotmail.com.br>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Topic: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Index: AQHYPN5CzLbpGwv62Eyf/QOJSNQRSqzOeNCAgAVDwAE=
Date:   Mon, 28 Mar 2022 01:29:06 +0000
Message-ID: <MN2PR20MB2512CC55566CDBE7133C0ACDD21C9@MN2PR20MB2512.namprd20.prod.outlook.com>
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
 <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
In-Reply-To: <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: a6ecd9f3-ed7e-f35c-1fca-c8313d0c45ad
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Z1yJhKG4aiOWLx6rwIMh4GV6TlzUJjMB]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3051a980-2b35-44e6-0444-08da105a59ab
x-ms-traffictypediagnostic: CH0PR20MB3929:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m9ZMG6KHPehmr7it2t7HjsX88C6FhvLytqXRglRMye8RQhE64/vyskBz2nNFaEju899zG3gQ8AWnhtoMWdQ/PXZGjMMcgecV7DzD4s2AowO9dsc4i021HFkeMhphqwM+Fiub5CYPHA4/w0CcRs8buTRU2/0tfwOGklGHWGwGaGxtgtyCHRoXt5tOd8ZTtX4bZIFCzq2QJbWpcjh8XytDhQ+HA5260rbPmkQVLUwi61grjnZyoTVJUX8aK+rbvAm83u4Yp1p2qSGMV9YCURue8sB+yA9aOPwh/YkZXQ7R7d4izzxFRAqive7hhJu1ENG+YGSH4nvL7e845+B+N4Y9dRIocbewbHk9vJZ+bjLGPnHyZQY56PRgM3yXWdPTaocluSEgBEAvxbpNyI4aj5al8Ns2hpcrbu6NTPpoexfeXSFUktc/F13PKTOy0mgnva89l9YSH1OzU4D72HXyL8I9QOBVUJDFb7Jog+44myggRYVW7J2lmtFXMD/9wsjaAyyWSy7vGbr8r8BkmIOWF+cm2ZlHNI0sP8bUk/Q2ZukAg3FyYQWfrR7w3qdbKvdERIisO137z/nsKjZaBuprYviUnOdrP4CAl4ax7WQz6w5R8eeRPIxr6A8AG43EBS2HISUi
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ll3GBRfmwSFWKYDL7e+ptNgioPd11em7JD2lxL8MG4/zdqQaEloVgBPptb?=
 =?iso-8859-1?Q?iL5e37pTpK2Fkry4AbjR8c9qSK5GWNEfxE8I3Cb5nYwBrSpFwtf4oyjqMZ?=
 =?iso-8859-1?Q?9Kz4H7fO3RvmApyPYEeEZs4Zbfb7INRt4UQBh/0warDIUZdXIqF3qqV7V1?=
 =?iso-8859-1?Q?LDelsLZTVLtmzOerFSUy+dXAnmUAWfJ1TpIXBCSGE6jbqwyGITI61cpEuI?=
 =?iso-8859-1?Q?XOyuzRWAJTYWi7jjbdhHZJdmYizlAh+ROchxdGz6HF5CUQp8OUSXM/HAoz?=
 =?iso-8859-1?Q?g7SSbwxFr6guCQ7fL4skzYDOgwLsOlvko3b2qDY3VgY/Ci8pilkRxzlgEN?=
 =?iso-8859-1?Q?Gc2PGYuo2/7IsKDQMWaHfdZDQ9v1TKWHWs5k+Dsk7stK7HQmvExX2TlJZV?=
 =?iso-8859-1?Q?HBLxiGa+5Y8v1nPRq1a91Ub2joO4p4+x8by4fUjRVI2KwhzRpDGCFlkMcs?=
 =?iso-8859-1?Q?Xi6X9vinQx87hfKJahG+4+8K0zP1v9uM/dwGQUzkadPiFn7GHT/vQHjgYD?=
 =?iso-8859-1?Q?4R96Rl32QuejJxXBBvp1gkZGFrSTusH3DLQqv62LoKKRI8uWc2K58sURvH?=
 =?iso-8859-1?Q?3YWty7kuoh7DkncDj7VKzrS09507b9+ZIfDPReUpqT2wScGCHueEIr7wEb?=
 =?iso-8859-1?Q?6Vy2THbsFDfZJ+xXJvCOMhR1vvteWPAEks6DX0VJvftMfnOmnySljSKGpN?=
 =?iso-8859-1?Q?kci8dBp3a3xPYrcK65nUMZ4hUsLKmHBsl2KkDPo8qBDAY09KGAwlU1Wuyr?=
 =?iso-8859-1?Q?Nk+j0kJjN4BDSkFPii9mn9dp1HuTk5Y+o3gkE45DajxJ14HqQzhpAWEsVE?=
 =?iso-8859-1?Q?GojXvn8lEqD5jg1RJXYqYUen+br2t9CF583IQlorO4AE+3GrtGRTy3MXwH?=
 =?iso-8859-1?Q?prjpv9JF+87CzrOmJ9UXUSZPv2p9XlHbX2gonMQ1vFt+VebMOShhBDs7yC?=
 =?iso-8859-1?Q?yH5bfENS7JHqehGd4/uGa4eNj+DFdLjWe5aoLY4ngaepZA6wfG2vmLJZzm?=
 =?iso-8859-1?Q?d2sERTcX7F+WpfwfYaAiVOkgoLsxTvbbAhAWk+WTjuLztbn1JmmEiDFd5d?=
 =?iso-8859-1?Q?j15mZQZtiL1HXZ6abXONjuuaND0w8ANlXudVxs7JTjSvBL+LaNx3cssO6+?=
 =?iso-8859-1?Q?Zta5OVrTSzNsUJHdxM3XmIPRO+Ffuv/zBm8bmSdMmYxZJQ69M6KpN7pUxy?=
 =?iso-8859-1?Q?8Z7m8uhAyKvHbqpfUBGRqPNOfkQOV/m5SuITnkwxK9ib5oYIbmLmuqN2+/?=
 =?iso-8859-1?Q?SuScNLQwNy9zcrfm8IN18IdIGBfKbTnbq69pJsH3q35DAJC3pXcGwITrqn?=
 =?iso-8859-1?Q?1gxMcFMed9WLu6evIAX4vayTnw16A6FmjPRnI3oQeKQCQDrZjVs9efT2Ow?=
 =?iso-8859-1?Q?AX/INpUymjusH/RDWIbfI7okCg1Ub4SzQrj1Yx8t1KhqLI9h5jV78XhV9D?=
 =?iso-8859-1?Q?nLuYgAQPbTrfNySNVu/Eznlaxh6g5+Td1goSyw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR20MB2512.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3051a980-2b35-44e6-0444-08da105a59ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 01:29:06.2421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3929
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.03.22 13:18, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> CCing the regression mailing list, as it should be in the loop for all
> regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

Thanks.

> On 21.03.22 05:53, Bruno Damasceno Freire wrote:
> > Hello everybody;
> > 
> > This regression was first found during rpm operations with specific packages that became A LOT slower to update ranging from 4 to 30 minutes.
> > 
> > The slowness results from:
> > a_ the kernel regression: specific system calls touching files with btrfs compression property will generate higher inode eviction on 5.15 kernels.
> > b_ the inode eviction generating btrfs inode logging and directory logging.
> > c_ the btrfs directory logging on the 5.15 kernel not being particulary efficient in the presence of high inode eviction.
> > 
> > There is already an ongoing work [1] to improve "c" on newer kernels but I was told they are not elegible for the 5.15 version due to backporting policy restrictions.
> > AFAIK there isn't any work for "a" yet.
> > The consequence is that btrfs users running the 5.15 LTS kernel may experience severely degraded performance for specific I/O workloads on files with the compression property enabled.
> > 
> > ___How to reproduce:
> > After some research I learned how to reproduce the regression without rpm.
> >
> > 1st option)
> > I made a script specifically to research this regression [2].
> > It has more information, more test results and several options.
> > The scrip does a little too much so I'm just linking it here.
> > I hope it can help.
> > 
> > 2nd option)
> > boot a 5.15 kernel,
> > setup and mount a RAM disk with btrfs,
> > create a folder and set its compression property,
> > populate the folder,
> > make a loop that:
> > -rename a file,
> > -unlink the renamed file,
> > -create a new file.
> > 
> > [1] https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
> > [2] https://github.com/bdamascen0/s3e
> > 
> > ___Test results
> > These tests were done on a virtual machine (kvm) with Ubuntu Jammy Jellyfish.
> > The kernel is 5.15.0.23 that relates to the 5.15.27 upstream kernel.
> 
> Please repeat this with a vanilla kernel, Ubuntu's kernel are heavily
> patched and one of their patches might be causing your problem.

Done. Same higher inode-evictions and slow results.
Also tested on a 5.15.0-rc1 kernel and, again, same results.
Older and newer 5.14 kernels produced normal results so it really seems that the regression was introduced early in the 5.15 cycle.

> > Main results (x86_64):
> > 250 files - zstd:         17521 ms @inode_evictions: 31375
> > 250 files - lzo:          17114 ms @inode_evictions: 31375
> > 250 files - uncompressed:  1138 ms @inode_evictions: 499
> > 
> > Load test results (x86_64):
> > 1000 files - 51.6 x more inode evictions - 18.1 x more time
> > 250  files - 62.9 x more inode evictions - 15.2 x more time
> > 100  files - 25.4 x more inode evictions -  3.7 x more time
> > 50   files - 12.8 x more inode evictions -  2.0 x more time
> > 10   files -  2.8 x more inode evictions -  1.3 x more time
> 
> I'm missing something: more inode evictions when compared to what? A
> 5.14 vanilla kernel?

Not clear at all. Sorry.
Will repost with my full set of results [2] including a vanilla kernel, the 15.0-rc1, more distros and a better load test report.

> > CPU usage results (x86_64):
> > 1000 files - zstd:           137841 ms
> > real    2m17,881s
> > user    0m1,704s
> > sys     2m11,937s
> > 1000 files - lzo:            135456 ms
> > real    2m15,478s
> > user    0m1,805s
> > sys	2m9,758s
> > 1000 files - uncompressed:     7496 ms
> > real    0m7,517s
> > user    0m1,386s
> > sys     0m4,899s
> > 
> > I'm sending this message to the linux-fsdevel mailing list first.
> > Please tell if you think this subject would be of interest of another kernel subsystem.
> > PS: I'm not subscribed to this list.
> 
> We need to get Btrfs people into the boat, but please clarify first if
> this really is a regression with the upstream kernel.

Sure. The Btrfs crew belong on this boat.
The Btrfs developer Filipe Manana assisted me on the original bug report [1].
He concluded that the btrfs compression property just happens to trigger something outside the btrfs code and was guessing it could be at the vfs or mm subsystems.
The bug was also the beginning of a long term work to make the filesystem more robust but the improvements would not be elegible for the 5.15 version due to backport restrictions.

> Ciao, Thorsten

Grazie, Bruno
