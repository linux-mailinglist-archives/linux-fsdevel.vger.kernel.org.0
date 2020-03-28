Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B181964C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 10:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgC1JSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 05:18:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64257 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1JSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585387104; x=1616923104;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+PsCsonX8bZfG1AEpo10Ej9MyADdApXGyZTaUj9ciWM=;
  b=is3dfu9cMsmLpzE64QBFSLaFYXRRMJ6ga8FBbVwfWTnk5uYIhX4qZI47
   7MZgOj33NOSt12CFHQ5lALBwQcNmWZoLNqGfMNMHB8m3TgOB9QPKlblpG
   fn0K4P7V1IcCWq/4gi78rHr//Tke4w74n0g40tPaXiwp5VTTI2OuOah0B
   +kwih6ctQ4VAUIiuI+Oxywf6M5YjOKsh5khCPSvV8VZevL9J/QrbTVhzl
   Io3iG6Eu7zNblIYQ0iWYM0GNjIUhzGYIyYfVff+AsbT4kHC+pCZWScQuy
   7Gv6f38YBaAeujSc5EeRJbhbzjeCbRQILwsGH3Ho0wdxeJI0gBJyHC9Ba
   g==;
IronPort-SDR: sRVPWHQf0vUXYU7EC+e5OGCI8kmniS6hnm2eMhrF0SfJCYoXJsNlIepXSNKtiAHs/O1ttSGBPG
 aC+D2sYXOzWSxkuXrrWRbfTPo63PRGHutzJM62drhe6ZVcFBhhcSdMnS98Iig2+bBgcYeVtYc8
 xKEEMCNLh3KneNMDbVjevLMJTX1Z4KiwgeLDZa/uZrlKMts6dHXKkIMzV6pANRVOy1GrBvZzQz
 KDw1qOsaiutdsyFZTp/N9he9Y6zce4qKYzhgRgpihoOkWB4VyxYfpLXRrLfSIFBLId6u7FIb0B
 QRA=
