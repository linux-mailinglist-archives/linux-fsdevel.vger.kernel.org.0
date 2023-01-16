Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E139166BB81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 11:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjAPKRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 05:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjAPKQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:16:45 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E2197;
        Mon, 16 Jan 2023 02:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673864162; x=1705400162;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=lTdCAuffutPuXwlHWB8OBnMxAz8SHXcX/lJaIL0zQao=;
  b=cXypnXI6u7CoWExe+ubZJZJqJwrT6U7U/kpz/hTlcGE9tVCxncn1H3Hr
   nVv7IOgGTDIQl1WPXS92EKBIdXbYBnRCYRUm+ETwe676ni5MNrj51E3Ye
   3LWYVlAFG1xwatTj1bcfTQyKpHslJMhN61EHlTXk+QCLTOrPcNMoWDUtX
   aCIcPlY/gDQquT2XnX662FzkkbM4DZNlB0jVeVGBO57F+5Anw/jiY7MsW
   GqKps6w35ti3q0vOyDRee9P01LbLyfKxM/hxBBRVM+/lKQcdGMdbXgyR1
   Zo+DFqz83bMm82qCtLvaWFNRSyywEorsSH5sfQh780088HlZBvlLTn/cQ
   A==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669046400"; 
   d="scan'208";a="325220449"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 18:16:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvgpauB01Ap7cx5xTmcnB9k802Uj9mAxRd2VLlxVSIbRUGrY65PWdvZqOmZpDykJiqQkBFBPQ2cdWQPa3nTdCnP9ULCmETqMRQ8IfYi1Ju87vuinbG8nVEZHNrC577owmoMVlz1pN0Skj4mUQ1DYpDiGETOvSvm3YO0vlFW4zNKngHYzAm8SNWm3jVaSrsA41rvVm+T7uUD4RNwekHRtVjBfAd0r3YjsWfTxsoRlh/4TUuPqTUCfhl2uqpB98rZsplpkuHJ5i6b4151XgHg8VfZrhzWOKqAtcxRZ7zCOvKyBtQgAXIbi3byEf6OQzEGcUlvsrpoeX9Lo598t935zaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/sUidFG2YniGgwahCRAbxwJXziRRiCpAvJVYAeGAq8=;
 b=j4mkUkJJu/GT7y/LA1Bn/FOLRaT6uPr4aQG8Xye8OXxwwczKKql8B51nSiJzGWOUfSNQeNoiWwAa6DtGpD35sCWde6If21cmh1BiWMKXDa/9MJNaKPRHna+apgfv7+GmpYViUUwC8MyNyyKyOwYcij5RJHsJL5y7o4eFeyxZxmQMNnpabi+jhOfTfdd8OLdrB600h6QmrU80g719HrAio66lJvp5jIGEZ1XnzC7dmgxBLC6E6N+FtQZ8wmvLSdeTIIzg4ixT+PfoUeaPfChhjQeHgoj/vUcMZY33rNx9l5+hlyqVxasLtuG7chMYy7te5lvnktY8scJizyxyB7dSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/sUidFG2YniGgwahCRAbxwJXziRRiCpAvJVYAeGAq8=;
 b=eHbr2wmu6dESB7+3Ilc+G6KwDeTXwfy2at/1ZOEiZHghtRN8T36ZTF8qVPTp10IJhGGchfqcLytLfHvTDnAQewnZ+k3nFyH27ZzyTSORrUN/JHqWLRNmq7k11b+i4edPHI8Xfy/hczzooibXerCHd10A+49mAR/v/jeG/TuUTHE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB4798.namprd04.prod.outlook.com (2603:10b6:805:b2::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Mon, 16 Jan 2023 10:15:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%8]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 10:15:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: btrfs mount failure with context option and latest mount command
