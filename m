Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD41233F5F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 17:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhCQQqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 12:46:04 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com ([40.107.21.92]:2543
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232676AbhCQQpo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO/dWv3H56ANXzMjqmaOxhbw0PP3OKh8OqjqvxfFbbtZ3JqjYMJw4rJKrwXqlg1gH7tJFtuERggauLLm1R4FtVTqCbSaahDTpmcIHFBYJzWRNFWOvz47Q2QXWzpsWSWK8vjWDxS7wJfUumil0K7Kb3rvYbb2LsTXXpIC5kcDWdoOLPn3ZMJgwOaOFE/KPriCyMdIMFRptowmkwpqzxQ8Ce6BEhPZmIZNlQDqyjoBAJcW4x2utN294yc4bUtBL1Gw+VIFClnShaJTJ379tparYlEECSzaaMZREyEPS3w4D7Tv92VFDRkDNXHm6YyB4MDKCm26ox67aZ2QBEP3oLRM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OFaxKWAs6v5+hQDbjM3RLmp5FD6ajhJyyNPpw+eF9U=;
 b=jNwbRbIN8hezOZe/A+/GmNub0tsrbKQRewCSlp7o3g+SKlRFwR2cTfDVlO5e29m6WejWCCCStJnluD9+FJf8RpxyuSfUx/woucdadQS7YtFygSDxeNazCLIfMVvB4Gub+JNHMaI8u9QL1qhEFdVwzmupRLDoLM2Xt6GeT/zVO49JduBsd4+TT4tEsd3DmKwZ9SO0qbzh6eVzVTmsXxe+zLdVbU9nuvJQKD9HO6v4YhbX8tCamnAn9MrYbTTCBPlm0N9IE/XTcrSlE6GeS3DCLGFpZmSX9cjD05F2lqna1VLLdEZmlUpaZfK1k6G+2sZTzFLnhyk2KDTTwg5axN754Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OFaxKWAs6v5+hQDbjM3RLmp5FD6ajhJyyNPpw+eF9U=;
 b=hQdkMnhNBGkvH8mBWTXpSJmzpwgACjzTHBd5B6KqKOHdZ5lNgDKlykSUjmrA6QmqqMVN3cRYDTuWOKMPPu8csDDYzYSJN0ixrp2iMJAirazSViNefFIn96vLCpgkVUE+1sjJm/L9rkPOHsdFe0fNXnYOSUJg8JMgRwbI1HKzSwk=
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com (2603:10a6:20b:ad::22)
 by AM5PR0401MB2547.eurprd04.prod.outlook.com (2603:10a6:203:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 16:45:41 +0000
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::d582:5989:a674:bfab]) by AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::d582:5989:a674:bfab%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 16:45:41 +0000
From:   David Mozes <david.mozes@silk.us>
To:     David Mozes <david.mozes@silk.us>,
        Eric Sandeen <sandeen@sandeen.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "sandeen@redhat.com" <sandeen@redhat.com>
Subject: RE: fs: avoid softlockups in s_inodes iterators commit
Thread-Topic: fs: avoid softlockups in s_inodes iterators commit
Thread-Index: AdcapuBpHwWWXKfESnKJze+uh6myxwAJencAAB5CKWAAAbNc8A==
Date:   Wed, 17 Mar 2021 16:45:41 +0000
Message-ID: <AM6PR04MB5639629BAB2CD2981BAA3AFDF16A9@AM6PR04MB5639.eurprd04.prod.outlook.com>
References: <AM6PR04MB5639492BE427FDA2E1A9F74BF16B9@AM6PR04MB5639.eurprd04.prod.outlook.com>
 <4c7da46e-283b-c1e3-132a-2d8d5d9b2cea@sandeen.net>
 <AM6PR04MB563935FDA6010EA1383AA08BF16A9@AM6PR04MB5639.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB563935FDA6010EA1383AA08BF16A9@AM6PR04MB5639.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: silk.us; dkim=none (message not signed)
 header.d=none;silk.us; dmarc=none action=none header.from=silk.us;
