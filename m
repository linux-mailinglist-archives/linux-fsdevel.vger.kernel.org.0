Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A75531BFFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhBORAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 12:00:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17886 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhBOQ7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613408354; x=1644944354;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rCs8936pdsWf23eXXPNwwfBK0NErnr2wav/aQYeqreY=;
  b=BtXjApeh/UzGYSDUMIE5ThVUYkA8/xfGMrwVzrUejzUaQfhikdwQSYk9
   TxcuAvyY+EENdyszXvs+XETA0vTULUPgaKOn2dIIge44TU4oK5TMbmVUx
   OY/WWBVp/bk0QFcvtr6a5PTVjEhUh//omcofBjU9emDpZraQS8fjNtGey
   vVU8e5YPB5G0bO6rFoafs2h5dhhqPQ7QtX/gID9Um2zZa39jykAV5dwzg
   3XaluosyI7bUv+cDSCr5LgJXt/qfxRXTVOXEixOYkGQTTvS70eb+U1ers
   uJ3crOeSiFNRmRgKifwdrH0u9J1RHjFQOPBm3+2T5tUCvKyc1zURdkrm5
   w==;
IronPort-SDR: ZgdOcqzvWsdWeht4Gr4vcIGXg+zjpEtF2HrKivzqCra35YA9w5h9UhzTr6Y01FbNvi+70nL8WR
 C6p2lgMe9rR5OIxnwEuON1BdvNFwpPEvGX3m2TJHk4UljBp50FN9fxKQAfhWaK1Yw6OeGkDqnT
 NdFa1DckkgiqbfEURLW7eZ3eIMIs/r5igv+uxRGo0jqd8mKzoYEo0Shmxe9/mDIiJnZG3eIwlz
 N18wlNVeAh5QO29mNAXKjNQgq8GFqb/Hf+xWPNHRMsOKK/f+7zuaikVaas+8DRVgdgOtZjHy6z
 8vI=
X-IronPort-AV: E=Sophos;i="5.81,181,1610380800"; 
   d="scan'208";a="164479986"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2021 00:58:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNH6gAJHf/3agN6tTK65WkCcjCmYhuHSmmusfCU2Di7OYLkQa//0gSnDFvmPng5/FHJyuWj9cHkWooebWUaagpHVSbOgHdNPMo2ditu2lUEjepZN3qVW5dTV/xNdcl9UzQhg82+j0KLCJQ/9bQ0FHKroSFmQXHf4G3YJK1MV1hnSjz8fvnepbZ2ei8SHfA4GLeIKVnHZiW9d2aALaDTO5SDex4bxm9x51v2MiA3HZ8I6LpA1hY9hv/6WtzANkQVTb6ODjQEQNH0+Cjx1lKLfd2lY+Cov/5F4dxx0mjsUqaHaODDVVvEAKXGkZ4SRTw1ZF36FAGDT7IOT37foLPBfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h7jHLvlSvYFrT9kWz5AY7K9h70G3xwmVb8NURLEGkA=;
 b=iF7eslLcFLXgp0GLnKyjFpVoX2ftSn/45j//aFRkkW5LTm8uIuCmddEvCX5pfVIRm0eSg9ARKSv3OsDjNaJbmS/o3qpjxDb+yb0NTZqSqfM4As+KMMGYeQ5hWjyXwlWrCGofSxcD5JpIhQ7OmkxEKk/kFOV2Ybu9Fsi7ZJauS0nDy4oed1E0AIHWw16si3aAJRESlzEAyOARMJrP+97R1eswSWvuudpRZ+czYPQ86A79tW4tf31Jc0sSoAXYBs0od8/kjhuLTQvmUG+C5yxMaEHxWoh985xSGyxmobnJHrgQ9egFClfVAkTo1NBTrt6ef9b2gaGNGz6uRXKyDnmDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h7jHLvlSvYFrT9kWz5AY7K9h70G3xwmVb8NURLEGkA=;
 b=hK9WH8mFtJ8C7xl/b2AZ7ixItbB/Cnu1sJhkUP1XNZvavQLuyRb08NyGHxBXQCGsHSj5jjksqg+W9AT5skRNZsBShil3BqwPn95aAFukNVsFFLoQH0bK4V3ry+LTImh5RiVisXYCZH0u/VGuS8R23iAQWb284Oe4egcRbh5g4co=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3887.namprd04.prod.outlook.com
 (2603:10b6:805:49::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Mon, 15 Feb
 2021 16:58:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3846.038; Mon, 15 Feb 2021
 16:58:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v15 00/42] btrfs: zoned block device support