Thread-Topic: btrfs mount failure with context option and latest mount command
Thread-Index: AQHZKZOGTdIwGkiZ2UyjMiGIEgdYFg==
Date:   Mon, 16 Jan 2023 10:15:58 +0000
Message-ID: <20230116101556.neld5ddm6brssy4n@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN6PR04MB4798:EE_
x-ms-office365-filtering-correlation-id: 565ff988-609a-477a-3fe0-08daf7aaa92f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLzLkxnnmgbsiREjO5UZ++DOu/4WGNK1NeDygMiXO9few+FaklZ1t5DKDUBjn2RcfpBTFqsT+mYLlpljqZPYy95q1gE0Cz4e9Vgy1x8b93Be6zU6uPtBSZJ4dMwNApF86FtcM7neFM8NWY8XaCNKJ+gSou6RtmS8hjDFaQCREPd9yVePRz2dgM+FzuBB0T/skGIwwEdx0Xsmuo6Gmmvp6wpKTjDJ4ciRSUiPwYB8yujBKy4uAPmDnaC0/wxfw+dQ9zx87XNXK+x3kGiZrx0zwrVlqGXrE4ugwWd7o/dEfic1m063+0YMkv4vs/aPSFyIpvLHDSYqCPh6e3wX6SVa/1TQBY10WWYLuBraoZiIKdJZqdqXzC3FOYu3vNnFiae77N4SdQUENaD1Fs8I+tJ9iZKxep06dqV3PJ8SpnDsI+p/pyCtzHovhjRCO013VvRSfyCoDOBIviAgt1Uf0ZTwBlXVjR9yZk4Xzv/H8MVmCKFFYyj7ozzlqaU5KHRSomWOxXcS//kPL4vcz4r2bN5VjGjS/6gSFckNjLY7fiXGDKhDuhSC2gaU0MEIs/kxdICKMBfnlkPgwwAaumGJ2wplN2Sr1VCryZYd7KBmbz2rXQ+a+SkmiJxLq65UnAqsy3NNg6LsTkfy7IzAjXDn3K8+LA7eaTU8JaTnB2t8e5gfAFbyDYr1bn4MFfcSv0u71lAWG+5/byP2nw6t+F8DC3cteg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(86362001)(186003)(6512007)(9686003)(26005)(450100002)(91956017)(4326008)(64756008)(8676002)(66556008)(66946007)(66476007)(76116006)(66446008)(41300700001)(83380400001)(316002)(71200400001)(6506007)(1076003)(110136005)(6486002)(54906003)(478600001)(122000001)(44832011)(38070700005)(38100700002)(2906002)(82960400001)(5660300002)(8936002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AlG/xi0RvNDkW9n/g5HiBPLcXPffYyzZtBcX4U/h9AhtjNAQkcaW9QKuNcGV?=
 =?us-ascii?Q?b3lFOelBfczbuiPjAyJtUfQ5ZdAjan5EK5HOUc/w/M25TAtoMdKfFi0XEICR?=
 =?us-ascii?Q?IV0YALvKOW9hgo2pTE5VHjQ6XhlbNAGp7J3ZLJ+BRJm34/ffE45Qx9QoojfV?=
 =?us-ascii?Q?DiJV7C1Rfn6KnGrWZQSFKxHjpYrp08X8QgnmlK1v8q9b7N5mEqv+2MREhExM?=
 =?us-ascii?Q?3ajjifYALkC/rUKIJPld/X8T08OLOWIcJk+6Sk+WtOQmb+7o5skuqrXQZL/X?=
 =?us-ascii?Q?7xd7x3Aosl3f3Zp9qNtpNNmIfpGh8F4JyV1QLnd+TBhqH7esFqkb58aJFOXu?=
 =?us-ascii?Q?lXhmnVTJaQhJlsm3fcio8bugGnQhSVeoIAWwXI5fJbqHxD/vzdRFO3AHHi7y?=
 =?us-ascii?Q?mKKzW8LyCpC59U8mbYQVsQrgZ45/jGhdN5C2JAO91sYPsD1KOBqnAkYOnjBH?=
 =?us-ascii?Q?TT7ikH+2HGT7hHxbYPpOhAC0F2E+Wrk3sLcWe4EQatHvG9vdZIkGGzT+heR6?=
 =?us-ascii?Q?fvXpJDCapOUFS550S6O4lQbCwusbcrUKrXADG1DHoU91YyAQwNrv5sw8dkBa?=
 =?us-ascii?Q?K39KCDMFF0Yx7wc8x/q2qvk2SbeAPgaB7UVBgZniVWiz2vgwFiqeWLi5FEAA?=
 =?us-ascii?Q?k+Gff+lq35SV5E6JyQXL/BpGUxtlzPN9C9drKOXHAfsf+h1MlJtOi5Mfym60?=
 =?us-ascii?Q?sy0pnD5jF0QebbX23kvcNvELcirB/OO/zaKF0oT/UUi+ZdcZupyBW3w6bFJz?=
 =?us-ascii?Q?zKF1h8BQ7I7OFhGF2j4GnmovtqcFHtV2iAT+Ee2bS2JFX2nDvr3Q9X16rRo/?=
 =?us-ascii?Q?KhpQX2oKsPO4gQR1MJLRXRuG7AMKvnJvhQgx/RMlp7/d0e5hNw1CR6RH6RDI?=
 =?us-ascii?Q?iQP2Skvb6CrkbJnNh3WtmIftG8owuj9oFRTuXOjNcBbeuPeS1bHf5jghTPOT?=
 =?us-ascii?Q?EnOsJIrj8W7gyXKtyxaSXKU/AyVMsTmDuwsPLr0xS8sG0BgLH26H2yEKKkI5?=
 =?us-ascii?Q?UaAklfv5Y2mgiQ+d+n6LcHaWIwhepJuDLkqC1baZDrlsG3jwkkWsjQPL2tEI?=
 =?us-ascii?Q?RQiPT70GKp0ax06cidxGGPs4NzFSjFzSG2EiR1h855b1olBV2FNchxgImm2S?=
 =?us-ascii?Q?hP3zzM/ObTtq6m2yAFMynhO0ikY1dlEloyz6kpqZlLVgwQbaul1B1lRGmoJu?=
 =?us-ascii?Q?IskW7dxk97kxp4tCIB0pDA79j9TH62BpdyG9Hcj80Va2DeRmMgVTbZriMSyO?=
 =?us-ascii?Q?nUN6+ANvPVBqa+O7xvcG+IOWeYkxdfPxZKcvOvMiEMTq+pPXJZfTA+s6gYDZ?=
 =?us-ascii?Q?rjm4HBBlSTe2mkFdJMlHpVXl9B1YDzP3tTSNtA2waLMjEtsTS9q1mARs5Eb8?=
 =?us-ascii?Q?lLzcH6ZJy856bdSU12oGLXU98PT7N9UNhIV7bJZIVv/WDqUymlEP5tYvQYmy?=
 =?us-ascii?Q?Qye8Yq8t3lnF17aeqScrN5pTuBgRM21gXVgw+a7ejhTKHU0dyjUupL6vFu4C?=
 =?us-ascii?Q?OH/lHsupAPvcj02IfWZQVudrk/K+BhupLTn0zBQXoMkTEgor3qEBveMd/E4Y?=
 =?us-ascii?Q?yIWzPJjwqTTfJLcwgxWq+lQ/4KaDeUK1k9KNcqlMs4k4Q+B2UDbz+6jtA57p?=
 =?us-ascii?Q?EBlm1t+kgtyov4NFZGUeVEU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DF4549D25539D40A2FC8F6A25A3031E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1GzoLx7F2adznpEtEsSL9WK7QthbOh0cxeBgi0REw7PLyPSTCSl1ekUVhga+0P68cZT5jtFpca8Q+xmNl3GcWWYBMRyWlUOJ1TN8Y2Sh8MThrBsRF5Vpc0gPXInZdtbhPdys+1jvNvLDjCO+kQY4pqcqHR8u5ol7TxxVsSRg8qwWiC53iZfFSTUpmCVnMFWda9R8m+ROXH9X4U1X9gYnxoOY/qCL5AIWHtwlhQooZJ+LT97XDjBSLcS4Pmd8NbS7hWtb2yr+jlm/iltUCFEI38ltsiWIoXTGPKC7WLR9mo6EgQYcyl7av1S/4cv6NURykFG5tkxAGrkI9D2/tS7CAj6H/nyIVcz/LtqY0hEKomwvX4Usy19xOnF0MB04hecvQeaDiKnoX7tTXAXJtBTkb1wluY1yzsnhAamqu7JCyd/bL6YuQdlJqQHUuVKf9N6sALu2dwHvgcDz8qdriHDkM0LlQZF7wMXfv2bBjo+YbD4K75ssZe5U8pwPN+TzRAYe+rUqlvNh6MYSbkTZItVx1Brcmi5buy4mpOujgh5SxiKrajJ6FJi9nm3Y1GcgmUw6Rsp+0Qq0rUno+ehCNZr+RSQy+tjHu/Hyy0Dhhqgt7M3UjVIpNuVhZSjFZp0/8E1bx2okch9TVcrnDUjnBofJpnxTzDbYX+8J5i24xYMbb0QltngW5WGH8BROycFjrkd82vJDhU5kSthVzmU5AYws7daJi1sytYZnk1wMWy654UNxukAX/NwVbW9ZantkA4p1W0oQcBAcipcfd6QxSVEWHrzWpBsampllXl80TM+Hzps=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565ff988-609a-477a-3fe0-08daf7aaa92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 10:15:58.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AuKR6vllh1ZC6a7oFgNoFWeWDFVvBv38a1AciGleNAECUyzQb9O0voZxreaGmU6X+Md9Ol2xzl/MpaXVRB9fGqhI4dyMUgP4urDu7MH3mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4798
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I observe mount command with -o context option fails for btrfs, using mount
command built from the latest util-linux master branch code (git hash
dbf77f7a1).

$ sudo mount -o context=3D"system_u:object_r:root_t:s0" /dev/nullb1 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/nullb1, miss=
ing codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.

Kernel reports an SELinux error message:

[565959.593054][T12131] SELinux: mount invalid.  Same superblock, different=
 security settings for (dev nullb1, type btrfs)

Is this a known issue?

Details:

- Mount succeeds without the -o context option.
- Ext4 succeeds to mount with the option.
- Mount succeeds rolling back util-linux code to older git hash 8241fb005,
  which was committed on January 3rd. After this commit, a number of commit=
s
  were merged to util-linux to use fsconfig syscall for mount in place of
  mount syscall.

Then the new fsconfig syscall looks the trigger of the failure. I took a lo=
ok in
the code of mount path and saw that btrfs is not modified to use struct
fs_context for the fsconfig syscall. The -o context option is parsed and ke=
pt in
security field of fs_context, but it is not passed to btrfs_mount.

--=20
Shin'ichiro Kawasaki=
