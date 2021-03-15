Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261BA33AC25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 08:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCOHXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 03:23:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27336 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhCOHXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615792980; x=1647328980;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RpfSDqtTDRp2Wps5sKe9wz32kZTPsMWtu0oJYU6ZYpg=;
  b=NVFHSHte8c5zknPmpcSvo/OaZ2Wbg9xXZYP78pV5gG37PsQm6V7cGmRV
   htjCqvMpqb5PZfE/+QDxFoVVCmhZQnhJH36HwCmGRuzU2A6M1avxw+973
   nQced1U23+ESgdQwReak/q4FwPrQ2aDWmx2tVMeNFE+QRo39aKafNjvJa
   oGvPf9puHrk1Zxrot8wz1NePN9hjB+JHzME37L7WTV7WsZ57mW5EGY+3B
   sdis+iO9PQCFBaSfR4O5jHY/geD+3VFCLYtyjy4RTL48gZ7gmCLQEcxyX
   OZfl4eZcxQX5r7wi5PJTfEwRxurY6z55T6x/CxWlBeR5XdNpShapYEu+T
   A==;
IronPort-SDR: N8Cbkvfn2wSpiFIOKoPJtgzanCrU5Eofj1mZA4YRzmbXTMnthUAue03x17MF2hnb6f4FhE67uj
 gzvF92Nm232BmaxWB+FmddkawmGUZANUzktzxV3nHp2BbB4BpInMb6Wp7UO/Rn9i6nthIQDY63
 +8lpXRsuWjcw5kp/Mzzx2VE51RRFFgBAdmTxP9fPvJZH7ZUx+AufeNYER2F6yKgw7urzjsH5kq
 tIDAkWuwnrOZhMwdQGjBbMQ977NFAkLGsMQfxDBJmbIU9glMyuhw3MTAgpAqY1Pc7v+XrFWKXS
 a1k=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="163295812"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 15:23:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWRckHelwtrmae1zqj67AvFAVAcpFip4Rna+3ZWFqFb50qJhCqWv7HH5TySQoTckiF+0Vjd0/QEwSCRODJu029CF6+QFKKWnm2HE46V/TQowBv3Og4NBKuwKtDFYSoryK3LQRL1U0QpbZMOAQgGZ0yMY0m1ppe372l1adn7g2Z57sgO/8fRF83zpX0GGoVf2GneESlLDvWdZFILkWhTi+/E/cyoI2xTx4M6FbqssKHzqaMDwX8IjzKc87TEcXWJbjYjwBILB1HAjOHBn5rBNnLk8SwmPIShijsgkRUGePBt493Iou1Zt0QMOux2zwHnCkA+3+X178nAIBpZUUPATOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puSUvKm26429sO+Kc+9FHDgRnz/D3atdwRnE3cKgXsE=;
 b=ceI7l8SXwVqMsyCm47jUXNnEPNabE1hcudSTcDX6AhQ/cTBRUb2MeIjDnWXcx2nlcifnY1bVRQvmO0hklnR8v7Glgpa2LaEv0eU5tR9vqRWKAY5r78FoBV/APh2TqRHuYNgEWaM/vocPcHPGUpnEp88YtHBUtBFnq23LgKxi+BkPdR5BXpbXyrQemoG/6ISSWfL25YbUiFRcvJGcR/IrSPMAAkt+I6dxXsDOOjmSNQbxEYQS11Qo3swIG8QtfcrdkOkmXS5HvQVAntBCIwhA+GoBeLIkfvG2Tc/DaYxtcuAR6aJZYNwzb7KV2iODgQWCHspv8YX3xWhfW479vp+iXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puSUvKm26429sO+Kc+9FHDgRnz/D3atdwRnE3cKgXsE=;
 b=lF2yxznI7gcqE042C7czfrveDbuQY/UKj6fCoLZmmwFLRwyyTw1H0KQfxFdli+otBKloojUFtnvghUzxyIATbgRvGyY9a0jdTlzJf9BX6/8QSzSAzO7P3SeAHWFD99f1fi986kT/zaYY8UPWKdg9iQ8J9u5hLaMNaZ8PQR8krzY=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6595.namprd04.prod.outlook.com (2603:10b6:208:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 07:22:56 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:22:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        kernel test robot <lkp@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Thread-Topic: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Thread-Index: AQHXGU5UzgIQSOxcCkmbmdVM+KAasA==
Date:   Mon, 15 Mar 2021 07:22:56 +0000
Message-ID: <BL0PR04MB6514205221C23615549ED67DE76C9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210315034919.87980-3-damien.lemoal@wdc.com>
 <202103151548.W9MG3wiF-lkp@intel.com>
 <PH0PR04MB741614B0DED04C088E0B075E9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:85a2:35e9:2c43:32e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7aff04bd-7a2b-42e8-b3fc-08d8e78327a4
x-ms-traffictypediagnostic: BL0PR04MB6595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB65950FC9603BDD8533B89E8AE76C9@BL0PR04MB6595.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cgymLJ4uqrBtLjNdiQjxnzwLJjb1is+HCih4d0+ob3LBwnPrsy3AHAUjRNjpHJpncd7B4/MIvapDWwmRT4JKYk86h5h69RdrqW9bn7sOrMHpMa7jt3OZvwiRu1syioqFAxI+7AQmuCerSaHxenyqzTwWEoUtE8DLw3XTTqR14ob+ysDUcPSU4f3K6w8Kq4PG01RKG7cM9syD/irEMkcKbOXw8SDgbetJbF4nxg1T96CFdb2toYQ4a2tHFjzOw1fNTwSJiEwifqBJGZd+9i5nz/smkWYbSDGbd/rqEC7MTWBbCIZ9jAPuOCT0aw2pAkA97qAb0Oji/bm1SRoDCqpy6+S3jfHvOD1Ao6aXlMFVPtp8iun9+CK7IwG6Bij/LbrvQOLy96e4HfOSHhpDgh+AWP6E7E4RpfVk9FQFE6x7DmCqiuXloYJn83uoeN3fFhGOEgDxJxIMTBgBXNF+IkC49QZf5HEWchzovhRo++vbdYxaQUz2y13tJLpvT9HVL+rcWVuUHLNUZOWJEevVY8b2SavCaAuTTxpsXqDPrQnRuHUMNHAr0XvJgesjFybU22e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(9686003)(52536014)(76116006)(54906003)(110136005)(8676002)(8936002)(5660300002)(55016002)(66556008)(7696005)(66446008)(91956017)(64756008)(66946007)(66476007)(33656002)(86362001)(6506007)(186003)(83380400001)(316002)(4326008)(4744005)(478600001)(71200400001)(2906002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PVVjlPxpte7/dntMU3+SL2vzp1ClF+s4lwyYKghXGuc9ebu6nevA76ygi8r/?=
 =?us-ascii?Q?419IWYEqCJCKGY7LWdPQbQUFMjTgviXCv3PPdj+JM7QTJrA04TNwioQV/Za3?=
 =?us-ascii?Q?AWzFQguWDaOmNX+tK3yj7/yR9F6ZudVwSvWIqsqL/HCAcDYIcFirSh0brHg3?=
 =?us-ascii?Q?ikvTMOrm9/XWWMxKHDujBe2Q7GvX0dOFu+WiB8Qpu1IPDr/SDh6fW+/VzzgG?=
 =?us-ascii?Q?MLTcAux2lh9/fFquwebH9/EDzPr1EROjCIETwNOeNiNK9s2b9eCmuLLVmMiO?=
 =?us-ascii?Q?g8YxWo06bmZFXsh7F1iG7IRnWnR9zYfrkOdlkQqW+VQSd+uIxmuI+UedL0/R?=
 =?us-ascii?Q?RLqf+xdceJuy9BzOaExgDQ10C7VMGygChvvLRDjRFfC2Veu0PffT3Wa68MKR?=
 =?us-ascii?Q?zL1Z08hUxhYn/S2gaVxJCjTjAd8CMhw3ND/7rsQsVJho9dJ2Fw98Wvl5ZY0P?=
 =?us-ascii?Q?CuDKz2J84NNsnUuebPH2y1lWW6lVgrQ31wbi/FAr6ERWGa/l6BHNdPmwvVzh?=
 =?us-ascii?Q?DYspDTf1E8WU4lMPfdOLcR4lNCghFTGLRv1d9HRqfYjL0pjYGNNDXwGCMINd?=
 =?us-ascii?Q?F2qfBnYR/aE73FTVmR75KIt3l2d7BJDFh44tl1vBwTjJkOv7P0fFF33uUljX?=
 =?us-ascii?Q?si3MhpqFQZJjAo3zuqrJdkeBEveVhSbcweEu7Vp+dr87x0tnu58tnnT8DtU5?=
 =?us-ascii?Q?+9df/xlH0vzU+mLyzXnHlKTYdVQrW8I/4UxIZS+0LwZPlrvLLBOVoUElNLUs?=
 =?us-ascii?Q?eWExPqnr4oEOPzi1ZCmx7R9ayGrgN2ArjsyJPNJ0R4CLTNEA3BxcNqk8IHcO?=
 =?us-ascii?Q?SMwTnCk1aEAkJBJv0Ion9g0tbw8n+WnLcnvEMMgwP8ovMQUUEmdyB/wQNfqp?=
 =?us-ascii?Q?LSFp8ZnSvfgL9B69YeUP2NAfwU2Y4XwqEyKbJ0uurpvUd/EZX1d/csH5WCB2?=
 =?us-ascii?Q?3J9pw+3myqRI2dVTHE5oeETZj5puZ7rm+pkkE2g5F/jlPFMP1X1JWk/4WORx?=
 =?us-ascii?Q?FJIOy71Sxs7INgGHxwxzGYEAmjKX8/Wg/NtmG3Kn0urp0mS57h9lvbM/oFzH?=
 =?us-ascii?Q?ukSFJkue1cVTMpFMRyz4XbNZgxlRfHygMk643bIacXKNUh5wEQuon8XYC2Cx?=
 =?us-ascii?Q?OpzAKpuiHepJ9QM1LDaGCxi6/EMBgRhcYOn3qlC5Czf4teRE3YyPkVzOCvEI?=
 =?us-ascii?Q?Cwg0eRrYC3q1xiokn4b5TegVnd+1kPXR1c8/aRL5XNFM6mKOSkKkvh5WBU7i?=
 =?us-ascii?Q?MDN4HvkFrZjIE2m39VO0eeLSJJbcVjHkxTukGiGgxwqwezTioBo/LJxQHFX1?=
 =?us-ascii?Q?7+hr+m5GgLyju8rfE7UgHH1UE/6USosW6wfdpU3qjz4XneaU2262hr1hV7Gd?=
 =?us-ascii?Q?+vQfgoy3VEO3gi2z+qLsYjbv1gJEAwNehh0l9jnXzLPco1628A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aff04bd-7a2b-42e8-b3fc-08d8e78327a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:22:56.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3uyXRDXm4cMYX51NJ/YbZ43jii/+bIIymgelUoD03B2tiiDXOpyeNDSbZRgSkRi0vP8Iidtz37KcDiVbCHj1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6595
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/15 16:21, Johannes Thumshirn wrote:=0A=
> On 15/03/2021 08:16, kernel test robot wrote:=0A=
>> 818	static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_=
iter *from)=0A=
>>    819	{=0A=
>>    820		struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>>    821		struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>    822		struct super_block *sb =3D inode->i_sb;=0A=
>>    823		bool sync =3D is_sync_kiocb(iocb);=0A=
>>    824		bool append =3D false;=0A=
>>    825		ssize_t ret, count;=0A=
> =0A=
>>    843		count =3D zonefs_write_checks(iocb, from);=0A=
>>  > 844		if (count <=3D 0)=0A=
>>    845			goto inode_unlock;=0A=
> =0A=
> Args that needs to be:=0A=
> 			if (count <=3D 0) {=0A=
> 				ret =3D count;=0A=
> 				goto inode_unlock;=0A=
> 			}=0A=
> =0A=
> Sorry for not spotting it.=0A=
=0A=
Yep. Sending v2. Weird that gcc does not complain on my local compile...=0A=
=0A=
> =0A=
>>    878	inode_unlock:=0A=
>>    879		inode_unlock(inode);=0A=
>>    880	=0A=
>>    881		return ret;=0A=
>>    882	}=0A=
>>    883	=0A=
> =0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