x-originating-ip: [37.142.234.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0a45276-e107-4105-8f39-08d8e96419fe
x-ms-traffictypediagnostic: AM5PR0401MB2547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR0401MB25478159F3735E6125300127F16A9@AM5PR0401MB2547.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:156;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aG+m2V1VU6S2D7hEKiHfRhotO7mEuf1UNAVJZkd7/pVFNW4+8jr7i+uqYsX0HpCyTxiy2WWTxOc0mNe2QHauXaNbhgTtkS1P0dmcJ+xoICfXF0vPAnbZqsDa16M917OagjqSFB+22sWZitYA94rjr2CuqbgzKWF9PVTXfwAfBVQHr1boX6/Nv0BNsItztAolD1V8NcbkbfwCXx0DPdHRCc5zDNfFcr0M9JNOz4eFKFoeMe3kj14O9vFAcU4UQBTc8RKl7uJAYook/3lR6zY3ECI1ntvOzU90ph4OSWLK++XEpP+kZjCJAd4xEyfJFT14aE4tw+FcveKZ8xqT88XT2ShCNTPYZ7UAlFJe26sT9sy67cqWZFaZzlFkUUehYQzj6jUWDLaizKa65HlC1yf6TFkHpPYwgBU0DB6Q2s98T3/47pK4RV+hPdxDpPg0Uqx4tc7f2Ij5hJzoqOUgMK/3oKhs+NXPpvDmrBAzKwqds2Aj7j/LTMSmdn3M4YyfHLlPz9HCz2+j9nM91As18PzC+l39Ogg3tGRm2hu2Q9FUo7WOj0Ac1JJBakEy/9MQNIpgP3+3Jp9QxGUQVxwCbXEVFLhTnz8FL7aN3nAYqefF6CjEtjo0/283of7WZXnBDx9HywMNL/1tPAEJ3bDDay/Z+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5639.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(71200400001)(4326008)(44832011)(55016002)(2940100002)(8676002)(83380400001)(8936002)(9686003)(86362001)(45080400002)(66946007)(478600001)(5660300002)(66476007)(26005)(186003)(66556008)(64756008)(66446008)(76116006)(110136005)(2906002)(52536014)(33656002)(53546011)(316002)(7696005)(6506007)(30864003)(80162006)(80862006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nIUOMukWlHqmjFGM5l6Uv6gtKUcwPFQ9HUnN/x9AHkENfKYxWuwndXJx9pIK?=
 =?us-ascii?Q?XD+4HfPiOm7nyxifRWoEeTTqKUFOtZL2L3X24DTObkGgKTpoXOuBBXhdDnaD?=
 =?us-ascii?Q?PYNsA1WraQMobui/rY8hUiwB9jqUa8IGDNy2lsyfgyrJltH7BGQz15cq0703?=
 =?us-ascii?Q?ke/rhURG4YlqRvxUFLApiPdRqpaPF6eeF2gSneOzGM30zLSdsSviCsgLZ9Mz?=
 =?us-ascii?Q?Pz20sW5w9hooNFjl7ZxDyEZrCRJdMOGcP0Rgh2dW1n32JkBQrIKsF1w1VQPe?=
 =?us-ascii?Q?Wx/QRPMRrep9343jLNt8Q9YEeAllkmqJNgaiI/K9ekzieDgVEf1dX3Wtdaq0?=
 =?us-ascii?Q?x//4lg+ton6VWZ+NHvKAU0ZSZB5toYfF1tDqjeuhDqzw+2qLNgflWGuMK711?=
 =?us-ascii?Q?1lwfW7ZGLP+Z4uROl411J4kY/NYbRrXOnex2GzVvRtNILgDx0xQc/yf4oeDi?=
 =?us-ascii?Q?32fobE5I9wrQeZ1O0JBbsF9LDc4FOBYqFVZJipwgBkMzHhxUmfIQZPMqvir6?=
 =?us-ascii?Q?g3DnEBZMwrtnU/vA8dgQCS5DaWI4Qflgx5rg9gyaSxqWSdMFYtGDoTmmbpFb?=
 =?us-ascii?Q?PWzQfV06ZaWQvZ/FCJ39z/isRPsF3Fzs3jj3ntJ4MXYu3aan28n8rHD0CXw5?=
 =?us-ascii?Q?sGaw6zt4WxxlJ9eVLlncCCM/KmCG4spPp52JoDHZGAwGF01KvtitiU568KdC?=
 =?us-ascii?Q?s9UUlFgBjf4B/4wXCraHFFvTOss5JumS4CbzlEuKnczmrpCfYsxVmfsXOMHh?=
 =?us-ascii?Q?YMsyS2xjnM64YjzIow56glqpHJ9Mlo7qogbyBASsLnHN7VeJvTJasc44TYo5?=
 =?us-ascii?Q?5whE4VeGbDCEfP7qZgeJN+7PpCMsrwHotzQHp8L6QPBh6EyuFBnjBdOhdwC1?=
 =?us-ascii?Q?NZvCrcVF0QhcpePXb9FmZuI6jG8JpuxTLsA85IdErHJ5OqR9OeC5/zvRBZ1u?=
 =?us-ascii?Q?K8d9qyWOEoLyofHtJSJzw3PXpRI72wBfpH6DEVJkkGKIBSlmvObBgNndu+r7?=
 =?us-ascii?Q?NOUu4xse8SJiN/O/NaOB8J3+J5NAgpP9tCiNvMWcOACejsfKmNL/+o3o5Fzl?=
 =?us-ascii?Q?S3pjzDLC79A6d5+IG+cptz38wpLyACFKOm3CfjYsQ07vkMFSefnUVvPOBtk/?=
 =?us-ascii?Q?Td/5Q96fslH2zSrG64OlBlnDeDXgI7ZLOh0aBhN+Yu5BkiCx8ciSL9gv9NX6?=
 =?us-ascii?Q?rNFdRIMoy120VIvH1zhFU/Wm/ZDNRLDPF+PXbLwT8d7dOZFjUzjFvHoQa7fv?=
 =?us-ascii?Q?WawPdZ0JwNp3YKm9XKYlQUSzaZ/l8l/sfktastf4pElN/N5PmuzFwloBkVX+?=
 =?us-ascii?Q?78cVPb+DHe5i3kxkyd1B6XgE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5639.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a45276-e107-4105-8f39-08d8e96419fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 16:45:41.4430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+uFVBMZPGjro/egc/GKSz/i7AlHQdJgz3ED5F0ml19UQKlHP0tH11T1Esb+cRVdPdaKyiwtQD/VFIYwualVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2547
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Send gin the stack of the first case on different run=20

panic on 25.2.2021
whatchg on server 4. the pmc was server w\2
Feb 23 05:46:06 c-node04 kernel: [125259.990332] watchdog: BUG: soft lockup=
 - CPU#41 stuck for 22s! [kuic_msg_domain:15790]
Feb 23 05:46:06 c-node04 kernel: [125259.990333] Modules linked in: iscsi_s=
cst(OE) crc32c_intel(O) scst_local(OE) scst_user(OE) scst(OE) drbd(O) lru_c=
ache(O) 8021q(O) mrp(O) garp(O) netconsole(O) nfsd(O) nfs_acl(O) auth_rpcgs=
s(O) lockd(O) sunrpc(O) grace(O) xt_MASQUERADE(O) xt_nat(O) xt_state(O) ipt=
able_nat(O) xt_addrtype(O) xt_conntrack(O) nf_nat(O) nf_conntrack(O) nf_def=
rag_ipv4(O) nf_defrag_ipv6(O) libcrc32c(O) br_netfilter(O) bridge(O) stp(O)=
 llc(O) overlay(O) be2iscsi(O) iscsi_boot_sysfs(O) bnx2i(O) cnic(O) uio(O) =
cxgb4i(O) cxgb4(O) cxgb3i(O) libcxgbi(O) cxgb3(O) mdio(O) libcxgb(O) ib_ise=
r(OE) iscsi_tcp(O) libiscsi_tcp(O) libiscsi(O) scsi_transport_iscsi(O) dm_m=
ultipath(O) rdma_ucm(OE) ib_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_c=
m(OE) ib_umad(OE) mlx5_fpga_tools(OE) mlx5_ib(OE) ib_uverbs(OE) mlx5_core(O=
E) mdev(OE) mlxfw(OE) ptp(O) pps_core(O) mlx4_ib(OE) ib_core(OE) mlx4_core(=
OE) mlx_compat(OE) fuse(O) binfmt_misc(O) pvpanic(O) pcspkr(O) virtio_rng(O=
) virtio_net(O) net_failover(O) failover(O) i2c_piix4(
Feb 23 05:46:06 c-node04 kernel: O) ext4(OE)
Feb 23 05:46:06 c-node04 kernel: [125259.990368]  jbd2(OE) mbcache(OE) virt=
io_scsi(OE) virtio_pci(OE) virtio_ring(OE) virtio(OE) [last unloaded: scst_=
local]
Feb 23 05:46:06 c-node04 kernel: [125259.990373] CPU: 41 PID: 15790 Comm: k=
uic_msg_domain Kdump: loaded Tainted: G        W  OEL    5.4.80-KM8 #14
Feb 23 05:46:06 c-node04 kernel: [125259.990374] Hardware name: Google Goog=
le Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Feb 23 05:46:06 c-node04 kernel: [125259.990378] RIP: 0010:smp_call_functio=
n_many+0x1e5/0x250
Feb 23 05:46:06 c-node04 kernel: [125259.990380] Code: c7 e8 bf 3d 75 00 3b=
 05 1d 13 1d 01 0f 83 b0 fe ff ff 48 63 d0 48 8b 0b 48 03 0c d5 20 99 18 a8=
 8b 51 18 83 e2 01 74 0a f3 90 <8b> 51 18 83 e2 01 75 f6 eb c8 48 8b 34 24 =
48 c7 c2 e0 9e 33 a8 89
Feb 23 05:46:06 c-node04 kernel: [125259.990381] RSP: 0000:ffff8f90bfbfbaa0=
 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
Feb 23 05:46:06 c-node04 kernel: [125259.990382] RAX: 0000000000000005 RBX:=
 ffff8f72c7aab540 RCX: ffff8f72c75703a0
Feb 23 05:46:06 c-node04 kernel: [125259.990383] RDX: 0000000000000001 RSI:=
 0000000000000000 RDI: ffff8f72c7aab548
Feb 23 05:46:06 c-node04 kernel: [125259.990384] RBP: ffff8f72c7aab548 R08:=
 0000000000000001 R09: ffff8f72c7aab550
Feb 23 05:46:06 c-node04 kernel: [125259.990385] R10: ffff8f72c7aab548 R11:=
 0000000000000001 R12: ffffffffa706efa0
Feb 23 05:46:06 c-node04 kernel: [125259.990385] R13: ffff8f72c7aa9e00 R14:=
 0000000000000001 R15: 0000000000000060
Feb 23 05:46:06 c-node04 kernel: [125259.990386] FS:  00007f261aa6d700(0000=
) GS:ffff8f72c7a80000(0000) knlGS:0000000000000000
Feb 23 05:46:06 c-node04 kernel: [125259.990387] CS:  0010 DS: 0000 ES: 000=
0 CR0: 0000000080050033
Feb 23 05:46:06 c-node04 kernel: [125259.990388] CR2: 00007f26281ff918 CR3:=
 0000003b9bc97005 CR4: 00000000003606e0
Feb 23 05:46:06 c-node04 kernel: [125259.990392] DR0: 0000000000000000 DR1:=
 0000000000000000 DR2: 0000000000000000
Feb 23 05:46:06 c-node04 kernel: [125259.990393] DR3: 0000000000000000 DR6:=
 00000000fffe0ff0 DR7: 0000000000000400
Feb 23 05:46:06 c-node04 kernel: [125259.990393] Call Trace:
Feb 23 05:46:06 c-node04 kernel: [125259.990399]  ? flush_tlb_func_common.c=
onstprop.10+0x250/0x250
Feb 23 05:46:06 c-node04 kernel: [125259.990400]  on_each_cpu_mask+0x23/0x6=
0



Feb 23 05:46:06 c-node04 kernel: [125259.990399]  ? flush_tlb_func_common.c=
onstprop.10+0x250/0x250
Feb 23 05:46:06 c-node04 kernel: [125259.990400]  on_each_cpu_mask+0x23/0x6=
0
Feb 23 05:46:06 c-node04 kernel: [125259.990402]  ? x86_configure_nx+0x40/0=
x40
Feb 23 05:46:06 c-node04 kernel: [125259.990403]  on_each_cpu_cond_mask+0xa=
0/0xd0
Feb 23 05:46:06 c-node04 kernel: [125259.990404]  ? flush_tlb_func_common.c=
onstprop.10+0x250/0x250
Feb 23 05:46:06 c-node04 kernel: [125259.990406]  flush_tlb_mm_range+0xbc/0=
xf0
Feb 23 05:46:06 c-node04 kernel: [125259.990409]  ptep_clear_flush+0x40/0x5=
0
Feb 23 05:46:06 c-node04 kernel: [125259.990411]  try_to_unmap_one+0x2ae/0x=
ae0
Feb 23 05:46:06 c-node04 kernel: [125259.990413]  rmap_walk_anon+0x13a/0x2c=
0
Feb 23 05:46:06 c-node04 kernel: [125259.990415]  try_to_unmap+0x9c/0xf0
Feb 23 05:46:06 c-node04 kernel: [125259.990417]  ? page_remove_rmap+0x330/=
0x330
Feb 23 05:46:06 c-node04 kernel: [125259.990418]  ? page_not_mapped+0x20/0x=
20
Feb 23 05:46:06 c-node04 kernel: [125259.990420]  ? page_get_anon_vma+0x80/=
0x80
Feb 23 05:46:06 c-node04 kernel: [125259.990421]  ? invalid_mkclean_vma+0x2=
0/0x20
Feb 23 05:46:06 c-node04 kernel: [125259.990423]  migrate_pages+0x3cd/0xc80
Feb 23 05:46:06 c-node04 kernel: [125259.990425]  ? do_pages_stat+0x180/0x1=
80
Feb 23 05:46:06 c-node04 kernel: [125259.990427]  migrate_misplaced_page+0x=
15e/0x270
Feb 23 05:46:06 c-node04 kernel: [125259.990429]  __handle_mm_fault+0xd80/0=
x12f0
Feb 23 05:46:06 c-node04 kernel: [125259.990432]  handle_mm_fault+0xc2/0x1f=
0
Feb 23 05:46:06 c-node04 kernel: [125259.990433]  __do_page_fault+0x23e/0x4=
f0
Feb 23 05:46:06 c-node04 kernel: [125259.990435]  do_page_fault+0x30/0x110
Feb 23 05:46:06 c-node04 kernel: [125259.990436]  page_fault+0x3e/0x50
Feb 23 05:46:06 c-node04 kernel: [125259.990438] RIP: 0033:0x7f267d43b470
Feb 23 05:46:06 c-node04 kernel: [125259.990439] Code: 00 b8 83 00 00 00 e9=
 37 fb ff ff 8b 43 10 83 e0 7f 83 f8 12 74 b5 83 f8 11 0f 85 89 fc ff ff e9=
 e4 fe ff ff 66 0f 1f 44 00 00 <8b> 77 10 49 89 f8 89 f0 89 f7 83 e7 7f 83 =
e0 7c 75 31 64 44 8b 0c
Feb 23 05:46:06 c-node04 kernel: [125259.990440] RSP: 002b:00007f261aa6c9f8=
 EFLAGS: 00010202
Feb 23 05:46:06 c-node04 kernel: [125259.990441] RAX: 000000001e16f5c0 RBX:=
 00007f26281ff8e0 RCX: 000000001e16f5c0
Feb 23 05:46:06 c-node04 kernel: [125259.990442] RDX: 00007f261aa6ca90 RSI:=
 00000000000017a0 RDI: 00007f26281ff908
Feb 23 05:46:06 c-node04 kernel: [125259.990443] RBP: 00007f261aa6ca30 R08:=
 000000000000000b R09: 0000000000000011
Feb 23 05:46:06 c-node04 kernel: [125259.990443] R10: 000000001e16f6dc R11:=
 000000001e16f5c0 R12: 0000000010cafa1

-----Original Message-----
From: David Mozes <david.mozes@silk.us>=20
Sent: Wednesday, March 17, 2021 6:40 PM
To: Eric Sandeen <sandeen@sandeen.net>; linux-fsdevel@vger.kernel.org
Cc: sandeen@redhat.com
Subject: RE: fs: avoid softlockups in s_inodes iterators commit

Sure Eric,
Send details again
I run a very high load traffic (Iscsi storage-related IO load )on GCP.
After one day of running, my kernel has been stack with two typical cases i=
nvolving page fault.
1)	Soft lockup, as described in the first typical case,=20
2)	Panic as described in the second case.

