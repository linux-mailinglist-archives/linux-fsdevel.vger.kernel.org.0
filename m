Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4F318EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 16:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhBKPbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 10:31:47 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37659 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhBKP1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613057243; x=1644593243;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=e/1vwhvj/iibh8ZYR/BO4fRwpCQuPECY+WHYKJPAOoY=;
  b=QCEOfswwzVhEoFgmH5MVbw63c6wMt9skXTV2AWP1bf1E4w/YNPN6XivL
   vkLNXzKP7QBoPxLl2hTj53Ybst+N+Ya4LubuN4HFBxSCaEhsYiatVv2Op
   6W1fpxu6LAQQViu0lN/DQffuFZiH1nUS+b4jGBNPPxXLjP30S2YwKCd2c
   mCn5KyG8Td1fQW0EIi9t2YHeXW7EfnyS9dZRDFPCvniDMAQBcc6R0DTl0
   yeLBdrzC6NAM3KJgwY7R7+sDyNIcT0oFwwTM2c+PCd9ZM9Oquu/B8Pqt+
   SOB48Yr0t3oS6wOdCjkUjBh7spFITvFfKZHlCvh0Ku+EhlO/ji0JVyks2
   w==;
IronPort-SDR: RsnUvlU01be8mK49P7cvVFV8sh1loJgg76lXheMwdCZQ0+kdFTsZ0gnKISexGlnANtAGeyvO7X
 ruepvT5WPG6dfBx+qqwtvlnEc6KWL5LzVmR4mzjyU5ncu2QIIYgYwqU3depVv+CoIKlm6mVi/c
 l59RpbePLtHLsdj0ymoWBRPj7bhvrBV80JM9C6lrd1cFX/AVHJA/ron4u67qZF7I8MaPZtlGkO
 fYOE8N6SFu2JORaNXul/knQR1SsUwfC/76zbwV/B4xIqBUTqEy+Lykdtht9p59RWukxYKWSVSj
 +80=
X-IronPort-AV: E=Sophos;i="5.81,170,1610380800"; 
   d="scan'208";a="164238205"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 23:26:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCWO7y5xmsaTJbvHm8BpE0J8MnEG7wbzdRYSn6xEH2zQMao/4q2qYjQMRyy+4QaAEdQ4iTq18hxSZ//dVvrVWoiK+J3h0RkS0nR4UaIGy/PciMPJB9J+nlzClc04XUxH30Nm1lzYKyxyGLb5JknQe2p9DFLqcqLoXNmcdaBGolt8plUPrSpgwU5I0ri+9znp9mrKbB5o3AnddUb8Tj1VVrcyoJ02f0NuEmvRrJGAldtby2lkXSJeDwl3QvVNb3clIeitLa755slE1q4d7FsCYYA/NLJljUCZXS9vSIkJiNCJvwmEXlaCBvflczcl3RK5eN9q3Pk3WFg+XzEYbZyl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/1vwhvj/iibh8ZYR/BO4fRwpCQuPECY+WHYKJPAOoY=;
 b=BjVci0MJG+cLJVNdARSidaHQNat6ksiLdUIUOsyaly3KWmuxOj8F5VrOgB4D4LanlGcALMc87eZois7n2jyJpkL2EhPeON2KBjE4f5xGYlIdMl5JIra+X1Y149peP5YHcg09Da3wjEt9bc1lI/tkokIKFdQLsZV1DP8WN3UgDyK2zGlGOtfy2WcGpVS0EoP7BcDYzGQLBR0CvNW1dyaCATDiM0APhYV+E8mF/q/HQ/UOk6MVY4TM0xdMoH6A3mu1Kyy7qV8UJYFNU2dg4VDhUDXWZUii4p0Y5tZwqDQqbX4xjdaQSrY1hkAe+Ngbrp70i2M01waCx5lRrLoXAL4MMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/1vwhvj/iibh8ZYR/BO4fRwpCQuPECY+WHYKJPAOoY=;
 b=bmSf6h5EDzEIEXeI1/iFwC6WqYNP9TVgEsKm34iyASWshr+d+wsf+LnJcfCCB8TFryckTwkygC0P85aYImH9n1+NR6r5TI+Qyg5pL52gxgTmqYDca+sYwEPpwiLHqXQuwur5UGDfzrPJ1Sq5dQpO0qsyGhNJexR33937Vs7HEHQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3807.namprd04.prod.outlook.com
 (2603:10b6:805:43::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Thu, 11 Feb
 2021 15:26:04 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3846.029; Thu, 11 Feb 2021
 15:26:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 00/42] btrfs: zoned block device support
