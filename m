Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC86C32DD7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 00:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhCDXAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 18:00:09 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11837 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCDXAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614898808; x=1646434808;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MohEwAd4XdcWDbc2Pyz7Y9r/I8zdsZHo3Q2RW29iH24=;
  b=HqzAm7sEB+Ju1neyCQME3cocFdkbdf/nDC3MHNSaxs5PMCEEADaTZZt+
   8yKZVvR130duggjgLJHt/u4/txe40wQm/ormTH2Ilu4/bB9k/NEChMh4O
   gy+wb5dJDu7poOmvz0I9BXWK1JbQgSsfJGlJavEx63QrkJgedVvwMFSVl
   cywuT/0I90mPlAZFedc1nRIw/+UHhLQTON2JHANucoLnytG4djFqOHzvr
   AhUSuE94IHA06CESbUFyKeSoQWPhZ9jejLC7EUKpl3wBAUlVejW7MNmmN
   SJS3vIvwpJFo5nZaZnIOsRO4kTr2jcRU23/M19dR8vncFq7JRgVc0uXn6
   A==;
IronPort-SDR: FkVinivB3gQMepAck8RKSXswtki3dLs9xOpTllm/9xXLusQ/mdPQSp1lRmXyi1pLkLVbAcvGJu
 40Ef/wBDFxklOQXI/BQsF3r+IsP4EczDtURV4sxSojyWR0m7e/HzyFSjvE96aVSKwR+rMApIXd
 xPuEUgd2GvMeU2n5foT40VIp7FHsHnftshWQGDaU5/4/hMBTpuhtSH1zcNFuQHqyhDToh5HTmJ
 oiiMWAe/2NjHoOtjUsk1BvfoobA8GafRzxIkBjrjhy4GL32Xg190zamzPepnxL4n1bDKQ26j60
 zKo=