First typical case: (the soft lockup happens on several CPUs):

Feb 21 07:38:52 c-node02 kernel: [242408.563170]  ? flush_tlb_func_common.c=
onstprop.10+0x250/0x250
Feb 21 07:38:52 c-node02 kernel: [242408.563171]  on_each_cpu_mask+0x23/0x6=
0 Feb 21 07:38:52 c-node02 kernel: [242408.563173]  ? x86_configure_nx+0x40=
/0x40 Feb 21 07:38:52 c-node02 kernel: [242408.563174]  on_each_cpu_cond_ma=
sk+0xa0/0xd0 Feb 21 07:38:52 c-node02 kernel: [242408.563175]  ? flush_tlb_=
func_common.constprop.10+0x250/0x250
Feb 21 07:38:52 c-node02 kernel: [242408.563177]  flush_tlb_mm_range+0xbc/0=
xf0 Feb 21 07:38:52 c-node02 kernel: [242408.563179]  ptep_clear_flush+0x40=
/0x50 Feb 21 07:38:52 c-node02 kernel: [242408.563180]  try_to_unmap_one+0x=
2ae/0xae0 Feb 21 07:38:52 c-node02 kernel: [242408.563184]  ? mutex_lock+0x=
e/0x30 Feb 21 07:38:52 c-node02 kernel: [242408.563186]  rmap_walk_anon+0x1=
3a/0x2c0 Feb 21 07:38:52 c-node02 kernel: [242408.563188]  try_to_unmap+0x9=
c/0xf0 Feb 21 07:38:52 c-node02 kernel: [242408.563190]  ? page_remove_rmap=
+0x330/0x330 Feb 21 07:38:52 c-node02 kernel: [242408.563192]  ? page_not_m=
apped+0x20/0x20 Feb 21 07:38:52 c-node02 kernel: [242408.563193]  ? page_ge=
t_anon_vma+0x80/0x80 Feb 21 07:38:52 c-node02 kernel: [242408.563195]  ? in=
valid_mkclean_vma+0x20/0x20 Feb 21 07:38:52 c-node02 kernel: [242408.563196=
]  migrate_pages+0x3cd/0xc80 Feb 21 07:38:52 c-node02 kernel: [242408.56319=
7]  ? do_pages_stat+0x180/0x180 Feb 21 07:38:52 c-node02 kernel: [242408.56=
3198]  migrate_misplaced_page+0x15e/0x270
Feb 21 07:38:52 c-node02 kernel: [242408.563200]  __handle_mm_fault+0xd80/0=
x12f0 Feb 21 07:38:52 c-node02 kernel: [242408.563202]  handle_mm_fault+0xc=
2/0x1f0 Feb 21 07:38:52 c-node02 kernel: [242408.563204]  __do_page_fault+0=
x23e/0x4f0 Feb 21 07:38:52 c-node02 kernel: [242408.563206]  do_page_fault+=
0x30/0x110 Feb 21 07:38:52 c-node02 kernel: [242408.563207]  page_fault+0x3=
e/0x50 Feb 21 07:38:52 c-node02 kernel: [242408.563209] RIP: 0033:0x7f27fff=
b9e73 Feb 21 07:38:52 c-node02 kernel: [242408.563211] Code: 89 6d e8 48 89=
 fb 4c 89 75 f0 4c 89 7d f8 49 89 f6 4c 89 65 e0 48 81 ec c0 06 00 00 4c 8b=
 3d 3c a1 34 00 49 89 d5 64 41 8b 07 <89> 85 dc fa ff ff 8b 87 c0 00 00 00 =
