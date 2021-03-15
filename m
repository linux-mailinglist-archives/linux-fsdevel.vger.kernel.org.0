Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A048433C790
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhCOUSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:18:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15419 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCOURs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615839468; x=1647375468;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+1XX0BNi0D8ySaM7z7+Mwi6iERMpY2hQUmkk/tyZNl0=;
  b=ZoULTQkotgWD2wO6GjnNoZpXKkwvmBRgg2/ifPcEyhTfuz4WtGLS9bVR
   rDSVqEvIEKuiG3+y/FmdkBEYqFMOtKngpeMU1SGrwMLuj+EFUacksaKMW
   doX8l/KhyVL31HNNwZdTR8oagLtU6ENUR2sX/YjkEMioj77ipf/n2qt4o
   +N7JQhY6HtUGVRIhijoL6YTzslkExIr7fufoEp92eN8Bku/g4Yea3uwVs
   OMQSAR7poJslc3WR9yn2nIFu8rl4PYmvy0nG5P/no/zY7NCsXTzZKd++l
   JUYgwyKxjO1evy+BQpBFetHfxyWs9xbFdok+nsxZ4HO2Y7ooI+BDvzwL6
   Q==;
IronPort-SDR: YrwvL1JGinb5aTqyBVHsmiIb3ozSXItBh2pDav71xnxNM3CRZO5SM33xE0cQQw3zxLADIPe4pl
 sAmIstFNE97FCbDOCwkwngPxzEis8LAWyO5oqV7GNPniviS3nOhR9VNSwgcmaG5Sp9ZdsaF/E4
 8GYwQMuTouF9n+cpVD5BD/d7urEAg4DbwFQIci5g2fb5R0cFtSLvL1dwbbENs3IsjqSWX3KK/V
 649kBb9djr9GYMLWCnKK8zBPojN5yGgPyhT3iRtVpu3TgNXYAm7MJ6Huko+PPrv4TV3ZxXOLA+
 4cA=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272911998"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 04:17:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFwQtg6tvU8UpHB3LxkAHSORB4eJ+HQCdmzbV8D9+Qxzqln4kkGvo0s74pBI79gnFiRXNZe8dCo6eDATvFTeoGNBL8JglrMwx4NAip+k9UWMe+DiZOy8Raigjq30zgKVkvwGh4QHkk9VoQP//+yf+Pzjfw5G0ztFzkdURcBwN9IE3WmC94SiBEfdVWU+PQEkqf9d5pyqUd5BGaNkubSLeyt8AJAz9JK1KWEnfyt4TkNFfeNaqdJYpb65S3TxyOliAI7JR2CSkx576OIviHemIqPIHwfXKGJR+7LUZAesa0iMfLiPxisG4jHSpxO0JtpQ8XmOPQJBeBovlvH2Xe04lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2kGo9KVjzM96xmSmO2KroTMyPB9WY3OdQiN5GWSrwM=;
 b=ZxbNRTB9cISkNuoDzTR0IcxgQpfAtm4AwOXXzNfVmNBlUn8AhT6oeZLuHUMcJvctzuRkBkKs0Y5QhGo8RCezBxGt98Cy/xCAvYF3thMwEtLokRO1wAtB6P+N6qJaAqV296IJVr3YftBRnhQGUFAbJ/7caxD8whhGbjqLdY3Ggtgm0GhC4inJEwg4wvMP+/g2mRSI80YS12xf64CLdxStwtpjE4XSrXWIHuXdBNVPITfSTnjaYIjaWBwsa5RLQ9Q9m4b7Qs/fG7NqS0A7Uw5qNtSCOiPP3Gy8s12bTGKdW8Y/+clsrQDPK1UJ0SVEqbrsGZP7ErUNJI1nAxJ0GzlfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2kGo9KVjzM96xmSmO2KroTMyPB9WY3OdQiN5GWSrwM=;
 b=Y2DJ8p3b9C3fpe9GQDDxcaigA7M0cpgHWXGAkr/ZPyTWYH2zvfa4p4smAlhf8zdTuFVCVP0IbLe9A77wXzYIsG+XqTwDwU23nGByawxthfNqpT6J6FKC4x8AVdzsuh4zyb3nl4nIEcekAoWgBTEiZ46eIng5iVFjkhoitkVjzkE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6991.namprd04.prod.outlook.com (2603:10b6:208:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 20:17:43 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 20:17:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Matteo Croce <mcroce@linux.microsoft.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH -next 2/5] block: add ioctl to read the disk sequence
 number