X-IronPort-AV: E=Sophos;i="5.72,315,1580745600"; 
   d="scan'208";a="138130139"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 17:18:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jutJHQB8Jo6yXF56g5wzmS44YFTzEFV4950GiHhzKWfafTtMbBv0TQ940Y2qB4hWlbXM58d02VusduBpmnHgEE6ax67ziPnfm9p6IZppj/WkzkfXPaza8AFITl5kQLa/s38f/sED0d3crf1Hqmsy11vigqFoAbkbX8detUy8aqjm1PydzqKqtFMlcq+F2/Jpyx5hkBj6521Umf+RzM2/w7IoG64RmezS/jH6MdzJXpOva7GWvTuhNuzDKu9pAj+4f8aakMm9XsJuYK1bZjr1TtauT34IcY46q/r6OgtX+v0nJHJiakcd9Fp+8LeY8YfF3k4EolnhNhVoC+KvzcAaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO/hN8XcRfxVZcLRTDzcg8m7CcoixNXHV6qEtrCy5hQ=;
 b=NdtyfRpK8JeOCPkAL0xYdmmjPKcAPi+9hGWxeOSCerz7mwbBDVEljidBQE0vmzgIpuDMTIzfGClgqtM8PTcCb4V5IzHM/c3qRDzKRCZCSsV02JbAkg1JKXYV4dW3kVp/1Lk4SnXolUarAFaTD2lstU7UtHa1MF6AYn3I6hFZx9cg37a4zb21z2PnFmhjMFBQlwqFZB9r4wIJcx5XMcfwJ6smnkIAMGxsmiT0wKLJK5+LF8mGhfRm3mFg8Kh/iEUAVZLm7K5FhIaXdJd42rG8X0ekVWCdP0ZMJKbrkyGQZc23JRec/hJv5UApeMxh1vNyQStD5bd475s1aCVAvWAVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO/hN8XcRfxVZcLRTDzcg8m7CcoixNXHV6qEtrCy5hQ=;
 b=ObtrfnIj6cgxSOnxfBUjTyLTeM/L2Tk6D/WVU0Lqi8rWeUwZqGc4t0MEmDv9/KRZsQbi2JEuClY7Cnx/JZpnC00sZqbpPtkgfGNpwfTAB5EsFA6/KecXRBajBe1QC7ze9aqiVXJgEZ/vR6XimRwdjM252esujfw6B8ozuadwdiE=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (10.166.200.137) by
 CO2PR04MB2360.namprd04.prod.outlook.com (10.166.94.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Sat, 28 Mar 2020 09:18:20 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Sat, 28 Mar 2020
 09:18:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v3 06/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWBFfTgI8rxzWhnkGqyEIWCxLs0g==
Date:   Sat, 28 Mar 2020 09:18:20 +0000
Message-ID: <CO2PR04MB23430A87641EDD359E5101FEE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-7-johannes.thumshirn@wdc.com>
 <20200328085106.GA22315@infradead.org>
 <CO2PR04MB23439D41B94F7D76D72CE3BCE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <20200328090715.GA26719@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f7cd418-1107-435d-0d7d-08d7d2f8f559
x-ms-traffictypediagnostic: CO2PR04MB2360:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB23608889F716C501339E5927E7CD0@CO2PR04MB2360.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 03569407CC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR04MB2343.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(9686003)(8936002)(66446008)(66946007)(91956017)(52536014)(81156014)(66476007)(7696005)(8676002)(6506007)(76116006)(5660300002)(71200400001)(81166006)(316002)(53546011)(4326008)(2906002)(54906003)(64756008)(66556008)(33656002)(86362001)(55016002)(26005)(6916009)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/ak85tGPRAAn1lJeYIwdyxWjfCRKehWJ7hfHXKrhFFzkFVHS5Ma/6L1T8inXezFlQ57gzoQm0u16RkJQ3CkmMC9Eds13IM3aVioGTl8OQ170VafS97Di5R8GnUGPmKbgFVoL1XyC/truKgIRT1GC+9BUDWaKVbOTt1go9OP6HhFZQYtKeDJkvO3edxIXw2xXL7bnLvwYTpeNeBYeSihVunkcaoLW3hpmlp/hZs0NufMsiDwZ84fW8gWZ0+CgVPT5HLopfAuYuWIwtmT3NViALY0TIhBNCpmd23Oy6VZhSE3wScIx1sgsRJ24qYmtKVnu/j0GJp28lnFO0OO1yvCFMBtqhc5Y4jDx1eIuxT5l0geR56M6Z/M0V0/kvMXWb9nEMf6s9R8rtiFf2VwJPArR/nXn07uhP/Q4kH1vt2VCy+UOhTYQUmSyuohD26eu79Z
x-ms-exchange-antispam-messagedata: RM1fGjOwRj3P3uisPIlnfyA8aGM8qzbShxjS+zGKLhd797p+vVSjrR+JLRFGdVEyPbvPkvyXYgXluVKFoUqv0vBS4hNhvv/G6B90AkiGxLzN2Gka5E/cNR8evr3pdYL+0mHAyYQoqdGTBkLD46oJSQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7cd418-1107-435d-0d7d-08d7d2f8f559
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2020 09:18:20.4181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ViA77jtgXAmgqWfmcPuiz6U+XEluzla7l6ugxGfa3ndjW+jpG0bxp2s3V/U26q0LUjmCNR0XFj+bktOeJxn7Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2360
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/28 18:07, hch@infradead.org wrote:=0A=
> On Sat, Mar 28, 2020 at 09:02:43AM +0000, Damien Le Moal wrote:=0A=
>> On 2020/03/28 17:51, Christoph Hellwig wrote:=0A=
>>>> Since zone reset and finish operations can be issued concurrently with=
=0A=
>>>> writes and zone append requests, ensure a coherent update of the zone=
=0A=
>>>> write pointer offsets by also write locking the target zones for these=
=0A=
>>>> zone management requests.=0A=
>>>=0A=
>>> While they can be issued concurrently you can't expect sane behavior=0A=
>>> in that case.  So I'm not sure why we need the zone write lock in this=
=0A=
>>> case.=0A=
>>=0A=
>> The behavior will certainly not be sane for the buggy application doing =
writes=0A=
>> and resets to the same zone concurrently (I have debugged that several t=
ime in=0A=
>> the field). So I am not worried about that at all. The zone write lock h=
ere is=0A=
>> still used to make sure the wp cache stays in sync with the drive. Witho=
ut it,=0A=
>> we could have races on completion update of the wp and get out of sync.=
=0A=
> =0A=
> How do the applications expect to get sane results from that in general?=
=0A=
=0A=
They do not get sane results :) That's application bugs. I do not care abou=
t=0A=
those. What I do care is that the wp cache stays in sync with the drive so =
that=0A=
it itself does not become the cause of errors.=0A=
=0A=
Rethinking about it though, the error processing code doing a zone report a=
nd wp=0A=
cache refresh will trigger for any write error, even those resulting from d=
umb=0A=
application bugs. So protection or not, since the wp cache refresh will be =
done,=0A=
we could simply no do zone write locking for reset and finish since these a=
re=0A=
really expected to be done without any in-flight write.=0A=
=0A=
> But if you think protecting against that is worth the effort I think=0A=
> there should be a separate patch to take the zone write lock for=0A=
> reset/finish.=0A=
=0A=
OK. That would be easy to add. But from the point above, I am now trying to=
=0A=
convince myself that this is not necessary.=0A=
=0A=
> =0A=
>>>> +#define SD_ZBC_INVALID_WP_OFST	~(0u)=0A=
>>>> +#define SD_ZBC_UPDATING_WP_OFST	(SD_ZBC_INVALID_WP_OFST - 1)=0A=
>>>=0A=
>>> Given that this goes into the seq_zones_wp_ofst shouldn't the block=0A=
>>> layer define these values?=0A=
>>=0A=
>> We could, at least the first one. The second one is really something tha=
t could=0A=
>> be considered completely driver dependent since other drivers doing this=
=0A=
>> emulation may handle the updating state differently.=0A=
>>=0A=
>> Since this is the only driver where this is needed, may be we can keep t=
his here=0A=
>> for now ?=0A=
> =0A=
> Well, I'd rather keep magic values for a field defined in common code=0A=
> in the common code.  Having behavior details spread over different=0A=
> modules makes code rather hard to follow.=0A=
> =0A=
>>>> +struct sd_zbc_zone_work {=0A=
>>>> +	struct work_struct work;=0A=
>>>> +	struct scsi_disk *sdkp;=0A=
>>>> +	unsigned int zno;=0A=
>>>> +	char buf[SD_BUF_SIZE];=0A=
>>>> +};=0A=
>>>=0A=
>>> Wouldn't it make sense to have one work_struct per scsi device and batc=
h=0A=
>>> updates?  That is also query a decenent sized buffer with a bunch of=0A=
>>> zones and update them all at once?  Also given that the other write=0A=
>>> pointer caching code is in the block layer, why is this in SCSI?=0A=
>>=0A=
>> Again, because we thought this is driver dependent in the sense that oth=
er=0A=
>> drivers may want to handle invalid WP entries differently.=0A=
> =0A=
> What sensible other strategy exists?  Nevermind that I hope we never=0A=
> see another driver.  And as above - I really want to keep behavior=0A=
> togetether instead of wiredly split over different code bases.  My=0A=
> preference would still be to have it just in sd, but you gave some good=
=0A=
> arguments for keeping it in the block layer.  Maybe we need to take a=0A=
> deeper look and figure out a way to keep it isolated in SCSI.=0A=
=0A=
OK. We can try again to see if we can keep all this WP caching in sd. The o=
nly=0A=
pain point is the revalidation as I explained before. Everything else would=
 stay=0A=
pretty much the same and all be scsi specific. I will dig again to see what=
 can=0A=
be done.=0A=
=0A=
> =0A=
>> Also, I think that=0A=
>> one work struct per device may be an overkill. This is for error recover=
y and on=0A=
>> a normal healthy systems, write errors are rare.=0A=
> =0A=
> I think it is less overkill than the dynamic allocation scheme with=0A=
> the mempool and slab cache, that is why I suggested it.=0A=
=0A=
Ah. OK. Good point.=0A=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