85 c0 0f 85 b9 01 00 00 c7 87 Feb 21 07:38:52 c-node02 kernel: [242408.5632=
11] RSP: 002b:00007f12a37fda10 EFLAGS: 00010202 Feb 21 07:38:52 c-node02 ke=
rnel: [242408.563213] RAX: 0000000000000000 RBX: 00007f12a37fe0e0 RCX: 0000=
000000000000 Feb 21 07:38:52 c-node02 kernel: [242408.563214] RDX: 00007f12=
a37fe200 RSI: 00000000017a9453 RDI: 00007f12a37fe0e0 Feb 21 07:38:52 c-node=
02 kernel: [242408.563214] RBP: 00007f12a37fe0d0 R08: 0000000000000000 R09:=
 00000000017c7550 Feb 21 07:38:52 c-node02 kernel: [242408.563215] R10: 000=
0000000000000 R11: 00000000000003f8 R12: 00000000017a9453 Feb 21 07:38:52 c=
-node02 kernel: [242408.563216] R13: 00007f12a37fe200 R14: 00000000017a9453=
 R15: fffffffffffffe90 Feb 21 07:38:52 c-node02 kernel: [242408.604094] wat=
chdog: BUG: soft lockup - CPU#45 stuck for 22s! [km_target_creat:49068] Feb=
 21 07:38:52 c-node02 kernel: [242408.604095] Modules linked in: iscsi_scst=
