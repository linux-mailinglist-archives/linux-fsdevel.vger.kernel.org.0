Return-Path: <linux-fsdevel+bounces-2895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F05107EC4FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D55C1C209C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8E628DDF;
	Wed, 15 Nov 2023 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YR5qURRe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gQemDTNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5B28DA2;
	Wed, 15 Nov 2023 14:20:09 +0000 (UTC)
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D1E1;
	Wed, 15 Nov 2023 06:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700058007; x=1731594007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xBMZYjdX8dmXlsdQIMxPXXXFZ16cTzoyA4Q0DnI8XF0=;
  b=YR5qURReiOxS1is8ngv+VM2Pp+e6mpIPQcIOr7HsvwX5jmFzBNyK8eoV
   6obrPdHj9CKG4velPNuIniwdswYuoyRFnlIovjGHJDx8J3AlSUYy0T60e
   2MXV40v7Jrl7+rgFEnsunOcRkzUEDg2n7lOQDBO1zbdLaJ4JP5cbvwNFf
   57nxuMFSNYJW2zy6BXLutvUoJnrrerkJaHRc+mc8lHCwxsJcnecQ6VZot
   LMFLUBmOYNuP8DUy/J4qqyohaSqYJUHCpjhx7KeigXXkrm3xq5bIrxa8Y
   qG8ldEnBWcBvnq9vMWXAILHdRhWJ5hzaHrZ6RwnOjyi+grC+frtwew9WM
   A==;