X-IronPort-AV: E=Sophos;i="5.81,223,1610380800"; 
   d="scan'208";a="161380859"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2021 07:00:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFQ26mO3ozbZUH2miza1Pt+lDy4VO4b7ypC/PX5hj3qC9nfn40i8qwYskNyag3TfUa8l05qnHyo/tLn3yHxaPRzoioYwf1z6+T5C5nzSd/GRJ17lsbH0Lt7xZLYfzGqW0Ikwo6xUrXzGlyH3eUjXj18ZGVik/RDvENH4r1dVG+QiI5sSzcXaNtT7Qfpry25jHz30pp9cFOMv3xtdI7xNMGPfL5UYCR/hAbLnLMj0XIFKZWC8E204HWQngJqLvWrgvmHq5SZCYqmqDrHa4A4g801+33jXretZS5NkClNBxfxxlM+/t0w3dYJnQrEMEKLg24gCA+QSSdb4tV7UbigX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N6re6ELupYThqfA8cXsLGtW6NXduaso/tdDhLnSSaU=;
 b=ICRVnzg3igefZdAUQfbJ6S9jJ+YuHeIA9Lp5lgcTdjcbzkBGiOL/zYslJdknyHNOtoUDp3wHlI5lMZLeLDQzzwfJ6HebqZ3obcykyxWklPZH3LI0VfJcy3xF6LVWU8ynPZW9CmAfcrwUl1nuu5StyD3dK1jFmsT2h4LqkFHmEBNOByaLMCHx39qXbuWCzyCe/QY56Azyzer7hR4zO81d6CFPdN/wkG9ZA+EAyvaePj12EFFLkuJyjlPwRHSr15SILEThItD/ykKrWPVKRnHIVJ1s9tBPt47XHct1OQgjqHSsaVbRkQ10sGMX5kDBXkSQ9u4THrvDVZWUZkDON0EnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N6re6ELupYThqfA8cXsLGtW6NXduaso/tdDhLnSSaU=;
 b=X2e8ieEKXMeYRrBEsQQaWmQnAEiLC5NHYWtGJyjbMmuQs602Vyl+h951IaQCTMyknd2XQv8/AepCo3OLWDPnbppJYC2AUZcgAzTNYKBYNxXUc7f1z2Re4K4518RwFQ1UpK6v8c5V0h9UpeG2vUaVhYFi1ugTAN2BCGvvVuYGhs4=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4769.namprd04.prod.outlook.com (2603:10b6:208:4f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Thu, 4 Mar
 2021 23:00:04 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 23:00:04 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: move superblock logging zone
 location
Thread-Topic: [PATCH v2 2/3] btrfs: zoned: move superblock logging zone
 location
Thread-Index: AQHXEJkY7w3+Wo37I0SEWH5SNym2wQ==
Date:   Thu, 4 Mar 2021 23:00:04 +0000
Message-ID: <BL0PR04MB65145B05E44E21D2092C4E4AE7979@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <cover.1614760899.git.naohiro.aota@wdc.com>
 <fe07f3ca7b17b6739cff8ab228d57bdbea0c447b.1614760899.git.naohiro.aota@wdc.com>
 <20210304151433.GR7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:9085:7df2:ab15:6c3a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6aa22d2a-714b-4d3b-87d7-08d8df613fb8
x-ms-traffictypediagnostic: BL0PR04MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB47699214360CF44370FAF383E7979@BL0PR04MB4769.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZQ/A4RBMMskQoFGenL7jg+qdzpWnxW7Ut27exnU93/wcMQJ5hYjJtcS7xI88N0qs3F+lBE4M0lQqHcR/2wzs85pIna2YQm4eWral51GsCYIYkoNepUtRH56wi1cwm+G/Hq65xHd3HeOKtUQ8AHda1nMQgXza/XAONnzFnnujQXovqc3omWiqKu9k87kgQqsv37A+AgvW+FfkLqutZ5NsETuROEf5VhxVZCHc9lZqMgQZFFW+f+EEP1z4zXbHYlPCOkmdfz4dD2iGq6YtAo8cHcFcvbhvuMYER+tnvEePZwHpKDRHiFBYza/7c4de3LDMDs/4kms7PMsaLxT4bzMMH4AFwm3M9h7JYUSuOFuTsH7048gLsXpeSD1LjOwMDhoD6ws4O5wd40e2U7koc7VNMDOmo7mA4WKXNpRumZRWBgi7vlUcNGO6WxPfJNQRbt/Es9G9DyDjdj/F6exzHQGMwzp7V3Wb8k3UE3GF5beWzV3Hksy6qjtZW26IxGLHJEX7fIujwUDCPGz8DZGCTJdwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(7696005)(5660300002)(6636002)(64756008)(8676002)(478600001)(91956017)(71200400001)(2906002)(83380400001)(52536014)(6506007)(53546011)(76116006)(66946007)(186003)(86362001)(66476007)(66446008)(33656002)(55016002)(54906003)(316002)(4326008)(9686003)(8936002)(66556008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?keq/HJm5+UoXllzlerN0tE3jOhOsbpCPaZJ5ulAs1bfDMw5ulma/87DyjMNa?=
 =?us-ascii?Q?npSBClhSiyOcxiZsqRAcrjGh0JhhyvsbhAwZ9M8hDxemR4F091R8iVvzb0kU?=
 =?us-ascii?Q?m7u0eDrqwRrSxRzz/CuKSW6ipezoMu+alJamgGJ4ENIj1Cb5Tn3Tpv0SEFEZ?=
 =?us-ascii?Q?g+kD3bo6XV3EsREWcr3s/hWU6F2bMQByM1iD6mvQHcJuEEHQY/gBM5/TH0SL?=
 =?us-ascii?Q?ILMqHDyk4Kz7LIwizmnN9l7DFdtxS6/55rAOOX4lv/NnIbwM+ZOb4qth9iKj?=
 =?us-ascii?Q?HdC4vcFlhG81ZALupbUZ58ubeU01ecmPhdthRcvHl0wYTW5Av/2dzTCcPqjY?=
 =?us-ascii?Q?A00VcydFMzNPcRcWl2cfVFPf1pqSMDUHnF1nTsK1JgjWoR6iy2mQpQwtEal7?=
 =?us-ascii?Q?Ne+PJdeXOG6Jr7/FHpCtIk5CJiZTqLt0cqU2RMvyj/Zw5dFJOyXz/wEmHb8C?=
 =?us-ascii?Q?Q/ZOMSr0p8C32bmOeAOZY5BkkvANkRPZKyk3AqLH7yzajlNAvU+9Ck1C21uv?=
 =?us-ascii?Q?GH9MS3LYQTqDwKCNJAnqHMBoF0nd6J6LlUSBZu93VH2mL/wTTDlkWzv/q8Xg?=
 =?us-ascii?Q?8WbiG7Z5GZBTKSR8LeLmS37pD87EoXHQK7jf+f7TAJw9qeSM6uoMHKSbvZQg?=
 =?us-ascii?Q?YXaLM7NfNy4FB8qtjYH/LTrovn2IbC7rbFZOpu7AOmtFQ1QJmDv7NZMx5kEL?=
 =?us-ascii?Q?Grt/Q/0hllP2hIOE5BCow91mmPspp9VMUYqelM4nLTWdY+BRMv0eEjwXS4d0?=
 =?us-ascii?Q?ocdajsDZoebEDKUck/SlvGMfXXz1aRNk2Fet7cOTiKZPHhUjiGeuNBxOUi6u?=
 =?us-ascii?Q?zLYXozs/cc4F7jRsYs/6/dU0Cku4LLZT3ENhNGpgJeFx2lZBlazdXN1Gh0ms?=
 =?us-ascii?Q?sSAFqnrtxCyZdjbetbF79iaWbC1GZiIfF8V+mBi3HtoOMZ8ufpJ3lMvtMqKH?=
 =?us-ascii?Q?nBypnJRHftfNcPEfJFfMEXxTeXDvqjRno0kupnIyB4drUbUeCuungHW6+Ktz?=
 =?us-ascii?Q?yNe42p0Re2k36M377eGb9H/T6jdbNmlojv1XttUNOk2+1DQC0j99zDhIUBZD?=
 =?us-ascii?Q?dDZTuEuDE8ndZY0jx5HJBRcMfKYmzMfzEp/bog1rfcl6vdSo7jPyzeQn8Amr?=
 =?us-ascii?Q?b1YmTHa5ZcYjqg8CLyUSFK1S+2MJoBEDi8WllaeMo9H7Q6MXuGVyDju5uF6j?=
 =?us-ascii?Q?2ld9Bwen5tMVVIfEoLDQ/twQGazl+MfOYsYcHG7xpH9S1IxhilNTl1wVJxpw?=
 =?us-ascii?Q?vJIRUL8JGpwIvg2AlvPcUX6QQ/fX7yv5TedEW0vHEMhbXKBYVm2uqsH1fpd4?=
 =?us-ascii?Q?A6ga3HykWZJ/ZjdfnUv+CDGfnUzO8E3hu93PNFmGWqFIW7qZlrJdld93hoR8?=
 =?us-ascii?Q?l2RQoEIzHPfpJa18M8TLwzD/h9WKb4vpbLYhlQk0PU7PCMCq7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa22d2a-714b-4d3b-87d7-08d8df613fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 23:00:04.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /szGNhmM/xw9vANjgAIxSF0Y4Spe2XFn7OiAQWoG5zppeBZyKoYsrpF3V0DaUxMZXwNh/olKNJ0olk4Ebr/xiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4769
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/05 0:20, David Sterba wrote:=0A=
> On Wed, Mar 03, 2021 at 05:55:47PM +0900, Naohiro Aota wrote:=0A=
>> This commit moves the location of superblock logging zones basing on the=
=0A=
>> fixed address instead of the fixed zone number.=0A=
>>=0A=
>> By locating the superblock zones using fixed addresses, we can scan a=0A=
>> dumped file system image without the zone information. And, no drawbacks=
=0A=
>> exist.=0A=
>>=0A=
>> The following zones are reserved as the circular buffer on zoned btrfs.=
=0A=
>>   - The primary superblock: zone at LBA 0 and the next zone=0A=
>>   - The first copy: zone at LBA 16G and the next zone=0A=
>>   - The second copy: zone at LBA 256G and the next zone=0A=
>>=0A=
>> If the location of the zones are outside of disk, we don't record the=0A=
>> superblock copy.=0A=
>>=0A=
>> The addresses are much larger than the usual superblock copies locations=
.=0A=
>> The copies' locations are decided to support possible future larger zone=
=0A=
>> size, not to overlap the log zones. We support zone size up to 8GB.=0A=
> =0A=
> One thing I don't see is that the reserved space for superblock is fixed=
=0A=
> regardless of the actual device zone size. In exclude_super_stripes.=0A=
> =0A=
> 0-16G for primary=0A=
> ... and now what, 16G would be the next copy thus reserving 16 up to 32G=
=0A=
> =0A=
> So the 64G offset for the 1st copy is more suitable:=0A=
> =0A=
> 0    -  16G primary=0A=
> 64G  -  80G 1st copy=0A=
> 256G - 272G 2nd copy=0A=
> =0A=
> This still does not sound great because it just builds on the original=0A=
> offsets from 10 years ago.  The device sizes are expected to be in=0A=
> terabytes but all the superblocks are in the first terabyte.=0A=
=0A=
I do not see an issue with that. For HDDs, one would ideally want each copy=
=0A=
under a different head but determining which head serves which LBA is not=
=0A=
possible with standard commands. LBAs are generally distributed initially a=
cross=0A=
one head (platter side) up to one or more zones, then goes on the next head=
=0A=
backward (other side of the same platter), and on to the following head/pla=
tter.=0A=
So distribution is first vertical then goes inward (and when reaching middl=
e of=0A=
the platter, everything starts again from the spindle outward).=0A=
=0A=
0/64G/256G likely gives you different heads. No way to tell for certain tho=
ugh.=0A=
=0A=
> What if we do that like=0A=
> =0A=
> 0   -  16G=0A=
> 1T  -  1T+16G=0A=
> 8T  -  8T+16G=0A=
> =0A=
> The HDD sizes start somewhere at 4T so the first two copies cover the=0A=
> small sizes, larger have all three copies. But we could go wild even=0A=
> more, like 0/4T/16T.=0A=
=0A=
That would work for HDDs. We are at 20T with SMR now and the lowest SMR cap=
acity=0A=
is 14T. For regular disks, yes, 4T is kind of the starting point for enterp=
rise=0A=
drives. Consumer/NAS drives can start lower though, at 1T or 2T.=0A=
To be able able to cover all cases nicely, I would suggest not exceeding 1T=
 for=0A=
the SB copies.=0A=
=0A=
> I'm not sure if the capacities for non-HDD are going to be also that=0A=
> large, I could not find anything specific, the only existing ZNS is some=
=0A=
> DC ZN540 but no details.=0A=
=0A=
That one is sampling at 2T capacity now. This likely will be a lower bounda=
ry=0A=
and higher capacities will be available. Not sure yet up to what point. Lik=
ely,=0A=
different models at 4T, 6T, 8T, 16T... will be available. So kind of the sa=
me=0A=
story as for HDDs. Keeping the SB copies within the first TB will allow=0A=
supporting all models.=0A=
=0A=
So I kind of like your initial suggestion:=0A=
=0A=
0    -  16G primary=0A=
64G  -  80G 1st copy=0A=
256G - 272G 2nd copy=0A=
=0A=
And we could even do:=0A=
=0A=
0    -  16G primary=0A=
128G - 160G 1st copy=0A=
512G - 544G 2nd copy=0A=
=0A=
Which would also safely allow larger zone sizes beyond 8G for ZNS too.=0A=
(I do not think this will happen anytime soon though, but with these values=
, we=0A=
are safer).=0A=
=0A=
> =0A=
> We need to get this right (best effort), so I'll postpone this patch=0A=
> until it's all sorted.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