(OE) crc32c_intel(O) scst_local(OE) netconsole(O) scst_user(OE) scst(OE) dr=
bd(O) lru_cache(O) loop(O) 8021q(O) mrp(O) garp(O) nfsd(O) nfs_acl(O) auth_=
rpcgss(O) lockd(O) sunrpc(O) grace(O) xt_MASQUERADE(O) xt_nat(O) xt_state(O=
) iptable_nat(O) xt_addrtype(O) xt_conntrack(O) nf_nat(O) nf_conntrack(O) n=
f_defrag_ipv4(O) nf_defrag_ipv6(O) libcrc32c(O) br_netfilter(O) bridge(O) s=
tp(O) llc(O) overlay(O) be2iscsi(O) iscsi_boot_sysfs(O) bnx2i(O) cnic(O) ui=
o(O) cxgb4i(O) cxgb4(O) cxgb3i(O) libcxgbi(O) cxgb3(O) mdio(O) libcxgb(O) i=
b_iser(OE) iscsi_tcp(O) libiscsi_tcp(O) libiscsi(O) scsi_transport_iscsi(O)=
 dm_multipath(O) rdma_ucm(OE) ib_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE)=
 ib_cm(OE) ib_umad(OE) mlx5_fpga_tools(OE) mlx5_ib(OE) ib_uverbs(OE) mlx5_c=