X-CSE-ConnectionGUID: 5BX79BJMRvC5Uunoitk0hQ==
X-CSE-MsgGUID: tfEibyedRdiBcLmYFUMlqg==
X-IronPort-AV: E=Sophos;i="6.03,305,1694707200"; 
   d="scan'208";a="2434084"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2023 22:20:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot9WKaUqfOS7fhNpt53bQXBvMlmr4RiNwZd6++Y4bwK/7aDjiILRMNBbCvJQWrEPmA/1zd3q8nZs5UVQYS8QHaA8bGxEWvSIk1Bk/7bTbyjVKraXf1VZf5svNJkmpF7sdKWTVIbOJJTUGP+bTunbx3ILG/NIeKfAy7HEEWUFjxaY5+2KB8cN8SWtVzbEf0lKpwQGNx4QGYuSMXeokh+Dlp7kfqPOueKNOE5HFmQhESLrzlCRdyJ3ruudwpXpdTnNYXPoPutOW67VRxMAhi3FxpvfSVJtkiIu/h0qKzg+AREAcnRTel5XnwtioqRtOVk6wZu3RttOxyFHFpwjk9k0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFlKj3Cm+HXhOrYJKyLh64Dok931k45V8grC0tQPszk=;
 b=c5X6PNWQ7ayrcsQ9snqUdUgvmrWehn/qETDdoe0ic1fH8qQ+xXuwvdjbzAWlZpwa0XXqykxAWTPHmJBNbSJbLfEI72FOiUWPmDL+2dYb2yy2Lop1ckAAZPFZs5aw/o90uTlGrXT7o5B+xZMAsqLHJP20RTVhtMlGByFJxNK9FuxVq6I13maIyzr6ACMlG5zeAuWBHePCMHGOaPtPHkjsQQb1tf7JoPaf7F5aP4gfgyEFRGj0ubLeVQdWNbVcze2movcH0cNgPCsBNZfrrpZeSvNpc0e/BT7pXRcMBdOk7IMwMucu7Kp5c8QBY2Gf+Gf0wEOIivcocK3srtpB3p/slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFlKj3Cm+HXhOrYJKyLh64Dok931k45V8grC0tQPszk=;
 b=gQemDTNThIwwcidMU6X8KOUwgN4AKDFuV1k/WIr4TQPU+s6GE0UdnNnfkqps8FJikOsSQs6GFYhJY8kd4GuVMNISH7mUcSOIuLZwAoXPC5ZWI8M9etFJJKVA7I55RMSC6DWpGzHAY23L1cHVN3b7G9CYCBDMhTZJwQ8sskeBSLM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB8433.namprd04.prod.outlook.com (2603:10b6:510:f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.22; Wed, 15 Nov
 2023 14:20:03 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 14:20:03 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Ming Lin <minggr@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Performance Difference between ext4 and Raw Block Device Access
 with buffer_io
Thread-Topic: Performance Difference between ext4 and Raw Block Device Access
 with buffer_io
Thread-Index: AQHaF87SuXWDUcRjnEWGkpoRp+qAVA==
Date: Wed, 15 Nov 2023 14:20:02 +0000
Message-ID: <ZVTTh/LdexBD7BdE@x1-carbon>
References:
 <CAF1ivSY-V+afUxfH7SDyM9vG991u7EoDCteL1y5jurnKSzQ3YA@mail.gmail.com>
 <ZVSNIClnCnmay8e6@fedora>
In-Reply-To: <ZVSNIClnCnmay8e6@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB8433:EE_
x-ms-office365-filtering-correlation-id: 226299c0-30a4-468f-a332-08dbe5e5f570
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QZ8RaetndVEYjTO2yZl4GHVxgaoQTW5S2v4NbTzNd0rBbSI1y0Y0IxK3hS1DOo3N8m23qDJEa19C0vzFLQ78BKaHlTX5bVfq5X1t4LEDuG0pLVeIRmJWQ4e07AEIP653v8UrOdycQtnjGYZMs6ok9mEHiVbBBa5xS7NAkNTxqpMLqzrNP1zqVlZbuMbWZFb8xSrNLBQ6jgl8y8APKTu/rW0ZpbTjQSvqI9XSoKXGDjJQ12LxxHyhF7JoRXEiXSBylvWXTqXqRiIGTp/XPo+9LeOmrDWnyzciO8EGMcyAlYxqRjxRyy/nrd+EAYF7h7y+LiALpTPMGJvoaQI7AuBV8LMM4LJaNbWhdVBMX8lfh/T1ygaProZOVjzLmJ22khBHK/8xrOhq8ZamPR9V8YWTULUdhLkJc7zW7kntg4+1Ps+TM9VEvAe3Va+hTDek1ljbdf055fjuDpDaUwTMfTf4QjEx1ZUp5Poc1WGmJdhoJsxi0XPSPsHYldwzMFBJlPHz3AKRby8z2OviGoa22XGKeDYOgtC10KXFHQNe0zBXPNaJaSTZLAGrzk46jFrniUX9tCqt7y6eSyjnuD0SwgcFaqEjZatOjyLSbEYNl12Wri4k57T9IZ/ca+7M0qIPwqv4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(122000001)(64756008)(76116006)(66556008)(54906003)(91956017)(6916009)(66446008)(38070700009)(38100700002)(26005)(66946007)(66476007)(316002)(86362001)(82960400001)(83380400001)(6512007)(71200400001)(33716001)(6506007)(9686003)(6486002)(2906002)(478600001)(8936002)(8676002)(5660300002)(41300700001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CxIsjqn8KRIiK0nBWAwZ+qX7avd3C8O6vMBG//TVNAfKA3AdXK0Uoz6Beuwf?=
 =?us-ascii?Q?Um2NmJFP2MnVvZeaVLgVJ8jrLP+fs7y8B+nSu2bWAL/gqTb/eq9BMPbosqna?=
 =?us-ascii?Q?XogvjnqoCx029SU59yFAnxNlz5i/ToyMFS4/mT6brVmO+9cx9tk/ylnn0zOF?=
 =?us-ascii?Q?daKCAdaA70TWbh7gTzYGu/1CY6buOSo3hBDAFAOWA0g78Co800dKitFVTlDd?=
 =?us-ascii?Q?yAlbhNzFQMO7c7MncudNNACvTxwboRwJqXfQ1px8bNWlSYnwaGm8RJqADBEp?=
 =?us-ascii?Q?zWrN6rz4mkvmblitbLwDahnC/Sag1Hn4Hk+WnjB4ddf3pZA6JETZk95SEroZ?=
 =?us-ascii?Q?ses782Uhe3Z3GtXO3OY3UWt+FkAu0/HObDcaUMLw0lmw6zbScMi8uHk78cKw?=
 =?us-ascii?Q?0igb2yPNKnYKxDHUx/EiYTWY00bUcWtTCtNm/JpQkhWWWbS/Dipi4L0P3xMC?=
 =?us-ascii?Q?YrlESMpHxGpZcOG/mw+UxLi2AeQmuHqc1vqfw/zqAGvPG8bhe1guu9Rz31bO?=
 =?us-ascii?Q?AEVsfZYHD+4LwWm29vCw9PIgTVsATDYa5iGd69ZZ6LWkpnNzSgNiQsKWQG6u?=
 =?us-ascii?Q?GLEQy/DgTfO90SCnt2qzdzz4hrB/sWcGXdg2DJrKoKCvr+BAA+JipK57VYHv?=
 =?us-ascii?Q?Tcv3d6J/5e/gcnjmFRDZ/47ab/fkGvVoJNe+tJiyc4qEO+5vuwi1F8084huF?=
 =?us-ascii?Q?mMeNonOijZZ97DtZS88Ww3yd9f7roS3P+hUOVNa4xlI5ra7lr28hMaGmfgZp?=
 =?us-ascii?Q?Sgp9FBGRtI4BnIwY7vBIPSW/LUg2W4Q8poNrzcMF61Z29fbyuxifIyBZ6P2m?=
 =?us-ascii?Q?dq9yY8I9m9LKe/iqj09LHxF9x5zgwIc1qRRKMVKZJtb4/Lnmra14EGUHXWqT?=
 =?us-ascii?Q?aIWqMBLv68Y3gJXnsTFQixYoDwRScmP2anMBJAmHLwYjOUPD+vyQB8JG5m03?=
 =?us-ascii?Q?qo4QT99eQZGK8HYfs9MIdTrrKkHIXuIxZr5jTLWFjB5hH0EGXNShZPFsUH20?=
 =?us-ascii?Q?qqtbI8A8YhORghQ7T7fBtG9R+0L+n0K0TT5bvC9EJGYL5jtF+lnGcGIKflQs?=
 =?us-ascii?Q?UC3FZ4AX6yn9AUHu5ljVeoeQLHZqfBiB5tZQZ2nYgqRSU9AyXV2EtBuaoUcy?=
 =?us-ascii?Q?guVZV/Xiif0v8RDlknbC/LTi35ztB4Iu5N75wyPtOW7/7w5S+c0lWSKRdjWW?=
 =?us-ascii?Q?MZfXUdnE+h4Lq0f9NrEakBwH+KYUG1/wsF7noqv3ZiMMlG6X5+eBLFQyCWA1?=
 =?us-ascii?Q?1zDbOQd7ixxxeTyKV/5l23wK5Sug25UqWAuSqo6kCgoh+gNO4vUhEaPXmkwW?=
 =?us-ascii?Q?38sQxELRmFEA+YfVQiw9DBTlqUAkz/mlQyjusBPnLp15xNqz0VNUWWVhXyby?=
 =?us-ascii?Q?JBz+qlgG+kleeVVM9DRuMSUw+uoYysE1jeZLXCGfmrTaJnTG8iaU8Ucm791k?=
 =?us-ascii?Q?sBmYZeisocg9hnLK5heShUQ1ai3crneAtpRYy0WkrrbmNG+e3VzbHL7yoK7b?=
 =?us-ascii?Q?so0NBfO/gTgHVqae47KhjvZ0aLPm2n0Cm7aWUe1MmAsV3Zu3oEPX3RuF7jZK?=
 =?us-ascii?Q?XaETYk5P53z8bj2QAp8dP5tvFSEvJdk4YWIbLhjqbZoVLnt20KuudGoZlOHN?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95F2C648D980BF4792B415C7BFED0B8A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eGpWWqdEKScmH8Ge0WkxLnlUuixa0mU8XNmIXejZXOIhAbEMDGECLV/nAgMEqmu38aA4Fdkh6766U2OAeH6sLWAbGFQMAU/6h0STklDn+wy2dedt8PuQdvdEUntu01Lq44K3YDZadUNoWL7D9oqyiEnTb8/E6ZYFKgk4cPVdT8ch+Ux0rwWa3bW2dOwKvaq9/73dEujgOSjZxOHNLhrffG7gn55VsTbUorRonmutCPvZ3erie7MWc2Bc1BCdfbsCGVQrf1HINq5PYKxaFWd6p4PTTxgTUB69lyk0Bjb3BRbFFcxIxa5kpvf0UJAhg0Ek7z+0p3HONk70CHt7Aybtrsc2WH2+hjxtPxkWddJGEfRWWoxUJnx4p66DP/xeNDOqDxW/P+QPBRQQlA5s06QK06qfsFnV8lNROTWYhjvQkzel/TdHato9SBuUR0UF2IiPMox0swe9FpHXUnR9pDf8pK24oL84pBcljT7hXK86Ahk5WFoDMm2McBkG7C8DC0oqkOCtRqbrzydcdnyhYX1rRpos8weDHHUq0SrYC68rmkxVdw5RXITEd0Vd61SfcU/pzq9TfXBrUBNt5AF2daUiARdHBa6t2n1Zv2/U1MWMI7UHANio+7vCvvKmQwI6gFYFrCKcXb5KhjRR9khFSoGa7VHtTK1D4OhxXDnUC1DZH3T54IndIsy0zM15DvHNFRmgJVOgQfqVgywItVa/AhQwLfs/Hm2u+sT9g0NCSwsTtbwNcjE2qi85/Abvwh0C5bcK5ecr/d1bgfaLyteTDHheyhxWKka3BHF1j0+iwziZ0mC5jG4qvmPlrHHlysJKqDeu0Gr6p1F8heUjxctjO3Un3A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226299c0-30a4-468f-a332-08dbe5e5f570
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 14:20:03.0710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzrWaufhdQF/7JOuLSEt35hw0w1gEu0puhnRoQK6uTImf00rQQ3vYyDvHuvh6GrFFM/Ks4aIf927NeVol6Ko2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8433

On Wed, Nov 15, 2023 at 05:19:28PM +0800, Ming Lei wrote:
> On Mon, Nov 13, 2023 at 05:57:52PM -0800, Ming Lin wrote:
> > Hi,
> >=20
> > We are currently conducting performance tests on an application that
> > involves writing/reading data to/from ext4 or a raw block device.
> > Specifically, for raw block device access, we have implemented a
> > simple "userspace filesystem" directly on top of it.
> >=20
> > All write/read operations are being tested using buffer_io. However,
> > we have observed that the ext4+buffer_io performance significantly
> > outperforms raw_block_device+buffer_io:
> >=20
> > ext4: write 18G/s, read 40G/s
> > raw block device: write 18G/s, read 21G/s
>=20
> Can you share your exact test case?
>=20
> I tried the following fio test on both ext4 over nvme and raw nvme, and t=
he
> result is the opposite: raw block device throughput is 2X ext4, and it
> can be observed in both VM and read hardware.
>=20
> 1) raw NVMe
>=20
> fio --direct=3D0 --size=3D128G --bs=3D64k --runtime=3D20 --numjobs=3D8 --=
ioengine=3Dpsync \
>     --group_reporting=3D1 --filename=3D/dev/nvme0n1 --name=3Dtest-read --=
rw=3Dread
>=20
> 2) ext4
>=20
> fio --size=3D1G --time_based --bs=3D4k --runtime=3D20 --numjobs=3D8 \
> 	--ioengine=3Dpsync --directory=3D$DIR --group_reporting=3D1 \
> 	--unlink=3D0 --direct=3D0 --fsync=3D0 --name=3Df1 --stonewall --rw=3Drea=
d

Hello Ming,

1) uses bs=3D64k, 2) uses bs=3D4k, was this intentional?

2) uses stonewall, but 1) doesn't, was this intentional?

For fairness, you might want to use the same size (1G vs 128G).

And perhaps clear the page cache before each fio invocation:
# echo 1 > /proc/sys/vm/drop_caches


Kind regards,
Niklas=

