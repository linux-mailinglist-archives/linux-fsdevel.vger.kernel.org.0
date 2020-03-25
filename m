Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D968192478
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 10:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCYJpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 05:45:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64280 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgCYJpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585129541; x=1616665541;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6i/K+VLWX+3Fthjzub+EWUNogvNfx5/hiVXF+RXR1g4=;
  b=Qn3k18ZP1f/KpptkyfCWLUDpiW2b5XEtMcNpBiVPZAskFWFJX5aVuFPB
   +DhubZP84pV4ELEiGE1b2OfCfoe7DD3pClSZKWP4kDN9fKucDfO3Om8su
   EVdfn+5VkV9MivzWdAN7TdMtvaW4FLs2i1dqIKr2JrXdHFxK53N/XyTCm
   M0Ba1uagVyPF1vQ1adKZwTzNuuUlGio1JDAy8wtOzBq/RmOMXC/+Binhd
   T6YofDvvzlue+u4WDJ/1G+KkOaoTXimDPq/pxzkmsp0Sm5c3lugP27EJj
   ZqwxF9Yi7dUNu1jrRdQypFsjyK54/67x/BuY8OiMz/YHWVX7xdXSvALFA
   w==;
IronPort-SDR: 0IyGNhWUDBUGpzjG9F75hHc9wHVfE17JQ3Eq2neEnUop/FqUGP4QDBTfudJMZn00AQhNYprK4H
 B4xCntQIwUc7lKNBKgXz22KqGU+Vr+XZ9jUz7ImQPaejzlSarQ/kx9iL+QMWUCj5Sib+LZzl3O
 hehcKEOVUPTm3gQ/ho4E6USC2lPaOnV2C5s/ipCIVdKnxPh7YrE5WBIlzYYatDMcE6B/20puo3
 l7bcjPDXN5QPSGONK0ZRinQWOu7baDp/N64RBr/icWem7HZQPFs16NfQgNXYVtcgH1wfOgkIz6
 YEk=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="241945658"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 17:45:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5ngtpGyiJxfj2BpeKNnalsod4vCISoCCKnXUKmyhYx/lQJEfoRQoWwONkbtHg6vFvWe4zn2g8QkoxhCtOSAQMW6kVJ6RKlaXi2IQdv3rSu45T0VijipvdPahdY0BqbdSYxosPMxzwfc5DH+15WTcsdrI/L+a+aoHhHZ9pqVoduMNMIbo1FxKwfk+zYupFdMlBJYrTsW88mdR6E8vcbNklkPrtPJrJ3BAOn+Zb1CjX8yk4KI+keOz4NOXxCP1z8eVkivyk+gt8sLDDyUSB3MFjhZ7Vixd7IFnvXJ86pJpX2VmYzTfQ0Cd724QkKTH6OgyzNTkhaRzd5TZdmdzHTYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfLO2JuVOlTfc7hJbxP9fwEFaH+hc9jCvO/T0N18rtc=;
 b=mdnoUYK8n0N+zYZrU4yjks8yPlFAFN/DTJVy8VK/pO7Ag1YsmHSqGKdS6KLn00TUGxyN59PUa+UHFc1WeLH/CZ4tLdVb6KmcPuKpzwnqaltDpSxL9MQ/TMMtagr7zSnUBVbvNpePqP4THVQPa+TcnYM3lnZ6rZxTOEbgNDqVupFNTDPu/o0Sf/AhYfq85wMkA8WnMBRtiUvLYchm5MLM51GmgXv3rdGN/K18SWLEiWC2sazEOtrcbbSS7Vc2OAHURjaQ8ezeQhc4C7v8l2KG4zm/pghtDdh6iznc6VRX27wsJpnpy9CmIsu4imBWVVVcNPWO13JZwmn5nsiC9a0fZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfLO2JuVOlTfc7hJbxP9fwEFaH+hc9jCvO/T0N18rtc=;
 b=VohALC6JhgIhi1Fd0rzG1Mw4+R8xlmLw8T6S/SiVQquJhfgTT7PheW0esaheSaFi3HCblPDwH3cX93aqXZTyhUbUDPrfFgYrGhCvEzDdIiYH79DE81DCRz2BdCjFhL56BHVIGip3fv5NmO0eYpCfyNgNtd+3qjlTN2TIP4XynGk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3565.namprd04.prod.outlook.com
 (2603:10b6:803:47::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 09:45:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2835.017; Wed, 25 Mar 2020
 09:45:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Topic: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Index: AQHWAfBwrmUQROWSvUa2jUG+SCcnLQ==
Date:   Wed, 25 Mar 2020 09:45:39 +0000
Message-ID: <SN4PR0401MB35980056EFCD6D0003463F939BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
 <20200324154131.GA32087@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0938c702-fb81-4327-7725-08d7d0a146dc
x-ms-traffictypediagnostic: SN4PR0401MB3565:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3565D8AC4081D702F66E0AB59BCE0@SN4PR0401MB3565.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(316002)(5660300002)(186003)(7696005)(26005)(81156014)(9686003)(81166006)(71200400001)(86362001)(6506007)(55016002)(4326008)(8936002)(91956017)(478600001)(66446008)(8676002)(66476007)(64756008)(66946007)(2906002)(66556008)(76116006)(54906003)(33656002)(53546011)(6916009)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3565;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0R9IR0siKpdz+M2ukn4trBGeg+3rslYEJAx6Jjgj8kZbYwox8kSM82j7rLSEKTyVAq7CZYd4lYGEbdpuQfxy+SIbWTCk7gPX3is5tu33Q+gE0dHta4j9wLn0TnB9Y0XMODBsDU72Uf2ZCRtzCsQcbUGNZYAxQXVWyQOYPf6Q8HkmKUA5054cpYxHjixuc4bi39L376ZEzel6mfZc5IeokuJcLgDUX9p3eMFYlNCv4ZumvTudAe52fIud1vWxDgZw1EF40kmecLsSpFlw6inuuFruP/mOfanpgO2tyg+lJseaLyeFsee9bDrkU3Uo9B1VbdfVoXwtAtvEf1r8tFFEZq1v2oF0kqJvdUSIvNz+bSvOlFrg4Rq0HIo9eO0kO302nbVt5IyhJoevBg0zS7JtHEuR4ogncSPvsjXQZ/w2UhQrcodEGAdcdptmzHXMfV5V
x-ms-exchange-antispam-messagedata: 469kSTLYSfIfOCMCjs+l0kdTCLAFFFg8lCeA0uMyYizOhI/7HTSUNqBM9eA6IxNcrON7Xxv84wboO24tOXUVVz4mh6sYl7YFLK77V/tqFG+CLDHKoBFIY765z/HX7TaX3yhTPDnNuAHRCiz5Ki4SuA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0938c702-fb81-4327-7725-08d7d0a146dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 09:45:39.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ou6yHJU1IBzV70lXoOh9j4Jn/eEvG+CM1hPegxPR161+3oXHr7I96SOdFtc6fKlcjoqAa2cKmzCIzmatHjIFsDLl6sgmfzVVpeWXYkB1iK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3565
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/03/2020 16:41, Christoph Hellwig wrote:=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * Issuing multiple BIOs for a large zone append write can=0A=
>> +		 * result in reordering of the write fragments and to data=0A=
>> +		 * corruption. So always stop after the first BIO is issued.=0A=
>> +		 */=0A=
>> +		if (zone_append)=0A=
>> +			break;=0A=
> At least for a normal file system that is absolutely not true.  If=0A=
> zonefs is so special it might be better of just using a slightly tweaked=
=0A=
> copy of blkdev_direct_IO rather than using iomap.=0A=
> =0A=
=0A=
Can you please elaborate on that? Why doesn't this hold true for a =0A=
normal file system? If we split the DIO write into multiple BIOs with =0A=
zone-append, there is nothing which guarantees the order of the written =0A=
data (at least as far as I can see).=0A=
=0A=
So if we have this DIO write:=0A=
|AAAAA|BBBB|CCCC|DDDD|=0A=
and we have to split it for whatever reason, what safe guards us from it =
=0A=
ending up on disk like this:=0A=
|CCCC|DDDD|AAAA|BBBB|=0A=
=0A=
This is essentially the same reason we can't split zone-append BIOs, or =0A=
am I totally off track now?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