ore(OE) mdev(OE) mlxfw(OE) ptp(O) pps_core(O) mlx4_ib(OE) ib_core(OE) mlx4_=
core(OE) mlx_compat(OE) fuse(O) binfmt_misc(O) pvpanic(O) pcspkr(O) virtio_=
rng(O) virtio_net(O) net_failover(O) failover(O) i2
:

Second typical case PANIC:=20

From the cosule:

[123080.813877] kernel tried to execute NX-protected page - exploit attempt=
? (uid: 0)
[    0.000000] Linux version 5.4.80-KM8 (david.mozes@kbuilder64-tc8-test1) =
(gcc version 8.3.1 20190311 (Red Hat 8.3.1-3) (GCC)) #14 SMP Mon Jan 11 16:=
21:21 IST 2021

Mon Jan 11 16:21:21 IST 2021
[    0.000000] Command line: ro root=3DLABEL=3D/ rd_NO_LUKS KEYBOARDTYPE=3D=
pc KEYTABLE=3Dus LANG=3Den_US.UTF-8 rd_NO_MD SYSFONT=3Dlatarcyrheb-sun16 no=
mpath append=3D"nmi_watchdog=3D2"



From the vmcore-dmesg:=20

[121271.606463] ll header: 00000000: 42 01 0a ad 0c 02 42 01 0a ad 0c 01 08=
 00 [122656.730235] sh (27931): drop_caches: 3 [123080.813877] kernel tried=
 to execute NX-protected page - exploit attempt? (uid: 0) [123080.813887] s=
