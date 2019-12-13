Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3664811ED4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 22:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLMV64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 16:58:56 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40092 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMV64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576274335; x=1607810335;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nZ/PiD37sCkWCJ1DX+bujCLkLEtwlfUfa7nLVaJmGiY=;
  b=W4RHi6kafFS7Z2Xv9q6CDYEVbdCneCgbbwI122d3T7UdWuIsrscIFX7R
   TDNen/jKreg8PPdv/Vfk1aiRab2rwVUEHtL5H3E2TCoPFMC1KEE6TH74b
   7Sb8cdqokCSKN4UScM00qdELZw2SQC2DoEzN7OutTga2JuxGanlMH2uH1
   xmWAhU8An9RM5ORK5xpCr+ph7Kepd11xZgKXWWITijZW9N3Ry9wVV/vi4
   7Za8DXPQZwPxZOro7yKTRsz/HGUWHRLRsnbW/zaGqLnvzEiVu5iRAdWh4
   kkdQZQN8B8kIar0wuNvCnVU/IzbDZiogKbY+IPKY7xtRfpa5t4VElPZys
   w==;
IronPort-SDR: bP7NIB0HxTP47nEUrvkGmYBRn6utga4yLM3zh+NRoRG5awYJldGIbxrKf1+Y6Mhy3xIXlfiote
 ZLdx7MYFScfyjdPXnDfoH+sLwzRMeHE4CXOmSCWZfNOGaYRSLVKB7EVLzx95ghPe5y7Nw42ep+
 zq3MP8cbLue0lrb3NL/vW44QKznDZFlfFTTcb44cRPRUr/80TVJn24YBsPYN9BoPqzc28HncYZ
 ZKwXqiQZYnpVc9o2zbqllcuTF0FaQtAAkH8zvXL1NpjlmbUwIBhaIKf3Hi0zcJFtDnFc0dSTp8
 VIc=
X-IronPort-AV: E=Sophos;i="5.69,311,1571673600"; 
   d="scan'208";a="232891167"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2019 05:58:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfS4xSILbLLFfpd5vTNe8wRR1kAEaPLaZS8e+gxPVhPF+39wXYSnCj4TcwwxDdDY8DEBErtdyGZQDJixSMJieJuNDJ1q/HIPeOxNs7I7wB6v2tx7RbG22tGEXcMCBFImlIwiD23sWOrIqaBT1lclywIt/kXOIoTmqUIeQaLMkr8PdwuIM7AuPFN98GRqI0u/Q/Uun2hB2AXhMIotU8limPU6NcOhOU5iC6uakvnuxZEF1mK7xvhxGLpBXVbvdnAKqQfzuyhR5S8Yo6F61JTo4GGhe4iGPsZuItpGIRaJWLlDTbM0gAsgs7at0F42pRq+7pHIBVTgADgxa1ADAtGtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY659iFdPpRp7gnTLe7/PpsJ59nOrPt0yX8/3W03Ogg=;
 b=AfnSKeEZ7bPmlt46L1Xjaosl2yYShO4wOh1X5IysAixSBS4eJ8kqt9dge6tfLqOJBzSJyFpYUpU+9KnicSjDFD+FenBzfELJaK0iiZkMHbXtgcPkA/BWwJRbyX9BMgRkD1PaaMMNSmWAPvgVO0qxyg57z9CsuLbsXuC8e9E0Btw3xMWA5G717ymwRQ81Va/eGTi/QPCna2ORvMi1ysCIaCtPDbw51Yp9eFmYd6oJZfjYA82EdOIVb7eoFjQ8B1tDD4MjEILxLUwDgAGtsqs45FZHgXzuO4MyngKK9OuG17CJq0+ufOlcwZO3BKbchVV3ft99WQA6O0oTqVnVnOlIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY659iFdPpRp7gnTLe7/PpsJ59nOrPt0yX8/3W03Ogg=;
 b=segQ90VCm8W6rB7Jr/wnGxjUTH5P59d1IMRkryu7k7Iq9X3R6qhEcXrjtNwt3z+Nxdnxs/JMrAqQ4wzKCIr93Et8AkshiZSm9FMDHmGPsUgzT/ooPpwTTLEn60aXNvRiuTPeLMXDdJ5gkQD3ZaY3QiWql16hX1rI8pEhfMi2JJM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4247.namprd04.prod.outlook.com (52.135.202.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 13 Dec 2019 21:58:53 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2516.019; Fri, 13 Dec 2019
 21:58:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v6 08/28] btrfs: implement log-structured superblock for
 HMZONED mode
Thread-Topic: [PATCH v6 08/28] btrfs: implement log-structured superblock for
 HMZONED mode
Thread-Index: AQHVsWtXUntI1dVy9USgPMaC3CmsRg==
Date:   Fri, 13 Dec 2019 21:58:53 +0000
Message-ID: <BYAPR04MB5816552C67964D6415A3FF70E7540@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-9-naohiro.aota@wdc.com>
 <e5bdec6e-a38e-7789-922f-5998b4401d02@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2199e2a-6be3-46d1-db91-08d78017a4a9
