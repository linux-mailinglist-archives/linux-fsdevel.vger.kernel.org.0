Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C765633CA96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 02:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCPBMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 21:12:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9064 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhCPBL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615857119; x=1647393119;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=y/8rq/2KsJnsL/T4YdKQWtzf3Z3UDrlqieF6lUTHQpU=;
  b=JsgFO/610dEjq0L30PqTtiobZ4ejhfU2p0/kP9fzS137MbS0k+KZTeo2
   C9qlQDwIicdyxZSVIqSdpWodVuo0UMBTGqbPlAPQxjCmURDtGmksG82kz
   5vTSi5PvuwDLrdS6IVltmsrqkrIzTHRzhIGDda2kNMTOCqstSPfwLGBm8
   J5CF9nH5YAqZyUoDf37VEvpEd6NOLNLotNyFWXJQxmSZU7XSIOBK1BG8X
   TsX5NVvxS7SDSFG7Sj8KTTQdf532Qr46IZqu+IPSxxTzOptRnLwAwe6XT
   61eVaGyq2Q17FAPPH1PN7K3evAkfTpc+cz8cdifk7BenYEkH+GIxFJ3bB
   g==;
IronPort-SDR: KhG1zk7cy2NsaKhNcEBSSnl3vhd5pVWwyJTtEiJ/AD8/iule01nblMkXwUHX5sv360Be0kWzM/
 5Xp7QsQOwm7CwzLLI+hozDSuFgR0admKAUrY9b3MHJUJdC5qVFPfowrezxec9AR1ZginnXm+6I
 gHzMWz7pEJvmD39w7toFFHhVBBxwOvHrm5uX9RrlKXt2MSdcIViDifRrt/CzchpDmjMZIP0vdx
 UTy4LkwZjhlHTotp15aa26crm5SnxiUTMp3NEz14GwBiGIIZjQuDyvoJYNboDYmKiO2b72Eqgd
 Er0=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272929655"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 09:11:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/PQf+0qMnrsUNT7qTlXadKLPNbo3ksVEvljWVNZOorbC8pc4CzgW/bWgNXHSo2xzt0WIbOaEuvejQtOynnkYmgEzFEIleFNkQILroXyrIKtCwv0mSGBpXedRTHbHqqc8wbmc1DVK1znGXdy9AViSwS6dScGCd/5QOXn1egZ1r16Acm//BPcXVmht35FtNUd15K7hwGXS4RxlCNbcU2cGCTNaKAwIJIO1iB+dRjcTnlsgJGVfq+cauKREjGI2JVLNf2JcN3LzXZzH3Z5j9IC1E4dKsqhZoqAUawr00hUXl6+Lde2meEFoCqfH/0xbqZY2PNE0xFK1rTzBPY+ERP/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2dJcWOFxEkVcNN+tCJX8UKM8k5IIv1t5QVWLJYJxwU=;
 b=cpUrsaiNvY2qKtnaY4G5qoOnRfCRMt+svFi9TBH4lGgYW/rK9mbRWUTALNu/mTri8c1y2qMG2Guyabg79oKafrcnOwfWmbplsRDsbUb2Z0bvp4PptH366CaEhCK2O2z2cB7zp9l3O3y9r5jxJ1UunOrpaOtvj63wbYENzOf5XIaDLLtsWs6399VZaPy6PQX+qyBng+4UxFno5DkyI3Xf0Wc/JuFossx3PmD+pXzBKq19oMNHc2j7WxjG+jo2T6liauuzSjvH+T94w6AinsnMDY9b1FVCBT/23vocjsVAfiy10IJCZcEKRewgzx2EOFMsFk6pRTtsEHZl6kAlQWM9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2dJcWOFxEkVcNN+tCJX8UKM8k5IIv1t5QVWLJYJxwU=;
 b=gw9IYMmO5o1mn4G5qyHiiDqhilK/cNj1zfKYZlLI3+3fg6euizsNdBzNjg3aguy9aJe6/awvhs4kXPtYoTOmR2ohiuwmzc6vYGN1VaK365uN6j/SBkQAXDqBWBsZNLD6qfiwK8mIEzPkdDwXMyTGl8VxWHu6ofQu0RdtItqlA7w=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7070.namprd04.prod.outlook.com (2603:10b6:208:1e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 01:11:57 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 01:11:57 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        kernel test robot <lkp@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Thread-Topic: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Thread-Index: AQHXGU5UzgIQSOxcCkmbmdVM+KAasA==
Date:   Tue, 16 Mar 2021 01:11:57 +0000
Message-ID: <BL0PR04MB65145A954830D891B46CC2B4E76B9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210315034919.87980-3-damien.lemoal@wdc.com>
 <202103151548.W9MG3wiF-lkp@intel.com>
 <PH0PR04MB741614B0DED04C088E0B075E9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <BL0PR04MB6514205221C23615549ED67DE76C9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210315170855.tguqrsl7wsbjojib@archlinux-ax161>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:85a2:35e9:2c43:32e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 343d541c-2ecd-46d4-36a2-08d8e8187e7e
x-ms-traffictypediagnostic: MN2PR04MB7070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB70702DBAE886D31DAB1876C0E76B9@MN2PR04MB7070.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcKpDHGmEoVNX+WF55/lnwPJdKoS7BRdVCKa0tU71AkJsbWrh4T85mefpAP1c1b3CNeBNS5pib+WwB2c4wiAVTo85Xi+eh8hMhmAm1p4RHzzECY3r9OJcVebw1d3i+LZR25HAn8cmbfZxK1UN2a43jYHtK2UFz4zyUH7Qm4I7QkX+bJpqlawvU02F5r7iC0qhfRnOxGDShZ7YhkFN9hhz56/QdnHJhCaEfwZma3QXZ3RdxJ9IJNZlj8Tbb/Sj6bbrPKsXxmnMre4dUKxom4gauqN82byn9Cib0CEjVaP6fARqV9936ZoSDqqRXbPwa6tyH/ro1+UJydTmDwh7L0dBA/F+xKg/VAHkbS5dVA+YasccOLnPICYeYgHj96CZK481N/es6zwKo1CUzLEIae5qg2rycOSc62bFdP85lhtZGhm5r92O0VZ6A/DeITi3Ive7/htpiJ09P1Woy4TIjiIOYAHqbnotl21B34dzu4b5YrGFCDfcMnijf2oGSa9OxMXhQzQiQXD5kgGAz9qMsT+tbgHbb0TORuAmlQ5dU+bR9MddvJ1q4yNosqa+faTw2fR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(33656002)(55016002)(9686003)(186003)(71200400001)(2906002)(83380400001)(86362001)(54906003)(76116006)(6916009)(66446008)(66476007)(66556008)(6506007)(53546011)(4326008)(8676002)(5660300002)(478600001)(91956017)(316002)(7696005)(66946007)(64756008)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VsBU7z/oGwViOSQWIM2HFkosjx+R2Ylcy/P6tMpRWDfpJyMPhx1YnrmgtJQg?=
 =?us-ascii?Q?yzBefRMqMKTYifw/OvaDNSFN1tW+m+9Se6iAa7JudXLBLf3jRIfaAxZ4RFvP?=
 =?us-ascii?Q?eJ1J4IY4X21qkYcIhGpr44hRJNVW5bUixLtcJFX+UsZlXfhIOD2WARWexFtc?=
 =?us-ascii?Q?nkQLzswchawiCNW5b2JR3VEK7agkvhL4bKp7cDC8Sgv3O8Rw5lewDpBjWLjc?=
 =?us-ascii?Q?zvBdJc5RsTeTBcdzxjrIJ8DIO5iyc1PtsPtESam0kCW96G9SDvp6LQlZqdd0?=
 =?us-ascii?Q?VY2irL3mIMVrJgjidMZxpHkQmz6cHje0Kuqb1aYVuzi/mUqX+6itzZi/W5UT?=
 =?us-ascii?Q?H5BDblRqXrrocSAs7YTbnPBprfpEX5p6Iw2+yr06FFG/8iqgIfjYsq2UManD?=
 =?us-ascii?Q?JDQMzPIlR8OVaqUyM2WSfGDBOCI45CvDSBAUGDaupxOqefHJWQlBjCqxzEax?=
 =?us-ascii?Q?OjChJdwYjzMiyPJl3p3K8gu314+Y2GrT0XtLWztLk5rJldYZ8lYwIQ1J1u8/?=
 =?us-ascii?Q?ABjIV/sy5neBWC+YMzYV/8Puy/8gsIlhdceXpxqF9VPb6fOM+lyvSYow0yBG?=
 =?us-ascii?Q?PohyqVo3NQWYSd9h4qt79z979dkWTcTWAI+71IdAeSoS1DDYOnkiW9+Uw9zl?=
 =?us-ascii?Q?RxvKQfZbA9qAMxyERGx7sDvTDC9HF31FPXwRf11RZ0IE+tDyP7t3Z/QlQzJM?=
 =?us-ascii?Q?v7uuylzX+L9iKoHx8W3+BZ0lM6OTatCb16ClEBSKRAwjxUZYqrQ2iHp4qBGJ?=
 =?us-ascii?Q?4Cf7FGHtBJa0tqaBFRLWeKOLSRxPwdNFJI7/iLrhIsr+n9imGDJ7mv7xBlMb?=
 =?us-ascii?Q?NsarckydxZGpNX2/jgYVy3mYomoDzV2FOnaCKakb3n+51AaHNpxU983gDqis?=
 =?us-ascii?Q?OZWS+uVjDnmwHv22oQASHg9wLfXW6QXD44wdAJqvzkPRCVc9ADgS8g/m1MWK?=
 =?us-ascii?Q?9yk5t1ZoenyJBb5wh8f7UJRqzn++R7RANPtt7SMkH77jlq+pC3N+i7enyi0o?=
 =?us-ascii?Q?5r2aeVNG5Zlb796oTN0Pvw64WCtZCn9y+4NKa9Hgil/cfLs0pRrtFpGBNWP1?=
 =?us-ascii?Q?4A9k00IbppZUYStusz1GHyw9eM98rKy1OD1q5Oy2E0RAC+GS3jGzSVgE/Z1Y?=
 =?us-ascii?Q?e1bgTbXI5tjKc60uUMpw2NKZ80vrJXCv/JDCIFtcE3HKfPpjpuJcUqDXdoNN?=
 =?us-ascii?Q?+PgGp3QXLjYHB5xRuW0d9RxL6/a9B4ghPu51CQgbtyO51OnCVPOKQ3bjEI9V?=
 =?us-ascii?Q?kDTeC9ibVFLKTQDyv7VzrMKILgA2w/BMBMtzdOm+cxdq47fJfyotyVMIp187?=
 =?us-ascii?Q?cvgDO8+Yf1wMG7QqPIuChYzq83qpPWA+g3NmxJRdytYuJArh1RirTMUQUQ4I?=
 =?us-ascii?Q?6pY2UiUVtNLjq4sO88YyXCUb6sg9RUdtdn6HgVlVjZdDtrtwug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343d541c-2ecd-46d4-36a2-08d8e8187e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 01:11:57.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXK52z8uh7Wct/D+1mj6nx3sTlmgATLQIdo1Z4fl0ensqFqoCsqpYY2otGd8MzD0jZg8qw9hk40HEyJLbZZrlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7070
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/16 2:09, Nathan Chancellor wrote:=0A=
> On Mon, Mar 15, 2021 at 07:22:56AM +0000, Damien Le Moal wrote:=0A=
>> On 2021/03/15 16:21, Johannes Thumshirn wrote:=0A=
>>> On 15/03/2021 08:16, kernel test robot wrote:=0A=
>>>> 818	static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct io=
v_iter *from)=0A=
>>>>    819	{=0A=
>>>>    820		struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>>>>    821		struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>>>    822		struct super_block *sb =3D inode->i_sb;=0A=
>>>>    823		bool sync =3D is_sync_kiocb(iocb);=0A=
>>>>    824		bool append =3D false;=0A=
>>>>    825		ssize_t ret, count;=0A=
>>>=0A=
>>>>    843		count =3D zonefs_write_checks(iocb, from);=0A=
>>>>  > 844		if (count <=3D 0)=0A=
>>>>    845			goto inode_unlock;=0A=
>>>=0A=
>>> Args that needs to be:=0A=
>>> 			if (count <=3D 0) {=0A=
>>> 				ret =3D count;=0A=
>>> 				goto inode_unlock;=0A=
>>> 			}=0A=
>>>=0A=
>>> Sorry for not spotting it.=0A=
>>=0A=
>> Yep. Sending v2. Weird that gcc does not complain on my local compile...=
=0A=
> =0A=
> Unfortunately, GCC's version of this warning was disabled for default=0A=
> compiles by Linus in commit 78a5255ffb6a ("Stop the ad-hoc games with=0A=
> -Wno-maybe-initialized"). W=3D2 is required, which can be quite noisy fro=
m=0A=
> my understanding. KCFLAGS=3D-Wmaybe-uninitialized is a good option.=0A=
=0A=
I was not aware of that change. Thanks for the information !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