ched: RT throttling activated [123080.821706] Kernel panic - not syncing: s=
tack-protector: Kernel stack is corrupted in: serial8250_console_write+0x26=
e/0x270

After I comment out=20


After I comment out the cond_resched(), everything looks more stable.=20
I Will try another run as Eric sagest with the:=20
cond_resched()
before the:
Invalidtated_mapping_pages
See and report regarding the behavior.
I think we have a very stressful environment on GCP for testing that Thx Da=
vid



-----Original Message-----
From: Eric Sandeen <sandeen@sandeen.net>
Sent: Wednesday, March 17, 2021 3:28 AM
To: David Mozes <david.mozes@silk.us>; linux-fsdevel@vger.kernel.org
Cc: sandeen@redhat.com
Subject: Re: fs: avoid softlockups in s_inodes iterators commit

On 3/16/21 3:56 PM, David Mozes wrote:
> Hi,
> Per Eric's request, I forward this discussion to the list first.
> My first answers are inside

ok, but you stripped out all of the other useful information like backtrace=
s, stack corruption, etc. You need to provide the evidence of the actual fa=
ilure for the list to see. Also ..

> -----Original Message-----
> From: Eric Sandeen <sandeen@redhat.com>
> Sent: Tuesday, March 16, 2021 10:18 PM
> To: David Mozes <david.mozes@silk.us>
> Subject: Re: Mail from David.Mozes regarding fs: avoid softlockups in=20
> s_inodes iterators commit
>=20
> On 3/16/21 3:02 PM, David Mozes wrote:
>> Hi Eric,
>>

...

> David > Not sure yet,  Will check.
>> 5.4.8 vanilla kernel it custom
>=20
> Is it vanilla, or is it custom? 5.4.8 or 5.4.80?
>=20
> David> 5.4.80 small custom as I mantion.=20

what is a "small custom?" Can you reproduce it on an unmodified upstream ke=
rnel?

-Eric