x-ms-traffictypediagnostic: BYAPR04MB4247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB424788E547BAA1C7A50F6124E7540@BYAPR04MB4247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(33656002)(26005)(4326008)(81166006)(81156014)(86362001)(66446008)(71200400001)(52536014)(66556008)(66946007)(66476007)(64756008)(6506007)(8936002)(5660300002)(76116006)(110136005)(54906003)(478600001)(186003)(53546011)(9686003)(8676002)(7696005)(55016002)(316002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4247;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7HM+XZCu4uBSK/BEgaWykFsJAhT+T2ZpSWPp01w4wKlZbKVns623H25UAXwM488simf0dPcuaJ2WW4esRXwnudssIY88lv7NLh4PPa5okpTGJGHwjTxanvIS+TWFj1QjMcARR1nRzld3OXVog4ZNdACyo6zAKYuIQ6ZyzDkbugR5lLb00kUnuLWtJZo/Xn8+uZ6aNRbHt7/WRkHHefy16/E3meVA++/9ZXBjj3JnZZ6vbgM8Pf7x4K2PXc4yyJkxAHQfWvaPK2hX2eyY3n6YSq5W9RAcWAZwyUK19Xy0So9W0UAnQ/CDQJ+GDD15po2nkJQvtaoyemmIjBqM2kBHmSMdZPfSnprdtjgeeao9lNDOUu20nS/dPrbx+726oaE0UmaSCYwT2fDxdW+k6rV1hR+Si09YLaG5QsPhwmapE18/4dnRJGg0yQ/mfXGfPhI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2199e2a-6be3-46d1-db91-08d78017a4a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 21:58:53.0233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROBimf7VcCPsjf5vhGBI8Z2BdzHCdB6asVRxwIgQprGGt9KMa0L45wbJ7ZDu0p/AZurGCLQKCXRNzdZgwyPbuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4247
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Josef,=0A=
=0A=
On 2019/12/14 1:39, Josef Bacik wrote:=0A=
> On 12/12/19 11:08 PM, Naohiro Aota wrote:=0A=
>> Superblock (and its copies) is the only data structure in btrfs which ha=
s a=0A=
>> fixed location on a device. Since we cannot overwrite in a sequential wr=
ite=0A=
>> required zone, we cannot place superblock in the zone. One easy solution=
 is=0A=
>> limiting superblock and copies to be placed only in conventional zones.=
=0A=
>> However, this method has two downsides: one is reduced number of superbl=
ock=0A=
>> copies. The location of the second copy of superblock is 256GB, which is=
 in=0A=
>> a sequential write required zone on typical devices in the market today.=
=0A=
>> So, the number of superblock and copies is limited to be two.  Second=0A=
>> downside is that we cannot support devices which have no conventional zo=
nes=0A=
>> at all.=0A=
>>=0A=
>> To solve these two problems, we employ superblock log writing. It uses t=
wo=0A=
>> zones as a circular buffer to write updated superblocks. Once the first=
=0A=
>> zone is filled up, start writing into the second buffer and reset the fi=
rst=0A=
>> one. We can determine the postion of the latest superblock by reading wr=
ite=0A=
>> pointer information from a device.=0A=
>>=0A=
>> The following zones are reserved as the circular buffer on HMZONED btrfs=
.=0A=
>>=0A=
>> - The primary superblock: zones 0 and 1=0A=
>> - The first copy: zones 16 and 17=0A=
>> - The second copy: zones 1024 or zone at 256GB which is minimum, and nex=
t=0A=
>>    to it=0A=
>>=0A=
> =0A=
> So the series of events for writing is=0A=
> =0A=
> -> get wp=0A=
> -> write super block=0A=
> -> advance wp=0A=
>    -> if wp =3D=3D end of the zone, reset the wp=0A=
=0A=
In your example, the reset is for the other zone, leaving the zone that=0A=
was just filled as is. The sequence would in fact be more like this for=0A=
zones 0 & 1:=0A=
=0A=
-> Get wp zone 0, if zone is full, reset it=0A=
-> write super block in zone 0=0A=
-> advance wp zone 0. If zone is full, switch to zone 1 for next update=0A=
=0A=
This would come after the sequence:=0A=
-> Get wp zone 1=0A=
-> write super block in zone 1=0A=
-> advance wp zone 1. If zone is full, switch to zone 0 for next update=0A=
=0A=
> =0A=
> now assume we crash here.  We'll go to mount the fs and the zone will loo=
k like =0A=
> it's empty because we reset the wp, and we'll be unable to mount the fs. =
 Am I =0A=
> missing something here?  Thanks,=0A=
=0A=
The last successful update of the super block is always present on disk=0A=
as the block right before the wp position of zone 0 or zone 1.=0A=
=0A=
> =0A=
> Josef=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