Thread-Topic: [PATCH -next 2/5] block: add ioctl to read the disk sequence
 number
Thread-Index: AQHXGdZHtEi8UCY5QU2YIkxHX6s5Yw==
Date:   Mon, 15 Mar 2021 20:17:43 +0000
Message-ID: <BL0PR04MB6514FC8F5D34120DFFF727BCE76C9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-3-mcroce@linux.microsoft.com>
 <20210315201331.GA2577561@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:85a2:35e9:2c43:32e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ee341a8-a551-4468-3169-08d8e7ef642b
x-ms-traffictypediagnostic: MN2PR04MB6991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB69911CD5647029C6E4FEBE65E76C9@MN2PR04MB6991.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qsOM+UmoHKev3Fa76QtphVATnWZ9aanI/HAQo7rX0OONavxjn8odKlDr/iJeWHcBxwLQ57XVhq+EO7g+tQ3cNhBH+v/WRV4155NbmC9P+ld3EUErCVhjisAvfa/ibmWdo/e99W3FeaIMvG90iftkLRM8UJiTUbJ4XmoJHkzMiQuZoTSxNpKEUbgkhPsZzfqW8Y8jw14GnuldP0C5/DD7KRVFuMZJfR/GVDxqoUVdN5qkwTodscODerOwh/EmyruLgLT1eYHHnzO9kzHibiJZRDCMElbDSfPZSSO3HVJBMjkbD1+AqULdrRTKoTaVB+9DLT3M2CxMoH7j1UP4GeonJQRwKrbFD9n2dLECR6QUP54gRotCyYwM9pIywph2LkY08zq/VHQjoCeBnOuKY2iuT8paPeN3IoWDKSySGcjQ+vVpgCnGYhcMzRQE+jSGxbCQNDfcIo3JTVeS4afYjzkr/HZjhM3N1gnTqbxXeUu0wPFjpzsT+hUDLmaZ+r+RlYK8JnpSI/+KNd9Gsn3akN1keHsDOYq0XYQt5Mcb9C1YcFE1WAeFvynpoKVSeo8d4N5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(7696005)(53546011)(86362001)(6506007)(186003)(71200400001)(55016002)(5660300002)(33656002)(52536014)(4326008)(66446008)(83380400001)(7416002)(478600001)(2906002)(64756008)(54906003)(66476007)(9686003)(91956017)(76116006)(4744005)(66946007)(110136005)(316002)(8936002)(66556008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?dNhaFmP8QcGCeoO2eS38fwBmIrQQXS1qnJL2tKYVvBXaBubOzvQJ3TvbaI?=
 =?iso-8859-1?Q?juSGSH9/AJRPP7uCPHshGy4IxWbXRPNPkmRAcogJSLD0d1rac+gie4LT66?=
 =?iso-8859-1?Q?r8Ln0EdJAW6W73pi0VFlnzluE90Vv3Ik2LN50o6trn3eTvaiAVEFW19OMz?=
 =?iso-8859-1?Q?5R1NpLUHtuF5q5yGApIInSAfDXOUKek8tgSIsKjC/fTvKHW+mCC0Vf+zq2?=
 =?iso-8859-1?Q?LeO7XpakBrFfxkfnfy4cpp+osiUTLVkQlyiqO3oDZfqFjLWpT7CEsVKYtQ?=
 =?iso-8859-1?Q?dMdZHGMp1Jx1wdSQqy0YfQhmOawS8RTzr94AtnC0AZVc3B+lmZTi4JOUlz?=
 =?iso-8859-1?Q?zQwUs43mOwAzR0PX9mHb7+Ne8ggckkfGZ1aazNMmlAPYePqKmeOL3YO1/x?=
 =?iso-8859-1?Q?AqGlJzupgEpteL/LxxLvISIc0rFqLqOWztHVFLfdQiSkqFp4Sv/qRUHO4T?=
 =?iso-8859-1?Q?2XL/Ve4NV2GjLStppF2XcnPCTkzeeAwzFzK6I+tlcwa4jTZrqEQIEhNQj9?=
 =?iso-8859-1?Q?oq991Le6QBqaGy1XPfsb0OOk/O4Wogko86Rmc6j6kI6X++pQnIPflJySyU?=
 =?iso-8859-1?Q?H/HzhjD1ipY2RVB9RgLHiQxnsbHQWSODhMwWl1SmOvvFZHgNVo/eHUCWMJ?=
 =?iso-8859-1?Q?+VfEMUFSm7TPi5yYGgSUveDGoTu/q3QI757wjDj5rImlDRU1Dp7Arur0wX?=
 =?iso-8859-1?Q?L7iNhCvCbSC73d89xJ4NasHcug5gUM6UbsLEfdngunAjTUrwQFm8o5fpWJ?=
 =?iso-8859-1?Q?iTGFDC7cC9h3tg4VM4hzjZeh2r4uKRRE2rUvJDy/LuC9r2OUO4e6pCXsdC?=
 =?iso-8859-1?Q?WZsmBe+xXI/XzUpl354CKxH+eEGdsNCmLCobobzjFRkuah3VQwaQqYVwKQ?=
 =?iso-8859-1?Q?RZ6ggrTEI0HChpgj2nkOrDUfo68Caa+ADfHV+ZaPqtDLNsy6/pF5V3K2Nt?=
 =?iso-8859-1?Q?VwbCcoU1HcrsZd0eO2K1Uv+lu9KlMBWs0LqKKBX/zsp4yoTJxiuFCI88Kz?=
 =?iso-8859-1?Q?5nFQb8GVXLn+Dw90HYLZOaQ0vjH3M05bSo7Z0YKETZJGP7AROQK4Cla0jL?=
 =?iso-8859-1?Q?KmglQZOcYUmwfdH/OYbOnFbfL2h53qvlRdFULC7RSTdot1XkpDIejShkqM?=
 =?iso-8859-1?Q?k1uWv2YP7yXVHaFjcrh+2UZ+Kn7Nc6GeiSVI2nIwnt4pbW8ipq1FhopUUp?=
 =?iso-8859-1?Q?5kmWXS7mTNEVFB6uPIB11UdfD7BggW4VhdMdD/uQMUbP1Up9R0/tzX+rcR?=
 =?iso-8859-1?Q?Vz9C5rsbyhTg44Nilx5cRDuzDmBzJ0D1TjgixxGdF7CRk4rPK6AtqBODyb?=
 =?iso-8859-1?Q?/1+fY7VyFwNmmD+sCL0zKMPHW1v4Pg03f4J8lzaSmEGlogFWr9ZzLXGdzf?=
 =?iso-8859-1?Q?8nMPtjE2lkUW/AmbWz5ymjis3VMEFOXeZEnW7d3SGWXuP4ZmQk2W+xkP6D?=
 =?iso-8859-1?Q?4HxqLs0bKs1Stk+zj9aQOIU7DRYq3e13tTh7hQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee341a8-a551-4468-3169-08d8e7ef642b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 20:17:43.4447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJqyGRH1BNI6BCrCB7T+39Y1T3509nnyqi/WSqGQjTAY2JeQGasZv8bbU575zu5FxHHs9dCCDoz+wcApyMzbQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6991
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/16 5:14, Matthew Wilcox wrote:=0A=
> On Mon, Mar 15, 2021 at 09:02:39PM +0100, Matteo Croce wrote:=0A=
>> +++ b/include/uapi/linux/fs.h=0A=
>> @@ -184,6 +184,7 @@ struct fsxattr {=0A=
>>  #define BLKSECDISCARD _IO(0x12,125)=0A=
>>  #define BLKROTATIONAL _IO(0x12,126)=0A=
>>  #define BLKZEROOUT _IO(0x12,127)=0A=
>> +#define BLKGETDISKSEQ _IOR(0x12,128,__u64)=0A=
>>  /*=0A=
>>   * A jump here: 130-131 are reserved for zoned block devices=0A=
>>   * (see uapi/linux/blkzoned.h)=0A=
> =0A=
> Not your bug, but this is now 130-136.=0A=
> =0A=
> +cc all the people who signed off on the commits that added those ioctl=
=0A=
> numbers without updating this comment.  Perhaps one of them will figure=
=0A=
> out how to stop this happening in future.=0A=
> =0A=
=0A=
Indeed. Will be more careful :)=0A=
And send a patch to fix this.=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