Thread-Topic: [PATCH v15 00/42] btrfs: zoned block device support
Thread-Index: AQHW+uBDi/qAxtbkv0uUNvQXEiNsGQ==
Date:   Mon, 15 Feb 2021 16:58:05 +0000
Message-ID: <SN4PR0401MB359821DC2BBF171C946142D09B889@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <20210210195829.GW1993@twin.jikos.cz>
 <SN4PR0401MB35987EE941FA59E2ECB8D7269B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211151901.GD1993@twin.jikos.cz>
 <SN4PR0401MB3598ADA963CA60A715DE5EDE9B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211154627.GE1993@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:e815:a55:41ef:1d6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52c75a24-d9ec-4fe3-38e0-08d8d1d2dce1
x-ms-traffictypediagnostic: SN6PR04MB3887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB38875B6A0EC5B5244F3179039B889@SN6PR04MB3887.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5WZxJvMHCQ+8FYVRQsqvaDg6f2oXOprGqcrm94cBtPF6osdMig9dPoIp0hg40HEj1K0X/s6XajafAyG2VA1JTCvG7RlkJVRrt0C6FubMwDU7ukee+jjJIUZTFh2QOAbK2j/G3xVS2yqY4FqplHwjf+miE1IWTvKQ5fMwcpjh3jEegd79EhQBeJkcA3Ox7lrTRAkpSE9gYvPCz566Ks8EaEQ+EKaag12hrtp5t46jjrHzpaJIgmQCCcm4G3WBVCdnFgv0yRouuo+GNMtRcKdIfgTVFG2U3kqaw0p6UFgv3ywEhZFYQR3cZ/LjekKFWFf52ReduI9haA6WxHS9BIbrzuv6fluzHC481Xcmnv3Gmnd17IimZWjvy2zDFHvwBbY1o59yN7mqUPQ+bBFZp8MlaQmcrRhBfENxsz+mrxhjoQe/V+MuzrnqVhKZhg8zc9/ZY8xG9RpUhKM5e2uQGZJdHskUl14wt4Mzq3mj2sqVAnr4Zmu7kAeEmweNI9ie/SF7lBZdrP75cYmMdFStRluZYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(186003)(86362001)(2906002)(9686003)(6916009)(66476007)(7696005)(4326008)(316002)(53546011)(91956017)(8936002)(6506007)(54906003)(55016002)(66446008)(64756008)(76116006)(5660300002)(71200400001)(8676002)(83380400001)(66946007)(478600001)(33656002)(52536014)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4hxfu1qiQboDw9mlioBu3EgaploJjNVaWnRueKw+4M09J+BTcbE8spa6PT3/?=
 =?us-ascii?Q?s3Tc1wUK6INMdScfo59T2Tldj/9O950nzo5IG2Zi9qj+eAO1cVbB13yIqjHm?=
 =?us-ascii?Q?F3HAYMyVu2dDs+P04WWz2osDXhpgcbI0DST0YNZM+4n7F2bLkOseOILX0CrD?=
 =?us-ascii?Q?SeNgVfYLkDE/37hCamO2LpYHUVOdRROmN/ZPPNCsXSAfnjfDceV5QcF0rM0H?=
 =?us-ascii?Q?3Qn9ayHgyPHcVChUAK5VmUz9o+tAap2vvsiUbNDAyJ8WODx4V1mf08A4mrU4?=
 =?us-ascii?Q?FO/y+zCDwzzeUnnE/lHORybYQqYZB2vYDXceblMicbd6AiksmGbUHmAx7rQx?=
 =?us-ascii?Q?Vrdql5vXurOAZPXzEru/3zza9P7aINM5HEbpPXKqbq+ABZkx4PmzmfuCE1T2?=
 =?us-ascii?Q?rCfgrnrVlMigjNdl0C412M+GnWXDvloAf/HKjU9fhSeKbcG7ironpBc26LvS?=
 =?us-ascii?Q?m47+ilyTzccAFsBbWpMTSTK/YabLwc716MuL+2KKxuiavRU/X6hxxk6VqU3a?=
 =?us-ascii?Q?QUzuLuuEG3eEJ4Ptp6WFDTIcx7Tl8N+d9jgmRuJDfcgcpwV4xnJkGg/GmLs1?=
 =?us-ascii?Q?xbWrCmGtXQCq89vojhA2LpRTrm7rY1Fx03SiUJV6ja1ok9z+/h5wVl6OXvFQ?=
 =?us-ascii?Q?yZUGyP/wnM9e7S0PXIPhKI++HUFAclMENmpKnUixTmtf9UIJOHvtooP4ekCI?=
 =?us-ascii?Q?nc67vLetJOjsa/BSe4S2DqUQZAeFz+DONDTezqUvqDmRL3kBuNXxjYL4wrC6?=
 =?us-ascii?Q?VIJ7JfbnipiQTVsHbf10825U7sslpYR4FyJpjESbHBMEGjJO6EPynsUgwZEB?=
 =?us-ascii?Q?j/2wTOYUaTDY3e3d5OviJloI5RKFqKp1Ml/nstH0cCCFSpN97wY+sfTyuAaX?=
 =?us-ascii?Q?P9c0NZ00DV3esw5s0jRisyXTtrwwkgV5wCMF1ekWoOlyqGahrr8zZt0vma3A?=
 =?us-ascii?Q?SZTNwgy109akChX9n/cFGZzjj4nXumS5za1NdqioNyEz88j/xs+EQHAySj+7?=
 =?us-ascii?Q?7ekKWNh1LWVEDB7iOO1aFPk8gtwCY85foEksdrcNEOD3BOl5vvLArsLLGtMu?=
 =?us-ascii?Q?kJB7qWYA068AK7Uwuzu7IAER6clL82E6z+8QRj3A65+6i39Rd2mL3Q//+kSy?=
 =?us-ascii?Q?YujAI4PsUBlgUE2k6LD/trfv5pWr67g3tHdCLG7OKPKZ3ualyxzEfER+Esxw?=
 =?us-ascii?Q?Qt5umIPY/dQc3IA7Nzv5P5gx7LOoXHGUgZEv5k/jJH/ztff8xPN+UXr5ECPI?=
 =?us-ascii?Q?8S3gc6+vFcSEKsXp6NobdF4lNgz6pQ/3r64q++tW2NOt7iTbUCX60PahgJAi?=
 =?us-ascii?Q?HFV8H6DRy7LIZ22Zf4dXu2n7PhPZwytLh6O3SxUh5C/5cQt7DiHBfOek1uo4?=
 =?us-ascii?Q?M3d08XjEZnP85xxTDlE9KWK47dzc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c75a24-d9ec-4fe3-38e0-08d8d1d2dce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 16:58:05.0840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmEVaY+LBV2yw99/k8oHH/x2h4hQynQ6k7bPBovXNf3Hqms+vSXPb/maIkEOA6SJR3U59ubAbFcjR3mIZXF2WfyyTOqblbwFGIeRkE37zsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3887
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/02/2021 16:48, David Sterba wrote:=0A=
> On Thu, Feb 11, 2021 at 03:26:04PM +0000, Johannes Thumshirn wrote:=0A=
>> On 11/02/2021 16:21, David Sterba wrote:=0A=
>>> On Thu, Feb 11, 2021 at 09:58:09AM +0000, Johannes Thumshirn wrote:=0A=
>>>> On 10/02/2021 21:02, David Sterba wrote:=0A=
>>>>>> This series implements superblock log writing. It uses two zones as =
a=0A=
>>>>>> circular buffer to write updated superblocks. Once the first zone is=
 filled=0A=