Thread-Topic: [PATCH v15 00/42] btrfs: zoned block device support
Thread-Index: AQHW+uBDi/qAxtbkv0uUNvQXEiNsGQ==
Date:   Thu, 11 Feb 2021 15:26:04 +0000
Message-ID: <SN4PR0401MB3598ADA963CA60A715DE5EDE9B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <20210210195829.GW1993@twin.jikos.cz>
 <SN4PR0401MB35987EE941FA59E2ECB8D7269B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211151901.GD1993@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7811aa06-ded8-4072-d314-08d8cea1587a
x-ms-traffictypediagnostic: SN6PR04MB3807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB38071619A8EF37D4CF308F329B8C9@SN6PR04MB3807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBeIeztPcewDZav1Hy9tEEZWR0MAa8X/zYYad+uWWRqAbzaKXkKXW5YBlK1CYrgoYFY33tBm/ChpLGnxgpc088q8tm8T6gJtBsIfc7EUzdHKJS9+tFfKdmE2Z/5ILgOc65QQIBcS3mRGFDhBAYbi01XAkFILUSFNlVnMj5RvO2neyf75tSE7NvoIOnzAmwKwJsoUaIK6byUSq/vPpVmUSCay+7nd1UBIDkf5YaDyEfNyaCT+OtULzM5ZvarQ8SJ3+okxNCOmvq2lJQuhfcE5ESFeQygUKwgL2DsxFI+SF9nB9YaPCK7HkmVNL3TIUJpSW6dEzp/+c8CfAsS9o916lBp/TqlsieTiy+0gFyL5G+YVKEUkIF5DxJyHAZrZxdH5X4TuoiHnX2O5V6yzCoAavs28GN+sA14k8ih3XVfr/kdFaq6fWBFtQLArmiwlF5XsCysKIu+y6aMWdhCI4DhwcO6b0y/I9oASOuj2jml8BtCmuN+S8AwQd4RFTT5ykwneMPn+KP6lKRj3iNlyIEVu4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(4326008)(478600001)(186003)(83380400001)(86362001)(7696005)(6506007)(33656002)(26005)(66476007)(8676002)(71200400001)(53546011)(66556008)(2906002)(6916009)(76116006)(91956017)(64756008)(66446008)(66946007)(55016002)(9686003)(316002)(8936002)(52536014)(54906003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DkExhCUtQlkpOe1Hg4xdJTQt2CuqxWz85xnNRwRPRPskSgCKTSSeQle5+2AO?=
 =?us-ascii?Q?K6O05ePzf6+4mtJ5dDL9TASOL23cZwZ+So2LEGvmNLk8JmonNPxLNPA9ZBsT?=
 =?us-ascii?Q?yw9j+hw1myDIE2wrbARWnVCGZtq4E9jd9jPNtAKYSkyrjwUDkD8Wnv4Rmu9o?=
 =?us-ascii?Q?U9FnuywYBkIB5jB4pgH3NbZdic6noz1RY7VfNRNkAsw+i3XWsmeCClclYTkR?=
 =?us-ascii?Q?IIN+k3NCVA1iP/dB+xWlBusD2+8Eh0XO39lBegkB3vrk4wNnXNwaJMy+emiW?=
 =?us-ascii?Q?irH/rZDztXa7VgItI5BLf3Btq6Afb1v6iNJxBnMI/ks1rZsK6XjKtVJfer6Z?=
 =?us-ascii?Q?VE6OOPIt7UTVmV/GrAUwSxfyETnVGlibZ6K015a0UesQIrXlWFCl+sC436P6?=
 =?us-ascii?Q?P+EGMO49rCjEVp0f4uOHr9THkWDLGlYL16rSj0GHZ0j3Z9khWu2o7HYyugsy?=
 =?us-ascii?Q?76quRe4ctJxlrhbBByx/vxuMhkjCLNPLXwouEW/CAI69rDg6p3ueouqw0FsG?=
 =?us-ascii?Q?31qaQxvIjlfsgK4OMou3GcJ7slAdY8xpFobFedHHDfHtFe40FWJ+KlvQAtvX?=
 =?us-ascii?Q?fg4zz0q6dhbNfA1+H0I+UyBYuBHn6uO4HqK4pNYVJUJdxPF6LVkS74JJyHcg?=
 =?us-ascii?Q?rqS57ChNdeF9mCd26j4U/u4IZW9hxeXYmYu545iEG2tUt6zPMIc1huZ7YATd?=
 =?us-ascii?Q?2AVQ5Lp3BfdIgJKWI8m1QFrRwuLE286SZRi5yCEzD5TOXGeCHVmBRnKVUcd5?=
 =?us-ascii?Q?XitDtHQO5DX/pVPr6iIGz8JD+X8bGWe5//F9F+ifi6pgWd7ykmob7T5YogtU?=
 =?us-ascii?Q?wou6RIClXALbmgQfy3LTk1gRKSSd7qeHR+JBZ4Qev5Fase7aWaPTT9FS+0Jm?=
 =?us-ascii?Q?18s4mHcmiHQMJB6KJpJGI/Yd+wkK1SEWZKA6rqfc2yOpFBduXHIh5FPM7pj7?=
 =?us-ascii?Q?/cjAUDbU11zrMfhG4g8X3XaoM2wNB/5ZIgIOvq71mYjG66zMTKj4drs9kFhq?=
 =?us-ascii?Q?ysG6x9qhipO+oJMCkitfkJSjEqLa0LHCgXxmVrhM9EgAbzrDjEl+6CKmzMoS?=
 =?us-ascii?Q?BDospEKyx3XmpTXUjn98dHzqGGxX0e+Gf/CTPB0NzYWumft+ZXtaIi38x5tH?=
 =?us-ascii?Q?AEkC2v1rYRcYhwdLqwUAiBQ3HdZG2ciNMo7F/rnJBsKkC1THqgEjWbLAMgrW?=
 =?us-ascii?Q?ljGd7aDltmud4j5uhBLaMTdmix9lZsVruqO6RGGVcRnI/6zWDVkiaVaynTpz?=
 =?us-ascii?Q?cPsHuixtydz/8dcYxD4/5vymgEdH+Es3UOeYRXw659QxMdvp+fs/v/34cqiG?=
 =?us-ascii?Q?ucDm9l+Nt3md9YVkAGZcUG/2ffmPscQLSlUic8MpRx5Gyw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7811aa06-ded8-4072-d314-08d8cea1587a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 15:26:04.1316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RQmHPrFB4QGhDYV88qEzvk/+8izT3PolwysnzRq0jA/dy4RMi0+p19OICHjx7UXFAX94Eri+vp1+P6MiFNe8d7sy6x2OWPioAQzI4VZDR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3807
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/02/2021 16:21, David Sterba wrote:=0A=
> On Thu, Feb 11, 2021 at 09:58:09AM +0000, Johannes Thumshirn wrote:=0A=
>> On 10/02/2021 21:02, David Sterba wrote:=0A=
>>>> This series implements superblock log writing. It uses two zones as a=
=0A=
>>>> circular buffer to write updated superblocks. Once the first zone is f=
illed=0A=
>>>> up, start writing into the second zone. The first zone will be reset o=
nce=0A=
>>>> both zones are filled. We can determine the postion of the latest=0A=
>>>> superblock by reading the write pointer information from a device.=0A=
>>>=0A=
>>> About that, in this patchset it's still leaving superblock at the fixed=
=0A=
>>> zone number while we want it at a fixed location, spanning 2 zones=0A=
>>> regardless of their size.=0A=
>>=0A=
>> We'll always need 2 zones or otherwise we won't be powercut safe.=0A=
> =0A=
> Yes we do, that hasn't changed.=0A=
> =0A=
=0A=
OK that I don't understand, with the log structured superblocks on a zoned=
=0A=
filesystem, we're writing a new superblock until the 1st zone is filled.=0A=
Then we advance to the second zone. As soon as we wrote a superblock to=0A=
the second zone we can reset the first.=0A=
If we only use one zone, we would need to write until it's end, reset and=
=0A=
start writing again from the beginning. But if a powercut happens between=
=0A=
reset and first write after the reset, we end up with no superblock.=0A=