>>>>>> up, start writing into the second zone. The first zone will be reset=
 once=0A=
>>>>>> both zones are filled. We can determine the postion of the latest=0A=
>>>>>> superblock by reading the write pointer information from a device.=
=0A=
>>>>>=0A=
>>>>> About that, in this patchset it's still leaving superblock at the fix=
ed=0A=
>>>>> zone number while we want it at a fixed location, spanning 2 zones=0A=
>>>>> regardless of their size.=0A=
>>>>=0A=
>>>> We'll always need 2 zones or otherwise we won't be powercut safe.=0A=
>>>=0A=
>>> Yes we do, that hasn't changed.=0A=
>>=0A=
>> OK that I don't understand, with the log structured superblocks on a zon=
ed=0A=
>> filesystem, we're writing a new superblock until the 1st zone is filled.=
=0A=
>> Then we advance to the second zone. As soon as we wrote a superblock to=
=0A=
>> the second zone we can reset the first.=0A=
>> If we only use one zone,=0A=
> =0A=
> No, that can't work and nobody suggests that.=0A=
> =0A=
>> we would need to write until it's end, reset and=0A=
>> start writing again from the beginning. But if a powercut happens betwee=
n=0A=
>> reset and first write after the reset, we end up with no superblock.=0A=
> =0A=
> What I'm saying and what we discussed on slack in December, we can't fix=
=0A=
> the zone number for the 1st and 2nd copy of superblock like it is now in=
=0A=
> sb_zone_number.=0A=
> =0A=
> The primary superblock must be there for any reference and to actually=0A=
> let the tools learn about the incompat bits.=0A=
> =0A=
> The 1st copy is now fixed zone 16, which depends on the zone size. The=0A=
> idea is to define the superblock offsets to start at given offsets,=0A=
> where the ring buffer has the two consecutive zones, regardless of their=
=0A=
> size.=0A=
> =0A=
> primary:		   0=0A=
> 1st copy:		 16G=0A=
> 2nd copy:		256G=0A=
> =0A=
> Due to the variability of the zones in future devices, we'll reserve a=0A=
> space at the superblock interval, assuming the zone sizes can grow up to=
=0A=
> several gigabytes. Current working number is 1G, with some safety margin=
=0A=
> the reserved ranges would be (eg. for a 4G zone size):=0A=
> =0A=
> primary:		0 up to 8G=0A=
> 1st copy:		16G up to 24G=0A=
> 2nd copy:		256G up to 262G=0A=
> =0A=
> It is wasteful but we want to be future proof and expecting disk sizes=0A=
> from tens of terabytes to a hundred terabytes, it's not significant=0A=
> loss of space.=0A=
> =0A=
> If the zone sizes can be expected higher than 4G, the 1st copy can be=0A=
> defined at 64G, that would leave us some margin until somebody thinks=0A=
> that 32G zones are a great idea.=0A=
> =0A=
=0A=
We've been talking about this today and our proposal would be as follows:=
=0A=
Primary SB is two zones starting at LBA 0=0A=
Seconday SB the two zones starting with the zone that contains the address =
16G=0A=
Third SB the two zones starting with the zone that contains the address 256=
G =0A=
or not present if the disk is too small.=0A=
=0A=
This would make it safe until a zone size of 8GB and we'd have adjacent =0A=
superblock log zones then.=0A=
=0A=
How does that sound?=0A=
=0A=
Byte,=0A=
	Johannes=0A=
